return {
	Play938081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

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

			local var_4_11 = "104701"

			if arg_1_1.actors_["104701"] == nil then
				local var_4_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_4_12) then
					local var_4_13 = Object.Instantiate(var_4_12, arg_1_1.canvasGo_.transform)

					var_4_13.transform:SetSiblingIndex(1)

					var_4_13.name = var_4_11
					var_4_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_11] = var_4_13

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_13:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_14 = arg_1_1.actors_["104701"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_14 then
					arg_1_1.var_.alphaOldValue104701 = var_4_14.alpha
					arg_1_1.var_.characterEffect104701 = var_4_14
				end

				arg_1_1.var_.alphaOldValue104701 = 0
			end

			local var_4_15 = 0.5

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 then
				if arg_1_1.var_.characterEffect104701 then
					arg_1_1.var_.characterEffect104701.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue104701, 1, (arg_1_1.time_ - 2) / var_4_15)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and arg_1_1.var_.characterEffect104701 then
				arg_1_1.var_.characterEffect104701.alpha = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.4

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938081001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 16 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 16)

				if (16 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 16)) > 0 and var_4_17 < var_4_21 then
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
	Play938081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.cswbg_:SetActive(false)

				local var_11_0 = arg_8_1.cswt_:GetComponent("RectTransform")

				arg_8_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_11_0.offsetMin = Vector2.New(400, 105)
				var_11_0.offsetMax = Vector2.New(-400, -200)
				arg_8_1.cswt_.text = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(419196).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.cswt_)

				arg_8_1.cswt_.fontSize = 108
				arg_8_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_8_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_8_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_8_1.cswbg_:SetActive(true)
			end

			local var_11_1 = 0
			local var_11_2 = 0.875

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938081002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 35 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 35)

				if (35 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 35)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938081003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 40 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 40)

				if (40 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 40)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938081004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["104701"]) and arg_16_1.var_.actorSpriteComps104701 == nil then
				arg_16_1.var_.actorSpriteComps104701 = arg_16_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["104701"]) then
				if arg_16_1.var_.actorSpriteComps104701 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								iter_19_1.color = Color.New(Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, (arg_16_1.time_ - 0) / var_19_0), Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, (arg_16_1.time_ - 0) / var_19_0), (Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, (arg_16_1.time_ - 0) / var_19_0)))
							else
								local var_19_1 = Mathf.Lerp(iter_19_1.color.r, 0.5, (arg_16_1.time_ - 0) / var_19_0)

								iter_19_1.color = Color.New(var_19_1, var_19_1, var_19_1)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["104701"]) and arg_16_1.var_.actorSpriteComps104701 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps104701 = nil
			end

			local var_19_2 = 0
			local var_19_3 = 0.425

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938081004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 17 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 17)

				if (17 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 17)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play938081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938081005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.525

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938081005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 21 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 21)

				if (21 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 21)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938081006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["104701"]) and arg_24_1.var_.actorSpriteComps104701 == nil then
				arg_24_1.var_.actorSpriteComps104701 = arg_24_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["104701"]) then
				if arg_24_1.var_.actorSpriteComps104701 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["104701"]) and arg_24_1.var_.actorSpriteComps104701 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps104701 = nil
			end

			local var_27_2 = 0
			local var_27_3 = 0.525

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938081006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 21 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 21)

				if (21 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 21)) > 0 and var_27_3 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_7 and arg_24_1.time_ < var_27_2 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play938081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938081007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.8

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938081007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 32 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 32)

				if (32 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 32)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play938081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938081008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.9

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

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938081008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 36 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 36)

				if (36 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 36)) > 0 and var_35_0 < var_35_3 then
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
	Play938081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938081009
		arg_36_1.duration_ = 9

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.bgs_.I20f == nil then
				local var_39_0 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I20f")
				var_39_0.name = "I20f"
				var_39_0.transform.parent = arg_36_1.stage_.transform
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_.I20f = var_39_0
			end

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				local var_39_1 = arg_36_1.bgs_.I20f

				arg_36_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_2 = var_39_1:GetComponent("SpriteRenderer")

				if var_39_2 and var_39_2.sprite then
					local var_39_3 = 2 * (var_39_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_1.transform.localScale = Vector3.New(var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "I20f" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_4 = 4

			if 4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_4 + 0.3 and arg_36_1.time_ < var_39_4 + 0.3 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_5 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_6 = 2

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 then
				local var_39_7 = Color.New(0, 0, 0)

				var_39_7.a = Mathf.Lerp(0, 1, (arg_36_1.time_ - var_39_5) / var_39_6)
				arg_36_1.mask_.color = var_39_7
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 then
				local var_39_8 = Color.New(0, 0, 0)

				var_39_8.a = 1
				arg_36_1.mask_.color = var_39_8
			end

			local var_39_9 = 2

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_10 = 2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 then
				local var_39_11 = Color.New(0, 0, 0)

				var_39_11.a = Mathf.Lerp(1, 0, (arg_36_1.time_ - var_39_9) / var_39_10)
				arg_36_1.mask_.color = var_39_11
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 then
				local var_39_12 = Color.New(0, 0, 0)

				arg_36_1.mask_.enabled = false
				var_39_12.a = 0
				arg_36_1.mask_.color = var_39_12
			end

			if 2.2 < arg_36_1.time_ and arg_36_1.time_ <= 2.2 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 2.9 < arg_36_1.time_ and arg_36_1.time_ <= 2.9 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_39_16 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_16 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_16

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_16
						arg_36_1.bgmTxt2_.text = var_39_16
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				arg_36_1.cswbg_:SetActive(false)
			end

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				if arg_36_1.var_.effectweisheng1 then
					Object.Destroy(arg_36_1.var_.effectweisheng1)

					arg_36_1.var_.effectweisheng1 = nil
				end
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_18 = 4
			local var_39_19 = 1.1

			if 4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_20 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_20:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_36_1.dialogCg_.alpha = arg_41_0
				end))
				var_39_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_21 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938081009).content)

				arg_36_1.text_.text = var_39_21

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_23 = 44 <= 0 and var_39_19 or var_39_19 * (utf8.len(var_39_21) / 44)

				if (44 <= 0 and var_39_19 or var_39_19 * (utf8.len(var_39_21) / 44)) > 0 and var_39_19 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23
					var_39_18 = var_39_18 + 0.3

					if var_39_23 + var_39_18 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_18
					end
				end

				arg_36_1.text_.text = var_39_21
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = var_39_18 + 0.3
			local var_39_25 = math.max(var_39_19, arg_36_1.talkMaxDuration)

			if var_39_18 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_24) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_24 + var_39_25 and arg_36_1.time_ < var_39_24 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play938081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 938081010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play938081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.875

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(938081010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 35 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 35)

				if (35 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 35)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play938081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 938081011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play938081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["10144"] == nil then
				local var_50_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_50_0) then
					local var_50_1 = Object.Instantiate(var_50_0, arg_47_1.canvasGo_.transform)

					var_50_1.transform:SetSiblingIndex(1)

					var_50_1.name = "10144"
					var_50_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_47_1.actors_["10144"] = var_50_1

					if arg_47_1.isInRecall_ then
						for iter_50_0, iter_50_1 in ipairs((var_50_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_50_1.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_50_2 = arg_47_1.actors_["10144"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10144 == nil then
				arg_47_1.var_.actorSpriteComps10144 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps10144 then
					for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_50_3 then
							if arg_47_1.isInRecall_ then
								iter_50_3.color = Color.New(Mathf.Lerp(iter_50_3.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_3.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_3.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_3.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_3.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10144 then
				for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_50_5 then
						iter_50_5.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10144 = nil
			end

			local var_50_5 = arg_47_1.actors_["10144"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10144 = var_50_5.localPosition
				var_50_5.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10144", 2)

				for iter_50_6 = 0, var_50_5.childCount - 1 do
					local var_50_6 = var_50_5:GetChild(iter_50_6)

					if var_50_6.name == "split_14" or not string.find(var_50_6.name, "split") then
						var_50_6.gameObject:SetActive(true)
					else
						var_50_6.gameObject:SetActive(false)
					end
				end
			end

			local var_50_7 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_47_1.time_ - 0) / var_50_7)
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_50_8 = 0
			local var_50_9 = 0.65

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(938081011).content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 26 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 26)

				if (26 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 26)) > 0 and var_50_9 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_13 and arg_47_1.time_ < var_50_8 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 938081012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play938081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["10183"] == nil then
				local var_54_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_54_0) then
					local var_54_1 = Object.Instantiate(var_54_0, arg_51_1.canvasGo_.transform)

					var_54_1.transform:SetSiblingIndex(1)

					var_54_1.name = "10183"
					var_54_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_51_1.actors_["10183"] = var_54_1

					if arg_51_1.isInRecall_ then
						for iter_54_0, iter_54_1 in ipairs((var_54_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_54_1.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_54_2 = arg_51_1.actors_["10183"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10183 == nil then
				arg_51_1.var_.actorSpriteComps10183 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps10183 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								iter_54_3.color = Color.New(Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_3.color.r, 1, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_3.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10183 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_54_5 then
						iter_54_5.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps10183 = nil
			end

			local var_54_5 = arg_51_1.actors_["10144"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10144 == nil then
				arg_51_1.var_.actorSpriteComps10144 = var_54_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.actorSpriteComps10144 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								iter_54_7.color = Color.New(Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_6), Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_6), (Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_6)))
							else
								local var_54_7 = Mathf.Lerp(iter_54_7.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_6)

								iter_54_7.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10144 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_54_9 then
						iter_54_9.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10144 = nil
			end

			local var_54_8 = arg_51_1.actors_["10183"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10183 = var_54_8.localPosition
				var_54_8.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10183", 4)

				for iter_54_10 = 0, var_54_8.childCount - 1 do
					local var_54_9 = var_54_8:GetChild(iter_54_10)

					if var_54_9.name == "split_9" or not string.find(var_54_9.name, "split") then
						var_54_9.gameObject:SetActive(true)
					else
						var_54_9.gameObject:SetActive(false)
					end
				end
			end

			local var_54_10 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_10 then
				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10183, Vector3.New(300, -475, -325), (arg_51_1.time_ - 0) / var_54_10)
			end

			if arg_51_1.time_ >= 0 + var_54_10 and arg_51_1.time_ < 0 + var_54_10 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(300, -475, -325)
			end

			local var_54_11 = 0
			local var_54_12 = 0.35

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(938081012).content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 14 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 14)

				if (14 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 14)) > 0 and var_54_12 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_16 and arg_51_1.time_ < var_54_11 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 938081013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play938081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["10144"]) and arg_55_1.var_.actorSpriteComps10144 == nil then
				arg_55_1.var_.actorSpriteComps10144 = arg_55_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["10144"]) then
				if arg_55_1.var_.actorSpriteComps10144 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 1, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["10144"]) and arg_55_1.var_.actorSpriteComps10144 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10144 = nil
			end

			local var_58_2 = arg_55_1.actors_["10183"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10183 == nil then
				arg_55_1.var_.actorSpriteComps10183 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps10183 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								iter_58_5.color = Color.New(Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_5.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_5.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10183 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_58_7 then
						iter_58_7.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps10183 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.575

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(938081013).content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 23 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 23)

				if (23 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 23)) > 0 and var_58_6 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_10 and arg_55_1.time_ < var_58_5 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play938081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 938081014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play938081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10183"]) and arg_59_1.var_.actorSpriteComps10183 == nil then
				arg_59_1.var_.actorSpriteComps10183 = arg_59_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10183"]) then
				if arg_59_1.var_.actorSpriteComps10183 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10183"]) and arg_59_1.var_.actorSpriteComps10183 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps10183 = nil
			end

			local var_62_2 = arg_59_1.actors_["10144"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10144 == nil then
				arg_59_1.var_.actorSpriteComps10144 = var_62_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_3 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.actorSpriteComps10144 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								iter_62_5.color = Color.New(Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_3), Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_3), (Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_3)))
							else
								local var_62_4 = Mathf.Lerp(iter_62_5.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_3)

								iter_62_5.color = Color.New(var_62_4, var_62_4, var_62_4)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10144 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_62_7 then
						iter_62_7.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10144 = nil
			end

			local var_62_5 = arg_59_1.actors_["10183"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10183 = var_62_5.localPosition
				var_62_5.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10183", 4)

				for iter_62_8 = 0, var_62_5.childCount - 1 do
					local var_62_6 = var_62_5:GetChild(iter_62_8)

					if var_62_6.name == "split_12" or not string.find(var_62_6.name, "split") then
						var_62_6.gameObject:SetActive(true)
					else
						var_62_6.gameObject:SetActive(false)
					end
				end
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10183, Vector3.New(300, -475, -325), (arg_59_1.time_ - 0) / var_62_7)
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(300, -475, -325)
			end

			local var_62_8 = manager.ui.mainCamera.transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_8.localPosition
			end

			local var_62_9 = 0.4

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_9 then
				local var_62_10, var_62_11 = math.modf((arg_59_1.time_ - 0) / 0.066)

				var_62_8.localPosition = Vector3.New(var_62_11 * 0.13, var_62_11 * 0.13, var_62_11 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= 0 + var_62_9 and arg_59_1.time_ < 0 + var_62_9 + arg_62_0 then
				var_62_8.localPosition = arg_59_1.var_.shakeOldPos
			end

			local var_62_12 = arg_59_1.actors_["10183"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10183 = var_62_12.localPosition
				var_62_12.localScale = Vector3.New(1, 1, 1)

				for iter_62_9 = 0, var_62_12.childCount - 1 do
					local var_62_13 = var_62_12:GetChild(iter_62_9)

					if var_62_13.name == "" or not string.find(var_62_13.name, "split") then
						var_62_13.gameObject:SetActive(true)
					else
						var_62_13.gameObject:SetActive(false)
					end
				end
			end

			local var_62_14 = 0.4

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_14 then
				var_62_12.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10183, Vector3.New(300, 28000, 88888), (arg_59_1.time_ - 0) / var_62_14)
			end

			if arg_59_1.time_ >= 0 + var_62_14 and arg_59_1.time_ < 0 + var_62_14 + arg_62_0 then
				var_62_12.localPosition = Vector3.New(300, 28000, 88888)
			end

			local var_62_15 = arg_59_1.actors_["10144"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10144 = var_62_15.localPosition
				var_62_15.localScale = Vector3.New(1, 1, 1)

				for iter_62_10 = 0, var_62_15.childCount - 1 do
					local var_62_16 = var_62_15:GetChild(iter_62_10)

					if var_62_16.name == "split_14" or not string.find(var_62_16.name, "split") then
						var_62_16.gameObject:SetActive(true)
					else
						var_62_16.gameObject:SetActive(false)
					end
				end
			end

			local var_62_17 = 0.533333333333333

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_17 then
				var_62_15.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10144, Vector3.New(-480, -381.1, -285.9), (arg_59_1.time_ - 0) / var_62_17)
			end

			if arg_59_1.time_ >= 0 + var_62_17 and arg_59_1.time_ < 0 + var_62_17 + arg_62_0 then
				var_62_15.localPosition = Vector3.New(-480, -381.1, -285.9)
			end

			local var_62_18 = arg_59_1.actors_["10144"].transform

			if 0.533333333333333 < arg_59_1.time_ and arg_59_1.time_ <= 0.533333333333333 + arg_62_0 then
				arg_59_1.var_.moveOldPos10144 = var_62_18.localPosition
				var_62_18.localScale = Vector3.New(1, 1, 1)

				for iter_62_11 = 0, var_62_18.childCount - 1 do
					local var_62_19 = var_62_18:GetChild(iter_62_11)

					if var_62_19.name == "split_14" or not string.find(var_62_19.name, "split") then
						var_62_19.gameObject:SetActive(true)
					else
						var_62_19.gameObject:SetActive(false)
					end
				end
			end

			local var_62_20 = 0.001

			if 0.533333333333333 <= arg_59_1.time_ and arg_59_1.time_ < 0.533333333333333 + var_62_20 then
				var_62_18.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_59_1.time_ - 0.533333333333333) / var_62_20)
			end

			if arg_59_1.time_ >= 0.533333333333333 + var_62_20 and arg_59_1.time_ < 0.533333333333333 + var_62_20 + arg_62_0 then
				var_62_18.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_62_21 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_21 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			if arg_59_1.time_ >= var_62_21 + 0.566880501341075 and arg_59_1.time_ < var_62_21 + 0.566880501341075 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_22 = 0
			local var_62_23 = 0.4

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_22 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_24 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_24:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_25 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(938081014).content)

				arg_59_1.text_.text = var_62_25

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_27 = 16 <= 0 and var_62_23 or var_62_23 * (utf8.len(var_62_25) / 16)

				if (16 <= 0 and var_62_23 or var_62_23 * (utf8.len(var_62_25) / 16)) > 0 and var_62_23 < var_62_27 then
					arg_59_1.talkMaxDuration = var_62_27
					var_62_22 = var_62_22 + 0.3

					if var_62_27 + var_62_22 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_27 + var_62_22
					end
				end

				arg_59_1.text_.text = var_62_25
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_28 = var_62_22 + 0.3
			local var_62_29 = math.max(var_62_23, arg_59_1.talkMaxDuration)

			if var_62_22 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_28 + var_62_29 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_28) / var_62_29

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_28 + var_62_29 and arg_59_1.time_ < var_62_28 + var_62_29 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(300, -475, -325),
					endPos = Vector3.New(300, 28000, 88888),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-507.9, -381.1, -285.9),
					endPos = Vector3.New(-480, -381.1, -285.9),
					easeType = LeanTweenType.easeShake
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.0335471680077414,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-507.9, -381.1, -285.9),
					endPos = Vector3.New(-507.9, -381.1, -285.9),
					easeType = LeanTweenType.easeShake
				}
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play938081015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 938081015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play938081016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10183"]) and arg_65_1.var_.actorSpriteComps10183 == nil then
				arg_65_1.var_.actorSpriteComps10183 = arg_65_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10183"]) then
				if arg_65_1.var_.actorSpriteComps10183 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10183"]) and arg_65_1.var_.actorSpriteComps10183 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10183 = nil
			end

			local var_68_2 = arg_65_1.actors_["10183"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10183 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10183", 7)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_5 = arg_65_1.actors_["10144"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 7)

				for iter_68_5 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_5)

					if var_68_6.name == "" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_8 = 0
			local var_68_9 = 1.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(938081015).content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_12 = 55 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_10) / 55)

				if (55 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_10) / 55)) > 0 and var_68_9 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_13 and arg_65_1.time_ < var_68_8 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play938081016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 938081016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play938081017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10144"]) and arg_69_1.var_.actorSpriteComps10144 == nil then
				arg_69_1.var_.actorSpriteComps10144 = arg_69_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10144"]) then
				if arg_69_1.var_.actorSpriteComps10144 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10144"]) and arg_69_1.var_.actorSpriteComps10144 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10144 = nil
			end

			local var_72_2 = arg_69_1.actors_["10144"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 3)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "split_13" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_72_5 = 0
			local var_72_6 = 1.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(938081016).content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 50 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 50)

				if (50 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 50)) > 0 and var_72_6 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_10 and arg_69_1.time_ < var_72_5 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play938081017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 938081017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play938081018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 == nil then
				arg_73_1.var_.actorSpriteComps10144 = arg_73_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10144"]) then
				if arg_73_1.var_.actorSpriteComps10144 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.225

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(938081017).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 9 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 9)

				if (9 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 9)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play938081018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 938081018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play938081019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["108301"] == nil then
				local var_80_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_80_0) then
					local var_80_1 = Object.Instantiate(var_80_0, arg_77_1.canvasGo_.transform)

					var_80_1.transform:SetSiblingIndex(1)

					var_80_1.name = "108301"
					var_80_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_["108301"] = var_80_1

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs((var_80_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_2 = arg_77_1.actors_["108301"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps108301 == nil then
				arg_77_1.var_.actorSpriteComps108301 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps108301 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_3.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_3.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps108301 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps108301 = nil
			end

			local var_80_5 = arg_77_1.actors_["108301"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos108301 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("108301", 4)

				for iter_80_6 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_6)

					if var_80_6.name == "split_7" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_80_8 = arg_77_1.actors_["10144"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 2)

				for iter_80_7 = 0, var_80_8.childCount - 1 do
					local var_80_9 = var_80_8:GetChild(iter_80_7)

					if var_80_9.name == "split_13" or not string.find(var_80_9.name, "split") then
						var_80_9.gameObject:SetActive(true)
					else
						var_80_9.gameObject:SetActive(false)
					end
				end
			end

			local var_80_10 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_10 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_77_1.time_ - 0) / var_80_10)
			end

			if arg_77_1.time_ >= 0 + var_80_10 and arg_77_1.time_ < 0 + var_80_10 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_80_11 = 0
			local var_80_12 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(938081018).content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 21 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_13) / 21)

				if (21 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_13) / 21)) > 0 and var_80_12 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_16 and arg_77_1.time_ < var_80_11 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 938081019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play938081020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 == nil then
				arg_81_1.var_.actorSpriteComps10144 = arg_81_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10144"]) then
				if arg_81_1.var_.actorSpriteComps10144 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 1, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10144 = nil
			end

			local var_84_2 = arg_81_1.actors_["108301"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps108301 == nil then
				arg_81_1.var_.actorSpriteComps108301 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps108301 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps108301 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps108301 = nil
			end

			local var_84_5 = arg_81_1.actors_["10144"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10144 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10144", 2)

				for iter_84_8 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_8)

					if var_84_6.name == "split_11" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_84_8 = 0
			local var_84_9 = 0.925

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(938081019).content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_12 = 37 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_10) / 37)

				if (37 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_10) / 37)) > 0 and var_84_9 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_13 and arg_81_1.time_ < var_84_8 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play938081020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 938081020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play938081021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["128404"] == nil then
				local var_88_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_88_0) then
					local var_88_1 = Object.Instantiate(var_88_0, arg_85_1.canvasGo_.transform)

					var_88_1.transform:SetSiblingIndex(1)

					var_88_1.name = "128404"
					var_88_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_["128404"] = var_88_1

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs((var_88_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_88_2 = arg_85_1.actors_["128404"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps128404 == nil then
				arg_85_1.var_.actorSpriteComps128404 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps128404 then
					for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_88_3 then
							if arg_85_1.isInRecall_ then
								iter_88_3.color = Color.New(Mathf.Lerp(iter_88_3.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_3.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_3.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_3.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_3.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps128404 then
				for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_88_5 then
						iter_88_5.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps128404 = nil
			end

			local var_88_5 = arg_85_1.actors_["10144"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_88_7 then
							if arg_85_1.isInRecall_ then
								iter_88_7.color = Color.New(Mathf.Lerp(iter_88_7.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_6), Mathf.Lerp(iter_88_7.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_6), (Mathf.Lerp(iter_88_7.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_7.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_6)

								iter_88_7.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_8, iter_88_9 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_9 then
						iter_88_9.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_8 = arg_85_1.actors_["128404"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos128404 = var_88_8.localPosition
				var_88_8.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("128404", 4)

				for iter_88_10 = 0, var_88_8.childCount - 1 do
					local var_88_9 = var_88_8:GetChild(iter_88_10)

					if var_88_9.name == "split_9" or not string.find(var_88_9.name, "split") then
						var_88_9.gameObject:SetActive(true)
					else
						var_88_9.gameObject:SetActive(false)
					end
				end
			end

			local var_88_10 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_10 then
				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_85_1.time_ - 0) / var_88_10)
			end

			if arg_85_1.time_ >= 0 + var_88_10 and arg_85_1.time_ < 0 + var_88_10 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_88_11 = arg_85_1.actors_["108301"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos108301 = var_88_11.localPosition
				var_88_11.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("108301", 7)

				for iter_88_11 = 0, var_88_11.childCount - 1 do
					local var_88_12 = var_88_11:GetChild(iter_88_11)

					if var_88_12.name == "split_4" or not string.find(var_88_12.name, "split") then
						var_88_12.gameObject:SetActive(true)
					else
						var_88_12.gameObject:SetActive(false)
					end
				end
			end

			local var_88_13 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_13 then
				var_88_11.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_85_1.time_ - 0) / var_88_13)
			end

			if arg_85_1.time_ >= 0 + var_88_13 and arg_85_1.time_ < 0 + var_88_13 + arg_88_0 then
				var_88_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_14 = 0
			local var_88_15 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_16 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(938081020).content)

				arg_85_1.text_.text = var_88_16

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_18 = 17 <= 0 and var_88_15 or var_88_15 * (utf8.len(var_88_16) / 17)

				if (17 <= 0 and var_88_15 or var_88_15 * (utf8.len(var_88_16) / 17)) > 0 and var_88_15 < var_88_18 then
					arg_85_1.talkMaxDuration = var_88_18

					if var_88_18 + var_88_14 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_14
					end
				end

				arg_85_1.text_.text = var_88_16
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_19 = math.max(var_88_15, arg_85_1.talkMaxDuration)

			if var_88_14 <= arg_85_1.time_ and arg_85_1.time_ < var_88_14 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_14) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_14 + var_88_19 and arg_85_1.time_ < var_88_14 + var_88_19 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play938081021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 938081021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play938081022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10144"]) and arg_89_1.var_.actorSpriteComps10144 == nil then
				arg_89_1.var_.actorSpriteComps10144 = arg_89_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10144"]) then
				if arg_89_1.var_.actorSpriteComps10144 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10144"]) and arg_89_1.var_.actorSpriteComps10144 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10144 = nil
			end

			local var_92_2 = arg_89_1.actors_["128404"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps128404 == nil then
				arg_89_1.var_.actorSpriteComps128404 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps128404 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								iter_92_5.color = Color.New(Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_5.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_5.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps128404 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps128404 = nil
			end

			local var_92_5 = arg_89_1.actors_["10144"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 2)

				for iter_92_8 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_8)

					if var_92_6.name == "split_11" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_92_8 = 0
			local var_92_9 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(938081021).content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 16 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_10) / 16)

				if (16 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_10) / 16)) > 0 and var_92_9 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_13 and arg_89_1.time_ < var_92_8 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 938081022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play938081023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(938081022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 46 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 46)

				if (46 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 46)) > 0 and var_96_0 < var_96_3 then
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
	Play938081023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 938081023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play938081024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.45

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(938081023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 18 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 18)

				if (18 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 18)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play938081024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 938081024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play938081025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["106603"] == nil then
				local var_104_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_104_0) then
					local var_104_1 = Object.Instantiate(var_104_0, arg_101_1.canvasGo_.transform)

					var_104_1.transform:SetSiblingIndex(1)

					var_104_1.name = "106603"
					var_104_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_["106603"] = var_104_1

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs((var_104_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_2 = arg_101_1.actors_["106603"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps106603 == nil then
				arg_101_1.var_.actorSpriteComps106603 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps106603 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_3.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_3.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps106603 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps106603 = nil
			end

			local var_104_5 = arg_101_1.actors_["10144"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_104_7 then
							if arg_101_1.isInRecall_ then
								iter_104_7.color = Color.New(Mathf.Lerp(iter_104_7.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_7.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_7.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_7.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_7.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_8, iter_104_9 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_9 then
						iter_104_9.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_8 = arg_101_1.actors_["106603"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos106603 = var_104_8.localPosition
				var_104_8.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("106603", 2)

				for iter_104_10 = 0, var_104_8.childCount - 1 do
					local var_104_9 = var_104_8:GetChild(iter_104_10)

					if var_104_9.name == "split_12" or not string.find(var_104_9.name, "split") then
						var_104_9.gameObject:SetActive(true)
					else
						var_104_9.gameObject:SetActive(false)
					end
				end
			end

			local var_104_10 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_10 then
				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_101_1.time_ - 0) / var_104_10)
			end

			if arg_101_1.time_ >= 0 + var_104_10 and arg_101_1.time_ < 0 + var_104_10 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_104_11 = arg_101_1.actors_["10144"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10144 = var_104_11.localPosition
				var_104_11.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10144", 7)

				for iter_104_11 = 0, var_104_11.childCount - 1 do
					local var_104_12 = var_104_11:GetChild(iter_104_11)

					if var_104_12.name == "" or not string.find(var_104_12.name, "split") then
						var_104_12.gameObject:SetActive(true)
					else
						var_104_12.gameObject:SetActive(false)
					end
				end
			end

			local var_104_13 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_13 then
				var_104_11.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_101_1.time_ - 0) / var_104_13)
			end

			if arg_101_1.time_ >= 0 + var_104_13 and arg_101_1.time_ < 0 + var_104_13 + arg_104_0 then
				var_104_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_14 = 0
			local var_104_15 = 0.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_16 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(938081024).content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_18 = 6 <= 0 and var_104_15 or var_104_15 * (utf8.len(var_104_16) / 6)

				if (6 <= 0 and var_104_15 or var_104_15 * (utf8.len(var_104_16) / 6)) > 0 and var_104_15 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18

					if var_104_18 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_14
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_19 = math.max(var_104_15, arg_101_1.talkMaxDuration)

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_19 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_14) / var_104_19

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_14 + var_104_19 and arg_101_1.time_ < var_104_14 + var_104_19 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 938081025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play938081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["128404"]) and arg_105_1.var_.actorSpriteComps128404 == nil then
				arg_105_1.var_.actorSpriteComps128404 = arg_105_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["128404"]) then
				if arg_105_1.var_.actorSpriteComps128404 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["128404"]) and arg_105_1.var_.actorSpriteComps128404 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps128404 = nil
			end

			local var_108_2 = arg_105_1.actors_["106603"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps106603 == nil then
				arg_105_1.var_.actorSpriteComps106603 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps106603 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps106603 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_108_7 then
						iter_108_7.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps106603 = nil
			end

			local var_108_5 = arg_105_1.actors_["128404"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos128404 = var_108_5.localPosition
				var_108_5.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("128404", 4)

				for iter_108_8 = 0, var_108_5.childCount - 1 do
					local var_108_6 = var_108_5:GetChild(iter_108_8)

					if var_108_6.name == "split_9" or not string.find(var_108_6.name, "split") then
						var_108_6.gameObject:SetActive(true)
					else
						var_108_6.gameObject:SetActive(false)
					end
				end
			end

			local var_108_7 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_105_1.time_ - 0) / var_108_7)
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_108_8 = 0
			local var_108_9 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(938081025).content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 18 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_10) / 18)

				if (18 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_10) / 18)) > 0 and var_108_9 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_13 and arg_105_1.time_ < var_108_8 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 938081026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play938081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10144"]) and arg_109_1.var_.actorSpriteComps10144 == nil then
				arg_109_1.var_.actorSpriteComps10144 = arg_109_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10144"]) then
				if arg_109_1.var_.actorSpriteComps10144 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 1, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10144"]) and arg_109_1.var_.actorSpriteComps10144 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10144 = nil
			end

			local var_112_2 = arg_109_1.actors_["128404"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps128404 == nil then
				arg_109_1.var_.actorSpriteComps128404 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps128404 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								iter_112_5.color = Color.New(Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_5.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_5.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps128404 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_112_7 then
						iter_112_7.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps128404 = nil
			end

			local var_112_5 = arg_109_1.actors_["10144"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10144 = var_112_5.localPosition
				var_112_5.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10144", 2)

				for iter_112_8 = 0, var_112_5.childCount - 1 do
					local var_112_6 = var_112_5:GetChild(iter_112_8)

					if var_112_6.name == "split_11" or not string.find(var_112_6.name, "split") then
						var_112_6.gameObject:SetActive(true)
					else
						var_112_6.gameObject:SetActive(false)
					end
				end
			end

			local var_112_7 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				var_112_5.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_109_1.time_ - 0) / var_112_7)
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				var_112_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_112_8 = arg_109_1.actors_["106603"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos106603 = var_112_8.localPosition
				var_112_8.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("106603", 7)

				for iter_112_9 = 0, var_112_8.childCount - 1 do
					local var_112_9 = var_112_8:GetChild(iter_112_9)

					if var_112_9.name == "" or not string.find(var_112_9.name, "split") then
						var_112_9.gameObject:SetActive(true)
					else
						var_112_9.gameObject:SetActive(false)
					end
				end
			end

			local var_112_10 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_10 then
				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 0) / var_112_10)
			end

			if arg_109_1.time_ >= 0 + var_112_10 and arg_109_1.time_ < 0 + var_112_10 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_11 = 0
			local var_112_12 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(938081026).content)

				arg_109_1.text_.text = var_112_13

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 30 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_13) / 30)

				if (30 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_13) / 30)) > 0 and var_112_12 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_13
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_16 and arg_109_1.time_ < var_112_11 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play938081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 938081027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play938081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(938081027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 40 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 40)

				if (40 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 40)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play938081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 938081028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play938081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = arg_117_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10144"]) then
				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_2 = 0
			local var_120_3 = 0.2

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
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

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_4 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(938081028).content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 8 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 8)

				if (8 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 8)) > 0 and var_120_3 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_7 and arg_117_1.time_ < var_120_2 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play938081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 938081029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play938081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10144"]) and arg_121_1.var_.actorSpriteComps10144 == nil then
				arg_121_1.var_.actorSpriteComps10144 = arg_121_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10144"]) then
				if arg_121_1.var_.actorSpriteComps10144 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 1, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10144"]) and arg_121_1.var_.actorSpriteComps10144 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10144 = nil
			end

			local var_124_2 = arg_121_1.actors_["10144"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10144 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10144", 2)

				for iter_124_4 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_4)

					if var_124_3.name == "split_12" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_124_5 = 0
			local var_124_6 = 0.875

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(938081029).content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 35 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 35)

				if (35 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 35)) > 0 and var_124_6 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_10 and arg_121_1.time_ < var_124_5 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play938081030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 938081030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play938081031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["106603"]) and arg_125_1.var_.actorSpriteComps106603 == nil then
				arg_125_1.var_.actorSpriteComps106603 = arg_125_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["106603"]) then
				if arg_125_1.var_.actorSpriteComps106603 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 1, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["106603"]) and arg_125_1.var_.actorSpriteComps106603 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps106603 = nil
			end

			local var_128_2 = arg_125_1.actors_["10144"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10144 == nil then
				arg_125_1.var_.actorSpriteComps10144 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps10144 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								iter_128_5.color = Color.New(Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_3), Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_3), (Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_3)))
							else
								local var_128_4 = Mathf.Lerp(iter_128_5.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_3)

								iter_128_5.color = Color.New(var_128_4, var_128_4, var_128_4)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10144 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_128_7 then
						iter_128_7.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10144 = nil
			end

			local var_128_5 = arg_125_1.actors_["106603"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos106603 = var_128_5.localPosition
				var_128_5.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("106603", 4)

				for iter_128_8 = 0, var_128_5.childCount - 1 do
					local var_128_6 = var_128_5:GetChild(iter_128_8)

					if var_128_6.name == "split_12" or not string.find(var_128_6.name, "split") then
						var_128_6.gameObject:SetActive(true)
					else
						var_128_6.gameObject:SetActive(false)
					end
				end
			end

			local var_128_7 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_125_1.time_ - 0) / var_128_7)
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_128_8 = arg_125_1.actors_["128404"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos128404 = var_128_8.localPosition
				var_128_8.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("128404", 7)

				for iter_128_9 = 0, var_128_8.childCount - 1 do
					local var_128_9 = var_128_8:GetChild(iter_128_9)

					if var_128_9.name == "split_10" or not string.find(var_128_9.name, "split") then
						var_128_9.gameObject:SetActive(true)
					else
						var_128_9.gameObject:SetActive(false)
					end
				end
			end

			local var_128_10 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_10 then
				var_128_8.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_125_1.time_ - 0) / var_128_10)
			end

			if arg_125_1.time_ >= 0 + var_128_10 and arg_125_1.time_ < 0 + var_128_10 + arg_128_0 then
				var_128_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_11 = 0
			local var_128_12 = 0.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(938081030).content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 16 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_13) / 16)

				if (16 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_13) / 16)) > 0 and var_128_12 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_16 and arg_125_1.time_ < var_128_11 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play938081031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 938081031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play938081032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = arg_129_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10144"]) then
				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_2 = arg_129_1.actors_["106603"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps106603 == nil then
				arg_129_1.var_.actorSpriteComps106603 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps106603 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								iter_132_5.color = Color.New(Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_5.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_5.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps106603 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_132_7 then
						iter_132_7.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps106603 = nil
			end

			local var_132_5 = arg_129_1.actors_["10144"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10144 = var_132_5.localPosition
				var_132_5.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10144", 2)

				for iter_132_8 = 0, var_132_5.childCount - 1 do
					local var_132_6 = var_132_5:GetChild(iter_132_8)

					if var_132_6.name == "split_11" or not string.find(var_132_6.name, "split") then
						var_132_6.gameObject:SetActive(true)
					else
						var_132_6.gameObject:SetActive(false)
					end
				end
			end

			local var_132_7 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				var_132_5.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_129_1.time_ - 0) / var_132_7)
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				var_132_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_132_8 = 0
			local var_132_9 = 1.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(938081031).content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 47 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_10) / 47)

				if (47 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_10) / 47)) > 0 and var_132_9 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_13 and arg_129_1.time_ < var_132_8 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play938081032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 938081032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play938081033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.725

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(938081032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)

				if (29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play938081033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 938081033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play938081034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10144"]) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = arg_137_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10144"]) then
				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10144"]) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.775

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(938081033).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 31 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 31)

				if (31 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 31)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play938081034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 938081034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play938081035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = arg_141_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10144"]) then
				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 1, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_2 = arg_141_1.actors_["10144"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 2)

				for iter_144_4 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_4)

					if var_144_3.name == "split_12" then
						var_144_3:SetAsLastSibling()
						var_144_3.gameObject:SetActive(true)

						arg_141_1.var_.actorSpriteSplit10144 = var_144_3.gameObject:GetComponent(typeof(Image))

						arg_141_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_144_4 = 0.5

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_141_1.time_ - 0) / var_144_4)

				if arg_141_1.var_.actorSpriteSplit10144 ~= nil then
					arg_141_1.var_.actorSpriteSplit10144:SetAlpha((arg_141_1.time_ - 0) / var_144_4)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_141_1.var_.actorSpriteSplit10144 ~= nil then
					arg_141_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_144_5 = 0
			local var_144_6 = 0.875

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(938081034).content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 35 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_7) / 35)

				if (35 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_7) / 35)) > 0 and var_144_6 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_10 and arg_141_1.time_ < var_144_5 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play938081035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 938081035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play938081036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.actors_["104902"] == nil then
				local var_148_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_148_0) then
					local var_148_1 = Object.Instantiate(var_148_0, arg_145_1.canvasGo_.transform)

					var_148_1.transform:SetSiblingIndex(1)

					var_148_1.name = "104902"
					var_148_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_145_1.actors_["104902"] = var_148_1

					if arg_145_1.isInRecall_ then
						for iter_148_0, iter_148_1 in ipairs((var_148_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_148_1.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_148_2 = arg_145_1.actors_["104902"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps104902 == nil then
				arg_145_1.var_.actorSpriteComps104902 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps104902 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								iter_148_3.color = Color.New(Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_3.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_3.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps104902 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_148_5 then
						iter_148_5.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps104902 = nil
			end

			local var_148_5 = arg_145_1.actors_["10144"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10144 == nil then
				arg_145_1.var_.actorSpriteComps10144 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps10144 then
					for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_148_7 then
							if arg_145_1.isInRecall_ then
								iter_148_7.color = Color.New(Mathf.Lerp(iter_148_7.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_7.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_7.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_7.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_7.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10144 then
				for iter_148_8, iter_148_9 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_148_9 then
						iter_148_9.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10144 = nil
			end

			local var_148_8 = arg_145_1.actors_["104902"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos104902 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("104902", 4)

				for iter_148_10 = 0, var_148_8.childCount - 1 do
					local var_148_9 = var_148_8:GetChild(iter_148_10)

					if var_148_9.name == "split_8" or not string.find(var_148_9.name, "split") then
						var_148_9.gameObject:SetActive(true)
					else
						var_148_9.gameObject:SetActive(false)
					end
				end
			end

			local var_148_10 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_10 then
				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_145_1.time_ - 0) / var_148_10)
			end

			if arg_145_1.time_ >= 0 + var_148_10 and arg_145_1.time_ < 0 + var_148_10 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(390, -335, -360)
			end

			local var_148_11 = arg_145_1.actors_["106603"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos106603 = var_148_11.localPosition
				var_148_11.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("106603", 7)

				for iter_148_11 = 0, var_148_11.childCount - 1 do
					local var_148_12 = var_148_11:GetChild(iter_148_11)

					if var_148_12.name == "" or not string.find(var_148_12.name, "split") then
						var_148_12.gameObject:SetActive(true)
					else
						var_148_12.gameObject:SetActive(false)
					end
				end
			end

			local var_148_13 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_13 then
				var_148_11.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_145_1.time_ - 0) / var_148_13)
			end

			if arg_145_1.time_ >= 0 + var_148_13 and arg_145_1.time_ < 0 + var_148_13 + arg_148_0 then
				var_148_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_14 = 0
			local var_148_15 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_16 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(938081035).content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_18 = 17 <= 0 and var_148_15 or var_148_15 * (utf8.len(var_148_16) / 17)

				if (17 <= 0 and var_148_15 or var_148_15 * (utf8.len(var_148_16) / 17)) > 0 and var_148_15 < var_148_18 then
					arg_145_1.talkMaxDuration = var_148_18

					if var_148_18 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_19 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_19 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_19

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_19 and arg_145_1.time_ < var_148_14 + var_148_19 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play938081036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 938081036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play938081037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = arg_149_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10144"]) then
				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 1, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_2 = arg_149_1.actors_["104902"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps104902 == nil then
				arg_149_1.var_.actorSpriteComps104902 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps104902 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								iter_152_5.color = Color.New(Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_5.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_5.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps104902 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_152_7 then
						iter_152_7.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps104902 = nil
			end

			local var_152_5 = arg_149_1.actors_["10144"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10144 = var_152_5.localPosition
				var_152_5.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10144", 2)

				for iter_152_8 = 0, var_152_5.childCount - 1 do
					local var_152_6 = var_152_5:GetChild(iter_152_8)

					if var_152_6.name == "split_11" then
						var_152_6:SetAsLastSibling()
						var_152_6.gameObject:SetActive(true)

						arg_149_1.var_.actorSpriteSplit10144 = var_152_6.gameObject:GetComponent(typeof(Image))

						arg_149_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_152_7 = 0.5

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_149_1.time_ - 0) / var_152_7)

				if arg_149_1.var_.actorSpriteSplit10144 ~= nil then
					arg_149_1.var_.actorSpriteSplit10144:SetAlpha((arg_149_1.time_ - 0) / var_152_7)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_149_1.var_.actorSpriteSplit10144 ~= nil then
					arg_149_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_152_8 = 0
			local var_152_9 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(938081036).content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_12 = 19 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 19)

				if (19 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_10) / 19)) > 0 and var_152_9 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_13 and arg_149_1.time_ < var_152_8 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play938081037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 938081037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play938081038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.075

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(938081037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)

				if (43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play938081038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 938081038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play938081039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = arg_157_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10144"]) then
				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_2 = arg_157_1.actors_["10144"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10144 = var_160_2.localPosition
				var_160_2.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10144", 7)

				for iter_160_4 = 0, var_160_2.childCount - 1 do
					local var_160_3 = var_160_2:GetChild(iter_160_4)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_2.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0) / var_160_4)
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_5 = arg_157_1.actors_["104902"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos104902 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("104902", 7)

				for iter_160_5 = 0, var_160_5.childCount - 1 do
					local var_160_6 = var_160_5:GetChild(iter_160_5)

					if var_160_6.name == "" or not string.find(var_160_6.name, "split") then
						var_160_6.gameObject:SetActive(true)
					else
						var_160_6.gameObject:SetActive(false)
					end
				end
			end

			local var_160_7 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_157_1.time_ - 0) / var_160_7)
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_160_8 = 0
			local var_160_9 = 0.85

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(938081038).content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_12 = 34 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_10) / 34)

				if (34 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_10) / 34)) > 0 and var_160_9 < var_160_12 then
					arg_157_1.talkMaxDuration = var_160_12

					if var_160_12 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_13 and arg_157_1.time_ < var_160_8 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play938081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 938081039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play938081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.475

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(938081039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 19 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 19)

				if (19 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 19)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play938081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 938081040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play938081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = arg_165_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10144"]) then
				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 1, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_2 = arg_165_1.actors_["10144"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 2)

				for iter_168_4 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_4)

					if var_168_3.name == "split_14" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_168_5 = 0
			local var_168_6 = 0.275

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(938081040).content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 11 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 11)

				if (11 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 11)) > 0 and var_168_6 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_10 and arg_165_1.time_ < var_168_5 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play938081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 938081041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play938081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["128404"]) and arg_169_1.var_.actorSpriteComps128404 == nil then
				arg_169_1.var_.actorSpriteComps128404 = arg_169_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["128404"]) then
				if arg_169_1.var_.actorSpriteComps128404 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["128404"]) and arg_169_1.var_.actorSpriteComps128404 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps128404 = nil
			end

			local var_172_2 = arg_169_1.actors_["10144"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10144 == nil then
				arg_169_1.var_.actorSpriteComps10144 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps10144 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_172_5 then
							if arg_169_1.isInRecall_ then
								iter_172_5.color = Color.New(Mathf.Lerp(iter_172_5.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_5.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_5.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_5.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_5.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10144 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_172_7 then
						iter_172_7.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10144 = nil
			end

			local var_172_5 = arg_169_1.actors_["128404"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos128404 = var_172_5.localPosition
				var_172_5.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("128404", 4)

				for iter_172_8 = 0, var_172_5.childCount - 1 do
					local var_172_6 = var_172_5:GetChild(iter_172_8)

					if var_172_6.name == "split_10" or not string.find(var_172_6.name, "split") then
						var_172_6.gameObject:SetActive(true)
					else
						var_172_6.gameObject:SetActive(false)
					end
				end
			end

			local var_172_7 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				var_172_5.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_169_1.time_ - 0) / var_172_7)
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				var_172_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_172_8 = 0
			local var_172_9 = 0.125

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(938081041).content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_12 = 5 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_10) / 5)

				if (5 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_10) / 5)) > 0 and var_172_9 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_13 and arg_169_1.time_ < var_172_8 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play938081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 938081042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play938081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10144"]) and arg_173_1.var_.actorSpriteComps10144 == nil then
				arg_173_1.var_.actorSpriteComps10144 = arg_173_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10144"]) then
				if arg_173_1.var_.actorSpriteComps10144 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10144"]) and arg_173_1.var_.actorSpriteComps10144 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10144 = nil
			end

			local var_176_2 = arg_173_1.actors_["128404"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								iter_176_5.color = Color.New(Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_5.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_5.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_7 then
						iter_176_7.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_5 = arg_173_1.actors_["10144"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10144 = var_176_5.localPosition
				var_176_5.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10144", 2)

				for iter_176_8 = 0, var_176_5.childCount - 1 do
					local var_176_6 = var_176_5:GetChild(iter_176_8)

					if var_176_6.name == "split_11" then
						var_176_6:SetAsLastSibling()
						var_176_6.gameObject:SetActive(true)

						arg_173_1.var_.actorSpriteSplit10144 = var_176_6.gameObject:GetComponent(typeof(Image))

						arg_173_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_176_7 = 0.5

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				var_176_5.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_173_1.time_ - 0) / var_176_7)

				if arg_173_1.var_.actorSpriteSplit10144 ~= nil then
					arg_173_1.var_.actorSpriteSplit10144:SetAlpha((arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				var_176_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_173_1.var_.actorSpriteSplit10144 ~= nil then
					arg_173_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_176_8 = 0
			local var_176_9 = 0.45

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(938081042).content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_12 = 18 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_10) / 18)

				if (18 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_10) / 18)) > 0 and var_176_9 < var_176_12 then
					arg_173_1.talkMaxDuration = var_176_12

					if var_176_12 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_13 and arg_173_1.time_ < var_176_8 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play938081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 938081043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play938081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["106603"]) and arg_177_1.var_.actorSpriteComps106603 == nil then
				arg_177_1.var_.actorSpriteComps106603 = arg_177_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["106603"]) then
				if arg_177_1.var_.actorSpriteComps106603 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["106603"]) and arg_177_1.var_.actorSpriteComps106603 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps106603 = nil
			end

			local var_180_2 = arg_177_1.actors_["10144"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								iter_180_5.color = Color.New(Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_5.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_5.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_5 = arg_177_1.actors_["106603"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos106603 = var_180_5.localPosition
				var_180_5.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("106603", 4)

				for iter_180_8 = 0, var_180_5.childCount - 1 do
					local var_180_6 = var_180_5:GetChild(iter_180_8)

					if var_180_6.name == "split_12" or not string.find(var_180_6.name, "split") then
						var_180_6.gameObject:SetActive(true)
					else
						var_180_6.gameObject:SetActive(false)
					end
				end
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_177_1.time_ - 0) / var_180_7)
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_180_8 = arg_177_1.actors_["128404"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_8.localPosition
				var_180_8.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 7)

				for iter_180_9 = 0, var_180_8.childCount - 1 do
					local var_180_9 = var_180_8:GetChild(iter_180_9)

					if var_180_9.name == "" or not string.find(var_180_9.name, "split") then
						var_180_9.gameObject:SetActive(true)
					else
						var_180_9.gameObject:SetActive(false)
					end
				end
			end

			local var_180_10 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_10 then
				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_177_1.time_ - 0) / var_180_10)
			end

			if arg_177_1.time_ >= 0 + var_180_10 and arg_177_1.time_ < 0 + var_180_10 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_11 = 0
			local var_180_12 = 0.6

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(938081043).content)

				arg_177_1.text_.text = var_180_13

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 24 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_13) / 24)

				if (24 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_13) / 24)) > 0 and var_180_12 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_13
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 <= arg_177_1.time_ and arg_177_1.time_ < var_180_11 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_11) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_11 + var_180_16 and arg_177_1.time_ < var_180_11 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play938081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 938081044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play938081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10144"]) and arg_181_1.var_.actorSpriteComps10144 == nil then
				arg_181_1.var_.actorSpriteComps10144 = arg_181_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10144"]) then
				if arg_181_1.var_.actorSpriteComps10144 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10144"]) and arg_181_1.var_.actorSpriteComps10144 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10144 = nil
			end

			local var_184_2 = arg_181_1.actors_["106603"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps106603 == nil then
				arg_181_1.var_.actorSpriteComps106603 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps106603 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps106603 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps106603 = nil
			end

			local var_184_5 = arg_181_1.actors_["10144"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10144 = var_184_5.localPosition
				var_184_5.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10144", 2)

				for iter_184_8 = 0, var_184_5.childCount - 1 do
					local var_184_6 = var_184_5:GetChild(iter_184_8)

					if var_184_6.name == "split_11" or not string.find(var_184_6.name, "split") then
						var_184_6.gameObject:SetActive(true)
					else
						var_184_6.gameObject:SetActive(false)
					end
				end
			end

			local var_184_7 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				var_184_5.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_181_1.time_ - 0) / var_184_7)
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				var_184_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_184_8 = 0
			local var_184_9 = 0.725

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(938081044).content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_12 = 29 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_10) / 29)

				if (29 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_10) / 29)) > 0 and var_184_9 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_13 and arg_181_1.time_ < var_184_8 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 938081045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play938081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10144 = arg_185_1.actors_["10144"].transform.localPosition
				arg_185_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10144", 2)

				for iter_188_0 = 0, arg_185_1.actors_["10144"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10144"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_12" then
						var_188_0:SetAsLastSibling()
						var_188_0.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit10144 = var_188_0.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_188_1 = 0.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_185_1.time_ - 0) / var_188_1)

				if arg_185_1.var_.actorSpriteSplit10144 ~= nil then
					arg_185_1.var_.actorSpriteSplit10144:SetAlpha((arg_185_1.time_ - 0) / var_188_1)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10144"].transform.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_185_1.var_.actorSpriteSplit10144 ~= nil then
					arg_185_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_188_2 = 0
			local var_188_3 = 0.55

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(938081045).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 22 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 22)

				if (22 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 22)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play938081046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 938081046
		arg_189_1.duration_ = 6

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play938081047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_9000

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10144"]) and arg_189_1.var_.actorSpriteComps10144 == nil then
				arg_189_1.var_.actorSpriteComps10144 = arg_189_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10144"]) then
				if arg_189_1.var_.actorSpriteComps10144 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10144"]) and arg_189_1.var_.actorSpriteComps10144 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10144 = nil
			end

			local var_192_2 = arg_189_1.actors_["10144"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10144 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10144", 7)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_5 = arg_189_1.actors_["106603"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos106603 = var_192_5.localPosition
				var_192_5.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("106603", 7)

				for iter_192_5 = 0, var_192_5.childCount - 1 do
					local var_192_6 = var_192_5:GetChild(iter_192_5)

					if var_192_6.name == "" or not string.find(var_192_6.name, "split") then
						var_192_6.gameObject:SetActive(true)
					else
						var_192_6.gameObject:SetActive(false)
					end
				end
			end

			local var_192_7 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_7)
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_8 = manager.ui.mainCamera.transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.shakeOldPos = var_192_8.localPosition
			end

			local var_192_9 = 0.6

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 then
				local var_192_10, var_192_11 = math.modf((arg_189_1.time_ - 0) / 0.066)

				var_192_8.localPosition = Vector3.New(var_192_11 * 0.13, var_192_11 * 0.13, var_192_11 * 0.13) + arg_189_1.var_.shakeOldPos
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 then
				var_192_8.localPosition = arg_189_1.var_.shakeOldPos
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_12 = arg_189_1.var_.effecttengkongerqi

				if not arg_189_1.var_.effecttengkongerqi then
					var_192_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_192_12.name = "tengkongerqi"
					arg_189_1.var_.effecttengkongerqi = var_192_12
				else
					var_192_12.transform:SetParent(var_192_9000)
				end

				var_192_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_192_14 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_14 + 1.5 and arg_189_1.time_ < var_192_14 + 1.5 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_15 = 1
			local var_192_16 = 1.225

			if 1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_17 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_17:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(938081046).content)

				arg_189_1.text_.text = var_192_18

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 49 <= 0 and var_192_16 or var_192_16 * (utf8.len(var_192_18) / 49)

				if (49 <= 0 and var_192_16 or var_192_16 * (utf8.len(var_192_18) / 49)) > 0 and var_192_16 < var_192_20 then
					arg_189_1.talkMaxDuration = var_192_20
					var_192_15 = var_192_15 + 0.3

					if var_192_20 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_18
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_21 = var_192_15 + 0.3
			local var_192_22 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_21) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_21 + var_192_22 and arg_189_1.time_ < var_192_21 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play938081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 938081047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play938081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.35

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

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(938081047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 14 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 14)

				if (14 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 14)) > 0 and var_198_0 < var_198_3 then
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
	Play938081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 938081048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play938081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["128404"]) and arg_199_1.var_.actorSpriteComps128404 == nil then
				arg_199_1.var_.actorSpriteComps128404 = arg_199_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["128404"]) then
				if arg_199_1.var_.actorSpriteComps128404 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 1, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["128404"]) and arg_199_1.var_.actorSpriteComps128404 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps128404 = nil
			end

			local var_202_2 = arg_199_1.actors_["128404"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos128404 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("128404", 2)

				for iter_202_4 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_4)

					if var_202_3.name == "split_9" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_199_1.time_ - 0) / var_202_4)
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_202_5 = 0
			local var_202_6 = 0.5

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(938081048).content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 20 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 20)

				if (20 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 20)) > 0 and var_202_6 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_10 and arg_199_1.time_ < var_202_5 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play938081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 938081049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play938081050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["104902"]) and arg_203_1.var_.actorSpriteComps104902 == nil then
				arg_203_1.var_.actorSpriteComps104902 = arg_203_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["104902"]) then
				if arg_203_1.var_.actorSpriteComps104902 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["104902"]) and arg_203_1.var_.actorSpriteComps104902 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps104902 = nil
			end

			local var_206_2 = arg_203_1.actors_["128404"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps128404 == nil then
				arg_203_1.var_.actorSpriteComps128404 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps128404 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_206_5 then
							if arg_203_1.isInRecall_ then
								iter_206_5.color = Color.New(Mathf.Lerp(iter_206_5.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_5.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_5.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_5.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_5.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps128404 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_206_7 then
						iter_206_7.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps128404 = nil
			end

			local var_206_5 = arg_203_1.actors_["104902"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos104902 = var_206_5.localPosition
				var_206_5.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("104902", 4)

				for iter_206_8 = 0, var_206_5.childCount - 1 do
					local var_206_6 = var_206_5:GetChild(iter_206_8)

					if var_206_6.name == "split_8" or not string.find(var_206_6.name, "split") then
						var_206_6.gameObject:SetActive(true)
					else
						var_206_6.gameObject:SetActive(false)
					end
				end
			end

			local var_206_7 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				var_206_5.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_203_1.time_ - 0) / var_206_7)
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				var_206_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_206_8 = 0
			local var_206_9 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(938081049).content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_12 = 14 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_10) / 14)

				if (14 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_10) / 14)) > 0 and var_206_9 < var_206_12 then
					arg_203_1.talkMaxDuration = var_206_12

					if var_206_12 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_13 and arg_203_1.time_ < var_206_8 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play938081050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 938081050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play938081051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["106603"]) and arg_207_1.var_.actorSpriteComps106603 == nil then
				arg_207_1.var_.actorSpriteComps106603 = arg_207_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["106603"]) then
				if arg_207_1.var_.actorSpriteComps106603 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 1, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["106603"]) and arg_207_1.var_.actorSpriteComps106603 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps106603 = nil
			end

			local var_210_2 = arg_207_1.actors_["104902"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps104902 == nil then
				arg_207_1.var_.actorSpriteComps104902 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps104902 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_210_5 then
							if arg_207_1.isInRecall_ then
								iter_210_5.color = Color.New(Mathf.Lerp(iter_210_5.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_5.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_5.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_5.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_5.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps104902 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_210_7 then
						iter_210_7.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps104902 = nil
			end

			local var_210_5 = arg_207_1.actors_["106603"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos106603 = var_210_5.localPosition
				var_210_5.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("106603", 2)

				for iter_210_8 = 0, var_210_5.childCount - 1 do
					local var_210_6 = var_210_5:GetChild(iter_210_8)

					if var_210_6.name == "split_12" or not string.find(var_210_6.name, "split") then
						var_210_6.gameObject:SetActive(true)
					else
						var_210_6.gameObject:SetActive(false)
					end
				end
			end

			local var_210_7 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				var_210_5.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_207_1.time_ - 0) / var_210_7)
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				var_210_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_210_8 = arg_207_1.actors_["128404"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos128404 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("128404", 7)

				for iter_210_9 = 0, var_210_8.childCount - 1 do
					local var_210_9 = var_210_8:GetChild(iter_210_9)

					if var_210_9.name == "" or not string.find(var_210_9.name, "split") then
						var_210_9.gameObject:SetActive(true)
					else
						var_210_9.gameObject:SetActive(false)
					end
				end
			end

			local var_210_10 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_10 then
				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_207_1.time_ - 0) / var_210_10)
			end

			if arg_207_1.time_ >= 0 + var_210_10 and arg_207_1.time_ < 0 + var_210_10 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_11 = 0
			local var_210_12 = 1.1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_13 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(938081050).content)

				arg_207_1.text_.text = var_210_13

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 44 <= 0 and var_210_12 or var_210_12 * (utf8.len(var_210_13) / 44)

				if (44 <= 0 and var_210_12 or var_210_12 * (utf8.len(var_210_13) / 44)) > 0 and var_210_12 < var_210_15 then
					arg_207_1.talkMaxDuration = var_210_15

					if var_210_15 + var_210_11 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_11
					end
				end

				arg_207_1.text_.text = var_210_13
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_12, arg_207_1.talkMaxDuration)

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_11) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_11 + var_210_16 and arg_207_1.time_ < var_210_11 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play938081051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 938081051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play938081052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["106603"]) and arg_211_1.var_.actorSpriteComps106603 == nil then
				arg_211_1.var_.actorSpriteComps106603 = arg_211_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["106603"]) then
				if arg_211_1.var_.actorSpriteComps106603 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["106603"]) and arg_211_1.var_.actorSpriteComps106603 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps106603 = nil
			end

			local var_214_2 = arg_211_1.actors_["106603"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos106603 = var_214_2.localPosition
				var_214_2.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("106603", 7)

				for iter_214_4 = 0, var_214_2.childCount - 1 do
					local var_214_3 = var_214_2:GetChild(iter_214_4)

					if var_214_3.name == "" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_2.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_211_1.time_ - 0) / var_214_4)
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_5 = arg_211_1.actors_["104902"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos104902 = var_214_5.localPosition
				var_214_5.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("104902", 7)

				for iter_214_5 = 0, var_214_5.childCount - 1 do
					local var_214_6 = var_214_5:GetChild(iter_214_5)

					if var_214_6.name == "" or not string.find(var_214_6.name, "split") then
						var_214_6.gameObject:SetActive(true)
					else
						var_214_6.gameObject:SetActive(false)
					end
				end
			end

			local var_214_7 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_211_1.time_ - 0) / var_214_7)
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_214_8 = 0
			local var_214_9 = 1.125

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(938081051).content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_12 = 45 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_10) / 45)

				if (45 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_10) / 45)) > 0 and var_214_9 < var_214_12 then
					arg_211_1.talkMaxDuration = var_214_12

					if var_214_12 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_13 and arg_211_1.time_ < var_214_8 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play938081052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 938081052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play938081053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["128404"]) and arg_215_1.var_.actorSpriteComps128404 == nil then
				arg_215_1.var_.actorSpriteComps128404 = arg_215_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["128404"]) then
				if arg_215_1.var_.actorSpriteComps128404 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["128404"]) and arg_215_1.var_.actorSpriteComps128404 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps128404 = nil
			end

			local var_218_2 = arg_215_1.actors_["128404"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos128404 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("128404", 2)

				for iter_218_4 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_4)

					if var_218_3.name == "split_8" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_218_5 = 0
			local var_218_6 = 0.425

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(938081052).content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 17 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 17)

				if (17 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 17)) > 0 and var_218_6 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_10 and arg_215_1.time_ < var_218_5 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play938081053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 938081053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play938081054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["104902"]) and arg_219_1.var_.actorSpriteComps104902 == nil then
				arg_219_1.var_.actorSpriteComps104902 = arg_219_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["104902"]) then
				if arg_219_1.var_.actorSpriteComps104902 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 1, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["104902"]) and arg_219_1.var_.actorSpriteComps104902 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps104902 = nil
			end

			local var_222_2 = arg_219_1.actors_["128404"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps128404 == nil then
				arg_219_1.var_.actorSpriteComps128404 = var_222_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_3 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.actorSpriteComps128404 then
					for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_222_5 then
							if arg_219_1.isInRecall_ then
								iter_222_5.color = Color.New(Mathf.Lerp(iter_222_5.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 0) / var_222_3), Mathf.Lerp(iter_222_5.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 0) / var_222_3), (Mathf.Lerp(iter_222_5.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 0) / var_222_3)))
							else
								local var_222_4 = Mathf.Lerp(iter_222_5.color.r, 0.5, (arg_219_1.time_ - 0) / var_222_3)

								iter_222_5.color = Color.New(var_222_4, var_222_4, var_222_4)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps128404 then
				for iter_222_6, iter_222_7 in pairs(arg_219_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_222_7 then
						iter_222_7.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps128404 = nil
			end

			local var_222_5 = arg_219_1.actors_["104902"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos104902 = var_222_5.localPosition
				var_222_5.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("104902", 4)

				for iter_222_8 = 0, var_222_5.childCount - 1 do
					local var_222_6 = var_222_5:GetChild(iter_222_8)

					if var_222_6.name == "split_6" or not string.find(var_222_6.name, "split") then
						var_222_6.gameObject:SetActive(true)
					else
						var_222_6.gameObject:SetActive(false)
					end
				end
			end

			local var_222_7 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_219_1.time_ - 0) / var_222_7)
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_222_8 = 0
			local var_222_9 = 0.675

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(938081053).content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_12 = 27 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 27)

				if (27 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 27)) > 0 and var_222_9 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_13 and arg_219_1.time_ < var_222_8 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play938081054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 938081054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play938081055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["106603"]) and arg_223_1.var_.actorSpriteComps106603 == nil then
				arg_223_1.var_.actorSpriteComps106603 = arg_223_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["106603"]) then
				if arg_223_1.var_.actorSpriteComps106603 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["106603"]) and arg_223_1.var_.actorSpriteComps106603 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps106603 = nil
			end

			local var_226_2 = arg_223_1.actors_["104902"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps104902 == nil then
				arg_223_1.var_.actorSpriteComps104902 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps104902 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								iter_226_5.color = Color.New(Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_5.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_5.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps104902 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_226_7 then
						iter_226_7.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps104902 = nil
			end

			local var_226_5 = arg_223_1.actors_["106603"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos106603 = var_226_5.localPosition
				var_226_5.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("106603", 2)

				for iter_226_8 = 0, var_226_5.childCount - 1 do
					local var_226_6 = var_226_5:GetChild(iter_226_8)

					if var_226_6.name == "split_7" or not string.find(var_226_6.name, "split") then
						var_226_6.gameObject:SetActive(true)
					else
						var_226_6.gameObject:SetActive(false)
					end
				end
			end

			local var_226_7 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				var_226_5.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_223_1.time_ - 0) / var_226_7)
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				var_226_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_226_8 = arg_223_1.actors_["128404"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos128404 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("128404", 7)

				for iter_226_9 = 0, var_226_8.childCount - 1 do
					local var_226_9 = var_226_8:GetChild(iter_226_9)

					if var_226_9.name == "" or not string.find(var_226_9.name, "split") then
						var_226_9.gameObject:SetActive(true)
					else
						var_226_9.gameObject:SetActive(false)
					end
				end
			end

			local var_226_10 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_10 then
				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_223_1.time_ - 0) / var_226_10)
			end

			if arg_223_1.time_ >= 0 + var_226_10 and arg_223_1.time_ < 0 + var_226_10 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_11 = 0
			local var_226_12 = 0.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(938081054).content)

				arg_223_1.text_.text = var_226_13

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 16 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_13) / 16)

				if (16 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_13) / 16)) > 0 and var_226_12 < var_226_15 then
					arg_223_1.talkMaxDuration = var_226_15

					if var_226_15 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_13
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_16 and arg_223_1.time_ < var_226_11 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play938081055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 938081055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play938081056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["106603"]) and arg_227_1.var_.actorSpriteComps106603 == nil then
				arg_227_1.var_.actorSpriteComps106603 = arg_227_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["106603"]) then
				if arg_227_1.var_.actorSpriteComps106603 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["106603"]) and arg_227_1.var_.actorSpriteComps106603 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps106603 = nil
			end

			local var_230_2 = 0
			local var_230_3 = 0.3

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_4 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(938081055).content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 12 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 12)

				if (12 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_4) / 12)) > 0 and var_230_3 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_7 and arg_227_1.time_ < var_230_2 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play938081056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 938081056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play938081057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["104902"]) and arg_231_1.var_.actorSpriteComps104902 == nil then
				arg_231_1.var_.actorSpriteComps104902 = arg_231_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["104902"]) then
				if arg_231_1.var_.actorSpriteComps104902 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["104902"]) and arg_231_1.var_.actorSpriteComps104902 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps104902 = nil
			end

			local var_234_2 = arg_231_1.actors_["104902"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos104902 = var_234_2.localPosition
				var_234_2.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104902", 4)

				for iter_234_4 = 0, var_234_2.childCount - 1 do
					local var_234_3 = var_234_2:GetChild(iter_234_4)

					if var_234_3.name == "split_8" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_231_1.time_ - 0) / var_234_4)
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(390, -335, -360)
			end

			local var_234_5 = 0
			local var_234_6 = 0.275

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(938081056).content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 11 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 11)

				if (11 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 11)) > 0 and var_234_6 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_10 and arg_231_1.time_ < var_234_5 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play938081057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 938081057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play938081058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["128404"]) and arg_235_1.var_.actorSpriteComps128404 == nil then
				arg_235_1.var_.actorSpriteComps128404 = arg_235_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["128404"]) then
				if arg_235_1.var_.actorSpriteComps128404 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["128404"]) and arg_235_1.var_.actorSpriteComps128404 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps128404 = nil
			end

			local var_238_2 = arg_235_1.actors_["104902"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps104902 == nil then
				arg_235_1.var_.actorSpriteComps104902 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps104902 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								iter_238_5.color = Color.New(Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_5.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_5.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps104902 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_238_7 then
						iter_238_7.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps104902 = nil
			end

			local var_238_5 = arg_235_1.actors_["128404"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos128404 = var_238_5.localPosition
				var_238_5.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("128404", 2)

				for iter_238_8 = 0, var_238_5.childCount - 1 do
					local var_238_6 = var_238_5:GetChild(iter_238_8)

					if var_238_6.name == "split_9" or not string.find(var_238_6.name, "split") then
						var_238_6.gameObject:SetActive(true)
					else
						var_238_6.gameObject:SetActive(false)
					end
				end
			end

			local var_238_7 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				var_238_5.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_235_1.time_ - 0) / var_238_7)
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				var_238_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_238_8 = arg_235_1.actors_["106603"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos106603 = var_238_8.localPosition
				var_238_8.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("106603", 7)

				for iter_238_9 = 0, var_238_8.childCount - 1 do
					local var_238_9 = var_238_8:GetChild(iter_238_9)

					if var_238_9.name == "" or not string.find(var_238_9.name, "split") then
						var_238_9.gameObject:SetActive(true)
					else
						var_238_9.gameObject:SetActive(false)
					end
				end
			end

			local var_238_10 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_10 then
				var_238_8.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_235_1.time_ - 0) / var_238_10)
			end

			if arg_235_1.time_ >= 0 + var_238_10 and arg_235_1.time_ < 0 + var_238_10 + arg_238_0 then
				var_238_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_238_11 = 0
			local var_238_12 = 0.375

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(938081057).content)

				arg_235_1.text_.text = var_238_13

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_15 = 15 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_13) / 15)

				if (15 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_13) / 15)) > 0 and var_238_12 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_13
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_11) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_16 and arg_235_1.time_ < var_238_11 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play938081058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 938081058
		arg_239_1.duration_ = 1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"

			SetActive(arg_239_1.choicesGo_, true)

			for iter_240_0, iter_240_1 in ipairs(arg_239_1.choices_) do
				SetActive(iter_240_1.go, iter_240_0 <= 1)
			end

			arg_239_1.choices_[1].txt.text = arg_239_1:FormatText(StoryChoiceCfg[1791].name)
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play938081059(arg_239_1)
			end

			arg_239_1:RecordChoiceLog(938081058, 1791)
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["128404"]) and arg_239_1.var_.actorSpriteComps128404 == nil then
				arg_239_1.var_.actorSpriteComps128404 = arg_239_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["128404"]) then
				if arg_239_1.var_.actorSpriteComps128404 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["128404"]) and arg_239_1.var_.actorSpriteComps128404 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps128404 = nil
			end

			local var_242_2 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			if arg_239_1.time_ >= var_242_2 + 0.6 and arg_239_1.time_ < var_242_2 + 0.6 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play938081059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 938081059
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play938081060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if arg_243_1.bgs_.H02a == nil then
				local var_246_0 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02a")
				var_246_0.name = "H02a"
				var_246_0.transform.parent = arg_243_1.stage_.transform
				var_246_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_.H02a = var_246_0
			end

			if 1.999999999999 < arg_243_1.time_ and arg_243_1.time_ <= 1.999999999999 + arg_246_0 then
				local var_246_1 = arg_243_1.bgs_.H02a

				arg_243_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_2 = var_246_1:GetComponent("SpriteRenderer")

				if var_246_2 and var_246_2.sprite then
					local var_246_3 = 2 * (var_246_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_1.transform.localScale = Vector3.New(var_246_3 / var_246_2.sprite.bounds.size.y < var_246_3 * manager.ui.mainCameraCom_.aspect / var_246_2.sprite.bounds.size.x and var_246_3 * manager.ui.mainCameraCom_.aspect / var_246_2.sprite.bounds.size.x or var_246_3 / var_246_2.sprite.bounds.size.y, var_246_3 / var_246_2.sprite.bounds.size.y < var_246_3 * manager.ui.mainCameraCom_.aspect / var_246_2.sprite.bounds.size.x and var_246_3 * manager.ui.mainCameraCom_.aspect / var_246_2.sprite.bounds.size.x or var_246_3 / var_246_2.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "H02a" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_4 = 4.034

			if 4.034 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			if arg_243_1.time_ >= var_246_4 + 0.3 and arg_243_1.time_ < var_246_4 + 0.3 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_5 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_6 = 2

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_6 then
				local var_246_7 = Color.New(0, 0, 0)

				var_246_7.a = Mathf.Lerp(0, 1, (arg_243_1.time_ - var_246_5) / var_246_6)
				arg_243_1.mask_.color = var_246_7
			end

			if arg_243_1.time_ >= var_246_5 + var_246_6 and arg_243_1.time_ < var_246_5 + var_246_6 + arg_246_0 then
				local var_246_8 = Color.New(0, 0, 0)

				var_246_8.a = 1
				arg_243_1.mask_.color = var_246_8
			end

			local var_246_9 = 2

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_10 = 2

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 then
				local var_246_11 = Color.New(0, 0, 0)

				var_246_11.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_9) / var_246_10)
				arg_243_1.mask_.color = var_246_11
			end

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 then
				local var_246_12 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_12.a = 0
				arg_243_1.mask_.color = var_246_12
			end

			local var_246_13 = arg_243_1.actors_["108301"]

			if 3.999999999999 < arg_243_1.time_ and arg_243_1.time_ <= 3.999999999999 + arg_246_0 and not isNil(var_246_13) and arg_243_1.var_.actorSpriteComps108301 == nil then
				arg_243_1.var_.actorSpriteComps108301 = var_246_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_14 = 0.2

			if 3.999999999999 <= arg_243_1.time_ and arg_243_1.time_ < 3.999999999999 + var_246_14 and not isNil(var_246_13) then
				if arg_243_1.var_.actorSpriteComps108301 then
					for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_246_3 then
							if arg_243_1.isInRecall_ then
								iter_246_3.color = Color.New(Mathf.Lerp(iter_246_3.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 3.999999999999) / var_246_14), Mathf.Lerp(iter_246_3.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 3.999999999999) / var_246_14), (Mathf.Lerp(iter_246_3.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 3.999999999999) / var_246_14)))
							else
								local var_246_15 = Mathf.Lerp(iter_246_3.color.r, 1, (arg_243_1.time_ - 3.999999999999) / var_246_14)

								iter_246_3.color = Color.New(var_246_15, var_246_15, var_246_15)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 3.999999999999 + var_246_14 and arg_243_1.time_ < 3.999999999999 + var_246_14 + arg_246_0 and not isNil(var_246_13) and arg_243_1.var_.actorSpriteComps108301 then
				for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_246_5 then
						iter_246_5.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps108301 = nil
			end

			local var_246_16 = arg_243_1.actors_["108301"].transform

			if 4 < arg_243_1.time_ and arg_243_1.time_ <= 4 + arg_246_0 then
				arg_243_1.var_.moveOldPos108301 = var_246_16.localPosition
				var_246_16.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("108301", 2)

				for iter_246_6 = 0, var_246_16.childCount - 1 do
					local var_246_17 = var_246_16:GetChild(iter_246_6)

					if var_246_17.name == "split_5" or not string.find(var_246_17.name, "split") then
						var_246_17.gameObject:SetActive(true)
					else
						var_246_17.gameObject:SetActive(false)
					end
				end
			end

			local var_246_18 = 0.001

			if 4 <= arg_243_1.time_ and arg_243_1.time_ < 4 + var_246_18 then
				var_246_16.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_243_1.time_ - 4) / var_246_18)
			end

			if arg_243_1.time_ >= 4 + var_246_18 and arg_243_1.time_ < 4 + var_246_18 + arg_246_0 then
				var_246_16.localPosition = Vector3.New(-420, -360, -195)
			end

			if 2.9 < arg_243_1.time_ and arg_243_1.time_ <= 2.9 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 2.2 < arg_243_1.time_ and arg_243_1.time_ <= 2.2 + arg_246_0 then
				arg_243_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 2.9 < arg_243_1.time_ and arg_243_1.time_ <= 2.9 + arg_246_0 then
				arg_243_1:AudioAction("play", "music", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_246_23 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if "" ~= "" then
					if arg_243_1.bgmTxt_.text ~= var_246_23 and arg_243_1.bgmTxt_.text ~= "" then
						if arg_243_1.bgmTxt2_.text ~= "" then
							arg_243_1.bgmTxt_.text = arg_243_1.bgmTxt2_.text
						end

						arg_243_1.bgmTxt2_.text = var_246_23

						arg_243_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_243_1.bgmTxt_.text = var_246_23
						arg_243_1.bgmTxt2_.text = var_246_23
					end

					if arg_243_1.bgmTimer then
						arg_243_1.bgmTimer:Stop()

						arg_243_1.bgmTimer = nil
					end

					if arg_243_1.settingData.show_music_name == 1 then
						arg_243_1.musicController:SetSelectedState("show")
						arg_243_1.musicAnimator_:Play("open", 0, 0)

						if arg_243_1.settingData.music_time ~= 0 then
							arg_243_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_243_1.settingData.music_time), function()
								if arg_243_1 == nil or isNil(arg_243_1.bgmTxt_) then
									return
								end

								arg_243_1.musicController:SetSelectedState("hide")
								arg_243_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_246_24 = arg_243_1.actors_["104902"].transform

			if 1.966 < arg_243_1.time_ and arg_243_1.time_ <= 1.966 + arg_246_0 then
				arg_243_1.var_.moveOldPos104902 = var_246_24.localPosition
				var_246_24.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("104902", 7)

				for iter_246_7 = 0, var_246_24.childCount - 1 do
					local var_246_25 = var_246_24:GetChild(iter_246_7)

					if var_246_25.name == "" or not string.find(var_246_25.name, "split") then
						var_246_25.gameObject:SetActive(true)
					else
						var_246_25.gameObject:SetActive(false)
					end
				end
			end

			local var_246_26 = 0.001

			if 1.966 <= arg_243_1.time_ and arg_243_1.time_ < 1.966 + var_246_26 then
				var_246_24.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_243_1.time_ - 1.966) / var_246_26)
			end

			if arg_243_1.time_ >= 1.966 + var_246_26 and arg_243_1.time_ < 1.966 + var_246_26 + arg_246_0 then
				var_246_24.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_246_27 = arg_243_1.actors_["128404"].transform

			if 1.966 < arg_243_1.time_ and arg_243_1.time_ <= 1.966 + arg_246_0 then
				arg_243_1.var_.moveOldPos128404 = var_246_27.localPosition
				var_246_27.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("128404", 7)

				for iter_246_8 = 0, var_246_27.childCount - 1 do
					local var_246_28 = var_246_27:GetChild(iter_246_8)

					if var_246_28.name == "" or not string.find(var_246_28.name, "split") then
						var_246_28.gameObject:SetActive(true)
					else
						var_246_28.gameObject:SetActive(false)
					end
				end
			end

			local var_246_29 = 0.001

			if 1.966 <= arg_243_1.time_ and arg_243_1.time_ < 1.966 + var_246_29 then
				var_246_27.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_243_1.time_ - 1.966) / var_246_29)
			end

			if arg_243_1.time_ >= 1.966 + var_246_29 and arg_243_1.time_ < 1.966 + var_246_29 + arg_246_0 then
				var_246_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_30 = 3.999999999999
			local var_246_31 = 1.1

			if 3.999999999999 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_32 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_32:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_243_1.dialogCg_.alpha = arg_248_0
				end))
				var_246_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_33 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(938081059).content)

				arg_243_1.text_.text = var_246_33

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_35 = 44 <= 0 and var_246_31 or var_246_31 * (utf8.len(var_246_33) / 44)

				if (44 <= 0 and var_246_31 or var_246_31 * (utf8.len(var_246_33) / 44)) > 0 and var_246_31 < var_246_35 then
					arg_243_1.talkMaxDuration = var_246_35
					var_246_30 = var_246_30 + 0.3

					if var_246_35 + var_246_30 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_35 + var_246_30
					end
				end

				arg_243_1.text_.text = var_246_33
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_36 = var_246_30 + 0.3
			local var_246_37 = math.max(var_246_31, arg_243_1.talkMaxDuration)

			if var_246_30 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_36 + var_246_37 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_36) / var_246_37

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_36 + var_246_37 and arg_243_1.time_ < var_246_36 + var_246_37 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play938081060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938081060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938081061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["106603"]) and arg_250_1.var_.actorSpriteComps106603 == nil then
				arg_250_1.var_.actorSpriteComps106603 = arg_250_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["106603"]) then
				if arg_250_1.var_.actorSpriteComps106603 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 1, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["106603"]) and arg_250_1.var_.actorSpriteComps106603 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps106603 = nil
			end

			local var_253_2 = arg_250_1.actors_["108301"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps108301 == nil then
				arg_250_1.var_.actorSpriteComps108301 = var_253_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_3 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_3 and not isNil(var_253_2) then
				if arg_250_1.var_.actorSpriteComps108301 then
					for iter_253_4, iter_253_5 in pairs(arg_250_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_253_5 then
							if arg_250_1.isInRecall_ then
								iter_253_5.color = Color.New(Mathf.Lerp(iter_253_5.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_3), Mathf.Lerp(iter_253_5.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_3), (Mathf.Lerp(iter_253_5.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_3)))
							else
								local var_253_4 = Mathf.Lerp(iter_253_5.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_3)

								iter_253_5.color = Color.New(var_253_4, var_253_4, var_253_4)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_3 and arg_250_1.time_ < 0 + var_253_3 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps108301 then
				for iter_253_6, iter_253_7 in pairs(arg_250_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_253_7 then
						iter_253_7.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps108301 = nil
			end

			local var_253_5 = arg_250_1.actors_["106603"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos106603 = var_253_5.localPosition
				var_253_5.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("106603", 4)

				for iter_253_8 = 0, var_253_5.childCount - 1 do
					local var_253_6 = var_253_5:GetChild(iter_253_8)

					if var_253_6.name == "split_6" or not string.find(var_253_6.name, "split") then
						var_253_6.gameObject:SetActive(true)
					else
						var_253_6.gameObject:SetActive(false)
					end
				end
			end

			local var_253_7 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				var_253_5.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_250_1.time_ - 0) / var_253_7)
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				var_253_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_253_8 = 0
			local var_253_9 = 0.5

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_10 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(938081060).content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_12 = 20 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 20)

				if (20 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 20)) > 0 and var_253_9 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_13 and arg_250_1.time_ < var_253_8 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play938081061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938081061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938081062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["108301"]) and arg_254_1.var_.actorSpriteComps108301 == nil then
				arg_254_1.var_.actorSpriteComps108301 = arg_254_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["108301"]) then
				if arg_254_1.var_.actorSpriteComps108301 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["108301"]) and arg_254_1.var_.actorSpriteComps108301 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps108301 = nil
			end

			local var_257_2 = arg_254_1.actors_["106603"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps106603 == nil then
				arg_254_1.var_.actorSpriteComps106603 = var_257_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_3 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.actorSpriteComps106603 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								iter_257_5.color = Color.New(Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_3), Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_3), (Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_3)))
							else
								local var_257_4 = Mathf.Lerp(iter_257_5.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_3)

								iter_257_5.color = Color.New(var_257_4, var_257_4, var_257_4)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps106603 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_257_7 then
						iter_257_7.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps106603 = nil
			end

			local var_257_5 = arg_254_1.actors_["108301"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos108301 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("108301", 2)

				for iter_257_8 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_8)

					if var_257_6.name == "split_1" then
						var_257_6:SetAsLastSibling()
						var_257_6.gameObject:SetActive(true)

						arg_254_1.var_.actorSpriteSplit108301 = var_257_6.gameObject:GetComponent(typeof(Image))

						arg_254_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_257_7 = 0.5

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_254_1.time_ - 0) / var_257_7)

				if arg_254_1.var_.actorSpriteSplit108301 ~= nil then
					arg_254_1.var_.actorSpriteSplit108301:SetAlpha((arg_254_1.time_ - 0) / var_257_7)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(-420, -360, -195)

				if arg_254_1.var_.actorSpriteSplit108301 ~= nil then
					arg_254_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_257_8 = 0
			local var_257_9 = 0.35

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(938081061).content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_12 = 14 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_10) / 14)

				if (14 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_10) / 14)) > 0 and var_257_9 < var_257_12 then
					arg_254_1.talkMaxDuration = var_257_12

					if var_257_12 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_13 and arg_254_1.time_ < var_257_8 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play938081062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938081062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938081063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["106603"]) and arg_258_1.var_.actorSpriteComps106603 == nil then
				arg_258_1.var_.actorSpriteComps106603 = arg_258_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["106603"]) then
				if arg_258_1.var_.actorSpriteComps106603 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 1, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["106603"]) and arg_258_1.var_.actorSpriteComps106603 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps106603 = nil
			end

			local var_261_2 = arg_258_1.actors_["108301"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps108301 == nil then
				arg_258_1.var_.actorSpriteComps108301 = var_261_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_3 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 and not isNil(var_261_2) then
				if arg_258_1.var_.actorSpriteComps108301 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								iter_261_5.color = Color.New(Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_3), Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_3), (Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_3)))
							else
								local var_261_4 = Mathf.Lerp(iter_261_5.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_3)

								iter_261_5.color = Color.New(var_261_4, var_261_4, var_261_4)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps108301 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_261_7 then
						iter_261_7.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps108301 = nil
			end

			local var_261_5 = arg_258_1.actors_["106603"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos106603 = var_261_5.localPosition
				var_261_5.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("106603", 4)

				for iter_261_8 = 0, var_261_5.childCount - 1 do
					local var_261_6 = var_261_5:GetChild(iter_261_8)

					if var_261_6.name == "split_1" then
						var_261_6:SetAsLastSibling()
						var_261_6.gameObject:SetActive(true)

						arg_258_1.var_.actorSpriteSplit106603 = var_261_6.gameObject:GetComponent(typeof(Image))

						arg_258_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_261_7 = 0.5

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_258_1.time_ - 0) / var_261_7)

				if arg_258_1.var_.actorSpriteSplit106603 ~= nil then
					arg_258_1.var_.actorSpriteSplit106603:SetAlpha((arg_258_1.time_ - 0) / var_261_7)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(453.9, -399.1, -303.3)

				if arg_258_1.var_.actorSpriteSplit106603 ~= nil then
					arg_258_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_261_8 = 0
			local var_261_9 = 0.2

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(938081062).content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_12 = 8 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_10) / 8)

				if (8 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_10) / 8)) > 0 and var_261_9 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_13 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_13 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_13

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_13 and arg_258_1.time_ < var_261_8 + var_261_13 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play938081063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938081063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938081064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["128404"]) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = arg_262_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["128404"]) then
				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								iter_265_1.color = Color.New(Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_0), Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_0), (Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_0)))
							else
								local var_265_1 = Mathf.Lerp(iter_265_1.color.r, 1, (arg_262_1.time_ - 0) / var_265_0)

								iter_265_1.color = Color.New(var_265_1, var_265_1, var_265_1)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["128404"]) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_2 = arg_262_1.actors_["106603"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps106603 == nil then
				arg_262_1.var_.actorSpriteComps106603 = var_265_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_3 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.actorSpriteComps106603 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								iter_265_5.color = Color.New(Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, (arg_262_1.time_ - 0) / var_265_3), Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, (arg_262_1.time_ - 0) / var_265_3), (Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, (arg_262_1.time_ - 0) / var_265_3)))
							else
								local var_265_4 = Mathf.Lerp(iter_265_5.color.r, 0.5, (arg_262_1.time_ - 0) / var_265_3)

								iter_265_5.color = Color.New(var_265_4, var_265_4, var_265_4)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps106603 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_265_7 then
						iter_265_7.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_262_1.var_.actorSpriteComps106603 = nil
			end

			local var_265_5 = arg_262_1.actors_["128404"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = var_265_5.localPosition
				var_265_5.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 2)

				for iter_265_8 = 0, var_265_5.childCount - 1 do
					local var_265_6 = var_265_5:GetChild(iter_265_8)

					if var_265_6.name == "split_2" or not string.find(var_265_6.name, "split") then
						var_265_6.gameObject:SetActive(true)
					else
						var_265_6.gameObject:SetActive(false)
					end
				end
			end

			local var_265_7 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				var_265_5.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_262_1.time_ - 0) / var_265_7)
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				var_265_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_265_8 = arg_262_1.actors_["108301"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos108301 = var_265_8.localPosition
				var_265_8.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("108301", 7)

				for iter_265_9 = 0, var_265_8.childCount - 1 do
					local var_265_9 = var_265_8:GetChild(iter_265_9)

					if var_265_9.name == "" or not string.find(var_265_9.name, "split") then
						var_265_9.gameObject:SetActive(true)
					else
						var_265_9.gameObject:SetActive(false)
					end
				end
			end

			local var_265_10 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_10 then
				var_265_8.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_262_1.time_ - 0) / var_265_10)
			end

			if arg_262_1.time_ >= 0 + var_265_10 and arg_262_1.time_ < 0 + var_265_10 + arg_265_0 then
				var_265_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_11 = 0
			local var_265_12 = 0.425

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_11 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(938081063).content)

				arg_262_1.text_.text = var_265_13

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 17 <= 0 and var_265_12 or var_265_12 * (utf8.len(var_265_13) / 17)

				if (17 <= 0 and var_265_12 or var_265_12 * (utf8.len(var_265_13) / 17)) > 0 and var_265_12 < var_265_15 then
					arg_262_1.talkMaxDuration = var_265_15

					if var_265_15 + var_265_11 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_15 + var_265_11
					end
				end

				arg_262_1.text_.text = var_265_13
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_12, arg_262_1.talkMaxDuration)

			if var_265_11 <= arg_262_1.time_ and arg_262_1.time_ < var_265_11 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_11) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_11 + var_265_16 and arg_262_1.time_ < var_265_11 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938081064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938081064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938081065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos128404 = arg_266_1.actors_["128404"].transform.localPosition
				arg_266_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("128404", 2)

				for iter_269_0 = 0, arg_266_1.actors_["128404"].transform.childCount - 1 do
					local var_269_0 = arg_266_1.actors_["128404"].transform:GetChild(iter_269_0)

					if var_269_0.name == "split_1" then
						var_269_0:SetAsLastSibling()
						var_269_0.gameObject:SetActive(true)

						arg_266_1.var_.actorSpriteSplit128404 = var_269_0.gameObject:GetComponent(typeof(Image))

						arg_266_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_269_1 = 0.5

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_266_1.time_ - 0) / var_269_1)

				if arg_266_1.var_.actorSpriteSplit128404 ~= nil then
					arg_266_1.var_.actorSpriteSplit128404:SetAlpha((arg_266_1.time_ - 0) / var_269_1)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["128404"].transform.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_266_1.var_.actorSpriteSplit128404 ~= nil then
					arg_266_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_269_2 = 0
			local var_269_3 = 0.95

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(938081064).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 38 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 38)

				if (38 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 38)) > 0 and var_269_3 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_7 and arg_266_1.time_ < var_269_2 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play938081065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938081065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938081066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["104902"]) and arg_270_1.var_.actorSpriteComps104902 == nil then
				arg_270_1.var_.actorSpriteComps104902 = arg_270_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["104902"]) then
				if arg_270_1.var_.actorSpriteComps104902 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 1, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["104902"]) and arg_270_1.var_.actorSpriteComps104902 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps104902 = nil
			end

			local var_273_2 = arg_270_1.actors_["128404"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps128404 == nil then
				arg_270_1.var_.actorSpriteComps128404 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps128404 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_273_5 then
							if arg_270_1.isInRecall_ then
								iter_273_5.color = Color.New(Mathf.Lerp(iter_273_5.color.r, arg_270_1.hightColor2.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_5.color.g, arg_270_1.hightColor2.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_5.color.b, arg_270_1.hightColor2.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_5.color.r, 0.5, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_5.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps128404 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_273_7 then
						iter_273_7.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps128404 = nil
			end

			local var_273_5 = arg_270_1.actors_["104902"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos104902 = var_273_5.localPosition
				var_273_5.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("104902", 4)

				for iter_273_8 = 0, var_273_5.childCount - 1 do
					local var_273_6 = var_273_5:GetChild(iter_273_8)

					if var_273_6.name == "split_2" or not string.find(var_273_6.name, "split") then
						var_273_6.gameObject:SetActive(true)
					else
						var_273_6.gameObject:SetActive(false)
					end
				end
			end

			local var_273_7 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_270_1.time_ - 0) / var_273_7)
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_273_8 = arg_270_1.actors_["106603"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos106603 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("106603", 7)

				for iter_273_9 = 0, var_273_8.childCount - 1 do
					local var_273_9 = var_273_8:GetChild(iter_273_9)

					if var_273_9.name == "" or not string.find(var_273_9.name, "split") then
						var_273_9.gameObject:SetActive(true)
					else
						var_273_9.gameObject:SetActive(false)
					end
				end
			end

			local var_273_10 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_10 then
				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_270_1.time_ - 0) / var_273_10)
			end

			if arg_270_1.time_ >= 0 + var_273_10 and arg_270_1.time_ < 0 + var_273_10 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_11 = 0
			local var_273_12 = 1

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(938081065).content)

				arg_270_1.text_.text = var_273_13

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 40 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 40)

				if (40 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 40)) > 0 and var_273_12 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_11 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_11
					end
				end

				arg_270_1.text_.text = var_273_13
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_12, arg_270_1.talkMaxDuration)

			if var_273_11 <= arg_270_1.time_ and arg_270_1.time_ < var_273_11 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_11) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_11 + var_273_16 and arg_270_1.time_ < var_273_11 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play938081066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938081066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938081067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["104902"]) and arg_274_1.var_.actorSpriteComps104902 == nil then
				arg_274_1.var_.actorSpriteComps104902 = arg_274_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["104902"]) then
				if arg_274_1.var_.actorSpriteComps104902 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["104902"]) and arg_274_1.var_.actorSpriteComps104902 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps104902 = nil
			end

			local var_277_2 = 0
			local var_277_3 = 0.45

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_4 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(938081066).content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 18 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 18)

				if (18 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 18)) > 0 and var_277_3 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_7 and arg_274_1.time_ < var_277_2 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938081067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938081067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938081068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos104902 = arg_278_1.actors_["104902"].transform.localPosition
				arg_278_1.actors_["104902"].transform.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("104902", 7)

				for iter_281_0 = 0, arg_278_1.actors_["104902"].transform.childCount - 1 do
					local var_281_0 = arg_278_1.actors_["104902"].transform:GetChild(iter_281_0)

					if var_281_0.name == "" or not string.find(var_281_0.name, "split") then
						var_281_0.gameObject:SetActive(true)
					else
						var_281_0.gameObject:SetActive(false)
					end
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["104902"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_278_1.time_ - 0) / var_281_1)
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["104902"].transform.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_281_2 = arg_278_1.actors_["128404"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos128404 = var_281_2.localPosition
				var_281_2.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("128404", 7)

				for iter_281_1 = 0, var_281_2.childCount - 1 do
					local var_281_3 = var_281_2:GetChild(iter_281_1)

					if var_281_3.name == "" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_278_1.time_ - 0) / var_281_4)
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_5 = 0
			local var_281_6 = 1.05

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(938081067).content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 42 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 42)

				if (42 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 42)) > 0 and var_281_6 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_10 and arg_278_1.time_ < var_281_5 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play938081068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 938081068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play938081069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.6

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(938081068).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 24 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 24)

				if (24 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 24)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play938081069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 938081069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play938081070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.3

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(938081069).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 12 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 12)

				if (12 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 12)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play938081070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938081070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938081071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10183"]) and arg_290_1.var_.actorSpriteComps10183 == nil then
				arg_290_1.var_.actorSpriteComps10183 = arg_290_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10183"]) then
				if arg_290_1.var_.actorSpriteComps10183 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor1.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor1.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor1.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 1, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10183"]) and arg_290_1.var_.actorSpriteComps10183 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_290_1.var_.actorSpriteComps10183 = nil
			end

			local var_293_2 = arg_290_1.actors_["10183"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos10183 = var_293_2.localPosition
				var_293_2.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10183", 2)

				for iter_293_4 = 0, var_293_2.childCount - 1 do
					local var_293_3 = var_293_2:GetChild(iter_293_4)

					if var_293_3.name == "split_7" or not string.find(var_293_3.name, "split") then
						var_293_3.gameObject:SetActive(true)
					else
						var_293_3.gameObject:SetActive(false)
					end
				end
			end

			local var_293_4 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				var_293_2.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_290_1.time_ - 0) / var_293_4)
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				var_293_2.localPosition = Vector3.New(-300, -475, -325)
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				local var_293_5 = arg_290_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_293_5 then
					arg_290_1.var_.alphaOldValue10183 = var_293_5.alpha
					arg_290_1.var_.characterEffect10183 = var_293_5
				end

				arg_290_1.var_.alphaOldValue10183 = 0
			end

			local var_293_6 = 0.0333333333333333

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_6 then
				if arg_290_1.var_.characterEffect10183 then
					arg_290_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_290_1.var_.alphaOldValue10183, 1, (arg_290_1.time_ - 0) / var_293_6)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_6 and arg_290_1.time_ < 0 + var_293_6 + arg_293_0 and arg_290_1.var_.characterEffect10183 then
				arg_290_1.var_.characterEffect10183.alpha = 1
			end

			local var_293_7 = 0
			local var_293_8 = 0.5

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_7 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_9 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(938081070).content)

				arg_290_1.text_.text = var_293_9

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 20 <= 0 and var_293_8 or var_293_8 * (utf8.len(var_293_9) / 20)

				if (20 <= 0 and var_293_8 or var_293_8 * (utf8.len(var_293_9) / 20)) > 0 and var_293_8 < var_293_11 then
					arg_290_1.talkMaxDuration = var_293_11

					if var_293_11 + var_293_7 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_7
					end
				end

				arg_290_1.text_.text = var_293_9
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_8, arg_290_1.talkMaxDuration)

			if var_293_7 <= arg_290_1.time_ and arg_290_1.time_ < var_293_7 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_7) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_7 + var_293_12 and arg_290_1.time_ < var_293_7 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play938081071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938081071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938081072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["128404"]) and arg_294_1.var_.actorSpriteComps128404 == nil then
				arg_294_1.var_.actorSpriteComps128404 = arg_294_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["128404"]) then
				if arg_294_1.var_.actorSpriteComps128404 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 1, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["128404"]) and arg_294_1.var_.actorSpriteComps128404 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_294_1.var_.actorSpriteComps128404 = nil
			end

			local var_297_2 = arg_294_1.actors_["10183"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps10183 == nil then
				arg_294_1.var_.actorSpriteComps10183 = var_297_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_3 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 and not isNil(var_297_2) then
				if arg_294_1.var_.actorSpriteComps10183 then
					for iter_297_4, iter_297_5 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_297_5 then
							if arg_294_1.isInRecall_ then
								iter_297_5.color = Color.New(Mathf.Lerp(iter_297_5.color.r, arg_294_1.hightColor2.r, (arg_294_1.time_ - 0) / var_297_3), Mathf.Lerp(iter_297_5.color.g, arg_294_1.hightColor2.g, (arg_294_1.time_ - 0) / var_297_3), (Mathf.Lerp(iter_297_5.color.b, arg_294_1.hightColor2.b, (arg_294_1.time_ - 0) / var_297_3)))
							else
								local var_297_4 = Mathf.Lerp(iter_297_5.color.r, 0.5, (arg_294_1.time_ - 0) / var_297_3)

								iter_297_5.color = Color.New(var_297_4, var_297_4, var_297_4)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps10183 then
				for iter_297_6, iter_297_7 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_297_7 then
						iter_297_7.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_294_1.var_.actorSpriteComps10183 = nil
			end

			local var_297_5 = arg_294_1.actors_["128404"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos128404 = var_297_5.localPosition
				var_297_5.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("128404", 4)

				for iter_297_8 = 0, var_297_5.childCount - 1 do
					local var_297_6 = var_297_5:GetChild(iter_297_8)

					if var_297_6.name == "split_2" or not string.find(var_297_6.name, "split") then
						var_297_6.gameObject:SetActive(true)
					else
						var_297_6.gameObject:SetActive(false)
					end
				end
			end

			local var_297_7 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				var_297_5.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_294_1.time_ - 0) / var_297_7)
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				var_297_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_297_8 = 0
			local var_297_9 = 0.4

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_10 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(938081071).content)

				arg_294_1.text_.text = var_297_10

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_12 = 16 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_10) / 16)

				if (16 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_10) / 16)) > 0 and var_297_9 < var_297_12 then
					arg_294_1.talkMaxDuration = var_297_12

					if var_297_12 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_10
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_8) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_8 + var_297_13 and arg_294_1.time_ < var_297_8 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play938081072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 938081072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play938081073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["128404"]) and arg_298_1.var_.actorSpriteComps128404 == nil then
				arg_298_1.var_.actorSpriteComps128404 = arg_298_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["128404"]) then
				if arg_298_1.var_.actorSpriteComps128404 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 0.5, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["128404"]) and arg_298_1.var_.actorSpriteComps128404 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_298_1.var_.actorSpriteComps128404 = nil
			end

			local var_301_2 = 0
			local var_301_3 = 0.275

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_4 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(938081072).content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_6 = 11 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_4) / 11)

				if (11 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_4) / 11)) > 0 and var_301_3 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_2
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_3, arg_298_1.talkMaxDuration)

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_2) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_2 + var_301_7 and arg_298_1.time_ < var_301_2 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play938081073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 938081073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play938081074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["106603"]) and arg_302_1.var_.actorSpriteComps106603 == nil then
				arg_302_1.var_.actorSpriteComps106603 = arg_302_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["106603"]) then
				if arg_302_1.var_.actorSpriteComps106603 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 1, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["106603"]) and arg_302_1.var_.actorSpriteComps106603 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps106603 = nil
			end

			local var_305_2 = arg_302_1.actors_["106603"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos106603 = var_305_2.localPosition
				var_305_2.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("106603", 4)

				for iter_305_4 = 0, var_305_2.childCount - 1 do
					local var_305_3 = var_305_2:GetChild(iter_305_4)

					if var_305_3.name == "split_2" or not string.find(var_305_3.name, "split") then
						var_305_3.gameObject:SetActive(true)
					else
						var_305_3.gameObject:SetActive(false)
					end
				end
			end

			local var_305_4 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				var_305_2.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_302_1.time_ - 0) / var_305_4)
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				var_305_2.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_305_5 = arg_302_1.actors_["128404"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos128404 = var_305_5.localPosition
				var_305_5.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("128404", 7)

				for iter_305_5 = 0, var_305_5.childCount - 1 do
					local var_305_6 = var_305_5:GetChild(iter_305_5)

					if var_305_6.name == "" or not string.find(var_305_6.name, "split") then
						var_305_6.gameObject:SetActive(true)
					else
						var_305_6.gameObject:SetActive(false)
					end
				end
			end

			local var_305_7 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_302_1.time_ - 0) / var_305_7)
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_305_8 = 0
			local var_305_9 = 0.225

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(938081073).content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_12 = 9 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_10) / 9)

				if (9 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_10) / 9)) > 0 and var_305_9 < var_305_12 then
					arg_302_1.talkMaxDuration = var_305_12

					if var_305_12 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_13 and arg_302_1.time_ < var_305_8 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play938081074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938081074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938081075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["10183"]) and arg_306_1.var_.actorSpriteComps10183 == nil then
				arg_306_1.var_.actorSpriteComps10183 = arg_306_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["10183"]) then
				if arg_306_1.var_.actorSpriteComps10183 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["10183"]) and arg_306_1.var_.actorSpriteComps10183 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps10183 = nil
			end

			local var_309_2 = arg_306_1.actors_["106603"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps106603 == nil then
				arg_306_1.var_.actorSpriteComps106603 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps106603 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								iter_309_5.color = Color.New(Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_5.color.r, 0.5, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_5.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps106603 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_309_7 then
						iter_309_7.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_306_1.var_.actorSpriteComps106603 = nil
			end

			local var_309_5 = arg_306_1.actors_["10183"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10183 = var_309_5.localPosition
				var_309_5.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10183", 2)

				for iter_309_8 = 0, var_309_5.childCount - 1 do
					local var_309_6 = var_309_5:GetChild(iter_309_8)

					if var_309_6.name == "split_3" then
						var_309_6:SetAsLastSibling()
						var_309_6.gameObject:SetActive(true)

						arg_306_1.var_.actorSpriteSplit10183 = var_309_6.gameObject:GetComponent(typeof(Image))

						arg_306_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_309_7 = 0.5

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				var_309_5.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_306_1.time_ - 0) / var_309_7)

				if arg_306_1.var_.actorSpriteSplit10183 ~= nil then
					arg_306_1.var_.actorSpriteSplit10183:SetAlpha((arg_306_1.time_ - 0) / var_309_7)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				var_309_5.localPosition = Vector3.New(-300, -475, -325)

				if arg_306_1.var_.actorSpriteSplit10183 ~= nil then
					arg_306_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_309_8 = 0
			local var_309_9 = 0.225

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_8 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_10 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(938081074).content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_12 = 9 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_10) / 9)

				if (9 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_10) / 9)) > 0 and var_309_9 < var_309_12 then
					arg_306_1.talkMaxDuration = var_309_12

					if var_309_12 + var_309_8 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_12 + var_309_8
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_9, arg_306_1.talkMaxDuration)

			if var_309_8 <= arg_306_1.time_ and arg_306_1.time_ < var_309_8 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_8) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_8 + var_309_13 and arg_306_1.time_ < var_309_8 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play938081075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938081075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938081076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10183"]) and arg_310_1.var_.actorSpriteComps10183 == nil then
				arg_310_1.var_.actorSpriteComps10183 = arg_310_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10183"]) then
				if arg_310_1.var_.actorSpriteComps10183 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10183"]) and arg_310_1.var_.actorSpriteComps10183 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps10183 = nil
			end

			local var_313_2 = 0
			local var_313_3 = 0.6

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_4 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(938081075).content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 24 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 24)

				if (24 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 24)) > 0 and var_313_3 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_7 and arg_310_1.time_ < var_313_2 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938081076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938081076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938081077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10183"]) and arg_314_1.var_.actorSpriteComps10183 == nil then
				arg_314_1.var_.actorSpriteComps10183 = arg_314_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10183"]) then
				if arg_314_1.var_.actorSpriteComps10183 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 1, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10183"]) and arg_314_1.var_.actorSpriteComps10183 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps10183 = nil
			end

			local var_317_2 = arg_314_1.actors_["10183"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10183 = var_317_2.localPosition
				var_317_2.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10183", 2)

				for iter_317_4 = 0, var_317_2.childCount - 1 do
					local var_317_3 = var_317_2:GetChild(iter_317_4)

					if var_317_3.name == "split_1" then
						var_317_3:SetAsLastSibling()
						var_317_3.gameObject:SetActive(true)

						arg_314_1.var_.actorSpriteSplit10183 = var_317_3.gameObject:GetComponent(typeof(Image))

						arg_314_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_317_4 = 0.5

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				var_317_2.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_314_1.time_ - 0) / var_317_4)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha((arg_314_1.time_ - 0) / var_317_4)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				var_317_2.localPosition = Vector3.New(-300, -475, -325)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_317_5 = 0
			local var_317_6 = 0.525

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(938081076).content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 21 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 21)

				if (21 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 21)) > 0 and var_317_6 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_10 and arg_314_1.time_ < var_317_5 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play938081077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938081077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play938081078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["10183"]) and arg_318_1.var_.actorSpriteComps10183 == nil then
				arg_318_1.var_.actorSpriteComps10183 = arg_318_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["10183"]) then
				if arg_318_1.var_.actorSpriteComps10183 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10183"]) and arg_318_1.var_.actorSpriteComps10183 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps10183 = nil
			end

			local var_321_2 = 0
			local var_321_3 = 0.375

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_4 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(938081077).content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_6 = 15 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 15)

				if (15 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 15)) > 0 and var_321_3 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_7 and arg_318_1.time_ < var_321_2 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play938081078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 938081078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play938081079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10183"]) and arg_322_1.var_.actorSpriteComps10183 == nil then
				arg_322_1.var_.actorSpriteComps10183 = arg_322_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10183"]) then
				if arg_322_1.var_.actorSpriteComps10183 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 1, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10183"]) and arg_322_1.var_.actorSpriteComps10183 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_322_1.var_.actorSpriteComps10183 = nil
			end

			local var_325_2 = arg_322_1.actors_["10183"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10183 = var_325_2.localPosition
				var_325_2.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10183", 2)

				for iter_325_4 = 0, var_325_2.childCount - 1 do
					local var_325_3 = var_325_2:GetChild(iter_325_4)

					if var_325_3.name == "split_7" then
						var_325_3:SetAsLastSibling()
						var_325_3.gameObject:SetActive(true)

						arg_322_1.var_.actorSpriteSplit10183 = var_325_3.gameObject:GetComponent(typeof(Image))

						arg_322_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_325_4 = 0.5

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				var_325_2.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_322_1.time_ - 0) / var_325_4)

				if arg_322_1.var_.actorSpriteSplit10183 ~= nil then
					arg_322_1.var_.actorSpriteSplit10183:SetAlpha((arg_322_1.time_ - 0) / var_325_4)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				var_325_2.localPosition = Vector3.New(-300, -475, -325)

				if arg_322_1.var_.actorSpriteSplit10183 ~= nil then
					arg_322_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_325_5 = 0
			local var_325_6 = 1.45

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(938081078).content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 58 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 58)

				if (58 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 58)) > 0 and var_325_6 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_10 and arg_322_1.time_ < var_325_5 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play938081079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 938081079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play938081080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10183"]) and arg_326_1.var_.actorSpriteComps10183 == nil then
				arg_326_1.var_.actorSpriteComps10183 = arg_326_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10183"]) then
				if arg_326_1.var_.actorSpriteComps10183 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 0.5, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10183"]) and arg_326_1.var_.actorSpriteComps10183 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_326_1.var_.actorSpriteComps10183 = nil
			end

			local var_329_2 = 0
			local var_329_3 = 0.575

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_4 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(938081079).content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_6 = 23 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 23)

				if (23 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 23)) > 0 and var_329_3 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_7 and arg_326_1.time_ < var_329_2 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play938081080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 938081080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play938081081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["128404"]) and arg_330_1.var_.actorSpriteComps128404 == nil then
				arg_330_1.var_.actorSpriteComps128404 = arg_330_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["128404"]) then
				if arg_330_1.var_.actorSpriteComps128404 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["128404"]) and arg_330_1.var_.actorSpriteComps128404 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps128404 = nil
			end

			local var_333_2 = arg_330_1.actors_["128404"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos128404 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("128404", 4)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "split_2" or not string.find(var_333_3.name, "split") then
						var_333_3.gameObject:SetActive(true)
					else
						var_333_3.gameObject:SetActive(false)
					end
				end
			end

			local var_333_4 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_330_1.time_ - 0) / var_333_4)
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_333_5 = arg_330_1.actors_["106603"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos106603 = var_333_5.localPosition
				var_333_5.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("106603", 7)

				for iter_333_5 = 0, var_333_5.childCount - 1 do
					local var_333_6 = var_333_5:GetChild(iter_333_5)

					if var_333_6.name == "" or not string.find(var_333_6.name, "split") then
						var_333_6.gameObject:SetActive(true)
					else
						var_333_6.gameObject:SetActive(false)
					end
				end
			end

			local var_333_7 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				var_333_5.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_330_1.time_ - 0) / var_333_7)
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				var_333_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_333_8 = 0
			local var_333_9 = 0.2

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_8 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_10 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(938081080).content)

				arg_330_1.text_.text = var_333_10

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_12 = 8 <= 0 and var_333_9 or var_333_9 * (utf8.len(var_333_10) / 8)

				if (8 <= 0 and var_333_9 or var_333_9 * (utf8.len(var_333_10) / 8)) > 0 and var_333_9 < var_333_12 then
					arg_330_1.talkMaxDuration = var_333_12

					if var_333_12 + var_333_8 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_8
					end
				end

				arg_330_1.text_.text = var_333_10
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_9, arg_330_1.talkMaxDuration)

			if var_333_8 <= arg_330_1.time_ and arg_330_1.time_ < var_333_8 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_8) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_8 + var_333_13 and arg_330_1.time_ < var_333_8 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play938081081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 938081081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play938081082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["108301"]) and arg_334_1.var_.actorSpriteComps108301 == nil then
				arg_334_1.var_.actorSpriteComps108301 = arg_334_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["108301"]) then
				if arg_334_1.var_.actorSpriteComps108301 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 1, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["108301"]) and arg_334_1.var_.actorSpriteComps108301 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps108301 = nil
			end

			local var_337_2 = arg_334_1.actors_["128404"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps128404 == nil then
				arg_334_1.var_.actorSpriteComps128404 = var_337_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_3 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_3 and not isNil(var_337_2) then
				if arg_334_1.var_.actorSpriteComps128404 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								iter_337_5.color = Color.New(Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_3), Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_3), (Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_3)))
							else
								local var_337_4 = Mathf.Lerp(iter_337_5.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_3)

								iter_337_5.color = Color.New(var_337_4, var_337_4, var_337_4)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_3 and arg_334_1.time_ < 0 + var_337_3 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps128404 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_337_7 then
						iter_337_7.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps128404 = nil
			end

			local var_337_5 = arg_334_1.actors_["108301"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos108301 = var_337_5.localPosition
				var_337_5.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("108301", 2)

				for iter_337_8 = 0, var_337_5.childCount - 1 do
					local var_337_6 = var_337_5:GetChild(iter_337_8)

					if var_337_6.name == "split_5" or not string.find(var_337_6.name, "split") then
						var_337_6.gameObject:SetActive(true)
					else
						var_337_6.gameObject:SetActive(false)
					end
				end
			end

			local var_337_7 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				var_337_5.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_334_1.time_ - 0) / var_337_7)
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				var_337_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_337_8 = arg_334_1.actors_["10183"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10183 = var_337_8.localPosition
				var_337_8.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10183", 7)

				for iter_337_9 = 0, var_337_8.childCount - 1 do
					local var_337_9 = var_337_8:GetChild(iter_337_9)

					if var_337_9.name == "" or not string.find(var_337_9.name, "split") then
						var_337_9.gameObject:SetActive(true)
					else
						var_337_9.gameObject:SetActive(false)
					end
				end
			end

			local var_337_10 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_10 then
				var_337_8.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_334_1.time_ - 0) / var_337_10)
			end

			if arg_334_1.time_ >= 0 + var_337_10 and arg_334_1.time_ < 0 + var_337_10 + arg_337_0 then
				var_337_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_337_11 = 0
			local var_337_12 = 0.2

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_11 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_13 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(938081081).content)

				arg_334_1.text_.text = var_337_13

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_15 = 8 <= 0 and var_337_12 or var_337_12 * (utf8.len(var_337_13) / 8)

				if (8 <= 0 and var_337_12 or var_337_12 * (utf8.len(var_337_13) / 8)) > 0 and var_337_12 < var_337_15 then
					arg_334_1.talkMaxDuration = var_337_15

					if var_337_15 + var_337_11 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_15 + var_337_11
					end
				end

				arg_334_1.text_.text = var_337_13
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_12, arg_334_1.talkMaxDuration)

			if var_337_11 <= arg_334_1.time_ and arg_334_1.time_ < var_337_11 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_11) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_11 + var_337_16 and arg_334_1.time_ < var_337_11 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play938081082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938081082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938081083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["106603"]) and arg_338_1.var_.actorSpriteComps106603 == nil then
				arg_338_1.var_.actorSpriteComps106603 = arg_338_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["106603"]) then
				if arg_338_1.var_.actorSpriteComps106603 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["106603"]) and arg_338_1.var_.actorSpriteComps106603 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps106603 = nil
			end

			local var_341_2 = arg_338_1.actors_["108301"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.actorSpriteComps108301 == nil then
				arg_338_1.var_.actorSpriteComps108301 = var_341_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_3 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_3 and not isNil(var_341_2) then
				if arg_338_1.var_.actorSpriteComps108301 then
					for iter_341_4, iter_341_5 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_341_5 then
							if arg_338_1.isInRecall_ then
								iter_341_5.color = Color.New(Mathf.Lerp(iter_341_5.color.r, arg_338_1.hightColor2.r, (arg_338_1.time_ - 0) / var_341_3), Mathf.Lerp(iter_341_5.color.g, arg_338_1.hightColor2.g, (arg_338_1.time_ - 0) / var_341_3), (Mathf.Lerp(iter_341_5.color.b, arg_338_1.hightColor2.b, (arg_338_1.time_ - 0) / var_341_3)))
							else
								local var_341_4 = Mathf.Lerp(iter_341_5.color.r, 0.5, (arg_338_1.time_ - 0) / var_341_3)

								iter_341_5.color = Color.New(var_341_4, var_341_4, var_341_4)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_3 and arg_338_1.time_ < 0 + var_341_3 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.actorSpriteComps108301 then
				for iter_341_6, iter_341_7 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_341_7 then
						iter_341_7.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_338_1.var_.actorSpriteComps108301 = nil
			end

			local var_341_5 = arg_338_1.actors_["106603"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos106603 = var_341_5.localPosition
				var_341_5.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("106603", 4)

				for iter_341_8 = 0, var_341_5.childCount - 1 do
					local var_341_6 = var_341_5:GetChild(iter_341_8)

					if var_341_6.name == "split_4" or not string.find(var_341_6.name, "split") then
						var_341_6.gameObject:SetActive(true)
					else
						var_341_6.gameObject:SetActive(false)
					end
				end
			end

			local var_341_7 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				var_341_5.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_338_1.time_ - 0) / var_341_7)
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				var_341_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_341_8 = arg_338_1.actors_["128404"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos128404 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("128404", 7)

				for iter_341_9 = 0, var_341_8.childCount - 1 do
					local var_341_9 = var_341_8:GetChild(iter_341_9)

					if var_341_9.name == "" or not string.find(var_341_9.name, "split") then
						var_341_9.gameObject:SetActive(true)
					else
						var_341_9.gameObject:SetActive(false)
					end
				end
			end

			local var_341_10 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_10 then
				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_10)
			end

			if arg_338_1.time_ >= 0 + var_341_10 and arg_338_1.time_ < 0 + var_341_10 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_11 = 0
			local var_341_12 = 0.275

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_11 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_13 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(938081082).content)

				arg_338_1.text_.text = var_341_13

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_15 = 11 <= 0 and var_341_12 or var_341_12 * (utf8.len(var_341_13) / 11)

				if (11 <= 0 and var_341_12 or var_341_12 * (utf8.len(var_341_13) / 11)) > 0 and var_341_12 < var_341_15 then
					arg_338_1.talkMaxDuration = var_341_15

					if var_341_15 + var_341_11 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_15 + var_341_11
					end
				end

				arg_338_1.text_.text = var_341_13
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_12, arg_338_1.talkMaxDuration)

			if var_341_11 <= arg_338_1.time_ and arg_338_1.time_ < var_341_11 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_11) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_11 + var_341_16 and arg_338_1.time_ < var_341_11 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play938081083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938081083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play938081084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10183"]) and arg_342_1.var_.actorSpriteComps10183 == nil then
				arg_342_1.var_.actorSpriteComps10183 = arg_342_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10183"]) then
				if arg_342_1.var_.actorSpriteComps10183 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 1, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10183"]) and arg_342_1.var_.actorSpriteComps10183 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_342_1.var_.actorSpriteComps10183 = nil
			end

			local var_345_2 = arg_342_1.actors_["106603"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps106603 == nil then
				arg_342_1.var_.actorSpriteComps106603 = var_345_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_3 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 and not isNil(var_345_2) then
				if arg_342_1.var_.actorSpriteComps106603 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								iter_345_5.color = Color.New(Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_3), Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_3), (Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_3)))
							else
								local var_345_4 = Mathf.Lerp(iter_345_5.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_3)

								iter_345_5.color = Color.New(var_345_4, var_345_4, var_345_4)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps106603 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_345_7 then
						iter_345_7.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps106603 = nil
			end

			local var_345_5 = arg_342_1.actors_["10183"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10183 = var_345_5.localPosition
				var_345_5.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10183", 2)

				for iter_345_8 = 0, var_345_5.childCount - 1 do
					local var_345_6 = var_345_5:GetChild(iter_345_8)

					if var_345_6.name == "split_2" or not string.find(var_345_6.name, "split") then
						var_345_6.gameObject:SetActive(true)
					else
						var_345_6.gameObject:SetActive(false)
					end
				end
			end

			local var_345_7 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				var_345_5.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_342_1.time_ - 0) / var_345_7)
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				var_345_5.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_345_8 = arg_342_1.actors_["108301"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos108301 = var_345_8.localPosition
				var_345_8.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("108301", 7)

				for iter_345_9 = 0, var_345_8.childCount - 1 do
					local var_345_9 = var_345_8:GetChild(iter_345_9)

					if var_345_9.name == "" or not string.find(var_345_9.name, "split") then
						var_345_9.gameObject:SetActive(true)
					else
						var_345_9.gameObject:SetActive(false)
					end
				end
			end

			local var_345_10 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_10 then
				var_345_8.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_342_1.time_ - 0) / var_345_10)
			end

			if arg_342_1.time_ >= 0 + var_345_10 and arg_342_1.time_ < 0 + var_345_10 + arg_345_0 then
				var_345_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_345_11 = 0
			local var_345_12 = 0.4

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_11 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_13 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(938081083).content)

				arg_342_1.text_.text = var_345_13

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_15 = 16 <= 0 and var_345_12 or var_345_12 * (utf8.len(var_345_13) / 16)

				if (16 <= 0 and var_345_12 or var_345_12 * (utf8.len(var_345_13) / 16)) > 0 and var_345_12 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_11 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_11
					end
				end

				arg_342_1.text_.text = var_345_13
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_12, arg_342_1.talkMaxDuration)

			if var_345_11 <= arg_342_1.time_ and arg_342_1.time_ < var_345_11 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_11) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_11 + var_345_16 and arg_342_1.time_ < var_345_11 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play938081084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 938081084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play938081085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10183"]) and arg_346_1.var_.actorSpriteComps10183 == nil then
				arg_346_1.var_.actorSpriteComps10183 = arg_346_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10183"]) then
				if arg_346_1.var_.actorSpriteComps10183 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor2.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor2.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor2.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 0.5, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10183"]) and arg_346_1.var_.actorSpriteComps10183 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_346_1.var_.actorSpriteComps10183 = nil
			end

			local var_349_2 = arg_346_1.actors_["10183"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10183 = var_349_2.localPosition
				var_349_2.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10183", 7)

				for iter_349_4 = 0, var_349_2.childCount - 1 do
					local var_349_3 = var_349_2:GetChild(iter_349_4)

					if var_349_3.name == "" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_346_1.time_ - 0) / var_349_4)
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_5 = arg_346_1.actors_["106603"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos106603 = var_349_5.localPosition
				var_349_5.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("106603", 7)

				for iter_349_5 = 0, var_349_5.childCount - 1 do
					local var_349_6 = var_349_5:GetChild(iter_349_5)

					if var_349_6.name == "" or not string.find(var_349_6.name, "split") then
						var_349_6.gameObject:SetActive(true)
					else
						var_349_6.gameObject:SetActive(false)
					end
				end
			end

			local var_349_7 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				var_349_5.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_346_1.time_ - 0) / var_349_7)
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				var_349_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_8 = 0
			local var_349_9 = 1.075

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_10 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(938081084).content)

				arg_346_1.text_.text = var_349_10

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_12 = 43 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_10) / 43)

				if (43 <= 0 and var_349_9 or var_349_9 * (utf8.len(var_349_10) / 43)) > 0 and var_349_9 < var_349_12 then
					arg_346_1.talkMaxDuration = var_349_12

					if var_349_12 + var_349_8 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_8
					end
				end

				arg_346_1.text_.text = var_349_10
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_9, arg_346_1.talkMaxDuration)

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_8) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_8 + var_349_13 and arg_346_1.time_ < var_349_8 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play938081085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 938081085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play938081086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["106603"]) and arg_350_1.var_.actorSpriteComps106603 == nil then
				arg_350_1.var_.actorSpriteComps106603 = arg_350_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["106603"]) then
				if arg_350_1.var_.actorSpriteComps106603 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["106603"]) and arg_350_1.var_.actorSpriteComps106603 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps106603 = nil
			end

			local var_353_2 = arg_350_1.actors_["106603"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos106603 = var_353_2.localPosition
				var_353_2.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("106603", 2)

				for iter_353_4 = 0, var_353_2.childCount - 1 do
					local var_353_3 = var_353_2:GetChild(iter_353_4)

					if var_353_3.name == "split_4" or not string.find(var_353_3.name, "split") then
						var_353_3.gameObject:SetActive(true)
					else
						var_353_3.gameObject:SetActive(false)
					end
				end
			end

			local var_353_4 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_2.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_350_1.time_ - 0) / var_353_4)
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_2.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_353_5 = 0
			local var_353_6 = 0.575

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(938081085).content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 23 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_7) / 23)

				if (23 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_7) / 23)) > 0 and var_353_6 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_10 and arg_350_1.time_ < var_353_5 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play938081086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 938081086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play938081087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["106603"]) and arg_354_1.var_.actorSpriteComps106603 == nil then
				arg_354_1.var_.actorSpriteComps106603 = arg_354_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["106603"]) then
				if arg_354_1.var_.actorSpriteComps106603 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								iter_357_1.color = Color.New(Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, (arg_354_1.time_ - 0) / var_357_0), Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, (arg_354_1.time_ - 0) / var_357_0), (Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, (arg_354_1.time_ - 0) / var_357_0)))
							else
								local var_357_1 = Mathf.Lerp(iter_357_1.color.r, 0.5, (arg_354_1.time_ - 0) / var_357_0)

								iter_357_1.color = Color.New(var_357_1, var_357_1, var_357_1)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["106603"]) and arg_354_1.var_.actorSpriteComps106603 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_354_1.var_.actorSpriteComps106603 = nil
			end

			local var_357_2 = 0
			local var_357_3 = 0.65

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_4 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(938081086).content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_6 = 26 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_4) / 26)

				if (26 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_4) / 26)) > 0 and var_357_3 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_7 and arg_354_1.time_ < var_357_2 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play938081087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 938081087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play938081088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["10183"]) and arg_358_1.var_.actorSpriteComps10183 == nil then
				arg_358_1.var_.actorSpriteComps10183 = arg_358_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["10183"]) then
				if arg_358_1.var_.actorSpriteComps10183 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 1, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["10183"]) and arg_358_1.var_.actorSpriteComps10183 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps10183 = nil
			end

			local var_361_2 = arg_358_1.actors_["10183"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10183 = var_361_2.localPosition
				var_361_2.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10183", 4)

				for iter_361_4 = 0, var_361_2.childCount - 1 do
					local var_361_3 = var_361_2:GetChild(iter_361_4)

					if var_361_3.name == "split_1" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_2.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10183, Vector3.New(300, -475, -325), (arg_358_1.time_ - 0) / var_361_4)
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_2.localPosition = Vector3.New(300, -475, -325)
			end

			local var_361_5 = 0
			local var_361_6 = 0.725

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(938081087).content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 29 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 29)

				if (29 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 29)) > 0 and var_361_6 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_10 and arg_358_1.time_ < var_361_5 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play938081088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 938081088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play938081089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos10183 = arg_362_1.actors_["10183"].transform.localPosition
				arg_362_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10183", 4)

				for iter_365_0 = 0, arg_362_1.actors_["10183"].transform.childCount - 1 do
					local var_365_0 = arg_362_1.actors_["10183"].transform:GetChild(iter_365_0)

					if var_365_0.name == "" or not string.find(var_365_0.name, "split") then
						var_365_0.gameObject:SetActive(true)
					else
						var_365_0.gameObject:SetActive(false)
					end
				end
			end

			local var_365_1 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_1 then
				arg_362_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10183, Vector3.New(300, -475, -325), (arg_362_1.time_ - 0) / var_365_1)
			end

			if arg_362_1.time_ >= 0 + var_365_1 and arg_362_1.time_ < 0 + var_365_1 + arg_365_0 then
				arg_362_1.actors_["10183"].transform.localPosition = Vector3.New(300, -475, -325)
			end

			local var_365_2 = 0
			local var_365_3 = 1.175

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(938081088).content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_6 = 47 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_4) / 47)

				if (47 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_4) / 47)) > 0 and var_365_3 < var_365_6 then
					arg_362_1.talkMaxDuration = var_365_6

					if var_365_6 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_3, arg_362_1.talkMaxDuration)

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_2) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_2 + var_365_7 and arg_362_1.time_ < var_365_2 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play938081089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 938081089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play938081090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10183"]) and arg_366_1.var_.actorSpriteComps10183 == nil then
				arg_366_1.var_.actorSpriteComps10183 = arg_366_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10183"]) then
				if arg_366_1.var_.actorSpriteComps10183 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10183"]) and arg_366_1.var_.actorSpriteComps10183 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps10183 = nil
			end

			local var_369_2 = arg_366_1.actors_["10183"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10183 = var_369_2.localPosition
				var_369_2.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10183", 7)

				for iter_369_4 = 0, var_369_2.childCount - 1 do
					local var_369_3 = var_369_2:GetChild(iter_369_4)

					if var_369_3.name == "" or not string.find(var_369_3.name, "split") then
						var_369_3.gameObject:SetActive(true)
					else
						var_369_3.gameObject:SetActive(false)
					end
				end
			end

			local var_369_4 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				var_369_2.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_366_1.time_ - 0) / var_369_4)
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				var_369_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_5 = arg_366_1.actors_["106603"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos106603 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("106603", 7)

				for iter_369_5 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_5)

					if var_369_6.name == "" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_8 = 0
			local var_369_9 = 1.15

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(938081089).content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_12 = 46 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_10) / 46)

				if (46 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_10) / 46)) > 0 and var_369_9 < var_369_12 then
					arg_366_1.talkMaxDuration = var_369_12

					if var_369_12 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_12 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_13 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_13 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_13

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_13 and arg_366_1.time_ < var_369_8 + var_369_13 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play938081090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 938081090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play938081091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10183"]) and arg_370_1.var_.actorSpriteComps10183 == nil then
				arg_370_1.var_.actorSpriteComps10183 = arg_370_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10183"]) then
				if arg_370_1.var_.actorSpriteComps10183 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10183"]) and arg_370_1.var_.actorSpriteComps10183 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps10183 = nil
			end

			local var_373_2 = arg_370_1.actors_["10183"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos10183 = var_373_2.localPosition
				var_373_2.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10183", 3)

				for iter_373_4 = 0, var_373_2.childCount - 1 do
					local var_373_3 = var_373_2:GetChild(iter_373_4)

					if var_373_3.name == "split_8" or not string.find(var_373_3.name, "split") then
						var_373_3.gameObject:SetActive(true)
					else
						var_373_3.gameObject:SetActive(false)
					end
				end
			end

			local var_373_4 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				var_373_2.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_370_1.time_ - 0) / var_373_4)
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				var_373_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_373_5 = 0
			local var_373_6 = 0.7

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_7 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(938081090).content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 28 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_7) / 28)

				if (28 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_7) / 28)) > 0 and var_373_6 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_5
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_6, arg_370_1.talkMaxDuration)

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_5) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_5 + var_373_10 and arg_370_1.time_ < var_373_5 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play938081091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 938081091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play938081092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10183"]) and arg_374_1.var_.actorSpriteComps10183 == nil then
				arg_374_1.var_.actorSpriteComps10183 = arg_374_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10183"]) then
				if arg_374_1.var_.actorSpriteComps10183 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10183"]) and arg_374_1.var_.actorSpriteComps10183 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps10183 = nil
			end

			local var_377_2 = manager.ui.mainCamera.transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.shakeOldPos = var_377_2.localPosition
			end

			local var_377_3 = 0.5

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 then
				local var_377_4, var_377_5 = math.modf((arg_374_1.time_ - 0) / 0.066)

				var_377_2.localPosition = Vector3.New(var_377_5 * 0.13, var_377_5 * 0.13, var_377_5 * 0.13) + arg_374_1.var_.shakeOldPos
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 then
				var_377_2.localPosition = arg_374_1.var_.shakeOldPos
			end

			local var_377_6 = 0

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			if arg_374_1.time_ >= var_377_6 + 0.5 and arg_374_1.time_ < var_377_6 + 0.5 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_7 = 0
			local var_377_8 = 0.075

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_7 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1565].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_9 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(938081091).content)

				arg_374_1.text_.text = var_377_9

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_11 = 3 <= 0 and var_377_8 or var_377_8 * (utf8.len(var_377_9) / 3)

				if (3 <= 0 and var_377_8 or var_377_8 * (utf8.len(var_377_9) / 3)) > 0 and var_377_8 < var_377_11 then
					arg_374_1.talkMaxDuration = var_377_11

					if var_377_11 + var_377_7 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_11 + var_377_7
					end
				end

				arg_374_1.text_.text = var_377_9
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_8, arg_374_1.talkMaxDuration)

			if var_377_7 <= arg_374_1.time_ and arg_374_1.time_ < var_377_7 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_7) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_7 + var_377_12 and arg_374_1.time_ < var_377_7 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play938081092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 938081092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play938081093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["128404"]) and arg_378_1.var_.actorSpriteComps128404 == nil then
				arg_378_1.var_.actorSpriteComps128404 = arg_378_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_0 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["128404"]) then
				if arg_378_1.var_.actorSpriteComps128404 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								iter_381_1.color = Color.New(Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor1.r, (arg_378_1.time_ - 0) / var_381_0), Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor1.g, (arg_378_1.time_ - 0) / var_381_0), (Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor1.b, (arg_378_1.time_ - 0) / var_381_0)))
							else
								local var_381_1 = Mathf.Lerp(iter_381_1.color.r, 1, (arg_378_1.time_ - 0) / var_381_0)

								iter_381_1.color = Color.New(var_381_1, var_381_1, var_381_1)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["128404"]) and arg_378_1.var_.actorSpriteComps128404 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_381_3 then
						iter_381_3.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_378_1.var_.actorSpriteComps128404 = nil
			end

			local var_381_2 = arg_378_1.actors_["10183"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos10183 = var_381_2.localPosition
				var_381_2.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10183", 7)

				for iter_381_4 = 0, var_381_2.childCount - 1 do
					local var_381_3 = var_381_2:GetChild(iter_381_4)

					if var_381_3.name == "split_2" or not string.find(var_381_3.name, "split") then
						var_381_3.gameObject:SetActive(true)
					else
						var_381_3.gameObject:SetActive(false)
					end
				end
			end

			local var_381_4 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				var_381_2.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_378_1.time_ - 0) / var_381_4)
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				var_381_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_381_5 = arg_378_1.actors_["128404"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos128404 = var_381_5.localPosition
				var_381_5.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("128404", 2)

				for iter_381_5 = 0, var_381_5.childCount - 1 do
					local var_381_6 = var_381_5:GetChild(iter_381_5)

					if var_381_6.name == "" or not string.find(var_381_6.name, "split") then
						var_381_6.gameObject:SetActive(true)
					else
						var_381_6.gameObject:SetActive(false)
					end
				end
			end

			local var_381_7 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				var_381_5.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_378_1.time_ - 0) / var_381_7)
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				var_381_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_381_8 = 0
			local var_381_9 = 0.45

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_10 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(938081092).content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_12 = 18 <= 0 and var_381_9 or var_381_9 * (utf8.len(var_381_10) / 18)

				if (18 <= 0 and var_381_9 or var_381_9 * (utf8.len(var_381_10) / 18)) > 0 and var_381_9 < var_381_12 then
					arg_378_1.talkMaxDuration = var_381_12

					if var_381_12 + var_381_8 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_8
					end
				end

				arg_378_1.text_.text = var_381_10
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_13 = math.max(var_381_9, arg_378_1.talkMaxDuration)

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_13 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_8) / var_381_13

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_8 + var_381_13 and arg_378_1.time_ < var_381_8 + var_381_13 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play938081093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 938081093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play938081094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["106603"]) and arg_382_1.var_.actorSpriteComps106603 == nil then
				arg_382_1.var_.actorSpriteComps106603 = arg_382_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["106603"]) then
				if arg_382_1.var_.actorSpriteComps106603 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								iter_385_1.color = Color.New(Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, (arg_382_1.time_ - 0) / var_385_0), Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, (arg_382_1.time_ - 0) / var_385_0), (Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, (arg_382_1.time_ - 0) / var_385_0)))
							else
								local var_385_1 = Mathf.Lerp(iter_385_1.color.r, 1, (arg_382_1.time_ - 0) / var_385_0)

								iter_385_1.color = Color.New(var_385_1, var_385_1, var_385_1)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["106603"]) and arg_382_1.var_.actorSpriteComps106603 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps106603 = nil
			end

			local var_385_2 = arg_382_1.actors_["128404"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps128404 == nil then
				arg_382_1.var_.actorSpriteComps128404 = var_385_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_3 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.actorSpriteComps128404 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								iter_385_5.color = Color.New(Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, (arg_382_1.time_ - 0) / var_385_3), Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, (arg_382_1.time_ - 0) / var_385_3), (Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, (arg_382_1.time_ - 0) / var_385_3)))
							else
								local var_385_4 = Mathf.Lerp(iter_385_5.color.r, 0.5, (arg_382_1.time_ - 0) / var_385_3)

								iter_385_5.color = Color.New(var_385_4, var_385_4, var_385_4)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps128404 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_385_7 then
						iter_385_7.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_382_1.var_.actorSpriteComps128404 = nil
			end

			local var_385_5 = arg_382_1.actors_["106603"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos106603 = var_385_5.localPosition
				var_385_5.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("106603", 4)

				for iter_385_8 = 0, var_385_5.childCount - 1 do
					local var_385_6 = var_385_5:GetChild(iter_385_8)

					if var_385_6.name == "split_5" or not string.find(var_385_6.name, "split") then
						var_385_6.gameObject:SetActive(true)
					else
						var_385_6.gameObject:SetActive(false)
					end
				end
			end

			local var_385_7 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				var_385_5.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_382_1.time_ - 0) / var_385_7)
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				var_385_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_385_8 = 0
			local var_385_9 = 0.25

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_8 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_10 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(938081093).content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_12 = 10 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_10) / 10)

				if (10 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_10) / 10)) > 0 and var_385_9 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_8
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_9, arg_382_1.talkMaxDuration)

			if var_385_8 <= arg_382_1.time_ and arg_382_1.time_ < var_385_8 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_8) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_8 + var_385_13 and arg_382_1.time_ < var_385_8 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play938081094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 938081094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play938081095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["106603"]) and arg_386_1.var_.actorSpriteComps106603 == nil then
				arg_386_1.var_.actorSpriteComps106603 = arg_386_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_0 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["106603"]) then
				if arg_386_1.var_.actorSpriteComps106603 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								iter_389_1.color = Color.New(Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, (arg_386_1.time_ - 0) / var_389_0), Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, (arg_386_1.time_ - 0) / var_389_0), (Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, (arg_386_1.time_ - 0) / var_389_0)))
							else
								local var_389_1 = Mathf.Lerp(iter_389_1.color.r, 0.5, (arg_386_1.time_ - 0) / var_389_0)

								iter_389_1.color = Color.New(var_389_1, var_389_1, var_389_1)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["106603"]) and arg_386_1.var_.actorSpriteComps106603 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_389_3 then
						iter_389_3.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_386_1.var_.actorSpriteComps106603 = nil
			end

			local var_389_2 = 0
			local var_389_3 = 0.7

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_4 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(938081094).content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_6 = 28 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_4) / 28)

				if (28 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_4) / 28)) > 0 and var_389_3 < var_389_6 then
					arg_386_1.talkMaxDuration = var_389_6

					if var_389_6 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_7 and arg_386_1.time_ < var_389_2 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play938081095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 938081095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play938081096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10183"]) and arg_390_1.var_.actorSpriteComps10183 == nil then
				arg_390_1.var_.actorSpriteComps10183 = arg_390_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10183"]) then
				if arg_390_1.var_.actorSpriteComps10183 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								iter_393_1.color = Color.New(Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_0), Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_0), (Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_0)))
							else
								local var_393_1 = Mathf.Lerp(iter_393_1.color.r, 1, (arg_390_1.time_ - 0) / var_393_0)

								iter_393_1.color = Color.New(var_393_1, var_393_1, var_393_1)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10183"]) and arg_390_1.var_.actorSpriteComps10183 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps10183 = nil
			end

			local var_393_2 = arg_390_1.actors_["106603"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos106603 = var_393_2.localPosition
				var_393_2.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("106603", 7)

				for iter_393_4 = 0, var_393_2.childCount - 1 do
					local var_393_3 = var_393_2:GetChild(iter_393_4)

					if var_393_3.name == "" or not string.find(var_393_3.name, "split") then
						var_393_3.gameObject:SetActive(true)
					else
						var_393_3.gameObject:SetActive(false)
					end
				end
			end

			local var_393_4 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				var_393_2.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_390_1.time_ - 0) / var_393_4)
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				var_393_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_393_5 = arg_390_1.actors_["10183"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos10183 = var_393_5.localPosition
				var_393_5.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10183", 3)

				for iter_393_5 = 0, var_393_5.childCount - 1 do
					local var_393_6 = var_393_5:GetChild(iter_393_5)

					if var_393_6.name == "split_8" or not string.find(var_393_6.name, "split") then
						var_393_6.gameObject:SetActive(true)
					else
						var_393_6.gameObject:SetActive(false)
					end
				end
			end

			local var_393_7 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				var_393_5.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_390_1.time_ - 0) / var_393_7)
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				var_393_5.localPosition = Vector3.New(0, -475, -325)
			end

			local var_393_8 = arg_390_1.actors_["128404"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos128404 = var_393_8.localPosition
				var_393_8.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("128404", 7)

				for iter_393_6 = 0, var_393_8.childCount - 1 do
					local var_393_9 = var_393_8:GetChild(iter_393_6)

					if var_393_9.name == "" or not string.find(var_393_9.name, "split") then
						var_393_9.gameObject:SetActive(true)
					else
						var_393_9.gameObject:SetActive(false)
					end
				end
			end

			local var_393_10 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_10 then
				var_393_8.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_390_1.time_ - 0) / var_393_10)
			end

			if arg_390_1.time_ >= 0 + var_393_10 and arg_390_1.time_ < 0 + var_393_10 + arg_393_0 then
				var_393_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_393_11 = 0
			local var_393_12 = 0.775

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_11 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_13 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(938081095).content)

				arg_390_1.text_.text = var_393_13

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_15 = 31 <= 0 and var_393_12 or var_393_12 * (utf8.len(var_393_13) / 31)

				if (31 <= 0 and var_393_12 or var_393_12 * (utf8.len(var_393_13) / 31)) > 0 and var_393_12 < var_393_15 then
					arg_390_1.talkMaxDuration = var_393_15

					if var_393_15 + var_393_11 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_15 + var_393_11
					end
				end

				arg_390_1.text_.text = var_393_13
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_16 = math.max(var_393_12, arg_390_1.talkMaxDuration)

			if var_393_11 <= arg_390_1.time_ and arg_390_1.time_ < var_393_11 + var_393_16 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_11) / var_393_16

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_11 + var_393_16 and arg_390_1.time_ < var_393_11 + var_393_16 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play938081096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 938081096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play938081097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10183 = arg_394_1.actors_["10183"].transform.localPosition
				arg_394_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10183", 3)

				for iter_397_0 = 0, arg_394_1.actors_["10183"].transform.childCount - 1 do
					local var_397_0 = arg_394_1.actors_["10183"].transform:GetChild(iter_397_0)

					if var_397_0.name == "split_1" then
						var_397_0:SetAsLastSibling()
						var_397_0.gameObject:SetActive(true)

						arg_394_1.var_.actorSpriteSplit10183 = var_397_0.gameObject:GetComponent(typeof(Image))

						arg_394_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_397_1 = 0.5

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_1 then
				arg_394_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_394_1.time_ - 0) / var_397_1)

				if arg_394_1.var_.actorSpriteSplit10183 ~= nil then
					arg_394_1.var_.actorSpriteSplit10183:SetAlpha((arg_394_1.time_ - 0) / var_397_1)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_1 and arg_394_1.time_ < 0 + var_397_1 + arg_397_0 then
				arg_394_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_394_1.var_.actorSpriteSplit10183 ~= nil then
					arg_394_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_397_2 = 0
			local var_397_3 = 0.95

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_4 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(938081096).content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_6 = 38 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_4) / 38)

				if (38 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_4) / 38)) > 0 and var_397_3 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_7 and arg_394_1.time_ < var_397_2 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play938081097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 938081097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play938081098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos10183 = arg_398_1.actors_["10183"].transform.localPosition
				arg_398_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("10183", 3)

				for iter_401_0 = 0, arg_398_1.actors_["10183"].transform.childCount - 1 do
					local var_401_0 = arg_398_1.actors_["10183"].transform:GetChild(iter_401_0)

					if var_401_0.name == "split_8" then
						var_401_0:SetAsLastSibling()
						var_401_0.gameObject:SetActive(true)

						arg_398_1.var_.actorSpriteSplit10183 = var_401_0.gameObject:GetComponent(typeof(Image))

						arg_398_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_401_1 = 0.5

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_1 then
				arg_398_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_398_1.time_ - 0) / var_401_1)

				if arg_398_1.var_.actorSpriteSplit10183 ~= nil then
					arg_398_1.var_.actorSpriteSplit10183:SetAlpha((arg_398_1.time_ - 0) / var_401_1)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_1 and arg_398_1.time_ < 0 + var_401_1 + arg_401_0 then
				arg_398_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_398_1.var_.actorSpriteSplit10183 ~= nil then
					arg_398_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_401_2 = 0
			local var_401_3 = 0.325

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_4 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(938081097).content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_6 = 13 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_4) / 13)

				if (13 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_4) / 13)) > 0 and var_401_3 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_7 and arg_398_1.time_ < var_401_2 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play938081098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 938081098
		arg_402_1.duration_ = 1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"

			SetActive(arg_402_1.choicesGo_, true)

			for iter_403_0, iter_403_1 in ipairs(arg_402_1.choices_) do
				SetActive(iter_403_1.go, iter_403_0 <= 1)
			end

			arg_402_1.choices_[1].txt.text = arg_402_1:FormatText(StoryChoiceCfg[1792].name)
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play938081099(arg_402_1)
			end

			arg_402_1:RecordChoiceLog(938081098, 1792)
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10183"]) and arg_402_1.var_.actorSpriteComps10183 == nil then
				arg_402_1.var_.actorSpriteComps10183 = arg_402_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10183"]) then
				if arg_402_1.var_.actorSpriteComps10183 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor2.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor2.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor2.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 0.5, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10183"]) and arg_402_1.var_.actorSpriteComps10183 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_402_1.var_.actorSpriteComps10183 = nil
			end

			local var_405_2 = 0

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.allBtn_.enabled = false
			end

			if arg_402_1.time_ >= var_405_2 + 0.6 and arg_402_1.time_ < var_405_2 + 0.6 + arg_405_0 then
				arg_402_1.allBtn_.enabled = true
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play938081099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 938081099
		arg_406_1.duration_ = 9

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play938081100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 2 < arg_406_1.time_ and arg_406_1.time_ <= 2 + arg_409_0 then
				local var_409_0 = arg_406_1.bgs_.H02a

				arg_406_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_409_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_1 = var_409_0:GetComponent("SpriteRenderer")

				if var_409_1 and var_409_1.sprite then
					local var_409_2 = 2 * (var_409_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_409_0.transform.localScale = Vector3.New(var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "H02a" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_3 = 4

			if 4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_3 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			if arg_406_1.time_ >= var_409_3 + 0.3 and arg_406_1.time_ < var_409_3 + 0.3 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_4 = 0

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_5 = 2

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_5 then
				local var_409_6 = Color.New(0, 0, 0)

				var_409_6.a = Mathf.Lerp(0, 1, (arg_406_1.time_ - var_409_4) / var_409_5)
				arg_406_1.mask_.color = var_409_6
			end

			if arg_406_1.time_ >= var_409_4 + var_409_5 and arg_406_1.time_ < var_409_4 + var_409_5 + arg_409_0 then
				local var_409_7 = Color.New(0, 0, 0)

				var_409_7.a = 1
				arg_406_1.mask_.color = var_409_7
			end

			local var_409_8 = 2

			if 2 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_9 = 2

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_9 then
				local var_409_10 = Color.New(0, 0, 0)

				var_409_10.a = Mathf.Lerp(1, 0, (arg_406_1.time_ - var_409_8) / var_409_9)
				arg_406_1.mask_.color = var_409_10
			end

			if arg_406_1.time_ >= var_409_8 + var_409_9 and arg_406_1.time_ < var_409_8 + var_409_9 + arg_409_0 then
				local var_409_11 = Color.New(0, 0, 0)

				arg_406_1.mask_.enabled = false
				var_409_11.a = 0
				arg_406_1.mask_.color = var_409_11
			end

			local var_409_12 = arg_406_1.actors_["10183"].transform

			if 1.966 < arg_406_1.time_ and arg_406_1.time_ <= 1.966 + arg_409_0 then
				arg_406_1.var_.moveOldPos10183 = var_409_12.localPosition
				var_409_12.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10183", 7)

				for iter_409_2 = 0, var_409_12.childCount - 1 do
					local var_409_13 = var_409_12:GetChild(iter_409_2)

					if var_409_13.name == "" or not string.find(var_409_13.name, "split") then
						var_409_13.gameObject:SetActive(true)
					else
						var_409_13.gameObject:SetActive(false)
					end
				end
			end

			local var_409_14 = 0.001

			if 1.966 <= arg_406_1.time_ and arg_406_1.time_ < 1.966 + var_409_14 then
				var_409_12.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10183, Vector3.New(0, -2000, -360), (arg_406_1.time_ - 1.966) / var_409_14)
			end

			if arg_406_1.time_ >= 1.966 + var_409_14 and arg_406_1.time_ < 1.966 + var_409_14 + arg_409_0 then
				var_409_12.localPosition = Vector3.New(0, -2000, -360)
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_15 = 4
			local var_409_16 = 1.3

			if 4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_15 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_17 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_17:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_18 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(938081099).content)

				arg_406_1.text_.text = var_409_18

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_20 = 52 <= 0 and var_409_16 or var_409_16 * (utf8.len(var_409_18) / 52)

				if (52 <= 0 and var_409_16 or var_409_16 * (utf8.len(var_409_18) / 52)) > 0 and var_409_16 < var_409_20 then
					arg_406_1.talkMaxDuration = var_409_20
					var_409_15 = var_409_15 + 0.3

					if var_409_20 + var_409_15 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_20 + var_409_15
					end
				end

				arg_406_1.text_.text = var_409_18
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_21 = var_409_15 + 0.3
			local var_409_22 = math.max(var_409_16, arg_406_1.talkMaxDuration)

			if var_409_15 + 0.3 <= arg_406_1.time_ and arg_406_1.time_ < var_409_21 + var_409_22 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_21) / var_409_22

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_21 + var_409_22 and arg_406_1.time_ < var_409_21 + var_409_22 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play938081100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 938081100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play938081101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["10183"]) and arg_412_1.var_.actorSpriteComps10183 == nil then
				arg_412_1.var_.actorSpriteComps10183 = arg_412_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_0 = 0.2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["10183"]) then
				if arg_412_1.var_.actorSpriteComps10183 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								iter_415_1.color = Color.New(Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor1.r, (arg_412_1.time_ - 0) / var_415_0), Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor1.g, (arg_412_1.time_ - 0) / var_415_0), (Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor1.b, (arg_412_1.time_ - 0) / var_415_0)))
							else
								local var_415_1 = Mathf.Lerp(iter_415_1.color.r, 1, (arg_412_1.time_ - 0) / var_415_0)

								iter_415_1.color = Color.New(var_415_1, var_415_1, var_415_1)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["10183"]) and arg_412_1.var_.actorSpriteComps10183 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_415_3 then
						iter_415_3.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps10183 = nil
			end

			local var_415_2 = arg_412_1.actors_["10183"].transform

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10183 = var_415_2.localPosition
				var_415_2.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10183", 3)

				for iter_415_4 = 0, var_415_2.childCount - 1 do
					local var_415_3 = var_415_2:GetChild(iter_415_4)

					if var_415_3.name == "split_1" or not string.find(var_415_3.name, "split") then
						var_415_3.gameObject:SetActive(true)
					else
						var_415_3.gameObject:SetActive(false)
					end
				end
			end

			local var_415_4 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				var_415_2.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_412_1.time_ - 0) / var_415_4)
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				var_415_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_415_5 = 0
			local var_415_6 = 0.475

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_7 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(938081100).content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 19 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_7) / 19)

				if (19 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_7) / 19)) > 0 and var_415_6 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_5
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_6, arg_412_1.talkMaxDuration)

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_5) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_5 + var_415_10 and arg_412_1.time_ < var_415_5 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play938081101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 938081101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play938081102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["10183"]) and arg_416_1.var_.actorSpriteComps10183 == nil then
				arg_416_1.var_.actorSpriteComps10183 = arg_416_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["10183"]) then
				if arg_416_1.var_.actorSpriteComps10183 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								iter_419_1.color = Color.New(Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, (arg_416_1.time_ - 0) / var_419_0), Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, (arg_416_1.time_ - 0) / var_419_0), (Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, (arg_416_1.time_ - 0) / var_419_0)))
							else
								local var_419_1 = Mathf.Lerp(iter_419_1.color.r, 0.5, (arg_416_1.time_ - 0) / var_419_0)

								iter_419_1.color = Color.New(var_419_1, var_419_1, var_419_1)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["10183"]) and arg_416_1.var_.actorSpriteComps10183 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_416_1.var_.actorSpriteComps10183 = nil
			end

			local var_419_2 = 0
			local var_419_3 = 0.35

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_2 + arg_419_0 then
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

				local var_419_4 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(938081101).content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_6 = 14 <= 0 and var_419_3 or var_419_3 * (utf8.len(var_419_4) / 14)

				if (14 <= 0 and var_419_3 or var_419_3 * (utf8.len(var_419_4) / 14)) > 0 and var_419_3 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_2 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_2
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_3, arg_416_1.talkMaxDuration)

			if var_419_2 <= arg_416_1.time_ and arg_416_1.time_ < var_419_2 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_2) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_2 + var_419_7 and arg_416_1.time_ < var_419_2 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play938081102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 938081102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play938081103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["10183"]) and arg_420_1.var_.actorSpriteComps10183 == nil then
				arg_420_1.var_.actorSpriteComps10183 = arg_420_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_0 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["10183"]) then
				if arg_420_1.var_.actorSpriteComps10183 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								iter_423_1.color = Color.New(Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor1.r, (arg_420_1.time_ - 0) / var_423_0), Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor1.g, (arg_420_1.time_ - 0) / var_423_0), (Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor1.b, (arg_420_1.time_ - 0) / var_423_0)))
							else
								local var_423_1 = Mathf.Lerp(iter_423_1.color.r, 1, (arg_420_1.time_ - 0) / var_423_0)

								iter_423_1.color = Color.New(var_423_1, var_423_1, var_423_1)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["10183"]) and arg_420_1.var_.actorSpriteComps10183 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_423_3 then
						iter_423_3.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_420_1.var_.actorSpriteComps10183 = nil
			end

			local var_423_2 = arg_420_1.actors_["10183"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos10183 = var_423_2.localPosition
				var_423_2.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10183", 3)

				for iter_423_4 = 0, var_423_2.childCount - 1 do
					local var_423_3 = var_423_2:GetChild(iter_423_4)

					if var_423_3.name == "split_1" or not string.find(var_423_3.name, "split") then
						var_423_3.gameObject:SetActive(true)
					else
						var_423_3.gameObject:SetActive(false)
					end
				end
			end

			local var_423_4 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				var_423_2.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_420_1.time_ - 0) / var_423_4)
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				var_423_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_423_5 = 0
			local var_423_6 = 0.825

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_7 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(938081102).content)

				arg_420_1.text_.text = var_423_7

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_9 = 33 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_7) / 33)

				if (33 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_7) / 33)) > 0 and var_423_6 < var_423_9 then
					arg_420_1.talkMaxDuration = var_423_9

					if var_423_9 + var_423_5 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_9 + var_423_5
					end
				end

				arg_420_1.text_.text = var_423_7
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_6, arg_420_1.talkMaxDuration)

			if var_423_5 <= arg_420_1.time_ and arg_420_1.time_ < var_423_5 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_5) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_5 + var_423_10 and arg_420_1.time_ < var_423_5 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play938081103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 938081103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play938081104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 1

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(938081103).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 40 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 40)

				if (40 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 40)) > 0 and var_427_0 < var_427_3 then
					arg_424_1.talkMaxDuration = var_427_3

					if var_427_3 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_3 + 0
					end
				end

				arg_424_1.text_.text = var_427_1
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_4 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_4

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play938081104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 938081104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play938081105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_9000

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos10183 = arg_428_1.actors_["10183"].transform.localPosition
				arg_428_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10183", 3)

				for iter_431_0 = 0, arg_428_1.actors_["10183"].transform.childCount - 1 do
					local var_431_0 = arg_428_1.actors_["10183"].transform:GetChild(iter_431_0)

					if var_431_0.name == "split_7" then
						var_431_0:SetAsLastSibling()
						var_431_0.gameObject:SetActive(true)

						arg_428_1.var_.actorSpriteSplit10183 = var_431_0.gameObject:GetComponent(typeof(Image))

						arg_428_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_431_1 = 0.5

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_1 then
				arg_428_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_428_1.time_ - 0) / var_431_1)

				if arg_428_1.var_.actorSpriteSplit10183 ~= nil then
					arg_428_1.var_.actorSpriteSplit10183:SetAlpha((arg_428_1.time_ - 0) / var_431_1)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_1 and arg_428_1.time_ < 0 + var_431_1 + arg_431_0 then
				arg_428_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_428_1.var_.actorSpriteSplit10183 ~= nil then
					arg_428_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				local var_431_2 = arg_428_1.var_.effectfensewenfei1

				if not arg_428_1.var_.effectfensewenfei1 then
					var_431_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_pinkbubble_in_keep"), manager.ui.mainCamera.transform)
					var_431_2.name = "fensewenfei1"
					arg_428_1.var_.effectfensewenfei1 = var_431_2
				else
					var_431_2.transform:SetParent(var_431_9000)
				end

				var_431_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_431_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_431_2.transform.localScale = Vector3.New(var_431_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_431_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_431_2.transform.localScale.z)
			end

			local var_431_4 = 0
			local var_431_5 = 1.125

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(938081104).content)

				arg_428_1.text_.text = var_431_6

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_8 = 45 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_6) / 45)

				if (45 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_6) / 45)) > 0 and var_431_5 < var_431_8 then
					arg_428_1.talkMaxDuration = var_431_8

					if var_431_8 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_6
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_9 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_9 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_9

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_9 and arg_428_1.time_ < var_431_4 + var_431_9 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play938081105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 938081105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play938081106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["10183"]) and arg_432_1.var_.actorSpriteComps10183 == nil then
				arg_432_1.var_.actorSpriteComps10183 = arg_432_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_0 = 0.2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["10183"]) then
				if arg_432_1.var_.actorSpriteComps10183 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								iter_435_1.color = Color.New(Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_0), Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_0), (Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_0)))
							else
								local var_435_1 = Mathf.Lerp(iter_435_1.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_0)

								iter_435_1.color = Color.New(var_435_1, var_435_1, var_435_1)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["10183"]) and arg_432_1.var_.actorSpriteComps10183 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_435_3 then
						iter_435_3.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10183 = nil
			end

			local var_435_2 = 0
			local var_435_3 = 0.275

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 then
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

				local var_435_4 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(938081105).content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_6 = 11 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_4) / 11)

				if (11 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_4) / 11)) > 0 and var_435_3 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_2
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_3, arg_432_1.talkMaxDuration)

			if var_435_2 <= arg_432_1.time_ and arg_432_1.time_ < var_435_2 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_2) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_2 + var_435_7 and arg_432_1.time_ < var_435_2 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play938081106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 938081106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play938081107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["10183"]) and arg_436_1.var_.actorSpriteComps10183 == nil then
				arg_436_1.var_.actorSpriteComps10183 = arg_436_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_0 = 0.2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["10183"]) then
				if arg_436_1.var_.actorSpriteComps10183 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								iter_439_1.color = Color.New(Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, (arg_436_1.time_ - 0) / var_439_0), Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, (arg_436_1.time_ - 0) / var_439_0), (Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, (arg_436_1.time_ - 0) / var_439_0)))
							else
								local var_439_1 = Mathf.Lerp(iter_439_1.color.r, 1, (arg_436_1.time_ - 0) / var_439_0)

								iter_439_1.color = Color.New(var_439_1, var_439_1, var_439_1)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["10183"]) and arg_436_1.var_.actorSpriteComps10183 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_439_3 then
						iter_439_3.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_436_1.var_.actorSpriteComps10183 = nil
			end

			local var_439_2 = arg_436_1.actors_["10183"].transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos10183 = var_439_2.localPosition
				var_439_2.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10183", 3)

				for iter_439_4 = 0, var_439_2.childCount - 1 do
					local var_439_3 = var_439_2:GetChild(iter_439_4)

					if var_439_3.name == "split_8" then
						var_439_3:SetAsLastSibling()
						var_439_3.gameObject:SetActive(true)

						arg_436_1.var_.actorSpriteSplit10183 = var_439_3.gameObject:GetComponent(typeof(Image))

						arg_436_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_439_4 = 0.5

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				var_439_2.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_436_1.time_ - 0) / var_439_4)

				if arg_436_1.var_.actorSpriteSplit10183 ~= nil then
					arg_436_1.var_.actorSpriteSplit10183:SetAlpha((arg_436_1.time_ - 0) / var_439_4)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				var_439_2.localPosition = Vector3.New(0, -475, -325)

				if arg_436_1.var_.actorSpriteSplit10183 ~= nil then
					arg_436_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_439_5 = manager.ui.mainCamera.transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.shakeOldPos = var_439_5.localPosition
			end

			local var_439_6 = 0.6

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_6 then
				local var_439_7, var_439_8 = math.modf((arg_436_1.time_ - 0) / 0.066)

				var_439_5.localPosition = Vector3.New(var_439_8 * 0.13, var_439_8 * 0.13, var_439_8 * 0.13) + arg_436_1.var_.shakeOldPos
			end

			if arg_436_1.time_ >= 0 + var_439_6 and arg_436_1.time_ < 0 + var_439_6 + arg_439_0 then
				var_439_5.localPosition = arg_436_1.var_.shakeOldPos
			end

			local var_439_9 = 0

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_9 + arg_439_0 then
				arg_436_1.allBtn_.enabled = false
			end

			if arg_436_1.time_ >= var_439_9 + 0.6 and arg_436_1.time_ < var_439_9 + 0.6 + arg_439_0 then
				arg_436_1.allBtn_.enabled = true
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				if arg_436_1.var_.effectfensewenfei1 then
					Object.Destroy(arg_436_1.var_.effectfensewenfei1)

					arg_436_1.var_.effectfensewenfei1 = nil
				end
			end

			local var_439_11 = 0
			local var_439_12 = 1.225

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_11 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_13 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(938081106).content)

				arg_436_1.text_.text = var_439_13

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_15 = 49 <= 0 and var_439_12 or var_439_12 * (utf8.len(var_439_13) / 49)

				if (49 <= 0 and var_439_12 or var_439_12 * (utf8.len(var_439_13) / 49)) > 0 and var_439_12 < var_439_15 then
					arg_436_1.talkMaxDuration = var_439_15

					if var_439_15 + var_439_11 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_15 + var_439_11
					end
				end

				arg_436_1.text_.text = var_439_13
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_16 = math.max(var_439_12, arg_436_1.talkMaxDuration)

			if var_439_11 <= arg_436_1.time_ and arg_436_1.time_ < var_439_11 + var_439_16 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_11) / var_439_16

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_11 + var_439_16 and arg_436_1.time_ < var_439_11 + var_439_16 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play938081107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 938081107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play938081108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.925

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_1 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(938081107).content)

				arg_440_1.text_.text = var_443_1

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_3 = 37 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_1) / 37)

				if (37 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_1) / 37)) > 0 and var_443_0 < var_443_3 then
					arg_440_1.talkMaxDuration = var_443_3

					if var_443_3 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_3 + 0
					end
				end

				arg_440_1.text_.text = var_443_1
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_4 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_4

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play938081108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 938081108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play938081109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos10183 = arg_444_1.actors_["10183"].transform.localPosition
				arg_444_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10183", 3)

				for iter_447_0 = 0, arg_444_1.actors_["10183"].transform.childCount - 1 do
					local var_447_0 = arg_444_1.actors_["10183"].transform:GetChild(iter_447_0)

					if var_447_0.name == "split_1" then
						var_447_0:SetAsLastSibling()
						var_447_0.gameObject:SetActive(true)

						arg_444_1.var_.actorSpriteSplit10183 = var_447_0.gameObject:GetComponent(typeof(Image))

						arg_444_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_447_1 = 0.5

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_444_1.time_ - 0) / var_447_1)

				if arg_444_1.var_.actorSpriteSplit10183 ~= nil then
					arg_444_1.var_.actorSpriteSplit10183:SetAlpha((arg_444_1.time_ - 0) / var_447_1)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_444_1.var_.actorSpriteSplit10183 ~= nil then
					arg_444_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_447_2 = 0
			local var_447_3 = 0.85

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_2 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_4 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(938081108).content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 34 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_4) / 34)

				if (34 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_4) / 34)) > 0 and var_447_3 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_2 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_2
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_3, arg_444_1.talkMaxDuration)

			if var_447_2 <= arg_444_1.time_ and arg_444_1.time_ < var_447_2 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_2) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_2 + var_447_7 and arg_444_1.time_ < var_447_2 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play938081109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 938081109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play938081110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos10183 = arg_448_1.actors_["10183"].transform.localPosition
				arg_448_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10183", 3)

				for iter_451_0 = 0, arg_448_1.actors_["10183"].transform.childCount - 1 do
					local var_451_0 = arg_448_1.actors_["10183"].transform:GetChild(iter_451_0)

					if var_451_0.name == "" or not string.find(var_451_0.name, "split") then
						var_451_0.gameObject:SetActive(true)
					else
						var_451_0.gameObject:SetActive(false)
					end
				end
			end

			local var_451_1 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_1 then
				arg_448_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_448_1.time_ - 0) / var_451_1)
			end

			if arg_448_1.time_ >= 0 + var_451_1 and arg_448_1.time_ < 0 + var_451_1 + arg_451_0 then
				arg_448_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_451_2 = 0
			local var_451_3 = 0.7

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_4 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(938081109).content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_6 = 28 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_4) / 28)

				if (28 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_4) / 28)) > 0 and var_451_3 < var_451_6 then
					arg_448_1.talkMaxDuration = var_451_6

					if var_451_6 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_7 and arg_448_1.time_ < var_451_2 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play938081110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 938081110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play938081111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["10183"]) and arg_452_1.var_.actorSpriteComps10183 == nil then
				arg_452_1.var_.actorSpriteComps10183 = arg_452_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_0 = 0.2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["10183"]) then
				if arg_452_1.var_.actorSpriteComps10183 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								iter_455_1.color = Color.New(Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, (arg_452_1.time_ - 0) / var_455_0), Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, (arg_452_1.time_ - 0) / var_455_0), (Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, (arg_452_1.time_ - 0) / var_455_0)))
							else
								local var_455_1 = Mathf.Lerp(iter_455_1.color.r, 0.5, (arg_452_1.time_ - 0) / var_455_0)

								iter_455_1.color = Color.New(var_455_1, var_455_1, var_455_1)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["10183"]) and arg_452_1.var_.actorSpriteComps10183 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_455_3 then
						iter_455_3.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_452_1.var_.actorSpriteComps10183 = nil
			end

			local var_455_2 = 0
			local var_455_3 = 0.225

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_2 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_4 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(938081110).content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_6 = 9 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 9)

				if (9 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 9)) > 0 and var_455_3 < var_455_6 then
					arg_452_1.talkMaxDuration = var_455_6

					if var_455_6 + var_455_2 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_6 + var_455_2
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_3, arg_452_1.talkMaxDuration)

			if var_455_2 <= arg_452_1.time_ and arg_452_1.time_ < var_455_2 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_2) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_2 + var_455_7 and arg_452_1.time_ < var_455_2 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play938081111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 938081111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play938081112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["10183"]) and arg_456_1.var_.actorSpriteComps10183 == nil then
				arg_456_1.var_.actorSpriteComps10183 = arg_456_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_0 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["10183"]) then
				if arg_456_1.var_.actorSpriteComps10183 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								iter_459_1.color = Color.New(Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, (arg_456_1.time_ - 0) / var_459_0), Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, (arg_456_1.time_ - 0) / var_459_0), (Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, (arg_456_1.time_ - 0) / var_459_0)))
							else
								local var_459_1 = Mathf.Lerp(iter_459_1.color.r, 1, (arg_456_1.time_ - 0) / var_459_0)

								iter_459_1.color = Color.New(var_459_1, var_459_1, var_459_1)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["10183"]) and arg_456_1.var_.actorSpriteComps10183 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_459_3 then
						iter_459_3.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps10183 = nil
			end

			local var_459_2 = arg_456_1.actors_["10183"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos10183 = var_459_2.localPosition
				var_459_2.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10183", 3)

				for iter_459_4 = 0, var_459_2.childCount - 1 do
					local var_459_3 = var_459_2:GetChild(iter_459_4)

					if var_459_3.name == "" or not string.find(var_459_3.name, "split") then
						var_459_3.gameObject:SetActive(true)
					else
						var_459_3.gameObject:SetActive(false)
					end
				end
			end

			local var_459_4 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				var_459_2.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_456_1.time_ - 0) / var_459_4)
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				var_459_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_459_5 = arg_456_1.actors_["10183"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos10183 = var_459_5.localPosition
				var_459_5.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10183", 3)

				for iter_459_5 = 0, var_459_5.childCount - 1 do
					local var_459_6 = var_459_5:GetChild(iter_459_5)

					if var_459_6.name == "split_7" then
						var_459_6:SetAsLastSibling()
						var_459_6.gameObject:SetActive(true)

						arg_456_1.var_.actorSpriteSplit10183 = var_459_6.gameObject:GetComponent(typeof(Image))

						arg_456_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_459_7 = 0.5

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				var_459_5.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_456_1.time_ - 0) / var_459_7)

				if arg_456_1.var_.actorSpriteSplit10183 ~= nil then
					arg_456_1.var_.actorSpriteSplit10183:SetAlpha((arg_456_1.time_ - 0) / var_459_7)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				var_459_5.localPosition = Vector3.New(0, -475, -325)

				if arg_456_1.var_.actorSpriteSplit10183 ~= nil then
					arg_456_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_459_8 = 0
			local var_459_9 = 1.125

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_8 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_10 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(938081111).content)

				arg_456_1.text_.text = var_459_10

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_12 = 45 <= 0 and var_459_9 or var_459_9 * (utf8.len(var_459_10) / 45)

				if (45 <= 0 and var_459_9 or var_459_9 * (utf8.len(var_459_10) / 45)) > 0 and var_459_9 < var_459_12 then
					arg_456_1.talkMaxDuration = var_459_12

					if var_459_12 + var_459_8 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_12 + var_459_8
					end
				end

				arg_456_1.text_.text = var_459_10
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_13 = math.max(var_459_9, arg_456_1.talkMaxDuration)

			if var_459_8 <= arg_456_1.time_ and arg_456_1.time_ < var_459_8 + var_459_13 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_8) / var_459_13

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_8 + var_459_13 and arg_456_1.time_ < var_459_8 + var_459_13 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play938081112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 938081112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play938081113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos10183 = arg_460_1.actors_["10183"].transform.localPosition
				arg_460_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10183", 3)

				for iter_463_0 = 0, arg_460_1.actors_["10183"].transform.childCount - 1 do
					local var_463_0 = arg_460_1.actors_["10183"].transform:GetChild(iter_463_0)

					if var_463_0.name == "split_8" then
						var_463_0:SetAsLastSibling()
						var_463_0.gameObject:SetActive(true)

						arg_460_1.var_.actorSpriteSplit10183 = var_463_0.gameObject:GetComponent(typeof(Image))

						arg_460_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_463_1 = 0.5

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_1 then
				arg_460_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_460_1.time_ - 0) / var_463_1)

				if arg_460_1.var_.actorSpriteSplit10183 ~= nil then
					arg_460_1.var_.actorSpriteSplit10183:SetAlpha((arg_460_1.time_ - 0) / var_463_1)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_1 and arg_460_1.time_ < 0 + var_463_1 + arg_463_0 then
				arg_460_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_460_1.var_.actorSpriteSplit10183 ~= nil then
					arg_460_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_463_2 = 0
			local var_463_3 = 1.025

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_2 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_4 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(938081112).content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_6 = 41 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_4) / 41)

				if (41 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_4) / 41)) > 0 and var_463_3 < var_463_6 then
					arg_460_1.talkMaxDuration = var_463_6

					if var_463_6 + var_463_2 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_6 + var_463_2
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_3, arg_460_1.talkMaxDuration)

			if var_463_2 <= arg_460_1.time_ and arg_460_1.time_ < var_463_2 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_2) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_2 + var_463_7 and arg_460_1.time_ < var_463_2 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play938081113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 938081113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play938081114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["10183"]) and arg_464_1.var_.actorSpriteComps10183 == nil then
				arg_464_1.var_.actorSpriteComps10183 = arg_464_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_0 = 0.2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["10183"]) then
				if arg_464_1.var_.actorSpriteComps10183 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								iter_467_1.color = Color.New(Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor2.r, (arg_464_1.time_ - 0) / var_467_0), Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor2.g, (arg_464_1.time_ - 0) / var_467_0), (Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor2.b, (arg_464_1.time_ - 0) / var_467_0)))
							else
								local var_467_1 = Mathf.Lerp(iter_467_1.color.r, 0.5, (arg_464_1.time_ - 0) / var_467_0)

								iter_467_1.color = Color.New(var_467_1, var_467_1, var_467_1)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["10183"]) and arg_464_1.var_.actorSpriteComps10183 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_467_3 then
						iter_467_3.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_464_1.var_.actorSpriteComps10183 = nil
			end

			local var_467_2 = arg_464_1.actors_["10183"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos10183 = var_467_2.localPosition
				var_467_2.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10183", 3)

				for iter_467_4 = 0, var_467_2.childCount - 1 do
					local var_467_3 = var_467_2:GetChild(iter_467_4)

					if var_467_3.name == "" or not string.find(var_467_3.name, "split") then
						var_467_3.gameObject:SetActive(true)
					else
						var_467_3.gameObject:SetActive(false)
					end
				end
			end

			local var_467_4 = 0.6

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				var_467_2.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10183, Vector3.New(-800, -475, -325), (arg_464_1.time_ - 0) / var_467_4)
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				var_467_2.localPosition = Vector3.New(-800, -475, -325)
			end

			local var_467_5 = 0
			local var_467_6 = 0.95

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_7 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(938081113).content)

				arg_464_1.text_.text = var_467_7

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_9 = 38 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_7) / 38)

				if (38 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_7) / 38)) > 0 and var_467_6 < var_467_9 then
					arg_464_1.talkMaxDuration = var_467_9

					if var_467_9 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_9 + var_467_5
					end
				end

				arg_464_1.text_.text = var_467_7
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_10 = math.max(var_467_6, arg_464_1.talkMaxDuration)

			if var_467_5 <= arg_464_1.time_ and arg_464_1.time_ < var_467_5 + var_467_10 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_5) / var_467_10

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_5 + var_467_10 and arg_464_1.time_ < var_467_5 + var_467_10 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -475, -325),
					endPos = Vector3.New(-800, -475, -325),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play938081114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 938081114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play938081115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.85

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(938081114).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 34 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 34)

				if (34 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 34)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play938081115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 938081115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play938081116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 1.05

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_1 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(938081115).content)

				arg_472_1.text_.text = var_475_1

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_3 = 42 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 42)

				if (42 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 42)) > 0 and var_475_0 < var_475_3 then
					arg_472_1.talkMaxDuration = var_475_3

					if var_475_3 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_3 + 0
					end
				end

				arg_472_1.text_.text = var_475_1
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_4 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_4 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_4

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_4 and arg_472_1.time_ < 0 + var_475_4 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play938081116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 938081116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play938081117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 1

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(938081116).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 40 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 40)

				if (40 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 40)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play938081117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 938081117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
			arg_480_1.auto_ = false
		end

		function arg_480_1.playNext_(arg_482_0)
			arg_480_1.onStoryFinished_()
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.3

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(938081117).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 12 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 12)

				if (12 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 12)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I20f",
		"TextureConfig/Background/H02a"
	},
	voices = {}
}
