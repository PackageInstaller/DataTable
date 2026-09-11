return {
	Play413081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08m == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08m")
				var_4_0.name = "F08m"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08m = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08m

				arg_1_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08m" then
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_crowd", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1.4

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413081001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 56 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 56)

				if (56 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 56)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413081002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.825

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(413081002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 73 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 73)

				if (73 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 73)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.575

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(413081003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 63 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 63)

				if (63 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 63)) > 0 and var_16_0 < var_16_3 then
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
	Play413081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413081004
		arg_17_1.duration_ = 12.43

		local var_17_0 = {
			zh = 6.2,
			ja = 12.433
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
				arg_17_0:Play413081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10092"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "10092"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["10092"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["10092"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092", 3)

				for iter_20_2 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_2)

					if var_20_3.name == "split_8" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_20_5 = arg_17_1.actors_["10092"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092 == nil then
				arg_17_1.var_.actorSpriteComps10092 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10092 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								iter_20_4.color = Color.New(Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_4.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_4.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_20_6 then
						iter_20_6.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_8 then
					arg_17_1.var_.alphaOldValue10092 = var_20_8.alpha
					arg_17_1.var_.characterEffect10092 = var_20_8
				end

				arg_17_1.var_.alphaOldValue10092 = 0
			end

			local var_20_9 = 0.5

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.characterEffect10092 then
					arg_17_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_17_1.var_.alphaOldValue10092, 1, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.characterEffect10092 then
				arg_17_1.var_.characterEffect10092.alpha = 1
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_10 = 0.5
			local var_20_11 = 0.725

			if 0.5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_12 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_12:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(413081004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 29 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_14) / 29)

				if (29 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_14) / 29)) > 0 and var_20_11 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16
					var_20_10 = var_20_10 + 0.3

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081004", "story_v_out_413081.awb") ~= 0 then
					local var_20_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081004", "story_v_out_413081.awb") / 1000

					if var_20_17 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_10
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_413081", "413081004", "story_v_out_413081.awb")

						arg_17_1:RecordAudio("413081004", var_20_18)
						arg_17_1:RecordAudio("413081004", var_20_18)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413081", "413081004", "story_v_out_413081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413081", "413081004", "story_v_out_413081.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = var_20_10 + 0.3
			local var_20_20 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413081005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413081005
		arg_23_1.duration_ = 5.1

		local var_23_0 = {
			zh = 3.033,
			ja = 5.1
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413081006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["10092"]) and arg_23_1.var_.actorSpriteComps10092 == nil then
				arg_23_1.var_.actorSpriteComps10092 = arg_23_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["10092"]) then
				if arg_23_1.var_.actorSpriteComps10092 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["10092"]) and arg_23_1.var_.actorSpriteComps10092 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps10092 = nil
			end

			local var_26_2 = 0
			local var_26_3 = 0.3

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_4 = arg_23_1:GetWordFromCfg(413081005)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 12 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 12)

				if (12 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 12)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081005", "story_v_out_413081.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081005", "story_v_out_413081.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_out_413081", "413081005", "story_v_out_413081.awb")

						arg_23_1:RecordAudio("413081005", var_26_9)
						arg_23_1:RecordAudio("413081005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413081", "413081005", "story_v_out_413081.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413081", "413081005", "story_v_out_413081.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413081006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413081006
		arg_27_1.duration_ = 5.2

		local var_27_0 = {
			zh = 3.666,
			ja = 5.2
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
				arg_27_0:Play413081007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["10092"]) and arg_27_1.var_.actorSpriteComps10092 == nil then
				arg_27_1.var_.actorSpriteComps10092 = arg_27_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["10092"]) then
				if arg_27_1.var_.actorSpriteComps10092 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["10092"]) and arg_27_1.var_.actorSpriteComps10092 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps10092 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.4

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:GetWordFromCfg(413081006)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 16 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 16)

				if (16 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 16)) > 0 and var_30_3 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081006", "story_v_out_413081.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081006", "story_v_out_413081.awb") / 1000

					if var_30_8 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_2
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_out_413081", "413081006", "story_v_out_413081.awb")

						arg_27_1:RecordAudio("413081006", var_30_9)
						arg_27_1:RecordAudio("413081006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413081", "413081006", "story_v_out_413081.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413081", "413081006", "story_v_out_413081.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_10 and arg_27_1.time_ < var_30_2 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play413081007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413081007
		arg_31_1.duration_ = 9.87

		local var_31_0 = {
			zh = 6.066,
			ja = 9.866
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
				arg_31_0:Play413081008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["10092"]) and arg_31_1.var_.actorSpriteComps10092 == nil then
				arg_31_1.var_.actorSpriteComps10092 = arg_31_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["10092"]) then
				if arg_31_1.var_.actorSpriteComps10092 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["10092"]) and arg_31_1.var_.actorSpriteComps10092 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps10092 = nil
			end

			local var_34_2 = 0
			local var_34_3 = 0.9

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_4 = arg_31_1:GetWordFromCfg(413081007)
				local var_34_5 = arg_31_1:FormatText(var_34_4.content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 36 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 36)

				if (36 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 36)) > 0 and var_34_3 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081007", "story_v_out_413081.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081007", "story_v_out_413081.awb") / 1000

					if var_34_8 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_2
					end

					if var_34_4.prefab_name ~= "" and arg_31_1.actors_[var_34_4.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_4.prefab_name].transform, "story_v_out_413081", "413081007", "story_v_out_413081.awb")

						arg_31_1:RecordAudio("413081007", var_34_9)
						arg_31_1:RecordAudio("413081007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413081", "413081007", "story_v_out_413081.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413081", "413081007", "story_v_out_413081.awb")
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

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play413081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413081008
		arg_35_1.duration_ = 5.83

		local var_35_0 = {
			zh = 3.966,
			ja = 5.833
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = arg_35_1.actors_["10092"].transform.localPosition
				arg_35_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 3)

				for iter_38_0 = 0, arg_35_1.actors_["10092"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["10092"].transform:GetChild(iter_38_0)

					if var_38_0.name == "split_5" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_38_2 = arg_35_1.actors_["10092"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10092 == nil then
				arg_35_1.var_.actorSpriteComps10092 = var_38_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_3 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.actorSpriteComps10092 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_38_2 then
							if arg_35_1.isInRecall_ then
								iter_38_2.color = Color.New(Mathf.Lerp(iter_38_2.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_3), Mathf.Lerp(iter_38_2.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_3), (Mathf.Lerp(iter_38_2.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_3)))
							else
								local var_38_4 = Mathf.Lerp(iter_38_2.color.r, 1, (arg_35_1.time_ - 0) / var_38_3)

								iter_38_2.color = Color.New(var_38_4, var_38_4, var_38_4)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10092 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_38_4 then
						iter_38_4.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps10092 = nil
			end

			local var_38_5 = 0
			local var_38_6 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_7 = arg_35_1:GetWordFromCfg(413081008)
				local var_38_8 = arg_35_1:FormatText(var_38_7.content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 18 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 18)

				if (18 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 18)) > 0 and var_38_6 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081008", "story_v_out_413081.awb") ~= 0 then
					local var_38_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081008", "story_v_out_413081.awb") / 1000

					if var_38_11 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_5
					end

					if var_38_7.prefab_name ~= "" and arg_35_1.actors_[var_38_7.prefab_name] ~= nil then
						local var_38_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_7.prefab_name].transform, "story_v_out_413081", "413081008", "story_v_out_413081.awb")

						arg_35_1:RecordAudio("413081008", var_38_12)
						arg_35_1:RecordAudio("413081008", var_38_12)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413081", "413081008", "story_v_out_413081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413081", "413081008", "story_v_out_413081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_13 and arg_35_1.time_ < var_38_5 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play413081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413081009
		arg_39_1.duration_ = 11.53

		local var_39_0 = {
			zh = 4.133,
			ja = 11.533
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["10092"]) and arg_39_1.var_.actorSpriteComps10092 == nil then
				arg_39_1.var_.actorSpriteComps10092 = arg_39_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_0 = 2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["10092"]) then
				if arg_39_1.var_.actorSpriteComps10092 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								iter_42_1.color = Color.New(Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_0), Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_0), (Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_0)))
							else
								local var_42_1 = Mathf.Lerp(iter_42_1.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_0)

								iter_42_1.color = Color.New(var_42_1, var_42_1, var_42_1)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["10092"]) and arg_39_1.var_.actorSpriteComps10092 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_42_3 then
						iter_42_3.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps10092 = nil
			end

			local var_42_2 = 0
			local var_42_3 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_4 = arg_39_1:GetWordFromCfg(413081009)
				local var_42_5 = arg_39_1:FormatText(var_42_4.content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 26 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 26)

				if (26 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 26)) > 0 and var_42_3 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081009", "story_v_out_413081.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081009", "story_v_out_413081.awb") / 1000

					if var_42_8 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_2
					end

					if var_42_4.prefab_name ~= "" and arg_39_1.actors_[var_42_4.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_4.prefab_name].transform, "story_v_out_413081", "413081009", "story_v_out_413081.awb")

						arg_39_1:RecordAudio("413081009", var_42_9)
						arg_39_1:RecordAudio("413081009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413081", "413081009", "story_v_out_413081.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413081", "413081009", "story_v_out_413081.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_10 and arg_39_1.time_ < var_42_2 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413081010
		arg_43_1.duration_ = 5.07

		local var_43_0 = {
			zh = 5.066,
			ja = 4.7
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
				arg_43_0:Play413081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10092 = arg_43_1.actors_["10092"].transform.localPosition
				arg_43_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10092", 7)

				for iter_46_0 = 0, arg_43_1.actors_["10092"].transform.childCount - 1 do
					local var_46_0 = arg_43_1.actors_["10092"].transform:GetChild(iter_46_0)

					if var_46_0.name == "split_8" or not string.find(var_46_0.name, "split") then
						var_46_0.gameObject:SetActive(true)
					else
						var_46_0.gameObject:SetActive(false)
					end
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 0) / var_46_1)
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_2 = "10093"

			if arg_43_1.actors_["10093"] == nil then
				local var_46_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_46_3) then
					local var_46_4 = Object.Instantiate(var_46_3, arg_43_1.canvasGo_.transform)

					var_46_4.transform:SetSiblingIndex(1)

					var_46_4.name = var_46_2
					var_46_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_2] = var_46_4

					if arg_43_1.isInRecall_ then
						for iter_46_1, iter_46_2 in ipairs((var_46_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_46_2.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_5 = arg_43_1.actors_["10093"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10093 = var_46_5.localPosition
				var_46_5.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10093", 3)

				for iter_46_3 = 0, var_46_5.childCount - 1 do
					local var_46_6 = var_46_5:GetChild(iter_46_3)

					if var_46_6.name == "split_7" or not string.find(var_46_6.name, "split") then
						var_46_6.gameObject:SetActive(true)
					else
						var_46_6.gameObject:SetActive(false)
					end
				end
			end

			local var_46_7 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				var_46_5.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_43_1.time_ - 0) / var_46_7)
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				var_46_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_46_8 = arg_43_1.actors_["10093"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.actorSpriteComps10093 == nil then
				arg_43_1.var_.actorSpriteComps10093 = var_46_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_9 and not isNil(var_46_8) then
				if arg_43_1.var_.actorSpriteComps10093 then
					for iter_46_4, iter_46_5 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_46_5 then
							if arg_43_1.isInRecall_ then
								iter_46_5.color = Color.New(Mathf.Lerp(iter_46_5.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_9), Mathf.Lerp(iter_46_5.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_9), (Mathf.Lerp(iter_46_5.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_9)))
							else
								local var_46_10 = Mathf.Lerp(iter_46_5.color.r, 1, (arg_43_1.time_ - 0) / var_46_9)

								iter_46_5.color = Color.New(var_46_10, var_46_10, var_46_10)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_9 and arg_43_1.time_ < 0 + var_46_9 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.actorSpriteComps10093 then
				for iter_46_6, iter_46_7 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_46_7 then
						iter_46_7.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10093 = nil
			end

			local var_46_11 = 0
			local var_46_12 = 0.6

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_13 = arg_43_1:GetWordFromCfg(413081010)
				local var_46_14 = arg_43_1:FormatText(var_46_13.content)

				arg_43_1.text_.text = var_46_14

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_16 = 24 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_14) / 24)

				if (24 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_14) / 24)) > 0 and var_46_12 < var_46_16 then
					arg_43_1.talkMaxDuration = var_46_16

					if var_46_16 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_11
					end
				end

				arg_43_1.text_.text = var_46_14
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081010", "story_v_out_413081.awb") ~= 0 then
					local var_46_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081010", "story_v_out_413081.awb") / 1000

					if var_46_17 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_11
					end

					if var_46_13.prefab_name ~= "" and arg_43_1.actors_[var_46_13.prefab_name] ~= nil then
						local var_46_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_13.prefab_name].transform, "story_v_out_413081", "413081010", "story_v_out_413081.awb")

						arg_43_1:RecordAudio("413081010", var_46_18)
						arg_43_1:RecordAudio("413081010", var_46_18)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413081", "413081010", "story_v_out_413081.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413081", "413081010", "story_v_out_413081.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_19 = math.max(var_46_12, arg_43_1.talkMaxDuration)

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_19 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_11) / var_46_19

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_11 + var_46_19 and arg_43_1.time_ < var_46_11 + var_46_19 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play413081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413081011
		arg_47_1.duration_ = 8.37

		local var_47_0 = {
			zh = 4.466,
			ja = 8.366
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10092 = arg_47_1.actors_["10092"].transform.localPosition
				arg_47_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10092", 7)

				for iter_50_0 = 0, arg_47_1.actors_["10092"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10092"].transform:GetChild(iter_50_0)

					if var_50_0.name == "" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_50_2 = "10094"

			if arg_47_1.actors_["10094"] == nil then
				local var_50_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_50_3) then
					local var_50_4 = Object.Instantiate(var_50_3, arg_47_1.canvasGo_.transform)

					var_50_4.transform:SetSiblingIndex(1)

					var_50_4.name = var_50_2
					var_50_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_47_1.actors_[var_50_2] = var_50_4

					if arg_47_1.isInRecall_ then
						for iter_50_1, iter_50_2 in ipairs((var_50_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_50_2.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_50_5 = arg_47_1.actors_["10094"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10094 = var_50_5.localPosition
				var_50_5.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10094", 3)

				for iter_50_3 = 0, var_50_5.childCount - 1 do
					local var_50_6 = var_50_5:GetChild(iter_50_3)

					if var_50_6.name == "split_2" or not string.find(var_50_6.name, "split") then
						var_50_6.gameObject:SetActive(true)
					else
						var_50_6.gameObject:SetActive(false)
					end
				end
			end

			local var_50_7 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_47_1.time_ - 0) / var_50_7)
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_50_8 = arg_47_1.actors_["10092"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.actorSpriteComps10092 == nil then
				arg_47_1.var_.actorSpriteComps10092 = var_50_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_9 and not isNil(var_50_8) then
				if arg_47_1.var_.actorSpriteComps10092 then
					for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_50_5 then
							if arg_47_1.isInRecall_ then
								iter_50_5.color = Color.New(Mathf.Lerp(iter_50_5.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_9), Mathf.Lerp(iter_50_5.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_9), (Mathf.Lerp(iter_50_5.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_9)))
							else
								local var_50_10 = Mathf.Lerp(iter_50_5.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_9)

								iter_50_5.color = Color.New(var_50_10, var_50_10, var_50_10)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_9 and arg_47_1.time_ < 0 + var_50_9 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.actorSpriteComps10092 then
				for iter_50_6, iter_50_7 in pairs(arg_47_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_50_7 then
						iter_50_7.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps10092 = nil
			end

			local var_50_11 = arg_47_1.actors_["10094"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_11) and arg_47_1.var_.actorSpriteComps10094 == nil then
				arg_47_1.var_.actorSpriteComps10094 = var_50_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_12 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_12 and not isNil(var_50_11) then
				if arg_47_1.var_.actorSpriteComps10094 then
					for iter_50_8, iter_50_9 in pairs(arg_47_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_50_9 then
							if arg_47_1.isInRecall_ then
								iter_50_9.color = Color.New(Mathf.Lerp(iter_50_9.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_12), Mathf.Lerp(iter_50_9.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_12), (Mathf.Lerp(iter_50_9.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_12)))
							else
								local var_50_13 = Mathf.Lerp(iter_50_9.color.r, 1, (arg_47_1.time_ - 0) / var_50_12)

								iter_50_9.color = Color.New(var_50_13, var_50_13, var_50_13)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_12 and arg_47_1.time_ < 0 + var_50_12 + arg_50_0 and not isNil(var_50_11) and arg_47_1.var_.actorSpriteComps10094 then
				for iter_50_10, iter_50_11 in pairs(arg_47_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_50_11 then
						iter_50_11.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10094 = nil
			end

			local var_50_14 = 0
			local var_50_15 = 0.5

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_16 = arg_47_1:GetWordFromCfg(413081011)
				local var_50_17 = arg_47_1:FormatText(var_50_16.content)

				arg_47_1.text_.text = var_50_17

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_19 = 20 <= 0 and var_50_15 or var_50_15 * (utf8.len(var_50_17) / 20)

				if (20 <= 0 and var_50_15 or var_50_15 * (utf8.len(var_50_17) / 20)) > 0 and var_50_15 < var_50_19 then
					arg_47_1.talkMaxDuration = var_50_19

					if var_50_19 + var_50_14 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_19 + var_50_14
					end
				end

				arg_47_1.text_.text = var_50_17
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081011", "story_v_out_413081.awb") ~= 0 then
					local var_50_20 = manager.audio:GetVoiceLength("story_v_out_413081", "413081011", "story_v_out_413081.awb") / 1000

					if var_50_20 + var_50_14 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_14
					end

					if var_50_16.prefab_name ~= "" and arg_47_1.actors_[var_50_16.prefab_name] ~= nil then
						local var_50_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_16.prefab_name].transform, "story_v_out_413081", "413081011", "story_v_out_413081.awb")

						arg_47_1:RecordAudio("413081011", var_50_21)
						arg_47_1:RecordAudio("413081011", var_50_21)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413081", "413081011", "story_v_out_413081.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413081", "413081011", "story_v_out_413081.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_15, arg_47_1.talkMaxDuration)

			if var_50_14 <= arg_47_1.time_ and arg_47_1.time_ < var_50_14 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_14) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_14 + var_50_22 and arg_47_1.time_ < var_50_14 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play413081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413081012
		arg_51_1.duration_ = 2

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10093 = arg_51_1.actors_["10093"].transform.localPosition
				arg_51_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10093", 3)

				for iter_54_0 = 0, arg_51_1.actors_["10093"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["10093"].transform:GetChild(iter_54_0)

					if var_54_0.name == "split_4" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_54_2 = arg_51_1.actors_["10094"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10094 = var_54_2.localPosition
				var_54_2.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10094", 7)

				for iter_54_1 = 0, var_54_2.childCount - 1 do
					local var_54_3 = var_54_2:GetChild(iter_54_1)

					if var_54_3.name == "" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0) / var_54_4)
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_5 = arg_51_1.actors_["10093"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10093 == nil then
				arg_51_1.var_.actorSpriteComps10093 = var_54_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.actorSpriteComps10093 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								iter_54_3.color = Color.New(Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_6), Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_6), (Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_6)))
							else
								local var_54_7 = Mathf.Lerp(iter_54_3.color.r, 1, (arg_51_1.time_ - 0) / var_54_6)

								iter_54_3.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10093 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_54_5 then
						iter_54_5.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps10093 = nil
			end

			local var_54_8 = arg_51_1.actors_["10094"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10094 == nil then
				arg_51_1.var_.actorSpriteComps10094 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_9 and not isNil(var_54_8) then
				if arg_51_1.var_.actorSpriteComps10094 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								iter_54_7.color = Color.New(Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_9), Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_9), (Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_9)))
							else
								local var_54_10 = Mathf.Lerp(iter_54_7.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_9)

								iter_54_7.color = Color.New(var_54_10, var_54_10, var_54_10)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_9 and arg_51_1.time_ < 0 + var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10094 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_54_9 then
						iter_54_9.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10094 = nil
			end

			local var_54_11 = 0
			local var_54_12 = 0.1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(413081012)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 4 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_14) / 4)

				if (4 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_14) / 4)) > 0 and var_54_12 < var_54_16 then
					arg_51_1.talkMaxDuration = var_54_16

					if var_54_16 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081012", "story_v_out_413081.awb") ~= 0 then
					local var_54_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081012", "story_v_out_413081.awb") / 1000

					if var_54_17 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_11
					end

					if var_54_13.prefab_name ~= "" and arg_51_1.actors_[var_54_13.prefab_name] ~= nil then
						local var_54_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_13.prefab_name].transform, "story_v_out_413081", "413081012", "story_v_out_413081.awb")

						arg_51_1:RecordAudio("413081012", var_54_18)
						arg_51_1:RecordAudio("413081012", var_54_18)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413081", "413081012", "story_v_out_413081.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413081", "413081012", "story_v_out_413081.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_19 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_19 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_19

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_19 and arg_51_1.time_ < var_54_11 + var_54_19 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play413081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413081013
		arg_55_1.duration_ = 6.3

		local var_55_0 = {
			zh = 4.466,
			ja = 6.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10093 = arg_55_1.actors_["10093"].transform.localPosition
				arg_55_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10093", 7)

				for iter_58_0 = 0, arg_55_1.actors_["10093"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["10093"].transform:GetChild(iter_58_0)

					if var_58_0.name == "" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_58_2 = arg_55_1.actors_["10092"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10092 = var_58_2.localPosition
				var_58_2.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10092", 3)

				for iter_58_1 = 0, var_58_2.childCount - 1 do
					local var_58_3 = var_58_2:GetChild(iter_58_1)

					if var_58_3.name == "split_8" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_2.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_55_1.time_ - 0) / var_58_4)
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_58_5 = arg_55_1.actors_["10093"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10093 == nil then
				arg_55_1.var_.actorSpriteComps10093 = var_58_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_6 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.actorSpriteComps10093 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								iter_58_3.color = Color.New(Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_6), Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_6), (Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_6)))
							else
								local var_58_7 = Mathf.Lerp(iter_58_3.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_6)

								iter_58_3.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10093 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_58_5 then
						iter_58_5.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps10093 = nil
			end

			local var_58_8 = arg_55_1.actors_["10092"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10092 == nil then
				arg_55_1.var_.actorSpriteComps10092 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_9 and not isNil(var_58_8) then
				if arg_55_1.var_.actorSpriteComps10092 then
					for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_58_7 then
							if arg_55_1.isInRecall_ then
								iter_58_7.color = Color.New(Mathf.Lerp(iter_58_7.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_9), Mathf.Lerp(iter_58_7.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_9), (Mathf.Lerp(iter_58_7.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_9)))
							else
								local var_58_10 = Mathf.Lerp(iter_58_7.color.r, 1, (arg_55_1.time_ - 0) / var_58_9)

								iter_58_7.color = Color.New(var_58_10, var_58_10, var_58_10)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_9 and arg_55_1.time_ < 0 + var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10092 then
				for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_58_9 then
						iter_58_9.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10092 = nil
			end

			local var_58_11 = 0
			local var_58_12 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_13 = arg_55_1:GetWordFromCfg(413081013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 27 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 27)

				if (27 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 27)) > 0 and var_58_12 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081013", "story_v_out_413081.awb") ~= 0 then
					local var_58_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081013", "story_v_out_413081.awb") / 1000

					if var_58_17 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_11
					end

					if var_58_13.prefab_name ~= "" and arg_55_1.actors_[var_58_13.prefab_name] ~= nil then
						local var_58_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_13.prefab_name].transform, "story_v_out_413081", "413081013", "story_v_out_413081.awb")

						arg_55_1:RecordAudio("413081013", var_58_18)
						arg_55_1:RecordAudio("413081013", var_58_18)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413081", "413081013", "story_v_out_413081.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413081", "413081013", "story_v_out_413081.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_19 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_19 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_19

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_19 and arg_55_1.time_ < var_58_11 + var_58_19 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play413081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413081014
		arg_59_1.duration_ = 5.73

		local var_59_0 = {
			zh = 3.3,
			ja = 5.733
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
				arg_59_0:Play413081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.45

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(413081014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 18 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 18)

				if (18 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 18)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081014", "story_v_out_413081.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081014", "story_v_out_413081.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_413081", "413081014", "story_v_out_413081.awb")

						arg_59_1:RecordAudio("413081014", var_62_6)
						arg_59_1:RecordAudio("413081014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413081", "413081014", "story_v_out_413081.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413081", "413081014", "story_v_out_413081.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play413081015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413081015
		arg_63_1.duration_ = 4.27

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 4.266
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413081016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10092 = arg_63_1.actors_["10092"].transform.localPosition
				arg_63_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10092", 7)

				for iter_66_0 = 0, arg_63_1.actors_["10092"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["10092"].transform:GetChild(iter_66_0)

					if var_66_0.name == "" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_66_2 = arg_63_1.actors_["10094"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10094 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10094", 3)

				for iter_66_1 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_1)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_66_5 = arg_63_1.actors_["10092"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.actorSpriteComps10092 == nil then
				arg_63_1.var_.actorSpriteComps10092 = var_66_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_6 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.actorSpriteComps10092 then
					for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_66_3 then
							if arg_63_1.isInRecall_ then
								iter_66_3.color = Color.New(Mathf.Lerp(iter_66_3.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_6), Mathf.Lerp(iter_66_3.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_6), (Mathf.Lerp(iter_66_3.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_6)))
							else
								local var_66_7 = Mathf.Lerp(iter_66_3.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_6)

								iter_66_3.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.actorSpriteComps10092 then
				for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_66_5 then
						iter_66_5.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10092 = nil
			end

			local var_66_8 = arg_63_1.actors_["10094"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10094 == nil then
				arg_63_1.var_.actorSpriteComps10094 = var_66_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_9 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_9 and not isNil(var_66_8) then
				if arg_63_1.var_.actorSpriteComps10094 then
					for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_66_7 then
							if arg_63_1.isInRecall_ then
								iter_66_7.color = Color.New(Mathf.Lerp(iter_66_7.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_9), Mathf.Lerp(iter_66_7.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_9), (Mathf.Lerp(iter_66_7.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_9)))
							else
								local var_66_10 = Mathf.Lerp(iter_66_7.color.r, 1, (arg_63_1.time_ - 0) / var_66_9)

								iter_66_7.color = Color.New(var_66_10, var_66_10, var_66_10)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_9 and arg_63_1.time_ < 0 + var_66_9 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps10094 then
				for iter_66_8, iter_66_9 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_66_9 then
						iter_66_9.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10094 = nil
			end

			local var_66_11 = 0
			local var_66_12 = 0.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_13 = arg_63_1:GetWordFromCfg(413081015)
				local var_66_14 = arg_63_1:FormatText(var_66_13.content)

				arg_63_1.text_.text = var_66_14

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 6 <= 0 and var_66_12 or var_66_12 * (utf8.len(var_66_14) / 6)

				if (6 <= 0 and var_66_12 or var_66_12 * (utf8.len(var_66_14) / 6)) > 0 and var_66_12 < var_66_16 then
					arg_63_1.talkMaxDuration = var_66_16

					if var_66_16 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_16 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_14
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081015", "story_v_out_413081.awb") ~= 0 then
					local var_66_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081015", "story_v_out_413081.awb") / 1000

					if var_66_17 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_11
					end

					if var_66_13.prefab_name ~= "" and arg_63_1.actors_[var_66_13.prefab_name] ~= nil then
						local var_66_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_13.prefab_name].transform, "story_v_out_413081", "413081015", "story_v_out_413081.awb")

						arg_63_1:RecordAudio("413081015", var_66_18)
						arg_63_1:RecordAudio("413081015", var_66_18)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413081", "413081015", "story_v_out_413081.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413081", "413081015", "story_v_out_413081.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_19 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_19 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_19

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_19 and arg_63_1.time_ < var_66_11 + var_66_19 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play413081016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413081016
		arg_67_1.duration_ = 2.37

		local var_67_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play413081017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10094 = arg_67_1.actors_["10094"].transform.localPosition
				arg_67_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10094", 0)

				for iter_70_0 = 0, arg_67_1.actors_["10094"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["10094"].transform:GetChild(iter_70_0)

					if var_70_0.name == "" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_70_2 = arg_67_1.actors_["10092"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10092 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10092", 3)

				for iter_70_1 = 0, var_70_2.childCount - 1 do
					local var_70_3 = var_70_2:GetChild(iter_70_1)

					if var_70_3.name == "split_8" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_67_1.time_ - 0) / var_70_4)
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_70_5 = arg_67_1.actors_["10094"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps10094 == nil then
				arg_67_1.var_.actorSpriteComps10094 = var_70_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_6 = 2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.actorSpriteComps10094 then
					for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_70_3 then
							if arg_67_1.isInRecall_ then
								iter_70_3.color = Color.New(Mathf.Lerp(iter_70_3.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_6), Mathf.Lerp(iter_70_3.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_6), (Mathf.Lerp(iter_70_3.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_6)))
							else
								local var_70_7 = Mathf.Lerp(iter_70_3.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_6)

								iter_70_3.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps10094 then
				for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_70_5 then
						iter_70_5.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps10094 = nil
			end

			local var_70_8 = arg_67_1.actors_["10092"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps10092 == nil then
				arg_67_1.var_.actorSpriteComps10092 = var_70_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_9 and not isNil(var_70_8) then
				if arg_67_1.var_.actorSpriteComps10092 then
					for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_70_7 then
							if arg_67_1.isInRecall_ then
								iter_70_7.color = Color.New(Mathf.Lerp(iter_70_7.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_9), Mathf.Lerp(iter_70_7.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_9), (Mathf.Lerp(iter_70_7.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_9)))
							else
								local var_70_10 = Mathf.Lerp(iter_70_7.color.r, 1, (arg_67_1.time_ - 0) / var_70_9)

								iter_70_7.color = Color.New(var_70_10, var_70_10, var_70_10)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_9 and arg_67_1.time_ < 0 + var_70_9 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps10092 then
				for iter_70_8, iter_70_9 in pairs(arg_67_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_70_9 then
						iter_70_9.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps10092 = nil
			end

			local var_70_11 = 0
			local var_70_12 = 0.1

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_13 = arg_67_1:GetWordFromCfg(413081016)
				local var_70_14 = arg_67_1:FormatText(var_70_13.content)

				arg_67_1.text_.text = var_70_14

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_16 = 4 <= 0 and var_70_12 or var_70_12 * (utf8.len(var_70_14) / 4)

				if (4 <= 0 and var_70_12 or var_70_12 * (utf8.len(var_70_14) / 4)) > 0 and var_70_12 < var_70_16 then
					arg_67_1.talkMaxDuration = var_70_16

					if var_70_16 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_11
					end
				end

				arg_67_1.text_.text = var_70_14
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081016", "story_v_out_413081.awb") ~= 0 then
					local var_70_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081016", "story_v_out_413081.awb") / 1000

					if var_70_17 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_17 + var_70_11
					end

					if var_70_13.prefab_name ~= "" and arg_67_1.actors_[var_70_13.prefab_name] ~= nil then
						local var_70_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_13.prefab_name].transform, "story_v_out_413081", "413081016", "story_v_out_413081.awb")

						arg_67_1:RecordAudio("413081016", var_70_18)
						arg_67_1:RecordAudio("413081016", var_70_18)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413081", "413081016", "story_v_out_413081.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413081", "413081016", "story_v_out_413081.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_19 = math.max(var_70_12, arg_67_1.talkMaxDuration)

			if var_70_11 <= arg_67_1.time_ and arg_67_1.time_ < var_70_11 + var_70_19 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_11) / var_70_19

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_11 + var_70_19 and arg_67_1.time_ < var_70_11 + var_70_19 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play413081017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413081017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play413081018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_0 = arg_71_1.bgs_.F08m

				arg_71_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_1 = var_74_0:GetComponent("SpriteRenderer")

				if var_74_1 and var_74_1.sprite then
					local var_74_2 = 2 * (var_74_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_0.transform.localScale = Vector3.New(var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "F08m" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_3 = 4

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_3 + 0.3 and arg_71_1.time_ < var_74_3 + 0.3 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_4 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_5 = 2

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_5 then
				local var_74_6 = Color.New(0, 0, 0)

				var_74_6.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_4) / var_74_5)
				arg_71_1.mask_.color = var_74_6
			end

			if arg_71_1.time_ >= var_74_4 + var_74_5 and arg_71_1.time_ < var_74_4 + var_74_5 + arg_74_0 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = 1
				arg_71_1.mask_.color = var_74_7
			end

			local var_74_8 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_9 = 2

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 then
				local var_74_10 = Color.New(0, 0, 0)

				var_74_10.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_8) / var_74_9)
				arg_71_1.mask_.color = var_74_10
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 then
				local var_74_11 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_11.a = 0
				arg_71_1.mask_.color = var_74_11
			end

			local var_74_12 = arg_71_1.actors_["10092"].transform

			if 1.966 < arg_71_1.time_ and arg_71_1.time_ <= 1.966 + arg_74_0 then
				arg_71_1.var_.moveOldPos10092 = var_74_12.localPosition
				var_74_12.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10092", 7)

				for iter_74_2 = 0, var_74_12.childCount - 1 do
					local var_74_13 = var_74_12:GetChild(iter_74_2)

					if var_74_13.name == "" or not string.find(var_74_13.name, "split") then
						var_74_13.gameObject:SetActive(true)
					else
						var_74_13.gameObject:SetActive(false)
					end
				end
			end

			local var_74_14 = 0.001

			if 1.966 <= arg_71_1.time_ and arg_71_1.time_ < 1.966 + var_74_14 then
				var_74_12.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_71_1.time_ - 1.966) / var_74_14)
			end

			if arg_71_1.time_ >= 1.966 + var_74_14 and arg_71_1.time_ < 1.966 + var_74_14 + arg_74_0 then
				var_74_12.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_15 = 4
			local var_74_16 = 1.625

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_17 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_17:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(413081017).content)

				arg_71_1.text_.text = var_74_18

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 65 <= 0 and var_74_16 or var_74_16 * (utf8.len(var_74_18) / 65)

				if (65 <= 0 and var_74_16 or var_74_16 * (utf8.len(var_74_18) / 65)) > 0 and var_74_16 < var_74_20 then
					arg_71_1.talkMaxDuration = var_74_20
					var_74_15 = var_74_15 + 0.3

					if var_74_20 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_18
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = var_74_15 + 0.3
			local var_74_22 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_21) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_21 + var_74_22 and arg_71_1.time_ < var_74_21 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play413081018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413081018
		arg_77_1.duration_ = 4.8

		local var_77_0 = {
			zh = 3.733,
			ja = 4.8
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
				arg_77_0:Play413081019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092 = arg_77_1.actors_["10092"].transform.localPosition
				arg_77_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092", 3)

				for iter_80_0 = 0, arg_77_1.actors_["10092"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10092"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_8" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_80_2 = arg_77_1.actors_["10092"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.575

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413081018)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 23 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 23)

				if (23 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 23)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081018", "story_v_out_413081.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081018", "story_v_out_413081.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413081", "413081018", "story_v_out_413081.awb")

						arg_77_1:RecordAudio("413081018", var_80_12)
						arg_77_1:RecordAudio("413081018", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413081", "413081018", "story_v_out_413081.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413081", "413081018", "story_v_out_413081.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413081019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413081019
		arg_81_1.duration_ = 5.13

		local var_81_0 = {
			zh = 3.333,
			ja = 5.133
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
				arg_81_0:Play413081020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.575

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(413081019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 23 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 23)

				if (23 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 23)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081019", "story_v_out_413081.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081019", "story_v_out_413081.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_413081", "413081019", "story_v_out_413081.awb")

						arg_81_1:RecordAudio("413081019", var_84_6)
						arg_81_1:RecordAudio("413081019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413081", "413081019", "story_v_out_413081.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413081", "413081019", "story_v_out_413081.awb")
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
	Play413081020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413081020
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play413081021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10092"]) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = arg_85_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10092"]) then
				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10092"]) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			local var_88_2 = 0
			local var_88_3 = 0.15

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_4 = arg_85_1:GetWordFromCfg(413081020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 6 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 6)

				if (6 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 6)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081020", "story_v_out_413081.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081020", "story_v_out_413081.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_413081", "413081020", "story_v_out_413081.awb")

						arg_85_1:RecordAudio("413081020", var_88_9)
						arg_85_1:RecordAudio("413081020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413081", "413081020", "story_v_out_413081.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413081", "413081020", "story_v_out_413081.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413081021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413081021
		arg_89_1.duration_ = 2.6

		local var_89_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_89_0:Play413081022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092 = arg_89_1.actors_["10092"].transform.localPosition
				arg_89_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092", 2)

				for iter_92_0 = 0, arg_89_1.actors_["10092"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10092"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_8" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_92_2 = arg_89_1.actors_["10093"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 4)

				for iter_92_1 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_1)

					if var_92_3.name == "split_7" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_92_5 = arg_89_1.actors_["10092"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10092 == nil then
				arg_89_1.var_.actorSpriteComps10092 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps10092 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								iter_92_3.color = Color.New(Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_3.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_3.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10092 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_92_5 then
						iter_92_5.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10092 = nil
			end

			local var_92_8 = arg_89_1.actors_["10093"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10093 == nil then
				arg_89_1.var_.actorSpriteComps10093 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 and not isNil(var_92_8) then
				if arg_89_1.var_.actorSpriteComps10093 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								iter_92_7.color = Color.New(Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_9), Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_9), (Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_9)))
							else
								local var_92_10 = Mathf.Lerp(iter_92_7.color.r, 1, (arg_89_1.time_ - 0) / var_92_9)

								iter_92_7.color = Color.New(var_92_10, var_92_10, var_92_10)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10093 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_92_9 then
						iter_92_9.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10093 = nil
			end

			local var_92_11 = 0
			local var_92_12 = 0.25

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(413081021)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 10 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 10)

				if (10 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 10)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081021", "story_v_out_413081.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081021", "story_v_out_413081.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_413081", "413081021", "story_v_out_413081.awb")

						arg_89_1:RecordAudio("413081021", var_92_18)
						arg_89_1:RecordAudio("413081021", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413081", "413081021", "story_v_out_413081.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413081", "413081021", "story_v_out_413081.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play413081022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413081022
		arg_93_1.duration_ = 4.83

		local var_93_0 = {
			zh = 4.833,
			ja = 3.8
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
				arg_93_0:Play413081023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = arg_93_1.actors_["10092"].transform.localPosition
				arg_93_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 2)

				for iter_96_0 = 0, arg_93_1.actors_["10092"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10092"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_8" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_96_2 = arg_93_1.actors_["10093"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10093 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10093", 4)

				for iter_96_1 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_1)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_96_5 = arg_93_1.actors_["10092"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 1, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_8 = arg_93_1.actors_["10093"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(413081022)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 26 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 26)

				if (26 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 26)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081022", "story_v_out_413081.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081022", "story_v_out_413081.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_413081", "413081022", "story_v_out_413081.awb")

						arg_93_1:RecordAudio("413081022", var_96_18)
						arg_93_1:RecordAudio("413081022", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413081", "413081022", "story_v_out_413081.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413081", "413081022", "story_v_out_413081.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play413081023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413081023
		arg_97_1.duration_ = 12.97

		local var_97_0 = {
			zh = 5.666,
			ja = 12.966
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
				arg_97_0:Play413081024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.825

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(413081023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 33 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 33)

				if (33 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 33)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081023", "story_v_out_413081.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081023", "story_v_out_413081.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_413081", "413081023", "story_v_out_413081.awb")

						arg_97_1:RecordAudio("413081023", var_100_6)
						arg_97_1:RecordAudio("413081023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413081", "413081023", "story_v_out_413081.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413081", "413081023", "story_v_out_413081.awb")
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
	Play413081024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413081024
		arg_101_1.duration_ = 3.37

		local var_101_0 = {
			zh = 3.366,
			ja = 3.2
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
				arg_101_0:Play413081025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = arg_101_1.actors_["10093"].transform.localPosition
				arg_101_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 4)

				for iter_104_0 = 0, arg_101_1.actors_["10093"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10093"].transform:GetChild(iter_104_0)

					if var_104_0.name == "split_4" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_104_2 = arg_101_1.actors_["10092"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10092 == nil then
				arg_101_1.var_.actorSpriteComps10092 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10092 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10092 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10092 = nil
			end

			local var_104_5 = arg_101_1.actors_["10093"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								iter_104_6.color = Color.New(Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_6.color.r, 1, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_6.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_8 then
						iter_104_8.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(413081024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)

				if (19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081024", "story_v_out_413081.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081024", "story_v_out_413081.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_413081", "413081024", "story_v_out_413081.awb")

						arg_101_1:RecordAudio("413081024", var_104_15)
						arg_101_1:RecordAudio("413081024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413081", "413081024", "story_v_out_413081.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413081", "413081024", "story_v_out_413081.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play413081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413081025
		arg_105_1.duration_ = 2.93

		local var_105_0 = {
			zh = 2.833,
			ja = 2.933
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
				arg_105_0:Play413081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10092"]) and arg_105_1.var_.actorSpriteComps10092 == nil then
				arg_105_1.var_.actorSpriteComps10092 = arg_105_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10092"]) then
				if arg_105_1.var_.actorSpriteComps10092 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 1, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10092"]) and arg_105_1.var_.actorSpriteComps10092 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10092 = nil
			end

			local var_108_2 = arg_105_1.actors_["10093"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								iter_108_5.color = Color.New(Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_5.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_5.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_7 then
						iter_108_7.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_5 = arg_105_1.actors_["10092"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092 = var_108_5.localPosition
				var_108_5.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092", 2)

				for iter_108_8 = 0, var_108_5.childCount - 1 do
					local var_108_6 = var_108_5:GetChild(iter_108_8)

					if var_108_6.name == "split_1_1" or not string.find(var_108_6.name, "split") then
						var_108_6.gameObject:SetActive(true)
					else
						var_108_6.gameObject:SetActive(false)
					end
				end
			end

			local var_108_7 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_105_1.time_ - 0) / var_108_7)
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_108_8 = 0
			local var_108_9 = 0.325

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(413081025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 13 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 13)

				if (13 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 13)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081025", "story_v_out_413081.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081025", "story_v_out_413081.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_413081", "413081025", "story_v_out_413081.awb")

						arg_105_1:RecordAudio("413081025", var_108_15)
						arg_105_1:RecordAudio("413081025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413081", "413081025", "story_v_out_413081.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413081", "413081025", "story_v_out_413081.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413081026
		arg_109_1.duration_ = 7.97

		local var_109_0 = {
			zh = 4.1,
			ja = 7.966
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
				arg_109_0:Play413081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.65

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(413081026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 26)

				if (26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 26)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081026", "story_v_out_413081.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081026", "story_v_out_413081.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_413081", "413081026", "story_v_out_413081.awb")

						arg_109_1:RecordAudio("413081026", var_112_6)
						arg_109_1:RecordAudio("413081026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413081", "413081026", "story_v_out_413081.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413081", "413081026", "story_v_out_413081.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413081027
		arg_113_1.duration_ = 5.1

		local var_113_0 = {
			zh = 1.5,
			ja = 5.1
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
				arg_113_0:Play413081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.2

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(413081027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 8 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 8)

				if (8 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 8)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081027", "story_v_out_413081.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081027", "story_v_out_413081.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_413081", "413081027", "story_v_out_413081.awb")

						arg_113_1:RecordAudio("413081027", var_116_6)
						arg_113_1:RecordAudio("413081027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413081", "413081027", "story_v_out_413081.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413081", "413081027", "story_v_out_413081.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413081028
		arg_117_1.duration_ = 3.53

		local var_117_0 = {
			zh = 2.966,
			ja = 3.533
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
				arg_117_0:Play413081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10092"]) and arg_117_1.var_.actorSpriteComps10092 == nil then
				arg_117_1.var_.actorSpriteComps10092 = arg_117_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10092"]) then
				if arg_117_1.var_.actorSpriteComps10092 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10092"]) and arg_117_1.var_.actorSpriteComps10092 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10092 = nil
			end

			local var_120_2 = arg_117_1.actors_["10093"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10093 == nil then
				arg_117_1.var_.actorSpriteComps10093 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10093 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								iter_120_5.color = Color.New(Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_5.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_5.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10093 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_120_7 then
						iter_120_7.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10093 = nil
			end

			local var_120_5 = 0
			local var_120_6 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(413081028)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 10 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 10)

				if (10 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 10)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081028", "story_v_out_413081.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081028", "story_v_out_413081.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_413081", "413081028", "story_v_out_413081.awb")

						arg_117_1:RecordAudio("413081028", var_120_12)
						arg_117_1:RecordAudio("413081028", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413081", "413081028", "story_v_out_413081.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413081", "413081028", "story_v_out_413081.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play413081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413081029
		arg_121_1.duration_ = 6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10093"]) and arg_121_1.var_.actorSpriteComps10093 == nil then
				arg_121_1.var_.actorSpriteComps10093 = arg_121_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10093"]) then
				if arg_121_1.var_.actorSpriteComps10093 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10093"]) and arg_121_1.var_.actorSpriteComps10093 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				local var_124_2 = arg_121_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_2 then
					arg_121_1.var_.alphaOldValue10092 = var_124_2.alpha
					arg_121_1.var_.characterEffect10092 = var_124_2
				end

				arg_121_1.var_.alphaOldValue10092 = 1
			end

			local var_124_3 = 0.5

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				if arg_121_1.var_.characterEffect10092 then
					arg_121_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_121_1.var_.alphaOldValue10092, 0, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and arg_121_1.var_.characterEffect10092 then
				arg_121_1.var_.characterEffect10092.alpha = 0
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				local var_124_4 = arg_121_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_4 then
					arg_121_1.var_.alphaOldValue10093 = var_124_4.alpha
					arg_121_1.var_.characterEffect10093 = var_124_4
				end

				arg_121_1.var_.alphaOldValue10093 = 1
			end

			local var_124_5 = 0.5

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				if arg_121_1.var_.characterEffect10093 then
					arg_121_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_121_1.var_.alphaOldValue10093, 0, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and arg_121_1.var_.characterEffect10093 then
				arg_121_1.var_.characterEffect10093.alpha = 0
			end

			if 0.366666666666667 < arg_121_1.time_ and arg_121_1.time_ <= 0.366666666666667 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hit", "")
			end

			if 0.6666667 < arg_121_1.time_ and arg_121_1.time_ <= 0.6666667 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_hit02", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_8 = 1
			local var_124_9 = 1.575

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_10 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_10:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(413081029).content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 63 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 63)

				if (63 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 63)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13
					var_124_8 = var_124_8 + 0.3

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = var_124_8 + 0.3
			local var_124_15 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_14) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_14 + var_124_15 and arg_121_1.time_ < var_124_14 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play413081030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413081030
		arg_127_1.duration_ = 9.43

		local var_127_0 = {
			zh = 6.6,
			ja = 9.433
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
				arg_127_0:Play413081031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10092 = arg_127_1.actors_["10092"].transform.localPosition
				arg_127_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10092", 3)

				for iter_130_0 = 0, arg_127_1.actors_["10092"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10092"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_1_1" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_130_2 = arg_127_1.actors_["10093"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10093 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10093", 4)

				for iter_130_1 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_1)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10093, Vector3.New(390, -350, -180), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_130_5 = arg_127_1.actors_["10092"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10092 == nil then
				arg_127_1.var_.actorSpriteComps10092 = var_130_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_6 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.actorSpriteComps10092 then
					for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_130_3 then
							if arg_127_1.isInRecall_ then
								iter_130_3.color = Color.New(Mathf.Lerp(iter_130_3.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_6), Mathf.Lerp(iter_130_3.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_6), (Mathf.Lerp(iter_130_3.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_6)))
							else
								local var_130_7 = Mathf.Lerp(iter_130_3.color.r, 1, (arg_127_1.time_ - 0) / var_130_6)

								iter_130_3.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10092 then
				for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_130_5 then
						iter_130_5.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10092 = nil
			end

			local var_130_8 = arg_127_1.actors_["10093"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10093 == nil then
				arg_127_1.var_.actorSpriteComps10093 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.actorSpriteComps10093 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								iter_130_7.color = Color.New(Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_7.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_7.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10093 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_130_9 then
						iter_130_9.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_11 = arg_127_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_11 then
					arg_127_1.var_.alphaOldValue10092 = var_130_11.alpha
					arg_127_1.var_.characterEffect10092 = var_130_11
				end

				arg_127_1.var_.alphaOldValue10092 = 0
			end

			local var_130_12 = 0.5

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_12 then
				if arg_127_1.var_.characterEffect10092 then
					arg_127_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_127_1.var_.alphaOldValue10092, 1, (arg_127_1.time_ - 0) / var_130_12)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_12 and arg_127_1.time_ < 0 + var_130_12 + arg_130_0 and arg_127_1.var_.characterEffect10092 then
				arg_127_1.var_.characterEffect10092.alpha = 1
			end

			local var_130_13 = 0
			local var_130_14 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(413081030)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_18 = 24 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 24)

				if (24 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 24)) > 0 and var_130_14 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18

					if var_130_18 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_13
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081030", "story_v_out_413081.awb") ~= 0 then
					local var_130_19 = manager.audio:GetVoiceLength("story_v_out_413081", "413081030", "story_v_out_413081.awb") / 1000

					if var_130_19 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_13
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_413081", "413081030", "story_v_out_413081.awb")

						arg_127_1:RecordAudio("413081030", var_130_20)
						arg_127_1:RecordAudio("413081030", var_130_20)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413081", "413081030", "story_v_out_413081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413081", "413081030", "story_v_out_413081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_21 = math.max(var_130_14, arg_127_1.talkMaxDuration)

			if var_130_13 <= arg_127_1.time_ and arg_127_1.time_ < var_130_13 + var_130_21 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_13) / var_130_21

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_13 + var_130_21 and arg_127_1.time_ < var_130_13 + var_130_21 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413081031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413081031
		arg_131_1.duration_ = 5.1

		local var_131_0 = {
			zh = 4.333,
			ja = 5.1
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
				arg_131_0:Play413081032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.45

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(413081031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 18 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 18)

				if (18 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 18)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081031", "story_v_out_413081.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081031", "story_v_out_413081.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_413081", "413081031", "story_v_out_413081.awb")

						arg_131_1:RecordAudio("413081031", var_134_6)
						arg_131_1:RecordAudio("413081031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413081", "413081031", "story_v_out_413081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413081", "413081031", "story_v_out_413081.awb")
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
	Play413081032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413081032
		arg_135_1.duration_ = 7.2

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play413081033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.bgs_.F08i == nil then
				local var_138_0 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_138_0.name = "F08i"
				var_138_0.transform.parent = arg_135_1.stage_.transform
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_.F08i = var_138_0
			end

			if 0.5 < arg_135_1.time_ and arg_135_1.time_ <= 0.5 + arg_138_0 then
				local var_138_1 = arg_135_1.bgs_.F08i

				arg_135_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_2 = var_138_1:GetComponent("SpriteRenderer")

				if var_138_2 and var_138_2.sprite then
					local var_138_3 = 2 * (var_138_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_1.transform.localScale = Vector3.New(var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "F08i" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_4 = 2.5

			if 2.5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_4 + 0.3 and arg_135_1.time_ < var_138_4 + 0.3 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_5 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_6 = 0.5

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 then
				local var_138_7 = Color.New(1, 1, 1)

				var_138_7.a = Mathf.Lerp(0, 1, (arg_135_1.time_ - var_138_5) / var_138_6)
				arg_135_1.mask_.color = var_138_7
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 then
				local var_138_8 = Color.New(1, 1, 1)

				var_138_8.a = 1
				arg_135_1.mask_.color = var_138_8
			end

			local var_138_9 = 0.5

			if 0.5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_10 = 2

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_10 then
				local var_138_11 = Color.New(1, 1, 1)

				var_138_11.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_9) / var_138_10)
				arg_135_1.mask_.color = var_138_11
			end

			if arg_135_1.time_ >= var_138_9 + var_138_10 and arg_135_1.time_ < var_138_9 + var_138_10 + arg_138_0 then
				local var_138_12 = Color.New(1, 1, 1)

				arg_135_1.mask_.enabled = false
				var_138_12.a = 0
				arg_135_1.mask_.color = var_138_12
			end

			local var_138_13 = arg_135_1.actors_["10092"].transform

			if 0.5 < arg_135_1.time_ and arg_135_1.time_ <= 0.5 + arg_138_0 then
				arg_135_1.var_.moveOldPos10092 = var_138_13.localPosition
				var_138_13.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10092", 7)

				for iter_138_2 = 0, var_138_13.childCount - 1 do
					local var_138_14 = var_138_13:GetChild(iter_138_2)

					if var_138_14.name == "" or not string.find(var_138_14.name, "split") then
						var_138_14.gameObject:SetActive(true)
					else
						var_138_14.gameObject:SetActive(false)
					end
				end
			end

			local var_138_15 = 0.001

			if 0.5 <= arg_135_1.time_ and arg_135_1.time_ < 0.5 + var_138_15 then
				var_138_13.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_135_1.time_ - 0.5) / var_138_15)
			end

			if arg_135_1.time_ >= 0.5 + var_138_15 and arg_135_1.time_ < 0.5 + var_138_15 + arg_138_0 then
				var_138_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_138_16 = arg_135_1.actors_["10093"].transform

			if 0.5 < arg_135_1.time_ and arg_135_1.time_ <= 0.5 + arg_138_0 then
				arg_135_1.var_.moveOldPos10093 = var_138_16.localPosition
				var_138_16.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10093", 7)

				for iter_138_3 = 0, var_138_16.childCount - 1 do
					local var_138_17 = var_138_16:GetChild(iter_138_3)

					if var_138_17.name == "" or not string.find(var_138_17.name, "split") then
						var_138_17.gameObject:SetActive(true)
					else
						var_138_17.gameObject:SetActive(false)
					end
				end
			end

			local var_138_18 = 0.001

			if 0.5 <= arg_135_1.time_ and arg_135_1.time_ < 0.5 + var_138_18 then
				var_138_16.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_135_1.time_ - 0.5) / var_138_18)
			end

			if arg_135_1.time_ >= 0.5 + var_138_18 and arg_135_1.time_ < 0.5 + var_138_18 + arg_138_0 then
				var_138_16.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_138_19 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_19 + 0.534 and arg_135_1.time_ < var_138_19 + 0.534 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if 0.1 < arg_135_1.time_ and arg_135_1.time_ <= 0.1 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_spear01", "")
			end

			if 1.2 < arg_135_1.time_ and arg_135_1.time_ <= 1.2 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_spear02", "")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_22 = 2.2
			local var_138_23 = 1.6

			if 2.2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_24 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_24:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_25 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(413081032).content)

				arg_135_1.text_.text = var_138_25

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_27 = 64 <= 0 and var_138_23 or var_138_23 * (utf8.len(var_138_25) / 64)

				if (64 <= 0 and var_138_23 or var_138_23 * (utf8.len(var_138_25) / 64)) > 0 and var_138_23 < var_138_27 then
					arg_135_1.talkMaxDuration = var_138_27
					var_138_22 = var_138_22 + 0.3

					if var_138_27 + var_138_22 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_27 + var_138_22
					end
				end

				arg_135_1.text_.text = var_138_25
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_28 = var_138_22 + 0.3
			local var_138_29 = math.max(var_138_23, arg_135_1.talkMaxDuration)

			if var_138_22 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_28 + var_138_29 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_28) / var_138_29

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_28 + var_138_29 and arg_135_1.time_ < var_138_28 + var_138_29 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play413081033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413081033
		arg_141_1.duration_ = 3.02

		local var_141_0 = {
			zh = 2.058,
			ja = 3.025
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
				arg_141_0:Play413081034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if arg_141_1.actors_["10022"] == nil then
				local var_144_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_144_0) then
					local var_144_1 = Object.Instantiate(var_144_0, arg_141_1.canvasGo_.transform)

					var_144_1.transform:SetSiblingIndex(1)

					var_144_1.name = "10022"
					var_144_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_141_1.actors_["10022"] = var_144_1

					if arg_141_1.isInRecall_ then
						for iter_144_0, iter_144_1 in ipairs((var_144_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_144_1.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_144_2 = arg_141_1.actors_["10022"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10022 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10022", 3)

				for iter_144_2 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_2)

					if var_144_3.name == "split_6" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_144_5 = arg_141_1.actors_["10092"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10092 == nil then
				arg_141_1.var_.actorSpriteComps10092 = var_144_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_6 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.actorSpriteComps10092 then
					for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_144_4 then
							if arg_141_1.isInRecall_ then
								iter_144_4.color = Color.New(Mathf.Lerp(iter_144_4.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_6), Mathf.Lerp(iter_144_4.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_6), (Mathf.Lerp(iter_144_4.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_6)))
							else
								local var_144_7 = Mathf.Lerp(iter_144_4.color.r, 1, (arg_141_1.time_ - 0) / var_144_6)

								iter_144_4.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10092 then
				for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_144_6 then
						iter_144_6.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				local var_144_8 = arg_141_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_144_8 then
					arg_141_1.var_.alphaOldValue10022 = var_144_8.alpha
					arg_141_1.var_.characterEffect10022 = var_144_8
				end

				arg_141_1.var_.alphaOldValue10022 = 0
			end

			local var_144_9 = 0.5

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 then
				if arg_141_1.var_.characterEffect10022 then
					arg_141_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_141_1.var_.alphaOldValue10022, 1, (arg_141_1.time_ - 0) / var_144_9)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 and arg_141_1.var_.characterEffect10022 then
				arg_141_1.var_.characterEffect10022.alpha = 1
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_10 = 0.225
			local var_144_11 = 0.275

			if 0.225 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_12 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_12:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(413081033)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 11 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_14) / 11)

				if (11 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_14) / 11)) > 0 and var_144_11 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16
					var_144_10 = var_144_10 + 0.3

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081033", "story_v_out_413081.awb") ~= 0 then
					local var_144_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081033", "story_v_out_413081.awb") / 1000

					if var_144_17 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_10
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_413081", "413081033", "story_v_out_413081.awb")

						arg_141_1:RecordAudio("413081033", var_144_18)
						arg_141_1:RecordAudio("413081033", var_144_18)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413081", "413081033", "story_v_out_413081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413081", "413081033", "story_v_out_413081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = var_144_10 + 0.3
			local var_144_20 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_19 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_19) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_19 + var_144_20 and arg_141_1.time_ < var_144_19 + var_144_20 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play413081034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413081034
		arg_147_1.duration_ = 4.53

		local var_147_0 = {
			zh = 3,
			ja = 4.533
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
				arg_147_0:Play413081035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.45

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(413081034)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 18 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 18)

				if (18 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 18)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081034", "story_v_out_413081.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081034", "story_v_out_413081.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_413081", "413081034", "story_v_out_413081.awb")

						arg_147_1:RecordAudio("413081034", var_150_6)
						arg_147_1:RecordAudio("413081034", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413081", "413081034", "story_v_out_413081.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413081", "413081034", "story_v_out_413081.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413081035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413081035
		arg_151_1.duration_ = 2.7

		local var_151_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
				arg_151_0:Play413081036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10022"]) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = arg_151_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10022"]) then
				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10022"]) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.275

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:GetWordFromCfg(413081035)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 11 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 11)

				if (11 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 11)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081035", "story_v_out_413081.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081035", "story_v_out_413081.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_413081", "413081035", "story_v_out_413081.awb")

						arg_151_1:RecordAudio("413081035", var_154_9)
						arg_151_1:RecordAudio("413081035", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413081", "413081035", "story_v_out_413081.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413081", "413081035", "story_v_out_413081.awb")
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
	Play413081036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413081036
		arg_155_1.duration_ = 3.7

		local var_155_0 = {
			zh = 2.333,
			ja = 3.7
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
				arg_155_0:Play413081037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = arg_155_1.actors_["10022"].transform.localPosition
				arg_155_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 3)

				for iter_158_0 = 0, arg_155_1.actors_["10022"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10022"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_2" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_158_2 = arg_155_1.actors_["10022"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_5 = arg_155_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_5 then
					arg_155_1.var_.alphaOldValue10022 = var_158_5.alpha
					arg_155_1.var_.characterEffect10022 = var_158_5
				end

				arg_155_1.var_.alphaOldValue10022 = 0
			end

			local var_158_6 = 0.0166666666666667

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 then
				if arg_155_1.var_.characterEffect10022 then
					arg_155_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_155_1.var_.alphaOldValue10022, 1, (arg_155_1.time_ - 0) / var_158_6)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and arg_155_1.var_.characterEffect10022 then
				arg_155_1.var_.characterEffect10022.alpha = 1
			end

			local var_158_7 = 0
			local var_158_8 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(413081036)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_12 = 13 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 13)

				if (13 <= 0 and var_158_8 or var_158_8 * (utf8.len(var_158_10) / 13)) > 0 and var_158_8 < var_158_12 then
					arg_155_1.talkMaxDuration = var_158_12

					if var_158_12 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_7
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081036", "story_v_out_413081.awb") ~= 0 then
					local var_158_13 = manager.audio:GetVoiceLength("story_v_out_413081", "413081036", "story_v_out_413081.awb") / 1000

					if var_158_13 + var_158_7 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_7
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_413081", "413081036", "story_v_out_413081.awb")

						arg_155_1:RecordAudio("413081036", var_158_14)
						arg_155_1:RecordAudio("413081036", var_158_14)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413081", "413081036", "story_v_out_413081.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413081", "413081036", "story_v_out_413081.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_15 = math.max(var_158_8, arg_155_1.talkMaxDuration)

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_15 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_7) / var_158_15

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_7 + var_158_15 and arg_155_1.time_ < var_158_7 + var_158_15 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413081037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413081037
		arg_159_1.duration_ = 6.57

		local var_159_0 = {
			zh = 6.566,
			ja = 4
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
				arg_159_0:Play413081038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = arg_159_1.actors_["10022"].transform.localPosition
				arg_159_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 7)

				for iter_162_0 = 0, arg_159_1.actors_["10022"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10022"].transform:GetChild(iter_162_0)

					if var_162_0.name == "" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_162_2 = 0
			local var_162_3 = 0.2

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1005].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:GetWordFromCfg(413081037)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 8 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 8)

				if (8 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 8)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081037", "story_v_out_413081.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081037", "story_v_out_413081.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_413081", "413081037", "story_v_out_413081.awb")

						arg_159_1:RecordAudio("413081037", var_162_9)
						arg_159_1:RecordAudio("413081037", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413081", "413081037", "story_v_out_413081.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413081", "413081037", "story_v_out_413081.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play413081038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413081038
		arg_163_1.duration_ = 3.4

		local var_163_0 = {
			zh = 2.2,
			ja = 3.4
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
				arg_163_0:Play413081039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = arg_163_1.actors_["10022"].transform.localPosition
				arg_163_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				for iter_166_0 = 0, arg_163_1.actors_["10022"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10022"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_8" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_166_2 = arg_163_1.actors_["10092"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10092 == nil then
				arg_163_1.var_.actorSpriteComps10092 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10092 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10092 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10092 = nil
			end

			local var_166_5 = 0
			local var_166_6 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(413081038)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 12 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 12)

				if (12 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 12)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081038", "story_v_out_413081.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081038", "story_v_out_413081.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_413081", "413081038", "story_v_out_413081.awb")

						arg_163_1:RecordAudio("413081038", var_166_12)
						arg_163_1:RecordAudio("413081038", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413081", "413081038", "story_v_out_413081.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413081", "413081038", "story_v_out_413081.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413081039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413081039
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 3.1,
			ja = 3.233
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
				arg_167_0:Play413081040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = arg_167_1.actors_["10092"].transform.localPosition
				arg_167_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 0)

				for iter_170_0 = 0, arg_167_1.actors_["10092"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10092"].transform:GetChild(iter_170_0)

					if var_170_0.name == "" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_170_2 = arg_167_1.actors_["10094"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10094 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10094", 3)

				for iter_170_1 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_1)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_170_5 = arg_167_1.actors_["10092"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_6 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_3 then
							if arg_167_1.isInRecall_ then
								iter_170_3.color = Color.New(Mathf.Lerp(iter_170_3.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_6), Mathf.Lerp(iter_170_3.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_6), (Mathf.Lerp(iter_170_3.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_6)))
							else
								local var_170_7 = Mathf.Lerp(iter_170_3.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_6)

								iter_170_3.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_5 then
						iter_170_5.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_8 = arg_167_1.actors_["10094"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10094 == nil then
				arg_167_1.var_.actorSpriteComps10094 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 and not isNil(var_170_8) then
				if arg_167_1.var_.actorSpriteComps10094 then
					for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_170_7 then
							if arg_167_1.isInRecall_ then
								iter_170_7.color = Color.New(Mathf.Lerp(iter_170_7.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_9), Mathf.Lerp(iter_170_7.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_9), (Mathf.Lerp(iter_170_7.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_9)))
							else
								local var_170_10 = Mathf.Lerp(iter_170_7.color.r, 1, (arg_167_1.time_ - 0) / var_170_9)

								iter_170_7.color = Color.New(var_170_10, var_170_10, var_170_10)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10094 then
				for iter_170_8, iter_170_9 in pairs(arg_167_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_170_9 then
						iter_170_9.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				local var_170_11 = arg_167_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_11 then
					arg_167_1.var_.alphaOldValue10094 = var_170_11.alpha
					arg_167_1.var_.characterEffect10094 = var_170_11
				end

				arg_167_1.var_.alphaOldValue10094 = 0
			end

			local var_170_12 = 0.5

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_12 then
				if arg_167_1.var_.characterEffect10094 then
					arg_167_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_167_1.var_.alphaOldValue10094, 1, (arg_167_1.time_ - 0) / var_170_12)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_12 and arg_167_1.time_ < 0 + var_170_12 + arg_170_0 and arg_167_1.var_.characterEffect10094 then
				arg_167_1.var_.characterEffect10094.alpha = 1
			end

			if 0.034 < arg_167_1.time_ and arg_167_1.time_ <= 0.034 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_14 = 0.5
			local var_170_15 = 0.125

			if 0.5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_16 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_16:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_17 = arg_167_1:GetWordFromCfg(413081039)
				local var_170_18 = arg_167_1:FormatText(var_170_17.content)

				arg_167_1.text_.text = var_170_18

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 5 <= 0 and var_170_15 or var_170_15 * (utf8.len(var_170_18) / 5)

				if (5 <= 0 and var_170_15 or var_170_15 * (utf8.len(var_170_18) / 5)) > 0 and var_170_15 < var_170_20 then
					arg_167_1.talkMaxDuration = var_170_20
					var_170_14 = var_170_14 + 0.3

					if var_170_20 + var_170_14 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_20 + var_170_14
					end
				end

				arg_167_1.text_.text = var_170_18
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081039", "story_v_out_413081.awb") ~= 0 then
					local var_170_21 = manager.audio:GetVoiceLength("story_v_out_413081", "413081039", "story_v_out_413081.awb") / 1000

					if var_170_21 + var_170_14 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_21 + var_170_14
					end

					if var_170_17.prefab_name ~= "" and arg_167_1.actors_[var_170_17.prefab_name] ~= nil then
						local var_170_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_17.prefab_name].transform, "story_v_out_413081", "413081039", "story_v_out_413081.awb")

						arg_167_1:RecordAudio("413081039", var_170_22)
						arg_167_1:RecordAudio("413081039", var_170_22)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413081", "413081039", "story_v_out_413081.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413081", "413081039", "story_v_out_413081.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_23 = var_170_14 + 0.3
			local var_170_24 = math.max(var_170_15, arg_167_1.talkMaxDuration)

			if var_170_14 + 0.3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_24 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_23) / var_170_24

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_23 + var_170_24 and arg_167_1.time_ < var_170_23 + var_170_24 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play413081040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413081040
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play413081041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10094 = arg_173_1.actors_["10094"].transform.localPosition
				arg_173_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10094", 0)

				for iter_176_0 = 0, arg_173_1.actors_["10094"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["10094"].transform:GetChild(iter_176_0)

					if var_176_0.name == "" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_176_2 = arg_173_1.actors_["10094"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10094 == nil then
				arg_173_1.var_.actorSpriteComps10094 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10094 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								iter_176_2.color = Color.New(Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_2.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_2.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10094 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10094 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 1.5

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(413081040).content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 60 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 60)

				if (60 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 60)) > 0 and var_176_6 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_10 and arg_173_1.time_ < var_176_5 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play413081041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413081041
		arg_177_1.duration_ = 6.4

		local var_177_0 = {
			zh = 4,
			ja = 6.4
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
				arg_177_0:Play413081042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10022 = arg_177_1.actors_["10022"].transform.localPosition
				arg_177_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10022", 2)

				for iter_180_0 = 0, arg_177_1.actors_["10022"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10022"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_8" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_180_2 = arg_177_1.actors_["10022"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10022 == nil then
				arg_177_1.var_.actorSpriteComps10022 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10022 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								iter_180_2.color = Color.New(Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_2.color.r, 1, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_2.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10022 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10022 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(413081041)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 16 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 16)

				if (16 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 16)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081041", "story_v_out_413081.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081041", "story_v_out_413081.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_413081", "413081041", "story_v_out_413081.awb")

						arg_177_1:RecordAudio("413081041", var_180_12)
						arg_177_1:RecordAudio("413081041", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413081", "413081041", "story_v_out_413081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413081", "413081041", "story_v_out_413081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play413081042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413081042
		arg_181_1.duration_ = 3.6

		local var_181_0 = {
			zh = 2.4,
			ja = 3.6
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
				arg_181_0:Play413081043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10094 = arg_181_1.actors_["10094"].transform.localPosition
				arg_181_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10094", 4)

				for iter_184_0 = 0, arg_181_1.actors_["10094"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10094"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_184_2 = arg_181_1.actors_["10022"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10022 = var_184_2.localPosition
				var_184_2.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10022", 2)

				for iter_184_1 = 0, var_184_2.childCount - 1 do
					local var_184_3 = var_184_2:GetChild(iter_184_1)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_2.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_181_1.time_ - 0) / var_184_4)
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_184_5 = arg_181_1.actors_["10094"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10094 == nil then
				arg_181_1.var_.actorSpriteComps10094 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10094 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								iter_184_3.color = Color.New(Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_3.color.r, 1, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_3.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10094 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_184_5 then
						iter_184_5.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10094 = nil
			end

			local var_184_8 = arg_181_1.actors_["10022"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10022 == nil then
				arg_181_1.var_.actorSpriteComps10022 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 and not isNil(var_184_8) then
				if arg_181_1.var_.actorSpriteComps10022 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								iter_184_7.color = Color.New(Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_9), Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_9), (Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_9)))
							else
								local var_184_10 = Mathf.Lerp(iter_184_7.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_9)

								iter_184_7.color = Color.New(var_184_10, var_184_10, var_184_10)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10022 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_184_9 then
						iter_184_9.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10022 = nil
			end

			local var_184_11 = 0
			local var_184_12 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(413081042)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)

				if (9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)) > 0 and var_184_12 < var_184_16 then
					arg_181_1.talkMaxDuration = var_184_16

					if var_184_16 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081042", "story_v_out_413081.awb") ~= 0 then
					local var_184_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081042", "story_v_out_413081.awb") / 1000

					if var_184_17 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_11
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_413081", "413081042", "story_v_out_413081.awb")

						arg_181_1:RecordAudio("413081042", var_184_18)
						arg_181_1:RecordAudio("413081042", var_184_18)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413081", "413081042", "story_v_out_413081.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413081", "413081042", "story_v_out_413081.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_19 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_19

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_19 and arg_181_1.time_ < var_184_11 + var_184_19 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play413081043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413081043
		arg_185_1.duration_ = 5.03

		local var_185_0 = {
			zh = 2.8,
			ja = 5.033
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
				arg_185_0:Play413081044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10022 = arg_185_1.actors_["10022"].transform.localPosition
				arg_185_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10022", 2)

				for iter_188_0 = 0, arg_185_1.actors_["10022"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10022"].transform:GetChild(iter_188_0)

					if var_188_0.name == "" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_188_2 = arg_185_1.actors_["10094"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10094 = var_188_2.localPosition
				var_188_2.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10094", 4)

				for iter_188_1 = 0, var_188_2.childCount - 1 do
					local var_188_3 = var_188_2:GetChild(iter_188_1)

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				var_188_2.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_185_1.time_ - 0) / var_188_4)
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				var_188_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_188_5 = arg_185_1.actors_["10022"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10022 == nil then
				arg_185_1.var_.actorSpriteComps10022 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10022 then
					for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_188_3 then
							if arg_185_1.isInRecall_ then
								iter_188_3.color = Color.New(Mathf.Lerp(iter_188_3.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_3.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_3.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_3.color.r, 1, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_3.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10022 then
				for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_188_5 then
						iter_188_5.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10022 = nil
			end

			local var_188_8 = arg_185_1.actors_["10094"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps10094 == nil then
				arg_185_1.var_.actorSpriteComps10094 = var_188_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_9 and not isNil(var_188_8) then
				if arg_185_1.var_.actorSpriteComps10094 then
					for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_188_7 then
							if arg_185_1.isInRecall_ then
								iter_188_7.color = Color.New(Mathf.Lerp(iter_188_7.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_9), Mathf.Lerp(iter_188_7.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_9), (Mathf.Lerp(iter_188_7.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_9)))
							else
								local var_188_10 = Mathf.Lerp(iter_188_7.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_9)

								iter_188_7.color = Color.New(var_188_10, var_188_10, var_188_10)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_9 and arg_185_1.time_ < 0 + var_188_9 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps10094 then
				for iter_188_8, iter_188_9 in pairs(arg_185_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_188_9 then
						iter_188_9.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10094 = nil
			end

			local var_188_11 = 0
			local var_188_12 = 0.325

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_13 = arg_185_1:GetWordFromCfg(413081043)
				local var_188_14 = arg_185_1:FormatText(var_188_13.content)

				arg_185_1.text_.text = var_188_14

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_16 = 13 <= 0 and var_188_12 or var_188_12 * (utf8.len(var_188_14) / 13)

				if (13 <= 0 and var_188_12 or var_188_12 * (utf8.len(var_188_14) / 13)) > 0 and var_188_12 < var_188_16 then
					arg_185_1.talkMaxDuration = var_188_16

					if var_188_16 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_16 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_14
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081043", "story_v_out_413081.awb") ~= 0 then
					local var_188_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081043", "story_v_out_413081.awb") / 1000

					if var_188_17 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_17 + var_188_11
					end

					if var_188_13.prefab_name ~= "" and arg_185_1.actors_[var_188_13.prefab_name] ~= nil then
						local var_188_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_13.prefab_name].transform, "story_v_out_413081", "413081043", "story_v_out_413081.awb")

						arg_185_1:RecordAudio("413081043", var_188_18)
						arg_185_1:RecordAudio("413081043", var_188_18)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413081", "413081043", "story_v_out_413081.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413081", "413081043", "story_v_out_413081.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_19 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_19 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_19

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_19 and arg_185_1.time_ < var_188_11 + var_188_19 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play413081044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413081044
		arg_189_1.duration_ = 10.23

		local var_189_0 = {
			zh = 5.133,
			ja = 10.233
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
				arg_189_0:Play413081045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.775

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(413081044)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 31 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 31)

				if (31 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 31)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081044", "story_v_out_413081.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081044", "story_v_out_413081.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_413081", "413081044", "story_v_out_413081.awb")

						arg_189_1:RecordAudio("413081044", var_192_6)
						arg_189_1:RecordAudio("413081044", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413081", "413081044", "story_v_out_413081.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413081", "413081044", "story_v_out_413081.awb")
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
	Play413081045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413081045
		arg_193_1.duration_ = 7.33

		local var_193_0 = {
			zh = 3.966,
			ja = 7.333
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
				arg_193_0:Play413081046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10094 = arg_193_1.actors_["10094"].transform.localPosition
				arg_193_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10094", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10094"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10094"].transform:GetChild(iter_196_0)

					if var_196_0.name == "" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_196_2 = arg_193_1.actors_["10022"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10022 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10022", 2)

				for iter_196_1 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_1)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_196_5 = arg_193_1.actors_["10094"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10094 == nil then
				arg_193_1.var_.actorSpriteComps10094 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps10094 then
					for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_196_3 then
							if arg_193_1.isInRecall_ then
								iter_196_3.color = Color.New(Mathf.Lerp(iter_196_3.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_3.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_3.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_3.color.r, 1, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_3.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10094 then
				for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_196_5 then
						iter_196_5.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10094 = nil
			end

			local var_196_8 = arg_193_1.actors_["10022"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10022 == nil then
				arg_193_1.var_.actorSpriteComps10022 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 and not isNil(var_196_8) then
				if arg_193_1.var_.actorSpriteComps10022 then
					for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_196_7 then
							if arg_193_1.isInRecall_ then
								iter_196_7.color = Color.New(Mathf.Lerp(iter_196_7.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_9), Mathf.Lerp(iter_196_7.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_9), (Mathf.Lerp(iter_196_7.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_9)))
							else
								local var_196_10 = Mathf.Lerp(iter_196_7.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_9)

								iter_196_7.color = Color.New(var_196_10, var_196_10, var_196_10)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10022 then
				for iter_196_8, iter_196_9 in pairs(arg_193_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_196_9 then
						iter_196_9.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10022 = nil
			end

			local var_196_11 = 0
			local var_196_12 = 0.45

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(413081045)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 18 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 18)

				if (18 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 18)) > 0 and var_196_12 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16

					if var_196_16 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081045", "story_v_out_413081.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081045", "story_v_out_413081.awb") / 1000

					if var_196_17 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_11
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_413081", "413081045", "story_v_out_413081.awb")

						arg_193_1:RecordAudio("413081045", var_196_18)
						arg_193_1:RecordAudio("413081045", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413081", "413081045", "story_v_out_413081.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413081", "413081045", "story_v_out_413081.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_19 and arg_193_1.time_ < var_196_11 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play413081046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413081046
		arg_197_1.duration_ = 5.37

		local var_197_0 = {
			zh = 3.3,
			ja = 5.366
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
				arg_197_0:Play413081047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10022 = arg_197_1.actors_["10022"].transform.localPosition
				arg_197_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10022", 2)

				for iter_200_0 = 0, arg_197_1.actors_["10022"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10022"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_6" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_200_2 = arg_197_1.actors_["10022"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10022 == nil then
				arg_197_1.var_.actorSpriteComps10022 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10022 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10022 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10022 = nil
			end

			local var_200_5 = arg_197_1.actors_["10094"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10094 == nil then
				arg_197_1.var_.actorSpriteComps10094 = var_200_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_6 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.actorSpriteComps10094 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								iter_200_6.color = Color.New(Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_6), Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_6), (Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_6)))
							else
								local var_200_7 = Mathf.Lerp(iter_200_6.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_6)

								iter_200_6.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10094 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_200_8 then
						iter_200_8.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10094 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.375

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(413081046)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 15 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 15)

				if (15 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 15)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081046", "story_v_out_413081.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081046", "story_v_out_413081.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_413081", "413081046", "story_v_out_413081.awb")

						arg_197_1:RecordAudio("413081046", var_200_15)
						arg_197_1:RecordAudio("413081046", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413081", "413081046", "story_v_out_413081.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413081", "413081046", "story_v_out_413081.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play413081047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413081047
		arg_201_1.duration_ = 7.4

		local var_201_0 = {
			zh = 4.066,
			ja = 7.4
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
				arg_201_0:Play413081048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10094"]) and arg_201_1.var_.actorSpriteComps10094 == nil then
				arg_201_1.var_.actorSpriteComps10094 = arg_201_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10094"]) then
				if arg_201_1.var_.actorSpriteComps10094 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10094"]) and arg_201_1.var_.actorSpriteComps10094 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10094 = nil
			end

			local var_204_2 = arg_201_1.actors_["10022"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10022 == nil then
				arg_201_1.var_.actorSpriteComps10022 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10022 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								iter_204_5.color = Color.New(Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_5.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_5.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10022 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_204_7 then
						iter_204_7.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10022 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(413081047)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 19 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 19)

				if (19 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 19)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081047", "story_v_out_413081.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081047", "story_v_out_413081.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_413081", "413081047", "story_v_out_413081.awb")

						arg_201_1:RecordAudio("413081047", var_204_12)
						arg_201_1:RecordAudio("413081047", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413081", "413081047", "story_v_out_413081.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413081", "413081047", "story_v_out_413081.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_13 and arg_201_1.time_ < var_204_5 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413081048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413081048
		arg_205_1.duration_ = 4.67

		local var_205_0 = {
			zh = 2.7,
			ja = 4.666
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
				arg_205_0:Play413081049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10022"]) and arg_205_1.var_.actorSpriteComps10022 == nil then
				arg_205_1.var_.actorSpriteComps10022 = arg_205_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10022"]) then
				if arg_205_1.var_.actorSpriteComps10022 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 1, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10022"]) and arg_205_1.var_.actorSpriteComps10022 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10022 = nil
			end

			local var_208_2 = arg_205_1.actors_["10094"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10094 == nil then
				arg_205_1.var_.actorSpriteComps10094 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10094 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								iter_208_5.color = Color.New(Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_5.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_5.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10094 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_208_7 then
						iter_208_7.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10094 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(413081048)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 14 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 14)

				if (14 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 14)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081048", "story_v_out_413081.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081048", "story_v_out_413081.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_413081", "413081048", "story_v_out_413081.awb")

						arg_205_1:RecordAudio("413081048", var_208_12)
						arg_205_1:RecordAudio("413081048", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413081", "413081048", "story_v_out_413081.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413081", "413081048", "story_v_out_413081.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_13 and arg_205_1.time_ < var_208_5 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413081049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413081049
		arg_209_1.duration_ = 4.27

		local var_209_0 = {
			zh = 2.1,
			ja = 4.266
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
				arg_209_0:Play413081050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10094"]) and arg_209_1.var_.actorSpriteComps10094 == nil then
				arg_209_1.var_.actorSpriteComps10094 = arg_209_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10094"]) then
				if arg_209_1.var_.actorSpriteComps10094 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 1, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10094"]) and arg_209_1.var_.actorSpriteComps10094 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10094 = nil
			end

			local var_212_2 = arg_209_1.actors_["10022"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10022 == nil then
				arg_209_1.var_.actorSpriteComps10022 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps10022 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								iter_212_5.color = Color.New(Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_5.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_5.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10022 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_212_7 then
						iter_212_7.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10022 = nil
			end

			local var_212_5 = 0
			local var_212_6 = 0.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(413081049)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 10 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 10)

				if (10 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 10)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081049", "story_v_out_413081.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081049", "story_v_out_413081.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_413081", "413081049", "story_v_out_413081.awb")

						arg_209_1:RecordAudio("413081049", var_212_12)
						arg_209_1:RecordAudio("413081049", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413081", "413081049", "story_v_out_413081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413081", "413081049", "story_v_out_413081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_13 and arg_209_1.time_ < var_212_5 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play413081050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413081050
		arg_213_1.duration_ = 11.37

		local var_213_0 = {
			zh = 8.833,
			ja = 11.366
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
				arg_213_0:Play413081051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10022"]) and arg_213_1.var_.actorSpriteComps10022 == nil then
				arg_213_1.var_.actorSpriteComps10022 = arg_213_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10022"]) then
				if arg_213_1.var_.actorSpriteComps10022 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10022"]) and arg_213_1.var_.actorSpriteComps10022 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10022 = nil
			end

			local var_216_2 = arg_213_1.actors_["10094"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10094 == nil then
				arg_213_1.var_.actorSpriteComps10094 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10094 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10094 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps10094 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 1.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(413081050)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 40 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 40)

				if (40 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 40)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081050", "story_v_out_413081.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081050", "story_v_out_413081.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_413081", "413081050", "story_v_out_413081.awb")

						arg_213_1:RecordAudio("413081050", var_216_12)
						arg_213_1:RecordAudio("413081050", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413081", "413081050", "story_v_out_413081.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413081", "413081050", "story_v_out_413081.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_13 and arg_213_1.time_ < var_216_5 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413081051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413081051
		arg_217_1.duration_ = 6.33

		local var_217_0 = {
			zh = 5.566,
			ja = 6.333
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
				arg_217_0:Play413081052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10022"]) and arg_217_1.var_.actorSpriteComps10022 == nil then
				arg_217_1.var_.actorSpriteComps10022 = arg_217_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10022"]) then
				if arg_217_1.var_.actorSpriteComps10022 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10022"]) and arg_217_1.var_.actorSpriteComps10022 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps10022 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.45

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_4 = arg_217_1:GetWordFromCfg(413081051)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 18 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 18)

				if (18 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 18)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081051", "story_v_out_413081.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081051", "story_v_out_413081.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_413081", "413081051", "story_v_out_413081.awb")

						arg_217_1:RecordAudio("413081051", var_220_9)
						arg_217_1:RecordAudio("413081051", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413081", "413081051", "story_v_out_413081.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413081", "413081051", "story_v_out_413081.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413081052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413081052
		arg_221_1.duration_ = 6.47

		local var_221_0 = {
			zh = 5.933,
			ja = 6.466
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
				arg_221_0:Play413081053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10022 = arg_221_1.actors_["10022"].transform.localPosition
				arg_221_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10022", 2)

				for iter_224_0 = 0, arg_221_1.actors_["10022"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10022"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_2" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_224_2 = arg_221_1.actors_["10022"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10022 == nil then
				arg_221_1.var_.actorSpriteComps10022 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10022 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 1, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10022 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10022 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.325

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(413081052)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 13 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 13)

				if (13 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 13)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081052", "story_v_out_413081.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081052", "story_v_out_413081.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_413081", "413081052", "story_v_out_413081.awb")

						arg_221_1:RecordAudio("413081052", var_224_12)
						arg_221_1:RecordAudio("413081052", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413081", "413081052", "story_v_out_413081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413081", "413081052", "story_v_out_413081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_13 and arg_221_1.time_ < var_224_5 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413081053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413081053
		arg_225_1.duration_ = 10.67

		local var_225_0 = {
			zh = 10.3666666666667,
			ja = 10.6666666666667
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
				arg_225_0:Play413081054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_0 = arg_225_1.bgs_.F08m

				arg_225_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_1 = var_228_0:GetComponent("SpriteRenderer")

				if var_228_1 and var_228_1.sprite then
					local var_228_2 = 2 * (var_228_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_0.transform.localScale = Vector3.New(var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "F08m" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_3 = 4

			if 4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			if arg_225_1.time_ >= var_228_3 + 0.3 and arg_225_1.time_ < var_228_3 + 0.3 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end

			local var_228_4 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_5 = 2

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_5 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = Mathf.Lerp(0, 1, (arg_225_1.time_ - var_228_4) / var_228_5)
				arg_225_1.mask_.color = var_228_6
			end

			if arg_225_1.time_ >= var_228_4 + var_228_5 and arg_225_1.time_ < var_228_4 + var_228_5 + arg_228_0 then
				local var_228_7 = Color.New(0, 0, 0)

				var_228_7.a = 1
				arg_225_1.mask_.color = var_228_7
			end

			local var_228_8 = 2

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_9 = 2

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 then
				local var_228_10 = Color.New(0, 0, 0)

				var_228_10.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_8) / var_228_9)
				arg_225_1.mask_.color = var_228_10
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 then
				local var_228_11 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_11.a = 0
				arg_225_1.mask_.color = var_228_11
			end

			local var_228_12 = arg_225_1.actors_["10022"].transform

			if 1.966 < arg_225_1.time_ and arg_225_1.time_ <= 1.966 + arg_228_0 then
				arg_225_1.var_.moveOldPos10022 = var_228_12.localPosition
				var_228_12.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10022", 0)

				for iter_228_2 = 0, var_228_12.childCount - 1 do
					local var_228_13 = var_228_12:GetChild(iter_228_2)

					if var_228_13.name == "" or not string.find(var_228_13.name, "split") then
						var_228_13.gameObject:SetActive(true)
					else
						var_228_13.gameObject:SetActive(false)
					end
				end
			end

			local var_228_14 = 0.001

			if 1.966 <= arg_225_1.time_ and arg_225_1.time_ < 1.966 + var_228_14 then
				var_228_12.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_225_1.time_ - 1.966) / var_228_14)
			end

			if arg_225_1.time_ >= 1.966 + var_228_14 and arg_225_1.time_ < 1.966 + var_228_14 + arg_228_0 then
				var_228_12.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_228_15 = arg_225_1.actors_["10094"].transform

			if 1.966 < arg_225_1.time_ and arg_225_1.time_ <= 1.966 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_15.localPosition
				var_228_15.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 0)

				for iter_228_3 = 0, var_228_15.childCount - 1 do
					local var_228_16 = var_228_15:GetChild(iter_228_3)

					if var_228_16.name == "" or not string.find(var_228_16.name, "split") then
						var_228_16.gameObject:SetActive(true)
					else
						var_228_16.gameObject:SetActive(false)
					end
				end
			end

			local var_228_17 = 0.001

			if 1.966 <= arg_225_1.time_ and arg_225_1.time_ < 1.966 + var_228_17 then
				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_225_1.time_ - 1.966) / var_228_17)
			end

			if arg_225_1.time_ >= 1.966 + var_228_17 and arg_225_1.time_ < 1.966 + var_228_17 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_228_18 = arg_225_1.actors_["10022"]

			if 1.966 < arg_225_1.time_ and arg_225_1.time_ <= 1.966 + arg_228_0 and not isNil(var_228_18) and arg_225_1.var_.actorSpriteComps10022 == nil then
				arg_225_1.var_.actorSpriteComps10022 = var_228_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_19 = 0.034

			if 1.966 <= arg_225_1.time_ and arg_225_1.time_ < 1.966 + var_228_19 and not isNil(var_228_18) then
				if arg_225_1.var_.actorSpriteComps10022 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								iter_228_5.color = Color.New(Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 1.966) / var_228_19), Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 1.966) / var_228_19), (Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 1.966) / var_228_19)))
							else
								local var_228_20 = Mathf.Lerp(iter_228_5.color.r, 0.5, (arg_225_1.time_ - 1.966) / var_228_19)

								iter_228_5.color = Color.New(var_228_20, var_228_20, var_228_20)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 1.966 + var_228_19 and arg_225_1.time_ < 1.966 + var_228_19 + arg_228_0 and not isNil(var_228_18) and arg_225_1.var_.actorSpriteComps10022 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_228_7 then
						iter_228_7.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10022 = nil
			end

			local var_228_21 = arg_225_1.actors_["10094"]

			if 1.966 < arg_225_1.time_ and arg_225_1.time_ <= 1.966 + arg_228_0 and not isNil(var_228_21) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_22 = 0.034

			if 1.966 <= arg_225_1.time_ and arg_225_1.time_ < 1.966 + var_228_22 and not isNil(var_228_21) then
				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_8, iter_228_9 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_9 then
							if arg_225_1.isInRecall_ then
								iter_228_9.color = Color.New(Mathf.Lerp(iter_228_9.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 1.966) / var_228_22), Mathf.Lerp(iter_228_9.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 1.966) / var_228_22), (Mathf.Lerp(iter_228_9.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 1.966) / var_228_22)))
							else
								local var_228_23 = Mathf.Lerp(iter_228_9.color.r, 0.5, (arg_225_1.time_ - 1.966) / var_228_22)

								iter_228_9.color = Color.New(var_228_23, var_228_23, var_228_23)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 1.966 + var_228_22 and arg_225_1.time_ < 1.966 + var_228_22 + arg_228_0 and not isNil(var_228_21) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_10, iter_228_11 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_11 then
						iter_228_11.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_24 = arg_225_1.actors_["10092"].transform

			if 3.73333333333333 < arg_225_1.time_ and arg_225_1.time_ <= 3.73333333333333 + arg_228_0 then
				arg_225_1.var_.moveOldPos10092 = var_228_24.localPosition
				var_228_24.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10092", 3)

				for iter_228_12 = 0, var_228_24.childCount - 1 do
					local var_228_25 = var_228_24:GetChild(iter_228_12)

					if var_228_25.name == "split_1_1" or not string.find(var_228_25.name, "split") then
						var_228_25.gameObject:SetActive(true)
					else
						var_228_25.gameObject:SetActive(false)
					end
				end
			end

			local var_228_26 = 0.001

			if 3.73333333333333 <= arg_225_1.time_ and arg_225_1.time_ < 3.73333333333333 + var_228_26 then
				var_228_24.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_225_1.time_ - 3.73333333333333) / var_228_26)
			end

			if arg_225_1.time_ >= 3.73333333333333 + var_228_26 and arg_225_1.time_ < 3.73333333333333 + var_228_26 + arg_228_0 then
				var_228_24.localPosition = Vector3.New(0, -300, -295)
			end

			local var_228_27 = arg_225_1.actors_["10092"]

			if 3.73333333333333 < arg_225_1.time_ and arg_225_1.time_ <= 3.73333333333333 + arg_228_0 and not isNil(var_228_27) and arg_225_1.var_.actorSpriteComps10092 == nil then
				arg_225_1.var_.actorSpriteComps10092 = var_228_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_28 = 0.2

			if 3.73333333333333 <= arg_225_1.time_ and arg_225_1.time_ < 3.73333333333333 + var_228_28 and not isNil(var_228_27) then
				if arg_225_1.var_.actorSpriteComps10092 then
					for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_228_14 then
							if arg_225_1.isInRecall_ then
								iter_228_14.color = Color.New(Mathf.Lerp(iter_228_14.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 3.73333333333333) / var_228_28), Mathf.Lerp(iter_228_14.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 3.73333333333333) / var_228_28), (Mathf.Lerp(iter_228_14.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 3.73333333333333) / var_228_28)))
							else
								local var_228_29 = Mathf.Lerp(iter_228_14.color.r, 1, (arg_225_1.time_ - 3.73333333333333) / var_228_28)

								iter_228_14.color = Color.New(var_228_29, var_228_29, var_228_29)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 3.73333333333333 + var_228_28 and arg_225_1.time_ < 3.73333333333333 + var_228_28 + arg_228_0 and not isNil(var_228_27) and arg_225_1.var_.actorSpriteComps10092 then
				for iter_228_15, iter_228_16 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_228_16 then
						iter_228_16.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10092 = nil
			end

			if 3.73333333333333 < arg_225_1.time_ and arg_225_1.time_ <= 3.73333333333333 + arg_228_0 then
				local var_228_30 = arg_225_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_30 then
					arg_225_1.var_.alphaOldValue10092 = var_228_30.alpha
					arg_225_1.var_.characterEffect10092 = var_228_30
				end

				arg_225_1.var_.alphaOldValue10092 = 0
			end

			local var_228_31 = 0.2

			if 3.73333333333333 <= arg_225_1.time_ and arg_225_1.time_ < 3.73333333333333 + var_228_31 then
				if arg_225_1.var_.characterEffect10092 then
					arg_225_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_225_1.var_.alphaOldValue10092, 1, (arg_225_1.time_ - 3.73333333333333) / var_228_31)
				end
			end

			if arg_225_1.time_ >= 3.73333333333333 + var_228_31 and arg_225_1.time_ < 3.73333333333333 + var_228_31 + arg_228_0 and arg_225_1.var_.characterEffect10092 then
				arg_225_1.var_.characterEffect10092.alpha = 1
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_32 = 4.06666666666667
			local var_228_33 = 0.725

			if 4.06666666666667 < arg_225_1.time_ and arg_225_1.time_ <= var_228_32 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_34 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_34:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_35 = arg_225_1:GetWordFromCfg(413081053)
				local var_228_36 = arg_225_1:FormatText(var_228_35.content)

				arg_225_1.text_.text = var_228_36

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_38 = 29 <= 0 and var_228_33 or var_228_33 * (utf8.len(var_228_36) / 29)

				if (29 <= 0 and var_228_33 or var_228_33 * (utf8.len(var_228_36) / 29)) > 0 and var_228_33 < var_228_38 then
					arg_225_1.talkMaxDuration = var_228_38
					var_228_32 = var_228_32 + 0.3

					if var_228_38 + var_228_32 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_38 + var_228_32
					end
				end

				arg_225_1.text_.text = var_228_36
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081053", "story_v_out_413081.awb") ~= 0 then
					local var_228_39 = manager.audio:GetVoiceLength("story_v_out_413081", "413081053", "story_v_out_413081.awb") / 1000

					if var_228_39 + var_228_32 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_39 + var_228_32
					end

					if var_228_35.prefab_name ~= "" and arg_225_1.actors_[var_228_35.prefab_name] ~= nil then
						local var_228_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_35.prefab_name].transform, "story_v_out_413081", "413081053", "story_v_out_413081.awb")

						arg_225_1:RecordAudio("413081053", var_228_40)
						arg_225_1:RecordAudio("413081053", var_228_40)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413081", "413081053", "story_v_out_413081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413081", "413081053", "story_v_out_413081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_41 = var_228_32 + 0.3
			local var_228_42 = math.max(var_228_33, arg_225_1.talkMaxDuration)

			if var_228_32 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_41 + var_228_42 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_41) / var_228_42

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_41 + var_228_42 and arg_225_1.time_ < var_228_41 + var_228_42 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play413081054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413081054
		arg_231_1.duration_ = 4.93

		local var_231_0 = {
			zh = 4.933,
			ja = 4.6
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
				arg_231_0:Play413081055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10092"]) and arg_231_1.var_.actorSpriteComps10092 == nil then
				arg_231_1.var_.actorSpriteComps10092 = arg_231_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10092"]) then
				if arg_231_1.var_.actorSpriteComps10092 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10092"]) and arg_231_1.var_.actorSpriteComps10092 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10092 = nil
			end

			local var_234_2 = 0
			local var_234_3 = 0.475

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_4 = arg_231_1:GetWordFromCfg(413081054)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 19 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 19)

				if (19 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 19)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081054", "story_v_out_413081.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081054", "story_v_out_413081.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_out_413081", "413081054", "story_v_out_413081.awb")

						arg_231_1:RecordAudio("413081054", var_234_9)
						arg_231_1:RecordAudio("413081054", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_413081", "413081054", "story_v_out_413081.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_413081", "413081054", "story_v_out_413081.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413081055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413081055
		arg_235_1.duration_ = 12.37

		local var_235_0 = {
			zh = 7.233,
			ja = 12.366
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
				arg_235_0:Play413081056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.9

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(413081055)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 36)

				if (36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 36)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081055", "story_v_out_413081.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081055", "story_v_out_413081.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_413081", "413081055", "story_v_out_413081.awb")

						arg_235_1:RecordAudio("413081055", var_238_6)
						arg_235_1:RecordAudio("413081055", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413081", "413081055", "story_v_out_413081.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413081", "413081055", "story_v_out_413081.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413081056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413081056
		arg_239_1.duration_ = 2.47

		local var_239_0 = {
			zh = 2.466,
			ja = 2.3
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
				arg_239_0:Play413081057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10092 = arg_239_1.actors_["10092"].transform.localPosition
				arg_239_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10092", 3)

				for iter_242_0 = 0, arg_239_1.actors_["10092"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["10092"].transform:GetChild(iter_242_0)

					if var_242_0.name == "" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_242_2 = arg_239_1.actors_["10092"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10092 == nil then
				arg_239_1.var_.actorSpriteComps10092 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10092 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10092 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps10092 = nil
			end

			local var_242_5 = 0
			local var_242_6 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:GetWordFromCfg(413081056)
				local var_242_8 = arg_239_1:FormatText(var_242_7.content)

				arg_239_1.text_.text = var_242_8

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 10 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 10)

				if (10 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 10)) > 0 and var_242_6 < var_242_10 then
					arg_239_1.talkMaxDuration = var_242_10

					if var_242_10 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_8
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081056", "story_v_out_413081.awb") ~= 0 then
					local var_242_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081056", "story_v_out_413081.awb") / 1000

					if var_242_11 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_5
					end

					if var_242_7.prefab_name ~= "" and arg_239_1.actors_[var_242_7.prefab_name] ~= nil then
						local var_242_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_7.prefab_name].transform, "story_v_out_413081", "413081056", "story_v_out_413081.awb")

						arg_239_1:RecordAudio("413081056", var_242_12)
						arg_239_1:RecordAudio("413081056", var_242_12)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413081", "413081056", "story_v_out_413081.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413081", "413081056", "story_v_out_413081.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_13 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_13 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_13

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_13 and arg_239_1.time_ < var_242_5 + var_242_13 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play413081057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413081057
		arg_243_1.duration_ = 11.4

		local var_243_0 = {
			zh = 5.433,
			ja = 11.4
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
				arg_243_0:Play413081058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.7

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(413081057)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 28 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 28)

				if (28 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 28)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081057", "story_v_out_413081.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081057", "story_v_out_413081.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_413081", "413081057", "story_v_out_413081.awb")

						arg_243_1:RecordAudio("413081057", var_246_6)
						arg_243_1:RecordAudio("413081057", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_413081", "413081057", "story_v_out_413081.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_413081", "413081057", "story_v_out_413081.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play413081058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413081058
		arg_247_1.duration_ = 3.73

		local var_247_0 = {
			zh = 3.733,
			ja = 3.3
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
				arg_247_0:Play413081059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10092"]) and arg_247_1.var_.actorSpriteComps10092 == nil then
				arg_247_1.var_.actorSpriteComps10092 = arg_247_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10092"]) then
				if arg_247_1.var_.actorSpriteComps10092 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10092"]) and arg_247_1.var_.actorSpriteComps10092 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps10092 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.325

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_4 = arg_247_1:GetWordFromCfg(413081058)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 13 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 13)

				if (13 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 13)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081058", "story_v_out_413081.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081058", "story_v_out_413081.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_413081", "413081058", "story_v_out_413081.awb")

						arg_247_1:RecordAudio("413081058", var_250_9)
						arg_247_1:RecordAudio("413081058", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413081", "413081058", "story_v_out_413081.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413081", "413081058", "story_v_out_413081.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413081059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413081059
		arg_251_1.duration_ = 2.87

		local var_251_0 = {
			zh = 2.86666666666667,
			ja = 2.53266666666667
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
				arg_251_0:Play413081060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10092 = arg_251_1.actors_["10092"].transform.localPosition
				arg_251_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10092", 3)

				for iter_254_0 = 0, arg_251_1.actors_["10092"].transform.childCount - 1 do
					local var_254_0 = arg_251_1.actors_["10092"].transform:GetChild(iter_254_0)

					if var_254_0.name == "split_5" or not string.find(var_254_0.name, "split") then
						var_254_0.gameObject:SetActive(true)
					else
						var_254_0.gameObject:SetActive(false)
					end
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_251_1.time_ - 0) / var_254_1)
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_254_2 = arg_251_1.actors_["10092"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10092 == nil then
				arg_251_1.var_.actorSpriteComps10092 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps10092 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								iter_254_2.color = Color.New(Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_3), Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_3), (Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_3)))
							else
								local var_254_4 = Mathf.Lerp(iter_254_2.color.r, 1, (arg_251_1.time_ - 0) / var_254_3)

								iter_254_2.color = Color.New(var_254_4, var_254_4, var_254_4)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10092 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_254_4 then
						iter_254_4.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10092 = nil
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_5 = 0.566666666666667
			local var_254_6 = 0.3

			if 0.566666666666667 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_7 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_7:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(413081059)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 12 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_9) / 12)

				if (12 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_9) / 12)) > 0 and var_254_6 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11
					var_254_5 = var_254_5 + 0.3

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081059", "story_v_out_413081.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_413081", "413081059", "story_v_out_413081.awb") / 1000

					if var_254_12 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_5
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_413081", "413081059", "story_v_out_413081.awb")

						arg_251_1:RecordAudio("413081059", var_254_13)
						arg_251_1:RecordAudio("413081059", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413081", "413081059", "story_v_out_413081.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413081", "413081059", "story_v_out_413081.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = var_254_5 + 0.3
			local var_254_15 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_14) / var_254_15

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play413081060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413081060
		arg_257_1.duration_ = 3.57

		local var_257_0 = {
			zh = 3.566,
			ja = 3.466
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
				arg_257_0:Play413081061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10092"]) and arg_257_1.var_.actorSpriteComps10092 == nil then
				arg_257_1.var_.actorSpriteComps10092 = arg_257_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10092"]) then
				if arg_257_1.var_.actorSpriteComps10092 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10092"]) and arg_257_1.var_.actorSpriteComps10092 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10092 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 0.25

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[999].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_4 = arg_257_1:GetWordFromCfg(413081060)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 10 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 10)

				if (10 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 10)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081060", "story_v_out_413081.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081060", "story_v_out_413081.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_413081", "413081060", "story_v_out_413081.awb")

						arg_257_1:RecordAudio("413081060", var_260_9)
						arg_257_1:RecordAudio("413081060", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413081", "413081060", "story_v_out_413081.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413081", "413081060", "story_v_out_413081.awb")
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
	Play413081061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413081061
		arg_261_1.duration_ = 8.33

		local var_261_0 = {
			zh = 2.933,
			ja = 8.333
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
				arg_261_0:Play413081062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10092 = arg_261_1.actors_["10092"].transform.localPosition
				arg_261_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10092", 3)

				for iter_264_0 = 0, arg_261_1.actors_["10092"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10092"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_8" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_264_2 = arg_261_1.actors_["10092"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10092 == nil then
				arg_261_1.var_.actorSpriteComps10092 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10092 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10092 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10092 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.25

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(413081061)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 10 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 10)

				if (10 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 10)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081061", "story_v_out_413081.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081061", "story_v_out_413081.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_413081", "413081061", "story_v_out_413081.awb")

						arg_261_1:RecordAudio("413081061", var_264_12)
						arg_261_1:RecordAudio("413081061", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413081", "413081061", "story_v_out_413081.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413081", "413081061", "story_v_out_413081.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play413081062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413081062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413081063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10092 = arg_265_1.actors_["10092"].transform.localPosition
				arg_265_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10092", 7)

				for iter_268_0 = 0, arg_265_1.actors_["10092"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["10092"].transform:GetChild(iter_268_0)

					if var_268_0.name == "" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_268_2 = arg_265_1.actors_["10092"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10092 == nil then
				arg_265_1.var_.actorSpriteComps10092 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps10092 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10092 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10092 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 1.425

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(413081062).content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 57 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 57)

				if (57 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 57)) > 0 and var_268_6 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_10 and arg_265_1.time_ < var_268_5 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play413081063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413081063
		arg_269_1.duration_ = 7.4

		local var_269_0 = {
			zh = 2.533,
			ja = 7.4
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play413081064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.3

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_5")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_1 = arg_269_1:GetWordFromCfg(413081063)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 12 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 12)

				if (12 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 12)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081063", "story_v_out_413081.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081063", "story_v_out_413081.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_413081", "413081063", "story_v_out_413081.awb")

						arg_269_1:RecordAudio("413081063", var_272_6)
						arg_269_1:RecordAudio("413081063", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413081", "413081063", "story_v_out_413081.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413081", "413081063", "story_v_out_413081.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play413081064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413081064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play413081065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10092 = arg_273_1.actors_["10092"].transform.localPosition
				arg_273_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10092", 7)

				for iter_276_0 = 0, arg_273_1.actors_["10092"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["10092"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_276_2 = arg_273_1.actors_["10092"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10092 == nil then
				arg_273_1.var_.actorSpriteComps10092 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps10092 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10092 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10092 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.975

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(413081064).content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 39 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 39)

				if (39 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 39)) > 0 and var_276_6 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_10 and arg_273_1.time_ < var_276_5 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play413081065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413081065
		arg_277_1.duration_ = 4.37

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play413081066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_5")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(413081065)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 15)

				if (15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 15)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081065", "story_v_out_413081.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081065", "story_v_out_413081.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_413081", "413081065", "story_v_out_413081.awb")

						arg_277_1:RecordAudio("413081065", var_280_6)
						arg_277_1:RecordAudio("413081065", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413081", "413081065", "story_v_out_413081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413081", "413081065", "story_v_out_413081.awb")
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
	Play413081066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413081066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413081067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0.5 < arg_281_1.time_ and arg_281_1.time_ <= 0.5 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_blast", "")
			end

			local var_284_1 = 0
			local var_284_2 = 1.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(413081066).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 54 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 54)

				if (54 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 54)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play413081067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413081067
		arg_285_1.duration_ = 6.37

		local var_285_0 = {
			zh = 5.7,
			ja = 6.366
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play413081068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_288_0 = 0.6

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				local var_288_1, var_288_2 = math.modf((arg_285_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_288_2 * 0.13, var_288_2 * 0.13, var_288_2 * 0.13) + arg_285_1.var_.shakeOldPos
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				manager.ui.mainCamera.transform.localPosition = arg_285_1.var_.shakeOldPos
			end

			local var_288_3 = 0

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			if arg_285_1.time_ >= var_288_3 + 0.6 and arg_285_1.time_ < var_288_3 + 0.6 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end

			local var_288_4 = 0
			local var_288_5 = 0.775

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_6 = arg_285_1:GetWordFromCfg(413081067)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 31 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 31)

				if (31 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 31)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081067", "story_v_out_413081.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_413081", "413081067", "story_v_out_413081.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_413081", "413081067", "story_v_out_413081.awb")

						arg_285_1:RecordAudio("413081067", var_288_11)
						arg_285_1:RecordAudio("413081067", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413081", "413081067", "story_v_out_413081.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413081", "413081067", "story_v_out_413081.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play413081068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413081068
		arg_289_1.duration_ = 4.5

		local var_289_0 = {
			zh = 2.7,
			ja = 4.5
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play413081069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.3

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:GetWordFromCfg(413081068)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 12 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 12)

				if (12 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 12)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081068", "story_v_out_413081.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081068", "story_v_out_413081.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_413081", "413081068", "story_v_out_413081.awb")

						arg_289_1:RecordAudio("413081068", var_292_6)
						arg_289_1:RecordAudio("413081068", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_413081", "413081068", "story_v_out_413081.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_413081", "413081068", "story_v_out_413081.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play413081069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 413081069
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play413081070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_296_1 = 0
			local var_296_2 = 1.425

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(413081069).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 57 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 57)

				if (57 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 57)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play413081070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 413081070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play413081071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.6

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(413081070).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 64 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 64)

				if (64 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 64)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play413081071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 413081071
		arg_301_1.duration_ = 4.3

		local var_301_0 = {
			zh = 1.999999999999,
			ja = 4.3
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
				arg_301_0:Play413081072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10092 = arg_301_1.actors_["10092"].transform.localPosition
				arg_301_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10092", 3)

				for iter_304_0 = 0, arg_301_1.actors_["10092"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10092"].transform:GetChild(iter_304_0)

					if var_304_0.name == "split_3" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_304_2 = arg_301_1.actors_["10092"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10092 == nil then
				arg_301_1.var_.actorSpriteComps10092 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps10092 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 1, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10092 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps10092 = nil
			end

			local var_304_5 = manager.ui.mainCamera.transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.shakeOldPos = var_304_5.localPosition
			end

			local var_304_6 = 0.6

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_6 then
				local var_304_7, var_304_8 = math.modf((arg_301_1.time_ - 0) / 0.066)

				var_304_5.localPosition = Vector3.New(var_304_8 * 0.13, var_304_8 * 0.13, var_304_8 * 0.13) + arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.time_ >= 0 + var_304_6 and arg_301_1.time_ < 0 + var_304_6 + arg_304_0 then
				var_304_5.localPosition = arg_301_1.var_.shakeOldPos
			end

			local var_304_9 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_9 + 0.6 and arg_301_1.time_ < var_304_9 + 0.6 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_304_11 = 0
			local var_304_12 = 0.225

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_13 = arg_301_1:GetWordFromCfg(413081071)
				local var_304_14 = arg_301_1:FormatText(var_304_13.content)

				arg_301_1.text_.text = var_304_14

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_16 = 9 <= 0 and var_304_12 or var_304_12 * (utf8.len(var_304_14) / 9)

				if (9 <= 0 and var_304_12 or var_304_12 * (utf8.len(var_304_14) / 9)) > 0 and var_304_12 < var_304_16 then
					arg_301_1.talkMaxDuration = var_304_16

					if var_304_16 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_16 + var_304_11
					end
				end

				arg_301_1.text_.text = var_304_14
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081071", "story_v_out_413081.awb") ~= 0 then
					local var_304_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081071", "story_v_out_413081.awb") / 1000

					if var_304_17 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_17 + var_304_11
					end

					if var_304_13.prefab_name ~= "" and arg_301_1.actors_[var_304_13.prefab_name] ~= nil then
						local var_304_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_13.prefab_name].transform, "story_v_out_413081", "413081071", "story_v_out_413081.awb")

						arg_301_1:RecordAudio("413081071", var_304_18)
						arg_301_1:RecordAudio("413081071", var_304_18)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_413081", "413081071", "story_v_out_413081.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_413081", "413081071", "story_v_out_413081.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_19 = math.max(var_304_12, arg_301_1.talkMaxDuration)

			if var_304_11 <= arg_301_1.time_ and arg_301_1.time_ < var_304_11 + var_304_19 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_11) / var_304_19

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_11 + var_304_19 and arg_301_1.time_ < var_304_11 + var_304_19 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play413081072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413081072
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play413081073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10092 = arg_305_1.actors_["10092"].transform.localPosition
				arg_305_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10092", 0)

				for iter_308_0 = 0, arg_305_1.actors_["10092"].transform.childCount - 1 do
					local var_308_0 = arg_305_1.actors_["10092"].transform:GetChild(iter_308_0)

					if var_308_0.name == "" or not string.find(var_308_0.name, "split") then
						var_308_0.gameObject:SetActive(true)
					else
						var_308_0.gameObject:SetActive(false)
					end
				end
			end

			local var_308_1 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 then
				arg_305_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_305_1.time_ - 0) / var_308_1)
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 then
				arg_305_1.actors_["10092"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_308_2 = arg_305_1.actors_["10092"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10092 == nil then
				arg_305_1.var_.actorSpriteComps10092 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps10092 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								iter_308_2.color = Color.New(Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_2.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_2.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10092 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_308_4 then
						iter_308_4.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps10092 = nil
			end

			if 0.034 < arg_305_1.time_ and arg_305_1.time_ <= 0.034 + arg_308_0 then
				arg_305_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_308_6 = 0
			local var_308_7 = 1.6

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_8 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(413081072).content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 64 <= 0 and var_308_7 or var_308_7 * (utf8.len(var_308_8) / 64)

				if (64 <= 0 and var_308_7 or var_308_7 * (utf8.len(var_308_8) / 64)) > 0 and var_308_7 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_11 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_11 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_11

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_11 and arg_305_1.time_ < var_308_6 + var_308_11 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play413081073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413081073
		arg_309_1.duration_ = 5.3

		local var_309_0 = {
			zh = 4.633,
			ja = 5.3
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play413081074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.675

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:GetWordFromCfg(413081073)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 27 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 27)

				if (27 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 27)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081073", "story_v_out_413081.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081073", "story_v_out_413081.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_413081", "413081073", "story_v_out_413081.awb")

						arg_309_1:RecordAudio("413081073", var_312_6)
						arg_309_1:RecordAudio("413081073", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_413081", "413081073", "story_v_out_413081.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_413081", "413081073", "story_v_out_413081.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play413081074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 413081074
		arg_313_1.duration_ = 6.1

		local var_313_0 = {
			zh = 5.366,
			ja = 6.1
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play413081075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10092 = arg_313_1.actors_["10092"].transform.localPosition
				arg_313_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10092", 3)

				for iter_316_0 = 0, arg_313_1.actors_["10092"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["10092"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_8" or not string.find(var_316_0.name, "split") then
						var_316_0.gameObject:SetActive(true)
					else
						var_316_0.gameObject:SetActive(false)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_313_1.time_ - 0) / var_316_1)
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_316_2 = arg_313_1.actors_["10092"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10092 == nil then
				arg_313_1.var_.actorSpriteComps10092 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps10092 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								iter_316_2.color = Color.New(Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_3), Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_3), (Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_3)))
							else
								local var_316_4 = Mathf.Lerp(iter_316_2.color.r, 1, (arg_313_1.time_ - 0) / var_316_3)

								iter_316_2.color = Color.New(var_316_4, var_316_4, var_316_4)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10092 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_316_4 then
						iter_316_4.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10092 = nil
			end

			local var_316_5 = 0
			local var_316_6 = 0.65

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(413081074)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 26 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 26)

				if (26 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 26)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081074", "story_v_out_413081.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081074", "story_v_out_413081.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_413081", "413081074", "story_v_out_413081.awb")

						arg_313_1:RecordAudio("413081074", var_316_12)
						arg_313_1:RecordAudio("413081074", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_413081", "413081074", "story_v_out_413081.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_413081", "413081074", "story_v_out_413081.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_13 and arg_313_1.time_ < var_316_5 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play413081075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 413081075
		arg_317_1.duration_ = 8.8

		local var_317_0 = {
			zh = 6.366,
			ja = 8.8
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play413081076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.725

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(413081075)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 29 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 29)

				if (29 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 29)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081075", "story_v_out_413081.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081075", "story_v_out_413081.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_413081", "413081075", "story_v_out_413081.awb")

						arg_317_1:RecordAudio("413081075", var_320_6)
						arg_317_1:RecordAudio("413081075", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_413081", "413081075", "story_v_out_413081.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_413081", "413081075", "story_v_out_413081.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play413081076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 413081076
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play413081077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10092 = arg_321_1.actors_["10092"].transform.localPosition
				arg_321_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10092", 7)

				for iter_324_0 = 0, arg_321_1.actors_["10092"].transform.childCount - 1 do
					local var_324_0 = arg_321_1.actors_["10092"].transform:GetChild(iter_324_0)

					if var_324_0.name == "" or not string.find(var_324_0.name, "split") then
						var_324_0.gameObject:SetActive(true)
					else
						var_324_0.gameObject:SetActive(false)
					end
				end
			end

			local var_324_1 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 then
				arg_321_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_321_1.time_ - 0) / var_324_1)
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 then
				arg_321_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0.716667 < arg_321_1.time_ and arg_321_1.time_ <= 0.716667 + arg_324_0 then
				arg_321_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_324_3 = 0
			local var_324_4 = 1.55

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_5 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(413081076).content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 62 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 62)

				if (62 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 62)) > 0 and var_324_4 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_3
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_4, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_3) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_8 and arg_321_1.time_ < var_324_3 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play413081077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 413081077
		arg_325_1.duration_ = 6.2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play413081078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_9000

			if 1.2 < arg_325_1.time_ and arg_325_1.time_ <= 1.2 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "minigame_activity_3_4", "minigame_activity_3_4_battle_bullet_30", "")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_seal", "")
			end

			if 1.325 < arg_325_1.time_ and arg_325_1.time_ <= 1.325 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "c_10079", "c_10079_bullet_7", "")
			end

			local var_328_4 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_5 = 0.8

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_5 then
				local var_328_6 = Color.New(1, 1, 1)

				var_328_6.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_4) / var_328_5)
				arg_325_1.mask_.color = var_328_6
			end

			if arg_325_1.time_ >= var_328_4 + var_328_5 and arg_325_1.time_ < var_328_4 + var_328_5 + arg_328_0 then
				local var_328_7 = Color.New(1, 1, 1)

				arg_325_1.mask_.enabled = false
				var_328_7.a = 0
				arg_325_1.mask_.color = var_328_7
			end

			if 0.366666666666667 < arg_325_1.time_ and arg_325_1.time_ <= 0.366666666666667 + arg_328_0 then
				local var_328_8 = arg_325_1.var_.effect12333

				if not arg_325_1.var_.effect12333 then
					var_328_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_328_8.name = "12333"
					arg_325_1.var_.effect12333 = var_328_8
				else
					var_328_8.transform:SetParent(var_328_9000)
				end

				var_328_8.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_328_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.325 < arg_325_1.time_ and arg_325_1.time_ <= 1.325 + arg_328_0 then
				if arg_325_1.var_.effect12333 then
					Object.Destroy(arg_325_1.var_.effect12333)

					arg_325_1.var_.effect12333 = nil
				end
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_11 = 1.2
			local var_328_12 = 0.875

			if 1.2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_13 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_13:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(413081077).content)

				arg_325_1.text_.text = var_328_14

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 35 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_14) / 35)

				if (35 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_14) / 35)) > 0 and var_328_12 < var_328_16 then
					arg_325_1.talkMaxDuration = var_328_16
					var_328_11 = var_328_11 + 0.3

					if var_328_16 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_16 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_14
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_17 = var_328_11 + 0.3
			local var_328_18 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_18 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_17) / var_328_18

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_17 + var_328_18 and arg_325_1.time_ < var_328_17 + var_328_18 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play413081078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413081078
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play413081079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 2 < arg_331_1.time_ and arg_331_1.time_ <= 2 + arg_334_0 then
				local var_334_0 = arg_331_1.bgs_.F08i

				arg_331_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_334_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_1 = var_334_0:GetComponent("SpriteRenderer")

				if var_334_1 and var_334_1.sprite then
					local var_334_2 = 2 * (var_334_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_334_0.transform.localScale = Vector3.New(var_334_2 / var_334_1.sprite.bounds.size.y < var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x and var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x or var_334_2 / var_334_1.sprite.bounds.size.y, var_334_2 / var_334_1.sprite.bounds.size.y < var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x and var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x or var_334_2 / var_334_1.sprite.bounds.size.y, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "F08i" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_3 = 3.999999999999

			if 3.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= var_334_3 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			if arg_331_1.time_ >= var_334_3 + 0.3 and arg_331_1.time_ < var_334_3 + 0.3 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			local var_334_4 = 0

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_5 = 2

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_5 then
				local var_334_6 = Color.New(0, 0, 0)

				var_334_6.a = Mathf.Lerp(0, 1, (arg_331_1.time_ - var_334_4) / var_334_5)
				arg_331_1.mask_.color = var_334_6
			end

			if arg_331_1.time_ >= var_334_4 + var_334_5 and arg_331_1.time_ < var_334_4 + var_334_5 + arg_334_0 then
				local var_334_7 = Color.New(0, 0, 0)

				var_334_7.a = 1
				arg_331_1.mask_.color = var_334_7
			end

			local var_334_8 = 2

			if 2 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_9 = 2

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 then
				local var_334_10 = Color.New(0, 0, 0)

				var_334_10.a = Mathf.Lerp(1, 0, (arg_331_1.time_ - var_334_8) / var_334_9)
				arg_331_1.mask_.color = var_334_10
			end

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 then
				local var_334_11 = Color.New(0, 0, 0)

				arg_331_1.mask_.enabled = false
				var_334_11.a = 0
				arg_331_1.mask_.color = var_334_11
			end

			if 1.03333333333333 < arg_331_1.time_ and arg_331_1.time_ <= 1.03333333333333 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_explosion", "")
			end

			if 3.299999999999 < arg_331_1.time_ and arg_331_1.time_ <= 3.299999999999 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_14 = 3.999999999999
			local var_334_15 = 1.775

			if 3.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_16 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_16:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_17 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(413081078).content)

				arg_331_1.text_.text = var_334_17

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_19 = 71 <= 0 and var_334_15 or var_334_15 * (utf8.len(var_334_17) / 71)

				if (71 <= 0 and var_334_15 or var_334_15 * (utf8.len(var_334_17) / 71)) > 0 and var_334_15 < var_334_19 then
					arg_331_1.talkMaxDuration = var_334_19
					var_334_14 = var_334_14 + 0.3

					if var_334_19 + var_334_14 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_19 + var_334_14
					end
				end

				arg_331_1.text_.text = var_334_17
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_20 = var_334_14 + 0.3
			local var_334_21 = math.max(var_334_15, arg_331_1.talkMaxDuration)

			if var_334_14 + 0.3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_20 + var_334_21 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_20) / var_334_21

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_20 + var_334_21 and arg_331_1.time_ < var_334_20 + var_334_21 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play413081079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 413081079
		arg_337_1.duration_ = 6.87

		local var_337_0 = {
			zh = 3.69966666666667,
			ja = 6.86666666666667
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play413081080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				local var_340_0 = arg_337_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_0 then
					arg_337_1.var_.alphaOldValue10022 = var_340_0.alpha
					arg_337_1.var_.characterEffect10022 = var_340_0
				end

				arg_337_1.var_.alphaOldValue10022 = 0
			end

			local var_340_1 = 0.5

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				if arg_337_1.var_.characterEffect10022 then
					arg_337_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_337_1.var_.alphaOldValue10022, 1, (arg_337_1.time_ - 0) / var_340_1)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 and arg_337_1.var_.characterEffect10022 then
				arg_337_1.var_.characterEffect10022.alpha = 1
			end

			local var_340_2 = arg_337_1.actors_["10022"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10022 = var_340_2.localPosition
				var_340_2.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10022", 2)

				for iter_340_0 = 0, var_340_2.childCount - 1 do
					local var_340_3 = var_340_2:GetChild(iter_340_0)

					if var_340_3.name == "split_8" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				var_340_2.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_337_1.time_ - 0) / var_340_4)
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				var_340_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_340_5 = arg_337_1.actors_["10022"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps10022 == nil then
				arg_337_1.var_.actorSpriteComps10022 = var_340_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_6 = 0.034

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_6 and not isNil(var_340_5) then
				if arg_337_1.var_.actorSpriteComps10022 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								iter_340_2.color = Color.New(Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_6), Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_6), (Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_6)))
							else
								local var_340_7 = Mathf.Lerp(iter_340_2.color.r, 1, (arg_337_1.time_ - 0) / var_340_6)

								iter_340_2.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_6 and arg_337_1.time_ < 0 + var_340_6 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps10022 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_340_4 then
						iter_340_4.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps10022 = nil
			end

			local var_340_8 = 0

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			if arg_337_1.time_ >= var_340_8 + 0.7 and arg_337_1.time_ < var_340_8 + 0.7 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end

			if arg_337_1.frameCnt_ <= 1 then
				arg_337_1.dialog_:SetActive(false)
			end

			local var_340_9 = 0.566666666666667
			local var_340_10 = 0.425

			if 0.566666666666667 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				arg_337_1.dialog_:SetActive(true)

				arg_337_1.dialogCg_.alpha = 0

				local var_340_11 = LeanTween.value(arg_337_1.dialog_, 0, 1, 0.3)

				var_340_11:setOnUpdate(LuaHelper.FloatAction(function(arg_341_0)
					arg_337_1.dialogCg_.alpha = arg_341_0
				end))
				var_340_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_337_1.dialog_)
					var_340_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_337_1.duration_ = arg_337_1.duration_ + 0.3

				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_12 = arg_337_1:GetWordFromCfg(413081079)
				local var_340_13 = arg_337_1:FormatText(var_340_12.content)

				arg_337_1.text_.text = var_340_13

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_15 = 17 <= 0 and var_340_10 or var_340_10 * (utf8.len(var_340_13) / 17)

				if (17 <= 0 and var_340_10 or var_340_10 * (utf8.len(var_340_13) / 17)) > 0 and var_340_10 < var_340_15 then
					arg_337_1.talkMaxDuration = var_340_15
					var_340_9 = var_340_9 + 0.3

					if var_340_15 + var_340_9 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_15 + var_340_9
					end
				end

				arg_337_1.text_.text = var_340_13
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081079", "story_v_out_413081.awb") ~= 0 then
					local var_340_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081079", "story_v_out_413081.awb") / 1000

					if var_340_16 + var_340_9 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_16 + var_340_9
					end

					if var_340_12.prefab_name ~= "" and arg_337_1.actors_[var_340_12.prefab_name] ~= nil then
						local var_340_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_12.prefab_name].transform, "story_v_out_413081", "413081079", "story_v_out_413081.awb")

						arg_337_1:RecordAudio("413081079", var_340_17)
						arg_337_1:RecordAudio("413081079", var_340_17)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_413081", "413081079", "story_v_out_413081.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_413081", "413081079", "story_v_out_413081.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_18 = var_340_9 + 0.3
			local var_340_19 = math.max(var_340_10, arg_337_1.talkMaxDuration)

			if var_340_9 + 0.3 <= arg_337_1.time_ and arg_337_1.time_ < var_340_18 + var_340_19 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_18) / var_340_19

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_18 + var_340_19 and arg_337_1.time_ < var_340_18 + var_340_19 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play413081080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413081080
		arg_343_1.duration_ = 5.2

		local var_343_0 = {
			zh = 3.1,
			ja = 5.2
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
				arg_343_0:Play413081081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10022"]) and arg_343_1.var_.actorSpriteComps10022 == nil then
				arg_343_1.var_.actorSpriteComps10022 = arg_343_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10022"]) then
				if arg_343_1.var_.actorSpriteComps10022 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10022"]) and arg_343_1.var_.actorSpriteComps10022 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10022 = nil
			end

			local var_346_2 = arg_343_1.actors_["10094"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10094 == nil then
				arg_343_1.var_.actorSpriteComps10094 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps10094 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								iter_346_5.color = Color.New(Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_5.color.r, 1, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_5.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10094 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_346_7 then
						iter_346_7.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10094 = nil
			end

			local var_346_5 = arg_343_1.actors_["10094"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10094 = var_346_5.localPosition
				var_346_5.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10094", 4)

				for iter_346_8 = 0, var_346_5.childCount - 1 do
					local var_346_6 = var_346_5:GetChild(iter_346_8)

					if var_346_6.name == "" or not string.find(var_346_6.name, "split") then
						var_346_6.gameObject:SetActive(true)
					else
						var_346_6.gameObject:SetActive(false)
					end
				end
			end

			local var_346_7 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				var_346_5.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10094, Vector3.New(390, -315, -320), (arg_343_1.time_ - 0) / var_346_7)
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				var_346_5.localPosition = Vector3.New(390, -315, -320)
			end

			local var_346_8 = 0
			local var_346_9 = 0.35

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(413081080)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 14 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 14)

				if (14 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 14)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081080", "story_v_out_413081.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081080", "story_v_out_413081.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_413081", "413081080", "story_v_out_413081.awb")

						arg_343_1:RecordAudio("413081080", var_346_15)
						arg_343_1:RecordAudio("413081080", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413081", "413081080", "story_v_out_413081.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413081", "413081080", "story_v_out_413081.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play413081081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413081081
		arg_347_1.duration_ = 8.27

		local var_347_0 = {
			zh = 5.1,
			ja = 8.266
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play413081082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10022"]) and arg_347_1.var_.actorSpriteComps10022 == nil then
				arg_347_1.var_.actorSpriteComps10022 = arg_347_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10022"]) then
				if arg_347_1.var_.actorSpriteComps10022 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 1, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10022"]) and arg_347_1.var_.actorSpriteComps10022 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10022 = nil
			end

			local var_350_2 = arg_347_1.actors_["10094"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10094 == nil then
				arg_347_1.var_.actorSpriteComps10094 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10094 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								iter_350_5.color = Color.New(Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_5.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_5.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10094 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_350_7 then
						iter_350_7.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps10094 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.675

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(413081081)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 27 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 27)

				if (27 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 27)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081081", "story_v_out_413081.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081081", "story_v_out_413081.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_413081", "413081081", "story_v_out_413081.awb")

						arg_347_1:RecordAudio("413081081", var_350_12)
						arg_347_1:RecordAudio("413081081", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413081", "413081081", "story_v_out_413081.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413081", "413081081", "story_v_out_413081.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play413081082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413081082
		arg_351_1.duration_ = 6.27

		local var_351_0 = {
			zh = 4.8,
			ja = 6.266
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
				arg_351_0:Play413081083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.7

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(413081082)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 28 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 28)

				if (28 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 28)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081082", "story_v_out_413081.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081082", "story_v_out_413081.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_413081", "413081082", "story_v_out_413081.awb")

						arg_351_1:RecordAudio("413081082", var_354_6)
						arg_351_1:RecordAudio("413081082", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413081", "413081082", "story_v_out_413081.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413081", "413081082", "story_v_out_413081.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413081083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413081083
		arg_355_1.duration_ = 4.8

		local var_355_0 = {
			zh = 2.5,
			ja = 4.8
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413081084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.375

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(413081083)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 15 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 15)

				if (15 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 15)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081083", "story_v_out_413081.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081083", "story_v_out_413081.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_413081", "413081083", "story_v_out_413081.awb")

						arg_355_1:RecordAudio("413081083", var_358_6)
						arg_355_1:RecordAudio("413081083", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413081", "413081083", "story_v_out_413081.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413081", "413081083", "story_v_out_413081.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play413081084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413081084
		arg_359_1.duration_ = 9.3

		local var_359_0 = {
			zh = 4.8,
			ja = 9.3
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
				arg_359_0:Play413081085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10022"]) and arg_359_1.var_.actorSpriteComps10022 == nil then
				arg_359_1.var_.actorSpriteComps10022 = arg_359_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.034

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10022"]) then
				if arg_359_1.var_.actorSpriteComps10022 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 0.5, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10022"]) and arg_359_1.var_.actorSpriteComps10022 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps10022 = nil
			end

			local var_362_2 = arg_359_1.actors_["10022"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10022 == nil then
				arg_359_1.var_.actorSpriteComps10022 = var_362_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_3 = 2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.actorSpriteComps10022 then
					for iter_362_4, iter_362_5 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_362_5 then
							if arg_359_1.isInRecall_ then
								iter_362_5.color = Color.New(Mathf.Lerp(iter_362_5.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 0) / var_362_3), Mathf.Lerp(iter_362_5.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 0) / var_362_3), (Mathf.Lerp(iter_362_5.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 0) / var_362_3)))
							else
								local var_362_4 = Mathf.Lerp(iter_362_5.color.r, 0.5, (arg_359_1.time_ - 0) / var_362_3)

								iter_362_5.color = Color.New(var_362_4, var_362_4, var_362_4)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10022 then
				for iter_362_6, iter_362_7 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_362_7 then
						iter_362_7.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps10022 = nil
			end

			local var_362_5 = 0
			local var_362_6 = 0.6

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_7 = arg_359_1:GetWordFromCfg(413081084)
				local var_362_8 = arg_359_1:FormatText(var_362_7.content)

				arg_359_1.text_.text = var_362_8

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 24 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 24)

				if (24 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 24)) > 0 and var_362_6 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_8
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081084", "story_v_out_413081.awb") ~= 0 then
					local var_362_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081084", "story_v_out_413081.awb") / 1000

					if var_362_11 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_5
					end

					if var_362_7.prefab_name ~= "" and arg_359_1.actors_[var_362_7.prefab_name] ~= nil then
						local var_362_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_7.prefab_name].transform, "story_v_out_413081", "413081084", "story_v_out_413081.awb")

						arg_359_1:RecordAudio("413081084", var_362_12)
						arg_359_1:RecordAudio("413081084", var_362_12)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_413081", "413081084", "story_v_out_413081.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_413081", "413081084", "story_v_out_413081.awb")
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

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play413081085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 413081085
		arg_363_1.duration_ = 5.63

		local var_363_0 = {
			zh = 5.633,
			ja = 5.1
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play413081086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10022 = arg_363_1.actors_["10022"].transform.localPosition
				arg_363_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10022", 2)

				for iter_366_0 = 0, arg_363_1.actors_["10022"].transform.childCount - 1 do
					local var_366_0 = arg_363_1.actors_["10022"].transform:GetChild(iter_366_0)

					if var_366_0.name == "split_6" or not string.find(var_366_0.name, "split") then
						var_366_0.gameObject:SetActive(true)
					else
						var_366_0.gameObject:SetActive(false)
					end
				end
			end

			local var_366_1 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 then
				arg_363_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_363_1.time_ - 0) / var_366_1)
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_366_2 = arg_363_1.actors_["10022"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10022 == nil then
				arg_363_1.var_.actorSpriteComps10022 = var_366_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_3 = 2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.actorSpriteComps10022 then
					for iter_366_1, iter_366_2 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_366_2 then
							if arg_363_1.isInRecall_ then
								iter_366_2.color = Color.New(Mathf.Lerp(iter_366_2.color.r, arg_363_1.hightColor1.r, (arg_363_1.time_ - 0) / var_366_3), Mathf.Lerp(iter_366_2.color.g, arg_363_1.hightColor1.g, (arg_363_1.time_ - 0) / var_366_3), (Mathf.Lerp(iter_366_2.color.b, arg_363_1.hightColor1.b, (arg_363_1.time_ - 0) / var_366_3)))
							else
								local var_366_4 = Mathf.Lerp(iter_366_2.color.r, 1, (arg_363_1.time_ - 0) / var_366_3)

								iter_366_2.color = Color.New(var_366_4, var_366_4, var_366_4)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10022 then
				for iter_366_3, iter_366_4 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_366_4 then
						iter_366_4.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps10022 = nil
			end

			local var_366_5 = 0
			local var_366_6 = 0.65

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_7 = arg_363_1:GetWordFromCfg(413081085)
				local var_366_8 = arg_363_1:FormatText(var_366_7.content)

				arg_363_1.text_.text = var_366_8

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_10 = 26 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_8) / 26)

				if (26 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_8) / 26)) > 0 and var_366_6 < var_366_10 then
					arg_363_1.talkMaxDuration = var_366_10

					if var_366_10 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_5
					end
				end

				arg_363_1.text_.text = var_366_8
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081085", "story_v_out_413081.awb") ~= 0 then
					local var_366_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081085", "story_v_out_413081.awb") / 1000

					if var_366_11 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_11 + var_366_5
					end

					if var_366_7.prefab_name ~= "" and arg_363_1.actors_[var_366_7.prefab_name] ~= nil then
						local var_366_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_7.prefab_name].transform, "story_v_out_413081", "413081085", "story_v_out_413081.awb")

						arg_363_1:RecordAudio("413081085", var_366_12)
						arg_363_1:RecordAudio("413081085", var_366_12)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_413081", "413081085", "story_v_out_413081.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_413081", "413081085", "story_v_out_413081.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_6, arg_363_1.talkMaxDuration)

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_5) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_5 + var_366_13 and arg_363_1.time_ < var_366_5 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413081086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 413081086
		arg_367_1.duration_ = 5.17

		local var_367_0 = {
			zh = 1.999999999999,
			ja = 5.166
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
				arg_367_0:Play413081087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10022 = arg_367_1.actors_["10022"].transform.localPosition
				arg_367_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10022", 2)

				for iter_370_0 = 0, arg_367_1.actors_["10022"].transform.childCount - 1 do
					local var_370_0 = arg_367_1.actors_["10022"].transform:GetChild(iter_370_0)

					if var_370_0.name == "" or not string.find(var_370_0.name, "split") then
						var_370_0.gameObject:SetActive(true)
					else
						var_370_0.gameObject:SetActive(false)
					end
				end
			end

			local var_370_1 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 then
				arg_367_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_367_1.time_ - 0) / var_370_1)
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 then
				arg_367_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_370_2 = arg_367_1.actors_["10094"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10094 == nil then
				arg_367_1.var_.actorSpriteComps10094 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps10094 then
					for iter_370_1, iter_370_2 in pairs(arg_367_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_370_2 then
							if arg_367_1.isInRecall_ then
								iter_370_2.color = Color.New(Mathf.Lerp(iter_370_2.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_3), Mathf.Lerp(iter_370_2.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_3), (Mathf.Lerp(iter_370_2.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_3)))
							else
								local var_370_4 = Mathf.Lerp(iter_370_2.color.r, 1, (arg_367_1.time_ - 0) / var_370_3)

								iter_370_2.color = Color.New(var_370_4, var_370_4, var_370_4)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10094 then
				for iter_370_3, iter_370_4 in pairs(arg_367_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_370_4 then
						iter_370_4.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10094 = nil
			end

			local var_370_5 = arg_367_1.actors_["10022"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.actorSpriteComps10022 == nil then
				arg_367_1.var_.actorSpriteComps10022 = var_370_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_6 = 2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_6 and not isNil(var_370_5) then
				if arg_367_1.var_.actorSpriteComps10022 then
					for iter_370_5, iter_370_6 in pairs(arg_367_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_370_6 then
							if arg_367_1.isInRecall_ then
								iter_370_6.color = Color.New(Mathf.Lerp(iter_370_6.color.r, arg_367_1.hightColor2.r, (arg_367_1.time_ - 0) / var_370_6), Mathf.Lerp(iter_370_6.color.g, arg_367_1.hightColor2.g, (arg_367_1.time_ - 0) / var_370_6), (Mathf.Lerp(iter_370_6.color.b, arg_367_1.hightColor2.b, (arg_367_1.time_ - 0) / var_370_6)))
							else
								local var_370_7 = Mathf.Lerp(iter_370_6.color.r, 0.5, (arg_367_1.time_ - 0) / var_370_6)

								iter_370_6.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_6 and arg_367_1.time_ < 0 + var_370_6 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.actorSpriteComps10022 then
				for iter_370_7, iter_370_8 in pairs(arg_367_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_370_8 then
						iter_370_8.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_367_1.var_.actorSpriteComps10022 = nil
			end

			local var_370_8 = arg_367_1.actors_["10094"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10094 = var_370_8.localPosition
				var_370_8.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10094", 4)

				for iter_370_9 = 0, var_370_8.childCount - 1 do
					local var_370_9 = var_370_8:GetChild(iter_370_9)

					if var_370_9.name == "" or not string.find(var_370_9.name, "split") then
						var_370_9.gameObject:SetActive(true)
					else
						var_370_9.gameObject:SetActive(false)
					end
				end
			end

			local var_370_10 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_10 then
				var_370_8.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10094, Vector3.New(390, -315, -320), (arg_367_1.time_ - 0) / var_370_10)
			end

			if arg_367_1.time_ >= 0 + var_370_10 and arg_367_1.time_ < 0 + var_370_10 + arg_370_0 then
				var_370_8.localPosition = Vector3.New(390, -315, -320)
			end

			local var_370_11 = 0
			local var_370_12 = 0.225

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_11 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_13 = arg_367_1:GetWordFromCfg(413081086)
				local var_370_14 = arg_367_1:FormatText(var_370_13.content)

				arg_367_1.text_.text = var_370_14

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_16 = 9 <= 0 and var_370_12 or var_370_12 * (utf8.len(var_370_14) / 9)

				if (9 <= 0 and var_370_12 or var_370_12 * (utf8.len(var_370_14) / 9)) > 0 and var_370_12 < var_370_16 then
					arg_367_1.talkMaxDuration = var_370_16

					if var_370_16 + var_370_11 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_16 + var_370_11
					end
				end

				arg_367_1.text_.text = var_370_14
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081086", "story_v_out_413081.awb") ~= 0 then
					local var_370_17 = manager.audio:GetVoiceLength("story_v_out_413081", "413081086", "story_v_out_413081.awb") / 1000

					if var_370_17 + var_370_11 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_17 + var_370_11
					end

					if var_370_13.prefab_name ~= "" and arg_367_1.actors_[var_370_13.prefab_name] ~= nil then
						local var_370_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_13.prefab_name].transform, "story_v_out_413081", "413081086", "story_v_out_413081.awb")

						arg_367_1:RecordAudio("413081086", var_370_18)
						arg_367_1:RecordAudio("413081086", var_370_18)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_413081", "413081086", "story_v_out_413081.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_413081", "413081086", "story_v_out_413081.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_19 = math.max(var_370_12, arg_367_1.talkMaxDuration)

			if var_370_11 <= arg_367_1.time_ and arg_367_1.time_ < var_370_11 + var_370_19 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_11) / var_370_19

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_11 + var_370_19 and arg_367_1.time_ < var_370_11 + var_370_19 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413081087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 413081087
		arg_371_1.duration_ = 5.83

		local var_371_0 = {
			zh = 3,
			ja = 5.833
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play413081088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos10022 = arg_371_1.actors_["10022"].transform.localPosition
				arg_371_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10022", 2)

				for iter_374_0 = 0, arg_371_1.actors_["10022"].transform.childCount - 1 do
					local var_374_0 = arg_371_1.actors_["10022"].transform:GetChild(iter_374_0)

					if var_374_0.name == "split_6" or not string.find(var_374_0.name, "split") then
						var_374_0.gameObject:SetActive(true)
					else
						var_374_0.gameObject:SetActive(false)
					end
				end
			end

			local var_374_1 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 then
				arg_371_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_371_1.time_ - 0) / var_374_1)
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 then
				arg_371_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_374_2 = arg_371_1.actors_["10022"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10022 == nil then
				arg_371_1.var_.actorSpriteComps10022 = var_374_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_3 = 2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.actorSpriteComps10022 then
					for iter_374_1, iter_374_2 in pairs(arg_371_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_374_2 then
							if arg_371_1.isInRecall_ then
								iter_374_2.color = Color.New(Mathf.Lerp(iter_374_2.color.r, arg_371_1.hightColor1.r, (arg_371_1.time_ - 0) / var_374_3), Mathf.Lerp(iter_374_2.color.g, arg_371_1.hightColor1.g, (arg_371_1.time_ - 0) / var_374_3), (Mathf.Lerp(iter_374_2.color.b, arg_371_1.hightColor1.b, (arg_371_1.time_ - 0) / var_374_3)))
							else
								local var_374_4 = Mathf.Lerp(iter_374_2.color.r, 1, (arg_371_1.time_ - 0) / var_374_3)

								iter_374_2.color = Color.New(var_374_4, var_374_4, var_374_4)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10022 then
				for iter_374_3, iter_374_4 in pairs(arg_371_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_374_4 then
						iter_374_4.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_371_1.var_.actorSpriteComps10022 = nil
			end

			local var_374_5 = arg_371_1.actors_["10094"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.actorSpriteComps10094 == nil then
				arg_371_1.var_.actorSpriteComps10094 = var_374_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_6 = 2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_6 and not isNil(var_374_5) then
				if arg_371_1.var_.actorSpriteComps10094 then
					for iter_374_5, iter_374_6 in pairs(arg_371_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_374_6 then
							if arg_371_1.isInRecall_ then
								iter_374_6.color = Color.New(Mathf.Lerp(iter_374_6.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_6), Mathf.Lerp(iter_374_6.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_6), (Mathf.Lerp(iter_374_6.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_6)))
							else
								local var_374_7 = Mathf.Lerp(iter_374_6.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_6)

								iter_374_6.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_6 and arg_371_1.time_ < 0 + var_374_6 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.actorSpriteComps10094 then
				for iter_374_7, iter_374_8 in pairs(arg_371_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_374_8 then
						iter_374_8.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps10094 = nil
			end

			local var_374_8 = 0
			local var_374_9 = 0.375

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_10 = arg_371_1:GetWordFromCfg(413081087)
				local var_374_11 = arg_371_1:FormatText(var_374_10.content)

				arg_371_1.text_.text = var_374_11

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 15 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 15)

				if (15 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 15)) > 0 and var_374_9 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_11
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081087", "story_v_out_413081.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081087", "story_v_out_413081.awb") / 1000

					if var_374_14 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_8
					end

					if var_374_10.prefab_name ~= "" and arg_371_1.actors_[var_374_10.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_10.prefab_name].transform, "story_v_out_413081", "413081087", "story_v_out_413081.awb")

						arg_371_1:RecordAudio("413081087", var_374_15)
						arg_371_1:RecordAudio("413081087", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_413081", "413081087", "story_v_out_413081.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_413081", "413081087", "story_v_out_413081.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play413081088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 413081088
		arg_375_1.duration_ = 2.47

		local var_375_0 = {
			zh = 2.466,
			ja = 2.433
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
				arg_375_0:Play413081089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10022 = arg_375_1.actors_["10022"].transform.localPosition
				arg_375_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10022", 2)

				for iter_378_0 = 0, arg_375_1.actors_["10022"].transform.childCount - 1 do
					local var_378_0 = arg_375_1.actors_["10022"].transform:GetChild(iter_378_0)

					if var_378_0.name == "" or not string.find(var_378_0.name, "split") then
						var_378_0.gameObject:SetActive(true)
					else
						var_378_0.gameObject:SetActive(false)
					end
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_375_1.time_ - 0) / var_378_1)
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_378_2 = arg_375_1.actors_["10094"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10094 == nil then
				arg_375_1.var_.actorSpriteComps10094 = var_378_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_3 = 2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.actorSpriteComps10094 then
					for iter_378_1, iter_378_2 in pairs(arg_375_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_378_2 then
							if arg_375_1.isInRecall_ then
								iter_378_2.color = Color.New(Mathf.Lerp(iter_378_2.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_3), Mathf.Lerp(iter_378_2.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_3), (Mathf.Lerp(iter_378_2.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_3)))
							else
								local var_378_4 = Mathf.Lerp(iter_378_2.color.r, 1, (arg_375_1.time_ - 0) / var_378_3)

								iter_378_2.color = Color.New(var_378_4, var_378_4, var_378_4)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10094 then
				for iter_378_3, iter_378_4 in pairs(arg_375_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_378_4 then
						iter_378_4.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps10094 = nil
			end

			local var_378_5 = arg_375_1.actors_["10022"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_5) and arg_375_1.var_.actorSpriteComps10022 == nil then
				arg_375_1.var_.actorSpriteComps10022 = var_378_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_6 = 2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_6 and not isNil(var_378_5) then
				if arg_375_1.var_.actorSpriteComps10022 then
					for iter_378_5, iter_378_6 in pairs(arg_375_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_378_6 then
							if arg_375_1.isInRecall_ then
								iter_378_6.color = Color.New(Mathf.Lerp(iter_378_6.color.r, arg_375_1.hightColor2.r, (arg_375_1.time_ - 0) / var_378_6), Mathf.Lerp(iter_378_6.color.g, arg_375_1.hightColor2.g, (arg_375_1.time_ - 0) / var_378_6), (Mathf.Lerp(iter_378_6.color.b, arg_375_1.hightColor2.b, (arg_375_1.time_ - 0) / var_378_6)))
							else
								local var_378_7 = Mathf.Lerp(iter_378_6.color.r, 0.5, (arg_375_1.time_ - 0) / var_378_6)

								iter_378_6.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_6 and arg_375_1.time_ < 0 + var_378_6 + arg_378_0 and not isNil(var_378_5) and arg_375_1.var_.actorSpriteComps10022 then
				for iter_378_7, iter_378_8 in pairs(arg_375_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_378_8 then
						iter_378_8.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_375_1.var_.actorSpriteComps10022 = nil
			end

			local var_378_8 = 0
			local var_378_9 = 0.25

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(413081088)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_13 = 10 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 10)

				if (10 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 10)) > 0 and var_378_9 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081088", "story_v_out_413081.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081088", "story_v_out_413081.awb") / 1000

					if var_378_14 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_8
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_413081", "413081088", "story_v_out_413081.awb")

						arg_375_1:RecordAudio("413081088", var_378_15)
						arg_375_1:RecordAudio("413081088", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_413081", "413081088", "story_v_out_413081.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_413081", "413081088", "story_v_out_413081.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_16 and arg_375_1.time_ < var_378_8 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play413081089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 413081089
		arg_379_1.duration_ = 4

		local var_379_0 = {
			zh = 3.8,
			ja = 4
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play413081090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.35

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:GetWordFromCfg(413081089)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 14 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 14)

				if (14 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 14)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081089", "story_v_out_413081.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_out_413081", "413081089", "story_v_out_413081.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_out_413081", "413081089", "story_v_out_413081.awb")

						arg_379_1:RecordAudio("413081089", var_382_6)
						arg_379_1:RecordAudio("413081089", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_413081", "413081089", "story_v_out_413081.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_413081", "413081089", "story_v_out_413081.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play413081090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 413081090
		arg_383_1.duration_ = 6.07

		local var_383_0 = {
			zh = 4.866,
			ja = 6.066
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
				arg_383_0:Play413081091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10022 = arg_383_1.actors_["10022"].transform.localPosition
				arg_383_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10022", 2)

				for iter_386_0 = 0, arg_383_1.actors_["10022"].transform.childCount - 1 do
					local var_386_0 = arg_383_1.actors_["10022"].transform:GetChild(iter_386_0)

					if var_386_0.name == "split_3" or not string.find(var_386_0.name, "split") then
						var_386_0.gameObject:SetActive(true)
					else
						var_386_0.gameObject:SetActive(false)
					end
				end
			end

			local var_386_1 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 then
				arg_383_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_383_1.time_ - 0) / var_386_1)
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 then
				arg_383_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_386_2 = arg_383_1.actors_["10022"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10022 == nil then
				arg_383_1.var_.actorSpriteComps10022 = var_386_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_3 = 2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.actorSpriteComps10022 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								iter_386_2.color = Color.New(Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_3), Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_3), (Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_3)))
							else
								local var_386_4 = Mathf.Lerp(iter_386_2.color.r, 1, (arg_383_1.time_ - 0) / var_386_3)

								iter_386_2.color = Color.New(var_386_4, var_386_4, var_386_4)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10022 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_386_4 then
						iter_386_4.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps10022 = nil
			end

			local var_386_5 = arg_383_1.actors_["10094"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10094 == nil then
				arg_383_1.var_.actorSpriteComps10094 = var_386_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_6 = 2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_6 and not isNil(var_386_5) then
				if arg_383_1.var_.actorSpriteComps10094 then
					for iter_386_5, iter_386_6 in pairs(arg_383_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_386_6 then
							if arg_383_1.isInRecall_ then
								iter_386_6.color = Color.New(Mathf.Lerp(iter_386_6.color.r, arg_383_1.hightColor2.r, (arg_383_1.time_ - 0) / var_386_6), Mathf.Lerp(iter_386_6.color.g, arg_383_1.hightColor2.g, (arg_383_1.time_ - 0) / var_386_6), (Mathf.Lerp(iter_386_6.color.b, arg_383_1.hightColor2.b, (arg_383_1.time_ - 0) / var_386_6)))
							else
								local var_386_7 = Mathf.Lerp(iter_386_6.color.r, 0.5, (arg_383_1.time_ - 0) / var_386_6)

								iter_386_6.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_6 and arg_383_1.time_ < 0 + var_386_6 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10094 then
				for iter_386_7, iter_386_8 in pairs(arg_383_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_386_8 then
						iter_386_8.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_383_1.var_.actorSpriteComps10094 = nil
			end

			local var_386_8 = 0
			local var_386_9 = 0.45

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_10 = arg_383_1:GetWordFromCfg(413081090)
				local var_386_11 = arg_383_1:FormatText(var_386_10.content)

				arg_383_1.text_.text = var_386_11

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_13 = 18 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 18)

				if (18 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 18)) > 0 and var_386_9 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_8
					end
				end

				arg_383_1.text_.text = var_386_11
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081090", "story_v_out_413081.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_out_413081", "413081090", "story_v_out_413081.awb") / 1000

					if var_386_14 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_8
					end

					if var_386_10.prefab_name ~= "" and arg_383_1.actors_[var_386_10.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_10.prefab_name].transform, "story_v_out_413081", "413081090", "story_v_out_413081.awb")

						arg_383_1:RecordAudio("413081090", var_386_15)
						arg_383_1:RecordAudio("413081090", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_413081", "413081090", "story_v_out_413081.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_413081", "413081090", "story_v_out_413081.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_9, arg_383_1.talkMaxDuration)

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_8) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_8 + var_386_16 and arg_383_1.time_ < var_386_8 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play413081091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 413081091
		arg_387_1.duration_ = 6.63

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play413081092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_9000

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10022 = arg_387_1.actors_["10022"].transform.localPosition
				arg_387_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10022", 0)

				for iter_390_0 = 0, arg_387_1.actors_["10022"].transform.childCount - 1 do
					local var_390_0 = arg_387_1.actors_["10022"].transform:GetChild(iter_390_0)

					if var_390_0.name == "" or not string.find(var_390_0.name, "split") then
						var_390_0.gameObject:SetActive(true)
					else
						var_390_0.gameObject:SetActive(false)
					end
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_387_1.time_ - 0) / var_390_1)
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_390_2 = arg_387_1.actors_["10094"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10094 = var_390_2.localPosition
				var_390_2.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10094", 0)

				for iter_390_1 = 0, var_390_2.childCount - 1 do
					local var_390_3 = var_390_2:GetChild(iter_390_1)

					if var_390_3.name == "" or not string.find(var_390_3.name, "split") then
						var_390_3.gameObject:SetActive(true)
					else
						var_390_3.gameObject:SetActive(false)
					end
				end
			end

			local var_390_4 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				var_390_2.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_387_1.time_ - 0) / var_390_4)
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				var_390_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_390_5 = arg_387_1.actors_["10022"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_5) and arg_387_1.var_.actorSpriteComps10022 == nil then
				arg_387_1.var_.actorSpriteComps10022 = var_390_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_6 = 2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_6 and not isNil(var_390_5) then
				if arg_387_1.var_.actorSpriteComps10022 then
					for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_390_3 then
							if arg_387_1.isInRecall_ then
								iter_390_3.color = Color.New(Mathf.Lerp(iter_390_3.color.r, arg_387_1.hightColor2.r, (arg_387_1.time_ - 0) / var_390_6), Mathf.Lerp(iter_390_3.color.g, arg_387_1.hightColor2.g, (arg_387_1.time_ - 0) / var_390_6), (Mathf.Lerp(iter_390_3.color.b, arg_387_1.hightColor2.b, (arg_387_1.time_ - 0) / var_390_6)))
							else
								local var_390_7 = Mathf.Lerp(iter_390_3.color.r, 0.5, (arg_387_1.time_ - 0) / var_390_6)

								iter_390_3.color = Color.New(var_390_7, var_390_7, var_390_7)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_6 and arg_387_1.time_ < 0 + var_390_6 + arg_390_0 and not isNil(var_390_5) and arg_387_1.var_.actorSpriteComps10022 then
				for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_390_5 then
						iter_390_5.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_387_1.var_.actorSpriteComps10022 = nil
			end

			local var_390_8 = arg_387_1.actors_["10094"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps10094 == nil then
				arg_387_1.var_.actorSpriteComps10094 = var_390_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_9 = 2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_9 and not isNil(var_390_8) then
				if arg_387_1.var_.actorSpriteComps10094 then
					for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_390_7 then
							if arg_387_1.isInRecall_ then
								iter_390_7.color = Color.New(Mathf.Lerp(iter_390_7.color.r, arg_387_1.hightColor2.r, (arg_387_1.time_ - 0) / var_390_9), Mathf.Lerp(iter_390_7.color.g, arg_387_1.hightColor2.g, (arg_387_1.time_ - 0) / var_390_9), (Mathf.Lerp(iter_390_7.color.b, arg_387_1.hightColor2.b, (arg_387_1.time_ - 0) / var_390_9)))
							else
								local var_390_10 = Mathf.Lerp(iter_390_7.color.r, 0.5, (arg_387_1.time_ - 0) / var_390_9)

								iter_390_7.color = Color.New(var_390_10, var_390_10, var_390_10)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_9 and arg_387_1.time_ < 0 + var_390_9 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps10094 then
				for iter_390_8, iter_390_9 in pairs(arg_387_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_390_9 then
						iter_390_9.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_387_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				local var_390_11 = arg_387_1.var_.effectquanyao1

				if not arg_387_1.var_.effectquanyao1 then
					var_390_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_390_11.name = "quanyao1"
					arg_387_1.var_.effectquanyao1 = var_390_11
				else
					var_390_11.transform:SetParent(var_390_9000)
				end

				var_390_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_390_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.46666666666667 < arg_387_1.time_ and arg_387_1.time_ <= 1.46666666666667 + arg_390_0 then
				if arg_387_1.var_.effectquanyao1 then
					Object.Destroy(arg_387_1.var_.effectquanyao1)

					arg_387_1.var_.effectquanyao1 = nil
				end
			end

			local var_390_14 = 0

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_15 = 1

			if var_390_14 <= arg_387_1.time_ and arg_387_1.time_ < var_390_14 + var_390_15 then
				local var_390_16 = Color.New(1, 1, 1)

				var_390_16.a = Mathf.Lerp(0, 1, (arg_387_1.time_ - var_390_14) / var_390_15)
				arg_387_1.mask_.color = var_390_16
			end

			if arg_387_1.time_ >= var_390_14 + var_390_15 and arg_387_1.time_ < var_390_14 + var_390_15 + arg_390_0 then
				local var_390_17 = Color.New(1, 1, 1)

				var_390_17.a = 1
				arg_387_1.mask_.color = var_390_17
			end

			local var_390_18 = 1

			if 1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_18 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_19 = 0.75

			if var_390_18 <= arg_387_1.time_ and arg_387_1.time_ < var_390_18 + var_390_19 then
				local var_390_20 = Color.New(1, 1, 1)

				var_390_20.a = Mathf.Lerp(1, 0, (arg_387_1.time_ - var_390_18) / var_390_19)
				arg_387_1.mask_.color = var_390_20
			end

			if arg_387_1.time_ >= var_390_18 + var_390_19 and arg_387_1.time_ < var_390_18 + var_390_19 + arg_390_0 then
				local var_390_21 = Color.New(1, 1, 1)

				arg_387_1.mask_.enabled = false
				var_390_21.a = 0
				arg_387_1.mask_.color = var_390_21
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if arg_387_1.frameCnt_ <= 1 then
				arg_387_1.dialog_:SetActive(false)
			end

			local var_390_23 = 1.63333333333333
			local var_390_24 = 1.675

			if 1.63333333333333 < arg_387_1.time_ and arg_387_1.time_ <= var_390_23 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_25 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_25:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_26 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(413081091).content)

				arg_387_1.text_.text = var_390_26

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_28 = 67 <= 0 and var_390_24 or var_390_24 * (utf8.len(var_390_26) / 67)

				if (67 <= 0 and var_390_24 or var_390_24 * (utf8.len(var_390_26) / 67)) > 0 and var_390_24 < var_390_28 then
					arg_387_1.talkMaxDuration = var_390_28
					var_390_23 = var_390_23 + 0.3

					if var_390_28 + var_390_23 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_28 + var_390_23
					end
				end

				arg_387_1.text_.text = var_390_26
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_29 = var_390_23 + 0.3
			local var_390_30 = math.max(var_390_24, arg_387_1.talkMaxDuration)

			if var_390_23 + 0.3 <= arg_387_1.time_ and arg_387_1.time_ < var_390_29 + var_390_30 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_29) / var_390_30

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_29 + var_390_30 and arg_387_1.time_ < var_390_29 + var_390_30 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413081092 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 413081092
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play413081093(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.225

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(413081092).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 49 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 49)

				if (49 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 49)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play413081093 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 413081093
		arg_397_1.duration_ = 5.73

		local var_397_0 = {
			zh = 2.766,
			ja = 5.733
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play413081094(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10022 = arg_397_1.actors_["10022"].transform.localPosition
				arg_397_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10022", 3)

				for iter_400_0 = 0, arg_397_1.actors_["10022"].transform.childCount - 1 do
					local var_400_0 = arg_397_1.actors_["10022"].transform:GetChild(iter_400_0)

					if var_400_0.name == "split_8" or not string.find(var_400_0.name, "split") then
						var_400_0.gameObject:SetActive(true)
					else
						var_400_0.gameObject:SetActive(false)
					end
				end
			end

			local var_400_1 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_397_1.time_ - 0) / var_400_1)
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_400_2 = arg_397_1.actors_["10022"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10022 == nil then
				arg_397_1.var_.actorSpriteComps10022 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps10022 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								iter_400_2.color = Color.New(Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_2.color.r, 1, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_2.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10022 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_400_4 then
						iter_400_4.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10022 = nil
			end

			local var_400_5 = 0
			local var_400_6 = 0.325

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_7 = arg_397_1:GetWordFromCfg(413081093)
				local var_400_8 = arg_397_1:FormatText(var_400_7.content)

				arg_397_1.text_.text = var_400_8

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 13 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 13)

				if (13 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 13)) > 0 and var_400_6 < var_400_10 then
					arg_397_1.talkMaxDuration = var_400_10

					if var_400_10 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_5
					end
				end

				arg_397_1.text_.text = var_400_8
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081093", "story_v_out_413081.awb") ~= 0 then
					local var_400_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081093", "story_v_out_413081.awb") / 1000

					if var_400_11 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_11 + var_400_5
					end

					if var_400_7.prefab_name ~= "" and arg_397_1.actors_[var_400_7.prefab_name] ~= nil then
						local var_400_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_7.prefab_name].transform, "story_v_out_413081", "413081093", "story_v_out_413081.awb")

						arg_397_1:RecordAudio("413081093", var_400_12)
						arg_397_1:RecordAudio("413081093", var_400_12)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_413081", "413081093", "story_v_out_413081.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_413081", "413081093", "story_v_out_413081.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_6, arg_397_1.talkMaxDuration)

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_5) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_5 + var_400_13 and arg_397_1.time_ < var_400_5 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play413081094 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 413081094
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play413081095(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10022 = arg_401_1.actors_["10022"].transform.localPosition
				arg_401_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10022", 7)

				for iter_404_0 = 0, arg_401_1.actors_["10022"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["10022"].transform:GetChild(iter_404_0)

					if var_404_0.name == "" or not string.find(var_404_0.name, "split") then
						var_404_0.gameObject:SetActive(true)
					else
						var_404_0.gameObject:SetActive(false)
					end
				end
			end

			local var_404_1 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				arg_401_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_401_1.time_ - 0) / var_404_1)
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_404_2 = 0
			local var_404_3 = 0.2

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(413081094).content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 48 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 48)

				if (48 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 48)) > 0 and var_404_3 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_7 and arg_401_1.time_ < var_404_2 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play413081095 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 413081095
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play413081096(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0.2 < arg_405_1.time_ and arg_405_1.time_ <= 0.2 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			if 0.991666666666667 < arg_405_1.time_ and arg_405_1.time_ <= 0.991666666666667 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_128", "se_story_128_magic", "")
			end

			local var_408_2 = 0
			local var_408_3 = 1.525

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_4 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(413081095).content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_6 = 61 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 61)

				if (61 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 61)) > 0 and var_408_3 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_2
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_3, arg_405_1.talkMaxDuration)

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_2) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_2 + var_408_7 and arg_405_1.time_ < var_408_2 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play413081096 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 413081096
		arg_409_1.duration_ = 6.27

		local var_409_0 = {
			zh = 5.233,
			ja = 6.266
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
			arg_409_1.auto_ = false
		end

		function arg_409_1.playNext_(arg_411_0)
			arg_409_1.onStoryFinished_()
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10022 = arg_409_1.actors_["10022"].transform.localPosition
				arg_409_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10022", 3)

				for iter_412_0 = 0, arg_409_1.actors_["10022"].transform.childCount - 1 do
					local var_412_0 = arg_409_1.actors_["10022"].transform:GetChild(iter_412_0)

					if var_412_0.name == "split_8" or not string.find(var_412_0.name, "split") then
						var_412_0.gameObject:SetActive(true)
					else
						var_412_0.gameObject:SetActive(false)
					end
				end
			end

			local var_412_1 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				arg_409_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_409_1.time_ - 0) / var_412_1)
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 then
				arg_409_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_412_2 = arg_409_1.actors_["10022"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps10022 == nil then
				arg_409_1.var_.actorSpriteComps10022 = var_412_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_3 = 2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.actorSpriteComps10022 then
					for iter_412_1, iter_412_2 in pairs(arg_409_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_412_2 then
							if arg_409_1.isInRecall_ then
								iter_412_2.color = Color.New(Mathf.Lerp(iter_412_2.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_3), Mathf.Lerp(iter_412_2.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_3), (Mathf.Lerp(iter_412_2.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_3)))
							else
								local var_412_4 = Mathf.Lerp(iter_412_2.color.r, 1, (arg_409_1.time_ - 0) / var_412_3)

								iter_412_2.color = Color.New(var_412_4, var_412_4, var_412_4)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps10022 then
				for iter_412_3, iter_412_4 in pairs(arg_409_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_412_4 then
						iter_412_4.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps10022 = nil
			end

			local var_412_5 = 0
			local var_412_6 = 0.6

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_7 = arg_409_1:GetWordFromCfg(413081096)
				local var_412_8 = arg_409_1:FormatText(var_412_7.content)

				arg_409_1.text_.text = var_412_8

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_10 = 24 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_8) / 24)

				if (24 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_8) / 24)) > 0 and var_412_6 < var_412_10 then
					arg_409_1.talkMaxDuration = var_412_10

					if var_412_10 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_8
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081096", "story_v_out_413081.awb") ~= 0 then
					local var_412_11 = manager.audio:GetVoiceLength("story_v_out_413081", "413081096", "story_v_out_413081.awb") / 1000

					if var_412_11 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_11 + var_412_5
					end

					if var_412_7.prefab_name ~= "" and arg_409_1.actors_[var_412_7.prefab_name] ~= nil then
						local var_412_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_7.prefab_name].transform, "story_v_out_413081", "413081096", "story_v_out_413081.awb")

						arg_409_1:RecordAudio("413081096", var_412_12)
						arg_409_1:RecordAudio("413081096", var_412_12)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_413081", "413081096", "story_v_out_413081.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_413081", "413081096", "story_v_out_413081.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_13 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_13 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_13

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_13 and arg_409_1.time_ < var_412_5 + var_412_13 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08m",
		"TextureConfig/Background/F08i"
	},
	voices = {
		"story_v_out_413081.awb"
	}
}
