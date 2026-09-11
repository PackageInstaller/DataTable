return {
	Play900701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_4_0.name = "ST22a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22a

				arg_1_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22a" then
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

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900701001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 45 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 45)

				if (45 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 45)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play900701002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 900701002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play900701003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.5

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(900701002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 20)

				if (20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 20)) > 0 and var_12_0 < var_12_3 then
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
	Play900701003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 900701003
		arg_13_1.duration_ = 5.2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play900701004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10022"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10022"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10022"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10022"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 2)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_6" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_5 = arg_13_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_5 then
					arg_13_1.var_.alphaOldValue10022 = var_16_5.alpha
					arg_13_1.var_.characterEffect10022 = var_16_5
				end

				arg_13_1.var_.alphaOldValue10022 = 0
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				if arg_13_1.var_.characterEffect10022 then
					arg_13_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10022, 1, (arg_13_1.time_ - 0) / var_16_6)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and arg_13_1.var_.characterEffect10022 then
				arg_13_1.var_.characterEffect10022.alpha = 1
			end

			local var_16_7 = arg_13_1.actors_["10022"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_8), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_8), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_8)))
							else
								local var_16_9 = Mathf.Lerp(iter_16_4.color.r, 1, (arg_13_1.time_ - 0) / var_16_8)

								iter_16_4.color = Color.New(var_16_9, var_16_9, var_16_9)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_10 = 0.2
			local var_16_11 = 0.3

			if 0.2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_12 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_12:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(900701003).content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 12 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 12)

				if (12 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 12)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15
					var_16_10 = var_16_10 + 0.3

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = var_16_10 + 0.3
			local var_16_17 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_16) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play900701004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 900701004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play900701005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1033"] == nil then
				local var_22_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_22_0) then
					local var_22_1 = Object.Instantiate(var_22_0, arg_19_1.canvasGo_.transform)

					var_22_1.transform:SetSiblingIndex(1)

					var_22_1.name = "1033"
					var_22_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_["1033"] = var_22_1

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs((var_22_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_2 = arg_19_1.actors_["1033"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1033 = var_22_2.localPosition
				var_22_2.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1033", 4)

				for iter_22_2 = 0, var_22_2.childCount - 1 do
					local var_22_3 = var_22_2:GetChild(iter_22_2)

					if var_22_3.name == "split_5" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_2.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_19_1.time_ - 0) / var_22_4)
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_2.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_5 = arg_19_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_5 then
					arg_19_1.var_.alphaOldValue1033 = var_22_5.alpha
					arg_19_1.var_.characterEffect1033 = var_22_5
				end

				arg_19_1.var_.alphaOldValue1033 = 0
			end

			local var_22_6 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 then
				if arg_19_1.var_.characterEffect1033 then
					arg_19_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue1033, 1, (arg_19_1.time_ - 0) / var_22_6)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and arg_19_1.var_.characterEffect1033 then
				arg_19_1.var_.characterEffect1033.alpha = 1
			end

			local var_22_7 = arg_19_1.actors_["1033"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_7) and arg_19_1.var_.actorSpriteComps1033 == nil then
				arg_19_1.var_.actorSpriteComps1033 = var_22_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_8 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_8 and not isNil(var_22_7) then
				if arg_19_1.var_.actorSpriteComps1033 then
					for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_22_4 then
							if arg_19_1.isInRecall_ then
								iter_22_4.color = Color.New(Mathf.Lerp(iter_22_4.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_8), Mathf.Lerp(iter_22_4.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_8), (Mathf.Lerp(iter_22_4.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_8)))
							else
								local var_22_9 = Mathf.Lerp(iter_22_4.color.r, 1, (arg_19_1.time_ - 0) / var_22_8)

								iter_22_4.color = Color.New(var_22_9, var_22_9, var_22_9)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_8 and arg_19_1.time_ < 0 + var_22_8 + arg_22_0 and not isNil(var_22_7) and arg_19_1.var_.actorSpriteComps1033 then
				for iter_22_5, iter_22_6 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_22_6 then
						iter_22_6.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps1033 = nil
			end

			local var_22_10 = arg_19_1.actors_["10022"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.actorSpriteComps10022 == nil then
				arg_19_1.var_.actorSpriteComps10022 = var_22_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_11 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_11 and not isNil(var_22_10) then
				if arg_19_1.var_.actorSpriteComps10022 then
					for iter_22_7, iter_22_8 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_22_8 then
							if arg_19_1.isInRecall_ then
								iter_22_8.color = Color.New(Mathf.Lerp(iter_22_8.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_11), Mathf.Lerp(iter_22_8.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_11), (Mathf.Lerp(iter_22_8.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_11)))
							else
								local var_22_12 = Mathf.Lerp(iter_22_8.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_11)

								iter_22_8.color = Color.New(var_22_12, var_22_12, var_22_12)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_11 and arg_19_1.time_ < 0 + var_22_11 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.actorSpriteComps10022 then
				for iter_22_9, iter_22_10 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_22_10 then
						iter_22_10.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps10022 = nil
			end

			local var_22_13 = 0
			local var_22_14 = 0.875

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_15 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(900701004).content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 35 <= 0 and var_22_14 or var_22_14 * (utf8.len(var_22_15) / 35)

				if (35 <= 0 and var_22_14 or var_22_14 * (utf8.len(var_22_15) / 35)) > 0 and var_22_14 < var_22_17 then
					arg_19_1.talkMaxDuration = var_22_17

					if var_22_17 + var_22_13 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_17 + var_22_13
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = math.max(var_22_14, arg_19_1.talkMaxDuration)

			if var_22_13 <= arg_19_1.time_ and arg_19_1.time_ < var_22_13 + var_22_18 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_13) / var_22_18

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_13 + var_22_18 and arg_19_1.time_ < var_22_13 + var_22_18 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play900701005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 900701005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play900701006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.75

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(900701005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 30 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 30)

				if (30 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 30)) > 0 and var_26_0 < var_26_3 then
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
	Play900701006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 900701006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play900701007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1033"]) and arg_27_1.var_.actorSpriteComps1033 == nil then
				arg_27_1.var_.actorSpriteComps1033 = arg_27_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1033"]) then
				if arg_27_1.var_.actorSpriteComps1033 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1033"]) and arg_27_1.var_.actorSpriteComps1033 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1033 = nil
			end

			local var_30_2 = arg_27_1.actors_["10022"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10022 == nil then
				arg_27_1.var_.actorSpriteComps10022 = var_30_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_3 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.actorSpriteComps10022 then
					for iter_30_4, iter_30_5 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_30_5 then
							if arg_27_1.isInRecall_ then
								iter_30_5.color = Color.New(Mathf.Lerp(iter_30_5.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_3), Mathf.Lerp(iter_30_5.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_3), (Mathf.Lerp(iter_30_5.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_3)))
							else
								local var_30_4 = Mathf.Lerp(iter_30_5.color.r, 1, (arg_27_1.time_ - 0) / var_30_3)

								iter_30_5.color = Color.New(var_30_4, var_30_4, var_30_4)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10022 then
				for iter_30_6, iter_30_7 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_30_7 then
						iter_30_7.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps10022 = nil
			end

			local var_30_5 = 0
			local var_30_6 = 0.675

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(900701006).content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 27 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 27)

				if (27 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 27)) > 0 and var_30_6 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_10 and arg_27_1.time_ < var_30_5 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play900701007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 900701007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play900701008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1033"]) and arg_31_1.var_.actorSpriteComps1033 == nil then
				arg_31_1.var_.actorSpriteComps1033 = arg_31_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1033"]) then
				if arg_31_1.var_.actorSpriteComps1033 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 1, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1033"]) and arg_31_1.var_.actorSpriteComps1033 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps1033 = nil
			end

			local var_34_2 = arg_31_1.actors_["10022"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_34_5 then
							if arg_31_1.isInRecall_ then
								iter_34_5.color = Color.New(Mathf.Lerp(iter_34_5.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_5.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_5.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_5.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_5.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_6, iter_34_7 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_7 then
						iter_34_7.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_5 = 0
			local var_34_6 = 0.975

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(900701007).content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 39 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 39)

				if (39 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 39)) > 0 and var_34_6 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_5
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_6, arg_31_1.talkMaxDuration)

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_5) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_5 + var_34_10 and arg_31_1.time_ < var_34_5 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play900701008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 900701008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play900701009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.6

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(900701008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 24 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 24)

				if (24 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 24)) > 0 and var_38_0 < var_38_3 then
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
	Play900701009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 900701009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play900701010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1033 = arg_39_1.actors_["1033"].transform.localPosition
				arg_39_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1033", 4)

				for iter_42_0 = 0, arg_39_1.actors_["1033"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["1033"].transform:GetChild(iter_42_0)

					if var_42_0.name == "split_5" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_42_2 = 0
			local var_42_3 = 0.875

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_4 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(900701009).content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 35 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_4) / 35)

				if (35 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_4) / 35)) > 0 and var_42_3 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_7 and arg_39_1.time_ < var_42_2 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play900701010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 900701010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play900701011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10022 = arg_43_1.actors_["10022"].transform.localPosition
				arg_43_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10022", 2)

				for iter_46_0 = 0, arg_43_1.actors_["10022"].transform.childCount - 1 do
					local var_46_0 = arg_43_1.actors_["10022"].transform:GetChild(iter_46_0)

					if var_46_0.name == "split_3" or not string.find(var_46_0.name, "split") then
						var_46_0.gameObject:SetActive(true)
					else
						var_46_0.gameObject:SetActive(false)
					end
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_43_1.time_ - 0) / var_46_1)
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_46_2 = arg_43_1.actors_["10022"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10022 == nil then
				arg_43_1.var_.actorSpriteComps10022 = var_46_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_3 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.actorSpriteComps10022 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								iter_46_2.color = Color.New(Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_3), Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_3), (Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_3)))
							else
								local var_46_4 = Mathf.Lerp(iter_46_2.color.r, 1, (arg_43_1.time_ - 0) / var_46_3)

								iter_46_2.color = Color.New(var_46_4, var_46_4, var_46_4)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10022 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_46_4 then
						iter_46_4.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10022 = nil
			end

			local var_46_5 = arg_43_1.actors_["1033"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps1033 == nil then
				arg_43_1.var_.actorSpriteComps1033 = var_46_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_6 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.actorSpriteComps1033 then
					for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_46_6 then
							if arg_43_1.isInRecall_ then
								iter_46_6.color = Color.New(Mathf.Lerp(iter_46_6.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_6), Mathf.Lerp(iter_46_6.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_6), (Mathf.Lerp(iter_46_6.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_6)))
							else
								local var_46_7 = Mathf.Lerp(iter_46_6.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_6)

								iter_46_6.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps1033 then
				for iter_46_7, iter_46_8 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_46_8 then
						iter_46_8.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps1033 = nil
			end

			local var_46_8 = 0
			local var_46_9 = 0.25

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(900701010).content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_12 = 10 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_10) / 10)

				if (10 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_10) / 10)) > 0 and var_46_9 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_13 and arg_43_1.time_ < var_46_8 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play900701011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 900701011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play900701012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1033 = arg_47_1.actors_["1033"].transform.localPosition
				arg_47_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1033", 4)

				for iter_50_0 = 0, arg_47_1.actors_["1033"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["1033"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_4" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_50_2 = arg_47_1.actors_["10022"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10022 == nil then
				arg_47_1.var_.actorSpriteComps10022 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps10022 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10022 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps10022 = nil
			end

			local var_50_5 = arg_47_1.actors_["1033"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.actorSpriteComps1033 == nil then
				arg_47_1.var_.actorSpriteComps1033 = var_50_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_6 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.actorSpriteComps1033 then
					for iter_50_5, iter_50_6 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_50_6 then
							if arg_47_1.isInRecall_ then
								iter_50_6.color = Color.New(Mathf.Lerp(iter_50_6.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_6), Mathf.Lerp(iter_50_6.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_6), (Mathf.Lerp(iter_50_6.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_6)))
							else
								local var_50_7 = Mathf.Lerp(iter_50_6.color.r, 1, (arg_47_1.time_ - 0) / var_50_6)

								iter_50_6.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.actorSpriteComps1033 then
				for iter_50_7, iter_50_8 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_50_8 then
						iter_50_8.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1033 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 0.075

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(900701011).content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 3 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 3)

				if (3 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 3)) > 0 and var_50_9 < var_50_12 then
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
				actorName = "1033",
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
	Play900701012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 900701012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play900701013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1033 = arg_51_1.actors_["1033"].transform.localPosition
				arg_51_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1033", 4)

				for iter_54_0 = 0, arg_51_1.actors_["1033"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["1033"].transform:GetChild(iter_54_0)

					if var_54_0.name == "split_2" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_54_2 = arg_51_1.actors_["1033"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1033 == nil then
				arg_51_1.var_.actorSpriteComps1033 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps1033 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								iter_54_2.color = Color.New(Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_2.color.r, 1, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_2.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1033 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_54_4 then
						iter_54_4.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps1033 = nil
			end

			local var_54_5 = arg_51_1.actors_["10022"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10022 = var_54_5.localPosition
				var_54_5.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10022", 2)

				for iter_54_5 = 0, var_54_5.childCount - 1 do
					local var_54_6 = var_54_5:GetChild(iter_54_5)

					if var_54_6.name == "split_6" or not string.find(var_54_6.name, "split") then
						var_54_6.gameObject:SetActive(true)
					else
						var_54_6.gameObject:SetActive(false)
					end
				end
			end

			local var_54_7 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_51_1.time_ - 0) / var_54_7)
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_54_8 = arg_51_1.actors_["10022"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10022 == nil then
				arg_51_1.var_.actorSpriteComps10022 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_9 and not isNil(var_54_8) then
				if arg_51_1.var_.actorSpriteComps10022 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_51_1.time_ >= 0 + var_54_9 and arg_51_1.time_ < 0 + var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10022 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_54_9 then
						iter_54_9.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10022 = nil
			end

			local var_54_11 = 0
			local var_54_12 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(900701012).content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 6 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 6)

				if (6 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 6)) > 0 and var_54_12 < var_54_15 then
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
				actorName = "1033",
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

		arg_51_1:InitPlayNodeList()
	end,
	Play900701013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 900701013
		arg_55_1.duration_ = 6.5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play900701014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.F01a == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_58_0.name = "F01a"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.F01a = var_58_0
			end

			if 0.500666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.500666666666667 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.F01a

				arg_55_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "F01a" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 0.5

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(1, 1, 1)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(1, 1, 1)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 0.500666666666667

			if 0.500666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 1

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(1, 1, 1)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(1, 1, 1)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			local var_58_12 = arg_55_1.actors_["1033"].transform

			if 0.466666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.466666666666667 + arg_58_0 then
				arg_55_1.var_.moveOldPos1033 = var_58_12.localPosition
				var_58_12.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1033", 7)

				for iter_58_2 = 0, var_58_12.childCount - 1 do
					local var_58_13 = var_58_12:GetChild(iter_58_2)

					if var_58_13.name == "split_2" or not string.find(var_58_13.name, "split") then
						var_58_13.gameObject:SetActive(true)
					else
						var_58_13.gameObject:SetActive(false)
					end
				end
			end

			local var_58_14 = 0.001

			if 0.466666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 0.466666666666667 + var_58_14 then
				var_58_12.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0.466666666666667) / var_58_14)
			end

			if arg_55_1.time_ >= 0.466666666666667 + var_58_14 and arg_55_1.time_ < 0.466666666666667 + var_58_14 + arg_58_0 then
				var_58_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_15 = arg_55_1.actors_["1033"].transform

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 then
				arg_55_1.var_.moveOldPos1033 = var_58_15.localPosition
				var_58_15.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1033", 2)

				for iter_58_3 = 0, var_58_15.childCount - 1 do
					local var_58_16 = var_58_15:GetChild(iter_58_3)

					if var_58_16.name == "split_1" or not string.find(var_58_16.name, "split") then
						var_58_16.gameObject:SetActive(true)
					else
						var_58_16.gameObject:SetActive(false)
					end
				end
			end

			local var_58_17 = 0.001

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_17 then
				var_58_15.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_55_1.time_ - 1.36666666666667) / var_58_17)
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_17 and arg_55_1.time_ < 1.36666666666667 + var_58_17 + arg_58_0 then
				var_58_15.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_58_18 = arg_55_1.actors_["10022"].transform

			if 0.466666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.466666666666667 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = var_58_18.localPosition
				var_58_18.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 7)

				for iter_58_4 = 0, var_58_18.childCount - 1 do
					local var_58_19 = var_58_18:GetChild(iter_58_4)

					if var_58_19.name == "split_6" or not string.find(var_58_19.name, "split") then
						var_58_19.gameObject:SetActive(true)
					else
						var_58_19.gameObject:SetActive(false)
					end
				end
			end

			local var_58_20 = 0.001

			if 0.466666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 0.466666666666667 + var_58_20 then
				var_58_18.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_55_1.time_ - 0.466666666666667) / var_58_20)
			end

			if arg_55_1.time_ >= 0.466666666666667 + var_58_20 and arg_55_1.time_ < 0.466666666666667 + var_58_20 + arg_58_0 then
				var_58_18.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_58_21 = "1038"

			if arg_55_1.actors_["1038"] == nil then
				local var_58_22 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_58_22) then
					local var_58_23 = Object.Instantiate(var_58_22, arg_55_1.canvasGo_.transform)

					var_58_23.transform:SetSiblingIndex(1)

					var_58_23.name = var_58_21
					var_58_23.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_55_1.actors_[var_58_21] = var_58_23

					if arg_55_1.isInRecall_ then
						for iter_58_5, iter_58_6 in ipairs((var_58_23:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_58_6.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_58_24 = arg_55_1.actors_["1038"].transform

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 then
				arg_55_1.var_.moveOldPos1038 = var_58_24.localPosition
				var_58_24.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1038", 4)

				for iter_58_7 = 0, var_58_24.childCount - 1 do
					local var_58_25 = var_58_24:GetChild(iter_58_7)

					if var_58_25.name == "split_1" or not string.find(var_58_25.name, "split") then
						var_58_25.gameObject:SetActive(true)
					else
						var_58_25.gameObject:SetActive(false)
					end
				end
			end

			local var_58_26 = 0.001

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_26 then
				var_58_24.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_55_1.time_ - 1.36666666666667) / var_58_26)
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_26 and arg_55_1.time_ < 1.36666666666667 + var_58_26 + arg_58_0 then
				var_58_24.localPosition = Vector3.New(390, -400, 0)
			end

			local var_58_27 = arg_55_1.actors_["1038"]

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 and not isNil(var_58_27) and arg_55_1.var_.actorSpriteComps1038 == nil then
				arg_55_1.var_.actorSpriteComps1038 = var_58_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_28 = 0.034

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_28 and not isNil(var_58_27) then
				if arg_55_1.var_.actorSpriteComps1038 then
					for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_58_9 then
							if arg_55_1.isInRecall_ then
								iter_58_9.color = Color.New(Mathf.Lerp(iter_58_9.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 1.36666666666667) / var_58_28), Mathf.Lerp(iter_58_9.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 1.36666666666667) / var_58_28), (Mathf.Lerp(iter_58_9.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 1.36666666666667) / var_58_28)))
							else
								local var_58_29 = Mathf.Lerp(iter_58_9.color.r, 0.5, (arg_55_1.time_ - 1.36666666666667) / var_58_28)

								iter_58_9.color = Color.New(var_58_29, var_58_29, var_58_29)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_28 and arg_55_1.time_ < 1.36666666666667 + var_58_28 + arg_58_0 and not isNil(var_58_27) and arg_55_1.var_.actorSpriteComps1038 then
				for iter_58_10, iter_58_11 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_58_11 then
						iter_58_11.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1038 = nil
			end

			local var_58_30 = arg_55_1.actors_["1033"]

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 and not isNil(var_58_30) and arg_55_1.var_.actorSpriteComps1033 == nil then
				arg_55_1.var_.actorSpriteComps1033 = var_58_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_31 = 0.034

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_31 and not isNil(var_58_30) then
				if arg_55_1.var_.actorSpriteComps1033 then
					for iter_58_12, iter_58_13 in pairs(arg_55_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_58_13 then
							if arg_55_1.isInRecall_ then
								iter_58_13.color = Color.New(Mathf.Lerp(iter_58_13.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 1.36666666666667) / var_58_31), Mathf.Lerp(iter_58_13.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 1.36666666666667) / var_58_31), (Mathf.Lerp(iter_58_13.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 1.36666666666667) / var_58_31)))
							else
								local var_58_32 = Mathf.Lerp(iter_58_13.color.r, 1, (arg_55_1.time_ - 1.36666666666667) / var_58_31)

								iter_58_13.color = Color.New(var_58_32, var_58_32, var_58_32)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_31 and arg_55_1.time_ < 1.36666666666667 + var_58_31 + arg_58_0 and not isNil(var_58_30) and arg_55_1.var_.actorSpriteComps1033 then
				for iter_58_14, iter_58_15 in pairs(arg_55_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_58_15 then
						iter_58_15.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps1033 = nil
			end

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 then
				local var_58_33 = arg_55_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_33 then
					arg_55_1.var_.alphaOldValue1033 = var_58_33.alpha
					arg_55_1.var_.characterEffect1033 = var_58_33
				end

				arg_55_1.var_.alphaOldValue1033 = 0
			end

			local var_58_34 = 0.2

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_34 then
				if arg_55_1.var_.characterEffect1033 then
					arg_55_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_55_1.var_.alphaOldValue1033, 1, (arg_55_1.time_ - 1.36666666666667) / var_58_34)
				end
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_34 and arg_55_1.time_ < 1.36666666666667 + var_58_34 + arg_58_0 and arg_55_1.var_.characterEffect1033 then
				arg_55_1.var_.characterEffect1033.alpha = 1
			end

			if 1.36666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 1.36666666666667 + arg_58_0 then
				local var_58_35 = arg_55_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_35 then
					arg_55_1.var_.alphaOldValue1038 = var_58_35.alpha
					arg_55_1.var_.characterEffect1038 = var_58_35
				end

				arg_55_1.var_.alphaOldValue1038 = 0
			end

			local var_58_36 = 0.2

			if 1.36666666666667 <= arg_55_1.time_ and arg_55_1.time_ < 1.36666666666667 + var_58_36 then
				if arg_55_1.var_.characterEffect1038 then
					arg_55_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_55_1.var_.alphaOldValue1038, 1, (arg_55_1.time_ - 1.36666666666667) / var_58_36)
				end
			end

			if arg_55_1.time_ >= 1.36666666666667 + var_58_36 and arg_55_1.time_ < 1.36666666666667 + var_58_36 + arg_58_0 and arg_55_1.var_.characterEffect1038 then
				arg_55_1.var_.characterEffect1038.alpha = 1
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_37 = 1.50066666666667
			local var_58_38 = 0.675

			if 1.50066666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_37 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_39 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_39:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_40 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(900701013).content)

				arg_55_1.text_.text = var_58_40

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_42 = 27 <= 0 and var_58_38 or var_58_38 * (utf8.len(var_58_40) / 27)

				if (27 <= 0 and var_58_38 or var_58_38 * (utf8.len(var_58_40) / 27)) > 0 and var_58_38 < var_58_42 then
					arg_55_1.talkMaxDuration = var_58_42
					var_58_37 = var_58_37 + 0.3

					if var_58_42 + var_58_37 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_42 + var_58_37
					end
				end

				arg_55_1.text_.text = var_58_40
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_43 = var_58_37 + 0.3
			local var_58_44 = math.max(var_58_38, arg_55_1.talkMaxDuration)

			if var_58_37 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_43 + var_58_44 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_43) / var_58_44

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_43 + var_58_44 and arg_55_1.time_ < var_58_43 + var_58_44 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play900701014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 900701014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play900701015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1038"]) and arg_61_1.var_.actorSpriteComps1038 == nil then
				arg_61_1.var_.actorSpriteComps1038 = arg_61_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1038"]) then
				if arg_61_1.var_.actorSpriteComps1038 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1038"]) and arg_61_1.var_.actorSpriteComps1038 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1038 = nil
			end

			local var_64_2 = arg_61_1.actors_["1033"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.7

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(900701014).content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 28 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_7) / 28)

				if (28 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_7) / 28)) > 0 and var_64_6 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_10 and arg_61_1.time_ < var_64_5 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play900701015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 900701015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play900701016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1038"]) and arg_65_1.var_.actorSpriteComps1038 == nil then
				arg_65_1.var_.actorSpriteComps1038 = arg_65_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1038"]) then
				if arg_65_1.var_.actorSpriteComps1038 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1038:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1038"]) and arg_65_1.var_.actorSpriteComps1038 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1038 = nil
			end

			local var_68_2 = arg_65_1.actors_["1033"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 == nil then
				arg_65_1.var_.actorSpriteComps1033 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1033 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1033 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.975

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(900701015).content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 39 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 39)

				if (39 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 39)) > 0 and var_68_6 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_10 and arg_65_1.time_ < var_68_5 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play900701016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 900701016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play900701017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.025

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(900701016).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 41 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 41)

				if (41 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 41)) > 0 and var_72_0 < var_72_3 then
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
	Play900701017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 900701017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play900701018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1033 = arg_73_1.actors_["1033"].transform.localPosition
				arg_73_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1033", 2)

				for iter_76_0 = 0, arg_73_1.actors_["1033"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1033"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_2" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_76_2 = 0
			local var_76_3 = 0.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(900701017).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 7 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 7)

				if (7 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 7)) > 0 and var_76_3 < var_76_6 then
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

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play900701018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 900701018
		arg_77_1.duration_ = 6.33

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play900701019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 then
				local var_80_0 = arg_77_1.bgs_.ST22a

				arg_77_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_1 = var_80_0:GetComponent("SpriteRenderer")

				if var_80_1 and var_80_1.sprite then
					local var_80_2 = 2 * (var_80_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_0.transform.localScale = Vector3.New(var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, var_80_2 / var_80_1.sprite.bounds.size.y < var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x and var_80_2 * manager.ui.mainCameraCom_.aspect / var_80_1.sprite.bounds.size.x or var_80_2 / var_80_1.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST22a" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_3 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_4 = 0.5

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_4 then
				local var_80_5 = Color.New(1, 1, 1)

				var_80_5.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_3) / var_80_4)
				arg_77_1.mask_.color = var_80_5
			end

			if arg_77_1.time_ >= var_80_3 + var_80_4 and arg_77_1.time_ < var_80_3 + var_80_4 + arg_80_0 then
				local var_80_6 = Color.New(1, 1, 1)

				var_80_6.a = 1
				arg_77_1.mask_.color = var_80_6
			end

			local var_80_7 = 0.5

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_8 = 1

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 then
				local var_80_9 = Color.New(1, 1, 1)

				var_80_9.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_7) / var_80_8)
				arg_77_1.mask_.color = var_80_9
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 then
				local var_80_10 = Color.New(1, 1, 1)

				arg_77_1.mask_.enabled = false
				var_80_10.a = 0
				arg_77_1.mask_.color = var_80_10
			end

			local var_80_11 = arg_77_1.actors_["1033"].transform

			if 0.466666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 0.466666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_11.localPosition
				var_80_11.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 7)

				for iter_80_2 = 0, var_80_11.childCount - 1 do
					local var_80_12 = var_80_11:GetChild(iter_80_2)

					if var_80_12.name == "split_1" or not string.find(var_80_12.name, "split") then
						var_80_12.gameObject:SetActive(true)
					else
						var_80_12.gameObject:SetActive(false)
					end
				end
			end

			local var_80_13 = 0.001

			if 0.466666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 0.466666666666667 + var_80_13 then
				var_80_11.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0.466666666666667) / var_80_13)
			end

			if arg_77_1.time_ >= 0.466666666666667 + var_80_13 and arg_77_1.time_ < 0.466666666666667 + var_80_13 + arg_80_0 then
				var_80_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_14 = arg_77_1.actors_["1033"].transform

			if 0.500666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 0.500666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_14.localPosition
				var_80_14.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 4)

				for iter_80_3 = 0, var_80_14.childCount - 1 do
					local var_80_15 = var_80_14:GetChild(iter_80_3)

					if var_80_15.name == "split_2" or not string.find(var_80_15.name, "split") then
						var_80_15.gameObject:SetActive(true)
					else
						var_80_15.gameObject:SetActive(false)
					end
				end
			end

			local var_80_16 = 0.001

			if 0.500666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 0.500666666666667 + var_80_16 then
				var_80_14.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_77_1.time_ - 0.500666666666667) / var_80_16)
			end

			if arg_77_1.time_ >= 0.500666666666667 + var_80_16 and arg_77_1.time_ < 0.500666666666667 + var_80_16 + arg_80_0 then
				var_80_14.localPosition = Vector3.New(390, -420, 0)
			end

			local var_80_17 = arg_77_1.actors_["1038"].transform

			if 0.466666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 0.466666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPos1038 = var_80_17.localPosition
				var_80_17.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1038", 7)

				for iter_80_4 = 0, var_80_17.childCount - 1 do
					local var_80_18 = var_80_17:GetChild(iter_80_4)

					if var_80_18.name == "split_1" or not string.find(var_80_18.name, "split") then
						var_80_18.gameObject:SetActive(true)
					else
						var_80_18.gameObject:SetActive(false)
					end
				end
			end

			local var_80_19 = 0.001

			if 0.466666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 0.466666666666667 + var_80_19 then
				var_80_17.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0.466666666666667) / var_80_19)
			end

			if arg_77_1.time_ >= 0.466666666666667 + var_80_19 and arg_77_1.time_ < 0.466666666666667 + var_80_19 + arg_80_0 then
				var_80_17.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_20 = arg_77_1.actors_["10022"].transform

			if 0.500666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 0.500666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPos10022 = var_80_20.localPosition
				var_80_20.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10022", 2)

				for iter_80_5 = 0, var_80_20.childCount - 1 do
					local var_80_21 = var_80_20:GetChild(iter_80_5)

					if var_80_21.name == "split_6" or not string.find(var_80_21.name, "split") then
						var_80_21.gameObject:SetActive(true)
					else
						var_80_21.gameObject:SetActive(false)
					end
				end
			end

			local var_80_22 = 0.001

			if 0.500666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 0.500666666666667 + var_80_22 then
				var_80_20.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_77_1.time_ - 0.500666666666667) / var_80_22)
			end

			if arg_77_1.time_ >= 0.500666666666667 + var_80_22 and arg_77_1.time_ < 0.500666666666667 + var_80_22 + arg_80_0 then
				var_80_20.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_80_23 = arg_77_1.actors_["10022"]

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 and not isNil(var_80_23) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_24 = 0.0346666666666666

			if 0.5 <= arg_77_1.time_ and arg_77_1.time_ < 0.5 + var_80_24 and not isNil(var_80_23) then
				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								iter_80_7.color = Color.New(Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0.5) / var_80_24), Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0.5) / var_80_24), (Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0.5) / var_80_24)))
							else
								local var_80_25 = Mathf.Lerp(iter_80_7.color.r, 0.5, (arg_77_1.time_ - 0.5) / var_80_24)

								iter_80_7.color = Color.New(var_80_25, var_80_25, var_80_25)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0.5 + var_80_24 and arg_77_1.time_ < 0.5 + var_80_24 + arg_80_0 and not isNil(var_80_23) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_9 then
						iter_80_9.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_26 = arg_77_1.actors_["1033"]

			if 0.5 < arg_77_1.time_ and arg_77_1.time_ <= 0.5 + arg_80_0 and not isNil(var_80_26) and arg_77_1.var_.actorSpriteComps1033 == nil then
				arg_77_1.var_.actorSpriteComps1033 = var_80_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_27 = 0.034

			if 0.5 <= arg_77_1.time_ and arg_77_1.time_ < 0.5 + var_80_27 and not isNil(var_80_26) then
				if arg_77_1.var_.actorSpriteComps1033 then
					for iter_80_10, iter_80_11 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_80_11 then
							if arg_77_1.isInRecall_ then
								iter_80_11.color = Color.New(Mathf.Lerp(iter_80_11.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0.5) / var_80_27), Mathf.Lerp(iter_80_11.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0.5) / var_80_27), (Mathf.Lerp(iter_80_11.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0.5) / var_80_27)))
							else
								local var_80_28 = Mathf.Lerp(iter_80_11.color.r, 1, (arg_77_1.time_ - 0.5) / var_80_27)

								iter_80_11.color = Color.New(var_80_28, var_80_28, var_80_28)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0.5 + var_80_27 and arg_77_1.time_ < 0.5 + var_80_27 + arg_80_0 and not isNil(var_80_26) and arg_77_1.var_.actorSpriteComps1033 then
				for iter_80_12, iter_80_13 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_80_13 then
						iter_80_13.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1033 = nil
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_29 = 1.33333333333333
			local var_80_30 = 0.825

			if 1.33333333333333 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_31 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_31:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_32 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(900701018).content)

				arg_77_1.text_.text = var_80_32

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_34 = 33 <= 0 and var_80_30 or var_80_30 * (utf8.len(var_80_32) / 33)

				if (33 <= 0 and var_80_30 or var_80_30 * (utf8.len(var_80_32) / 33)) > 0 and var_80_30 < var_80_34 then
					arg_77_1.talkMaxDuration = var_80_34
					var_80_29 = var_80_29 + 0.3

					if var_80_34 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_34 + var_80_29
					end
				end

				arg_77_1.text_.text = var_80_32
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_35 = var_80_29 + 0.3
			local var_80_36 = math.max(var_80_30, arg_77_1.talkMaxDuration)

			if var_80_29 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_36 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_35) / var_80_36

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_35 + var_80_36 and arg_77_1.time_ < var_80_35 + var_80_36 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.500666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.500666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play900701019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 900701019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play900701020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1033 = arg_83_1.actors_["1033"].transform.localPosition
				arg_83_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1033", 4)

				for iter_86_0 = 0, arg_83_1.actors_["1033"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["1033"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_5" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_86_2 = arg_83_1.actors_["1033"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps1033 == nil then
				arg_83_1.var_.actorSpriteComps1033 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps1033 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								iter_86_2.color = Color.New(Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_2.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_2.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps1033 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps1033 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(900701019).content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 4 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 4)

				if (4 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 4)) > 0 and var_86_6 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_10 and arg_83_1.time_ < var_86_5 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play900701020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 900701020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play900701021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10022"]) and arg_87_1.var_.actorSpriteComps10022 == nil then
				arg_87_1.var_.actorSpriteComps10022 = arg_87_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10022"]) then
				if arg_87_1.var_.actorSpriteComps10022 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_0), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_0), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_0)))
							else
								local var_90_1 = Mathf.Lerp(iter_90_1.color.r, 1, (arg_87_1.time_ - 0) / var_90_0)

								iter_90_1.color = Color.New(var_90_1, var_90_1, var_90_1)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10022"]) and arg_87_1.var_.actorSpriteComps10022 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps10022 = nil
			end

			local var_90_2 = arg_87_1.actors_["1033"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1033 == nil then
				arg_87_1.var_.actorSpriteComps1033 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps1033 then
					for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_90_5 then
							if arg_87_1.isInRecall_ then
								iter_90_5.color = Color.New(Mathf.Lerp(iter_90_5.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_5.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_5.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_5.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_5.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1033 then
				for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_90_7 then
						iter_90_7.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps1033 = nil
			end

			local var_90_5 = 0
			local var_90_6 = 0.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(900701020).content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 4 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 4)

				if (4 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 4)) > 0 and var_90_6 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_10 and arg_87_1.time_ < var_90_5 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play900701021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 900701021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play900701022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10022"]) and arg_91_1.var_.actorSpriteComps10022 == nil then
				arg_91_1.var_.actorSpriteComps10022 = arg_91_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.1

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10022"]) then
				if arg_91_1.var_.actorSpriteComps10022 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10022"]) and arg_91_1.var_.actorSpriteComps10022 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10022 = nil
			end

			local var_94_2 = arg_91_1.actors_["1033"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1033 == nil then
				arg_91_1.var_.actorSpriteComps1033 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.1

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps1033 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								iter_94_5.color = Color.New(Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_5.color.r, 1, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_5.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1033 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_94_7 then
						iter_94_7.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1033 = nil
			end

			local var_94_5 = 0
			local var_94_6 = 0.875

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(900701021).content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 35 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 35)

				if (35 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 35)) > 0 and var_94_6 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_10 and arg_91_1.time_ < var_94_5 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play900701022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 900701022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play900701023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(900701022).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 13)

				if (13 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 13)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play900701023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 900701023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play900701024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10022"]) and arg_99_1.var_.actorSpriteComps10022 == nil then
				arg_99_1.var_.actorSpriteComps10022 = arg_99_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.1

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10022"]) then
				if arg_99_1.var_.actorSpriteComps10022 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 1, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10022"]) and arg_99_1.var_.actorSpriteComps10022 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps10022 = nil
			end

			local var_102_2 = arg_99_1.actors_["1033"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1033 == nil then
				arg_99_1.var_.actorSpriteComps1033 = var_102_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_3 = 0.1

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.actorSpriteComps1033 then
					for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_102_5 then
							if arg_99_1.isInRecall_ then
								iter_102_5.color = Color.New(Mathf.Lerp(iter_102_5.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_3), Mathf.Lerp(iter_102_5.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_3), (Mathf.Lerp(iter_102_5.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_3)))
							else
								local var_102_4 = Mathf.Lerp(iter_102_5.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_3)

								iter_102_5.color = Color.New(var_102_4, var_102_4, var_102_4)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1033 then
				for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_102_7 then
						iter_102_7.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps1033 = nil
			end

			local var_102_5 = 0
			local var_102_6 = 0.525

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(900701023).content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 21 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_7) / 21)

				if (21 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_7) / 21)) > 0 and var_102_6 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_10 and arg_99_1.time_ < var_102_5 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play900701024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 900701024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play900701025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10022"]) and arg_103_1.var_.actorSpriteComps10022 == nil then
				arg_103_1.var_.actorSpriteComps10022 = arg_103_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.1

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10022"]) then
				if arg_103_1.var_.actorSpriteComps10022 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10022"]) and arg_103_1.var_.actorSpriteComps10022 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10022 = nil
			end

			local var_106_2 = arg_103_1.actors_["1033"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1033 == nil then
				arg_103_1.var_.actorSpriteComps1033 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.1

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1033 then
					for iter_106_4, iter_106_5 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_106_5 then
							if arg_103_1.isInRecall_ then
								iter_106_5.color = Color.New(Mathf.Lerp(iter_106_5.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_3), Mathf.Lerp(iter_106_5.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_3), (Mathf.Lerp(iter_106_5.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_3)))
							else
								local var_106_4 = Mathf.Lerp(iter_106_5.color.r, 1, (arg_103_1.time_ - 0) / var_106_3)

								iter_106_5.color = Color.New(var_106_4, var_106_4, var_106_4)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1033 then
				for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_106_7 then
						iter_106_7.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1033 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 0.5

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(900701024).content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 20 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_7) / 20)

				if (20 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_7) / 20)) > 0 and var_106_6 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_10 and arg_103_1.time_ < var_106_5 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play900701025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 900701025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play900701026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10022"]) and arg_107_1.var_.actorSpriteComps10022 == nil then
				arg_107_1.var_.actorSpriteComps10022 = arg_107_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.1

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10022"]) then
				if arg_107_1.var_.actorSpriteComps10022 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 1, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10022"]) and arg_107_1.var_.actorSpriteComps10022 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10022 = nil
			end

			local var_110_2 = arg_107_1.actors_["1033"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps1033 == nil then
				arg_107_1.var_.actorSpriteComps1033 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.1

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps1033 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								iter_110_5.color = Color.New(Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_5.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_5.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps1033 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_110_7 then
						iter_110_7.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1033 = nil
			end

			local var_110_5 = 0
			local var_110_6 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(900701025).content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 38 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_7) / 38)

				if (38 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_7) / 38)) > 0 and var_110_6 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_10 and arg_107_1.time_ < var_110_5 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play900701026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 900701026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play900701027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.925

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(900701026).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 37 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 37)

				if (37 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 37)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play900701027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 900701027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play900701028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.95

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(900701027).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 38 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 38)

				if (38 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 38)) > 0 and var_118_0 < var_118_3 then
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
	Play900701028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 900701028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play900701029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10022 = arg_119_1.actors_["10022"].transform.localPosition
				arg_119_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10022", 2)

				for iter_122_0 = 0, arg_119_1.actors_["10022"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10022"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_7" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10022, Vector3.New(-390, -350, -180), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_122_2 = 0
			local var_122_3 = 0.325

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(900701028).content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 13 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 13)

				if (13 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 13)) > 0 and var_122_3 < var_122_6 then
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
				actorName = "10022",
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
	Play900701029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 900701029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play900701030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1033 = arg_123_1.actors_["1033"].transform.localPosition
				arg_123_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1033", 4)

				for iter_126_0 = 0, arg_123_1.actors_["1033"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["1033"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_6" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_126_2 = arg_123_1.actors_["10022"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.1

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								iter_126_2.color = Color.New(Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_2.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_2.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_5 = arg_123_1.actors_["1033"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps1033 == nil then
				arg_123_1.var_.actorSpriteComps1033 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 0.1

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps1033 then
					for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_126_6 then
							if arg_123_1.isInRecall_ then
								iter_126_6.color = Color.New(Mathf.Lerp(iter_126_6.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_6.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_6.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_6.color.r, 1, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_6.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps1033 then
				for iter_126_7, iter_126_8 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_126_8 then
						iter_126_8.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps1033 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.175

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(900701029).content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 7 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_10) / 7)

				if (7 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_10) / 7)) > 0 and var_126_9 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_13 and arg_123_1.time_ < var_126_8 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play900701030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 900701030
		arg_127_1.duration_ = 8

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play900701031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.OM0602 == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0602")
				var_130_0.name = "OM0602"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.OM0602 = var_130_0
			end

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= 2 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.OM0602

				arg_127_1.bgs_.OM0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "OM0602" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_5 = 2

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_5 then
				local var_130_6 = Color.New(0, 0, 0)

				var_130_6.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_4) / var_130_5)
				arg_127_1.mask_.color = var_130_6
			end

			if arg_127_1.time_ >= var_130_4 + var_130_5 and arg_127_1.time_ < var_130_4 + var_130_5 + arg_130_0 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = 1
				arg_127_1.mask_.color = var_130_7
			end

			local var_130_8 = 2

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_9 = 1

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 then
				local var_130_10 = Color.New(0, 0, 0)

				var_130_10.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_8) / var_130_9)
				arg_127_1.mask_.color = var_130_10
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 then
				local var_130_11 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_11.a = 0
				arg_127_1.mask_.color = var_130_11
			end

			local var_130_12 = arg_127_1.actors_["1033"].transform

			if 1.966 < arg_127_1.time_ and arg_127_1.time_ <= 1.966 + arg_130_0 then
				arg_127_1.var_.moveOldPos1033 = var_130_12.localPosition
				var_130_12.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1033", 7)

				for iter_130_2 = 0, var_130_12.childCount - 1 do
					local var_130_13 = var_130_12:GetChild(iter_130_2)

					if var_130_13.name == "split_6" or not string.find(var_130_13.name, "split") then
						var_130_13.gameObject:SetActive(true)
					else
						var_130_13.gameObject:SetActive(false)
					end
				end
			end

			local var_130_14 = 0.001

			if 1.966 <= arg_127_1.time_ and arg_127_1.time_ < 1.966 + var_130_14 then
				var_130_12.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 1.966) / var_130_14)
			end

			if arg_127_1.time_ >= 1.966 + var_130_14 and arg_127_1.time_ < 1.966 + var_130_14 + arg_130_0 then
				var_130_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_15 = arg_127_1.actors_["10022"].transform

			if 1.966 < arg_127_1.time_ and arg_127_1.time_ <= 1.966 + arg_130_0 then
				arg_127_1.var_.moveOldPos10022 = var_130_15.localPosition
				var_130_15.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10022", 7)

				for iter_130_3 = 0, var_130_15.childCount - 1 do
					local var_130_16 = var_130_15:GetChild(iter_130_3)

					if var_130_16.name == "split_7" or not string.find(var_130_16.name, "split") then
						var_130_16.gameObject:SetActive(true)
					else
						var_130_16.gameObject:SetActive(false)
					end
				end
			end

			local var_130_17 = 0.001

			if 1.966 <= arg_127_1.time_ and arg_127_1.time_ < 1.966 + var_130_17 then
				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 1.966) / var_130_17)
			end

			if arg_127_1.time_ >= 1.966 + var_130_17 and arg_127_1.time_ < 1.966 + var_130_17 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_18 = manager.ui.mainCamera.transform

			if 2.034 < arg_127_1.time_ and arg_127_1.time_ <= 2.034 + arg_130_0 then
				arg_127_1.var_.shakeOldPos = var_130_18.localPosition
			end

			local var_130_19 = 1.166

			if 2.034 <= arg_127_1.time_ and arg_127_1.time_ < 2.034 + var_130_19 then
				local var_130_20, var_130_21 = math.modf((arg_127_1.time_ - 2.034) / 0.066)

				var_130_18.localPosition = Vector3.New(var_130_21 * 0.13, var_130_21 * 0.13, var_130_21 * 0.13) + arg_127_1.var_.shakeOldPos
			end

			if arg_127_1.time_ >= 2.034 + var_130_19 and arg_127_1.time_ < 2.034 + var_130_19 + arg_130_0 then
				var_130_18.localPosition = arg_127_1.var_.shakeOldPos
			end

			local var_130_22 = arg_127_1.bgs_.OM0602.transform

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= 2 + arg_130_0 then
				arg_127_1.var_.moveOldPosOM0602 = var_130_22.localPosition
				var_130_22.localScale = Vector3.New(1, 1, 1)
			end

			local var_130_23 = 0.001

			if 2 <= arg_127_1.time_ and arg_127_1.time_ < 2 + var_130_23 then
				var_130_22.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPosOM0602, Vector3.New(3.79, -0.64, 4.5), (arg_127_1.time_ - 2) / var_130_23)
			end

			if arg_127_1.time_ >= 2 + var_130_23 and arg_127_1.time_ < 2 + var_130_23 + arg_130_0 then
				var_130_22.localPosition = Vector3.New(3.79, -0.64, 4.5)
			end

			local var_130_24 = 3.1

			if 3.1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_25 = 0.3

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_25 then
				local var_130_26 = Color.New(1, 1, 1)

				var_130_26.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_24) / var_130_25)
				arg_127_1.mask_.color = var_130_26
			end

			if arg_127_1.time_ >= var_130_24 + var_130_25 and arg_127_1.time_ < var_130_24 + var_130_25 + arg_130_0 then
				local var_130_27 = Color.New(1, 1, 1)

				arg_127_1.mask_.enabled = false
				var_130_27.a = 0
				arg_127_1.mask_.color = var_130_27
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_28 = 3
			local var_130_29 = 0.2

			if 3 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_30 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_30:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_31 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(900701030).content)

				arg_127_1.text_.text = var_130_31

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_33 = 8 <= 0 and var_130_29 or var_130_29 * (utf8.len(var_130_31) / 8)

				if (8 <= 0 and var_130_29 or var_130_29 * (utf8.len(var_130_31) / 8)) > 0 and var_130_29 < var_130_33 then
					arg_127_1.talkMaxDuration = var_130_33
					var_130_28 = var_130_28 + 0.3

					if var_130_33 + var_130_28 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_33 + var_130_28
					end
				end

				arg_127_1.text_.text = var_130_31
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_34 = var_130_28 + 0.3
			local var_130_35 = math.max(var_130_29, arg_127_1.talkMaxDuration)

			if var_130_28 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_34 + var_130_35 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_34) / var_130_35

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_34 + var_130_35 and arg_127_1.time_ < var_130_34 + var_130_35 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play900701031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 900701031
		arg_133_1.duration_ = 5.57

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play900701032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0.0339999999999998 < arg_133_1.time_ and arg_133_1.time_ <= 0.0339999999999998 + arg_136_0 then
				arg_133_1.var_.moveOldPosOM0602 = arg_133_1.bgs_.OM0602.transform.localPosition
			end

			local var_136_0 = 1.091

			if 0.0339999999999998 <= arg_133_1.time_ and arg_133_1.time_ < 0.0339999999999998 + var_136_0 then
				arg_133_1.bgs_.OM0602.transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosOM0602, Vector3.New(0, 1, 10), (arg_133_1.time_ - 0.0339999999999998) / var_136_0)
			end

			if arg_133_1.time_ >= 0.0339999999999998 + var_136_0 and arg_133_1.time_ < 0.0339999999999998 + var_136_0 + arg_136_0 then
				arg_133_1.bgs_.OM0602.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_136_1 = arg_133_1.bgs_.OM0602.transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPosOM0602 = var_136_1.localPosition
				var_136_1.localScale = Vector3.New(1, 1, 1)
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosOM0602, Vector3.New(3.79, -0.64, 4.5), (arg_133_1.time_ - 0) / var_136_2)
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(3.79, -0.64, 4.5)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_3 = 0.566666666666667
			local var_136_4 = 0.125

			if 0.566666666666667 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_5 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_5:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(900701031).content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_8 = 5 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_6) / 5)

				if (5 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_6) / 5)) > 0 and var_136_4 < var_136_8 then
					arg_133_1.talkMaxDuration = var_136_8
					var_136_3 = var_136_3 + 0.3

					if var_136_8 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_6
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = var_136_3 + 0.3
			local var_136_10 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_9) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.091,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play900701032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 900701032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play900701033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.15

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119_1_split_1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(900701032).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 6 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 6)

				if (6 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 6)) > 0 and var_142_0 < var_142_3 then
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
	Play900701033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 900701033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play900701034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3021")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(900701033).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 17)

				if (17 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 17)) > 0 and var_146_0 < var_146_3 then
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
	Play900701034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 900701034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play900701035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.325

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(900701034).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 13 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 13)

				if (13 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 13)) > 0 and var_150_0 < var_150_3 then
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
	Play900701035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 900701035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play900701036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(900701035).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 24)

				if (24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 24)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play900701036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 900701036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play900701037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.2

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1138_split_7")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(900701036).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 8 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 8)

				if (8 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 8)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play900701037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 900701037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play900701038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.075

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(900701037).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 3 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 3)

				if (3 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 3)) > 0 and var_162_0 < var_162_3 then
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
	Play900701038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 900701038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play900701039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.625

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(900701038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 25 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 25)

				if (25 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 25)) > 0 and var_166_0 < var_166_3 then
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
	Play900701039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 900701039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play900701040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(900701039).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 15 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 15)

				if (15 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 15)) > 0 and var_170_0 < var_170_3 then
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
	Play900701040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 900701040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play900701041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.175

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(900701040).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 7 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 7)

				if (7 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 7)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play900701041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 900701041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play900701042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119_1_split_6")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(900701041).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)

				if (16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play900701042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 900701042
		arg_179_1.duration_ = 7

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play900701043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.bgs_.OM0601 == nil then
				local var_182_0 = Object.Instantiate(arg_179_1.paintGo_)

				var_182_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0601")
				var_182_0.name = "OM0601"
				var_182_0.transform.parent = arg_179_1.stage_.transform
				var_182_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.bgs_.OM0601 = var_182_0
			end

			if 1 < arg_179_1.time_ and arg_179_1.time_ <= 1 + arg_182_0 then
				local var_182_1 = arg_179_1.bgs_.OM0601

				arg_179_1.bgs_.OM0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_182_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_2 = var_182_1:GetComponent("SpriteRenderer")

				if var_182_2 and var_182_2.sprite then
					local var_182_3 = 2 * (var_182_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_182_1.transform.localScale = Vector3.New(var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "OM0601" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_4 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_5 = 1

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_5 then
				local var_182_6 = Color.New(1, 1, 1)

				var_182_6.a = Mathf.Lerp(0, 1, (arg_179_1.time_ - var_182_4) / var_182_5)
				arg_179_1.mask_.color = var_182_6
			end

			if arg_179_1.time_ >= var_182_4 + var_182_5 and arg_179_1.time_ < var_182_4 + var_182_5 + arg_182_0 then
				local var_182_7 = Color.New(1, 1, 1)

				var_182_7.a = 1
				arg_179_1.mask_.color = var_182_7
			end

			local var_182_8 = 1

			if 1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_9 = 1

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 then
				local var_182_10 = Color.New(1, 1, 1)

				var_182_10.a = Mathf.Lerp(1, 0, (arg_179_1.time_ - var_182_8) / var_182_9)
				arg_179_1.mask_.color = var_182_10
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 then
				local var_182_11 = Color.New(1, 1, 1)

				arg_179_1.mask_.enabled = false
				var_182_11.a = 0
				arg_179_1.mask_.color = var_182_11
			end

			local var_182_12 = arg_179_1.bgs_.OM0602.transform

			if 0.966 < arg_179_1.time_ and arg_179_1.time_ <= 0.966 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0602 = var_182_12.localPosition
			end

			local var_182_13 = 0.001

			if 0.966 <= arg_179_1.time_ and arg_179_1.time_ < 0.966 + var_182_13 then
				var_182_12.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0602, Vector3.New(0, 100, 10), (arg_179_1.time_ - 0.966) / var_182_13)
			end

			if arg_179_1.time_ >= 0.966 + var_182_13 and arg_179_1.time_ < 0.966 + var_182_13 + arg_182_0 then
				var_182_12.localPosition = Vector3.New(0, 100, 10)
			end

			local var_182_14 = arg_179_1.bgs_.OM0601.transform

			if 1 < arg_179_1.time_ and arg_179_1.time_ <= 1 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0601 = var_182_14.localPosition
			end

			local var_182_15 = 0.001

			if 1 <= arg_179_1.time_ and arg_179_1.time_ < 1 + var_182_15 then
				var_182_14.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0601, Vector3.New(-3.43, 1.67, 3.5), (arg_179_1.time_ - 1) / var_182_15)
			end

			if arg_179_1.time_ >= 1 + var_182_15 and arg_179_1.time_ < 1 + var_182_15 + arg_182_0 then
				var_182_14.localPosition = Vector3.New(-3.43, 1.67, 3.5)
			end

			local var_182_16 = arg_179_1.bgs_.OM0601.transform

			if 1.034 < arg_179_1.time_ and arg_179_1.time_ <= 1.034 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0601 = var_182_16.localPosition
			end

			local var_182_17 = 1.291

			if 1.034 <= arg_179_1.time_ and arg_179_1.time_ < 1.034 + var_182_17 then
				var_182_16.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0601, Vector3.New(-3.43, -0.25, 3.5), (arg_179_1.time_ - 1.034) / var_182_17)
			end

			if arg_179_1.time_ >= 1.034 + var_182_17 and arg_179_1.time_ < 1.034 + var_182_17 + arg_182_0 then
				var_182_16.localPosition = Vector3.New(-3.43, -0.25, 3.5)
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_18 = 2
			local var_182_19 = 0.325

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_18 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_20 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_20:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_21 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(900701042).content)

				arg_179_1.text_.text = var_182_21

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_23 = 13 <= 0 and var_182_19 or var_182_19 * (utf8.len(var_182_21) / 13)

				if (13 <= 0 and var_182_19 or var_182_19 * (utf8.len(var_182_21) / 13)) > 0 and var_182_19 < var_182_23 then
					arg_179_1.talkMaxDuration = var_182_23
					var_182_18 = var_182_18 + 0.3

					if var_182_23 + var_182_18 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_18
					end
				end

				arg_179_1.text_.text = var_182_21
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_24 = var_182_18 + 0.3
			local var_182_25 = math.max(var_182_19, arg_179_1.talkMaxDuration)

			if var_182_18 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_24 + var_182_25 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_24) / var_182_25

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_24 + var_182_25 and arg_179_1.time_ < var_182_24 + var_182_25 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.291,
				className = "StoryMoveNode",
				startTime = 1.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play900701043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 900701043
		arg_185_1.duration_ = 5.62

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play900701044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPosOM0601 = arg_185_1.bgs_.OM0601.transform.localPosition
			end

			local var_188_0 = 1.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.bgs_.OM0601.transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosOM0601, Vector3.New(3.75, 0.07, 3), (arg_185_1.time_ - 0) / var_188_0)
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.bgs_.OM0601.transform.localPosition = Vector3.New(3.75, 0.07, 3)
			end

			local var_188_1 = 0.625
			local var_188_2 = 0.375

			if 0.625 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(900701043).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 15 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 15)

				if (15 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 15)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play900701044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 900701044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play900701045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.25

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(900701044).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 10 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 10)

				if (10 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 10)) > 0 and var_192_0 < var_192_3 then
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
	Play900701045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 900701045
		arg_193_1.duration_ = 5.37

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play900701046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPosOM0601 = arg_193_1.bgs_.OM0601.transform.localPosition
			end

			local var_196_0 = 0.533333333333333

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.bgs_.OM0601.transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPosOM0601, Vector3.New(0, 1, 10), (arg_193_1.time_ - 0) / var_196_0)
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.bgs_.OM0601.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_196_1 = 0.367333333333333
			local var_196_2 = 0.2

			if 0.367333333333333 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(900701045).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 8 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 8)

				if (8 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 8)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.533333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play900701046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 900701046
		arg_197_1.duration_ = 7.38

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play900701047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_0 = arg_197_1.bgs_.OM0601

				arg_197_1.bgs_.OM0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_1 = var_200_0:GetComponent("SpriteRenderer")

				if var_200_1 and var_200_1.sprite then
					local var_200_2 = 2 * (var_200_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_0.transform.localScale = Vector3.New(var_200_2 / var_200_1.sprite.bounds.size.y < var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x and var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x or var_200_2 / var_200_1.sprite.bounds.size.y, var_200_2 / var_200_1.sprite.bounds.size.y < var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x and var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x or var_200_2 / var_200_1.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "OM0601" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_3 = manager.ui.mainCamera.transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.shakeOldPos = var_200_3.localPosition
			end

			local var_200_4 = 2.53333333333333

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				local var_200_5, var_200_6 = math.modf((arg_197_1.time_ - 0) / 0.066)

				var_200_3.localPosition = Vector3.New(var_200_6 * 0.13, var_200_6 * 0.13, var_200_6 * 0.13) + arg_197_1.var_.shakeOldPos
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = arg_197_1.var_.shakeOldPos
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_7 = arg_197_1.bgs_.OM0601:GetComponent("SpriteRenderer")

				if var_200_7 then
					arg_197_1.var_.alphaOldValueOM0601 = var_200_7.color.a
					arg_197_1.var_.alphaMatValueOM0601 = var_200_7
				end

				arg_197_1.var_.alphaOldValueOM0601 = 1
			end

			local var_200_8 = 1.6

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_8 then
				if arg_197_1.var_.alphaMatValueOM0601 then
					arg_197_1.var_.alphaMatValueOM0601.color.a = Mathf.Lerp(arg_197_1.var_.alphaOldValueOM0601, 0, (arg_197_1.time_ - 0) / var_200_8)
					arg_197_1.var_.alphaMatValueOM0601.color = arg_197_1.var_.alphaMatValueOM0601.color
				end
			end

			if arg_197_1.time_ >= 0 + var_200_8 and arg_197_1.time_ < 0 + var_200_8 + arg_200_0 and arg_197_1.var_.alphaMatValueOM0601 then
				arg_197_1.var_.alphaMatValueOM0601.color.a = 0
				arg_197_1.var_.alphaMatValueOM0601.color = arg_197_1.var_.alphaMatValueOM0601.color
			end

			local var_200_9 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_10 = 0.15

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 then
				local var_200_11 = Color.New(1, 1, 1)

				var_200_11.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_9) / var_200_10)
				arg_197_1.mask_.color = var_200_11
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 then
				local var_200_12 = Color.New(1, 1, 1)

				arg_197_1.mask_.enabled = false
				var_200_12.a = 0
				arg_197_1.mask_.color = var_200_12
			end

			local var_200_13 = 0.6

			if 0.6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_14 = 1

			if var_200_13 <= arg_197_1.time_ and arg_197_1.time_ < var_200_13 + var_200_14 then
				local var_200_15 = Color.New(1, 1, 1)

				var_200_15.a = Mathf.Lerp(0, 1, (arg_197_1.time_ - var_200_13) / var_200_14)
				arg_197_1.mask_.color = var_200_15
			end

			if arg_197_1.time_ >= var_200_13 + var_200_14 and arg_197_1.time_ < var_200_13 + var_200_14 + arg_200_0 then
				local var_200_16 = Color.New(1, 1, 1)

				var_200_16.a = 1
				arg_197_1.mask_.color = var_200_16
			end

			local var_200_17 = 1.6

			if 1.6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_17 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_18 = 1

			if var_200_17 <= arg_197_1.time_ and arg_197_1.time_ < var_200_17 + var_200_18 then
				local var_200_19 = Color.New(1, 1, 1)

				var_200_19.a = Mathf.Lerp(1, 0, (arg_197_1.time_ - var_200_17) / var_200_18)
				arg_197_1.mask_.color = var_200_19
			end

			if arg_197_1.time_ >= var_200_17 + var_200_18 and arg_197_1.time_ < var_200_17 + var_200_18 + arg_200_0 then
				local var_200_20 = Color.New(1, 1, 1)

				arg_197_1.mask_.enabled = false
				var_200_20.a = 0
				arg_197_1.mask_.color = var_200_20
			end

			local var_200_21 = "STwhite"

			if arg_197_1.bgs_.STwhite == nil then
				local var_200_22 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_22:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_21)
				var_200_22.name = var_200_21
				var_200_22.transform.parent = arg_197_1.stage_.transform
				var_200_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_21] = var_200_22
			end

			local var_200_23 = arg_197_1.bgs_.STwhite.transform

			if 1.6 < arg_197_1.time_ and arg_197_1.time_ <= 1.6 + arg_200_0 then
				arg_197_1.var_.moveOldPosSTwhite = var_200_23.localPosition
				var_200_23.localScale = Vector3.New(13, 13, 13)
			end

			local var_200_24 = 0.001

			if 1.6 <= arg_197_1.time_ and arg_197_1.time_ < 1.6 + var_200_24 then
				var_200_23.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_197_1.time_ - 1.6) / var_200_24)
			end

			if arg_197_1.time_ >= 1.6 + var_200_24 and arg_197_1.time_ < 1.6 + var_200_24 + arg_200_0 then
				var_200_23.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_25 = 2.38333333333333
			local var_200_26 = 0.15

			if 2.38333333333333 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_27 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_27:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3021")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_28 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(900701046).content)

				arg_197_1.text_.text = var_200_28

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_30 = 6 <= 0 and var_200_26 or var_200_26 * (utf8.len(var_200_28) / 6)

				if (6 <= 0 and var_200_26 or var_200_26 * (utf8.len(var_200_28) / 6)) > 0 and var_200_26 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30
					var_200_25 = var_200_25 + 0.3

					if var_200_30 + var_200_25 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_25
					end
				end

				arg_197_1.text_.text = var_200_28
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_31 = var_200_25 + 0.3
			local var_200_32 = math.max(var_200_26, arg_197_1.talkMaxDuration)

			if var_200_25 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_31 + var_200_32 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_31) / var_200_32

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_31 + var_200_32 and arg_197_1.time_ < var_200_31 + var_200_32 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play900701047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 900701047
		arg_203_1.duration_ = 7.5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play900701048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_9000

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				local var_206_0 = arg_203_1.bgs_.OM0602

				arg_203_1.bgs_.OM0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_1 = var_206_0:GetComponent("SpriteRenderer")

				if var_206_1 and var_206_1.sprite then
					local var_206_2 = 2 * (var_206_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_0.transform.localScale = Vector3.New(var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "OM0602" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_3 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_4 = 1.5

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_4 then
				local var_206_5 = Color.New(0, 0, 0)

				var_206_5.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_3) / var_206_4)
				arg_203_1.mask_.color = var_206_5
			end

			if arg_203_1.time_ >= var_206_3 + var_206_4 and arg_203_1.time_ < var_206_3 + var_206_4 + arg_206_0 then
				local var_206_6 = Color.New(0, 0, 0)

				var_206_6.a = 1
				arg_203_1.mask_.color = var_206_6
			end

			local var_206_7 = 1.5

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = false

				arg_203_1:SetGaussion(false)
			end

			local var_206_8 = 1

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 then
				local var_206_9 = Color.New(0, 0, 0)

				var_206_9.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_7) / var_206_8)
				arg_203_1.mask_.color = var_206_9
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 then
				local var_206_10 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_10.a = 0
				arg_203_1.mask_.color = var_206_10
			end

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				local var_206_11 = arg_203_1.var_.effect1234

				if not arg_203_1.var_.effect1234 then
					var_206_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_206_11.name = "1234"
					arg_203_1.var_.effect1234 = var_206_11
				else
					var_206_11.transform:SetParent(var_206_9000)
				end

				var_206_11.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_206_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_206_13 = 2.03333333333333

			if 2.03333333333333 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_14 = 0.466666666666666

			if var_206_13 <= arg_203_1.time_ and arg_203_1.time_ < var_206_13 + var_206_14 then
				local var_206_15 = Color.New(1, 1, 1)

				var_206_15.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_13) / var_206_14)
				arg_203_1.mask_.color = var_206_15
			end

			if arg_203_1.time_ >= var_206_13 + var_206_14 and arg_203_1.time_ < var_206_13 + var_206_14 + arg_206_0 then
				local var_206_16 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_16.a = 0
				arg_203_1.mask_.color = var_206_16
			end

			local var_206_17 = arg_203_1.bgs_.OM0602.transform

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				arg_203_1.var_.moveOldPosOM0602 = var_206_17.localPosition
			end

			local var_206_18 = 0.001

			if 1.5 <= arg_203_1.time_ and arg_203_1.time_ < 1.5 + var_206_18 then
				var_206_17.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosOM0602, Vector3.New(0.5, 1.96, 8), (arg_203_1.time_ - 1.5) / var_206_18)
			end

			if arg_203_1.time_ >= 1.5 + var_206_18 and arg_203_1.time_ < 1.5 + var_206_18 + arg_206_0 then
				var_206_17.localPosition = Vector3.New(0.5, 1.96, 8)
			end

			local var_206_19 = arg_203_1.bgs_.OM0602.transform

			if 1.534 < arg_203_1.time_ and arg_203_1.time_ <= 1.534 + arg_206_0 then
				arg_203_1.var_.moveOldPosOM0602 = var_206_19.localPosition
			end

			local var_206_20 = 0.499333333333334

			if 1.534 <= arg_203_1.time_ and arg_203_1.time_ < 1.534 + var_206_20 then
				var_206_19.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosOM0602, Vector3.New(-2.1, 0.45, 8), (arg_203_1.time_ - 1.534) / var_206_20)
			end

			if arg_203_1.time_ >= 1.534 + var_206_20 and arg_203_1.time_ < 1.534 + var_206_20 + arg_206_0 then
				var_206_19.localPosition = Vector3.New(-2.1, 0.45, 8)
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_21 = 2.5
			local var_206_22 = 0.275

			if 2.5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_23 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_23:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_24 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(900701047).content)

				arg_203_1.text_.text = var_206_24

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 11 <= 0 and var_206_22 or var_206_22 * (utf8.len(var_206_24) / 11)

				if (11 <= 0 and var_206_22 or var_206_22 * (utf8.len(var_206_24) / 11)) > 0 and var_206_22 < var_206_26 then
					arg_203_1.talkMaxDuration = var_206_26
					var_206_21 = var_206_21 + 0.3

					if var_206_26 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_26 + var_206_21
					end
				end

				arg_203_1.text_.text = var_206_24
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_27 = var_206_21 + 0.3
			local var_206_28 = math.max(var_206_22, arg_203_1.talkMaxDuration)

			if var_206_21 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_27 + var_206_28 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_27) / var_206_28

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_27 + var_206_28 and arg_203_1.time_ < var_206_27 + var_206_28 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.499333333333334,
				className = "StoryMoveNode",
				startTime = 1.534,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play900701048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 900701048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play900701049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.225

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(900701048).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 9 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 9)

				if (9 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 9)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play900701049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 900701049
		arg_213_1.duration_ = 5.2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play900701050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				local var_216_1, var_216_2 = math.modf((arg_213_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_216_2 * 0.13, var_216_2 * 0.13, var_216_2 * 0.13) + arg_213_1.var_.shakeOldPos
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				manager.ui.mainCamera.transform.localPosition = arg_213_1.var_.shakeOldPos
			end

			local var_216_3 = arg_213_1.bgs_.OM0602.transform

			if 0.2 < arg_213_1.time_ and arg_213_1.time_ <= 0.2 + arg_216_0 then
				arg_213_1.var_.moveOldPosOM0602 = var_216_3.localPosition
			end

			local var_216_4 = 0.001

			if 0.2 <= arg_213_1.time_ and arg_213_1.time_ < 0.2 + var_216_4 then
				var_216_3.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPosOM0602, Vector3.New(3.73, -0.25, 3), (arg_213_1.time_ - 0.2) / var_216_4)
			end

			if arg_213_1.time_ >= 0.2 + var_216_4 and arg_213_1.time_ < 0.2 + var_216_4 + arg_216_0 then
				var_216_3.localPosition = Vector3.New(3.73, -0.25, 3)
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_5 = 0.2
			local var_216_6 = 0.2

			if 0.2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_7 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_7:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(900701049).content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 8 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 8)

				if (8 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 8)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10
					var_216_5 = var_216_5 + 0.3

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = var_216_5 + 0.3
			local var_216_12 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_11 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_11) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_11 + var_216_12 and arg_213_1.time_ < var_216_11 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play900701050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 900701050
		arg_219_1.duration_ = 7

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play900701051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_0 = 1

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				local var_222_1 = Color.New(1, 1, 1)

				var_222_1.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.mask_.color = var_222_1
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				local var_222_2 = Color.New(1, 1, 1)

				var_222_2.a = 1
				arg_219_1.mask_.color = var_222_2
			end

			local var_222_3 = 1

			if 1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_4 = 1

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_4 then
				local var_222_5 = Color.New(1, 1, 1)

				var_222_5.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_3) / var_222_4)
				arg_219_1.mask_.color = var_222_5
			end

			if arg_219_1.time_ >= var_222_3 + var_222_4 and arg_219_1.time_ < var_222_3 + var_222_4 + arg_222_0 then
				local var_222_6 = Color.New(1, 1, 1)

				arg_219_1.mask_.enabled = false
				var_222_6.a = 0
				arg_219_1.mask_.color = var_222_6
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				if arg_219_1.var_.effect1234 then
					Object.Destroy(arg_219_1.var_.effect1234)

					arg_219_1.var_.effect1234 = nil
				end
			end

			local var_222_8 = arg_219_1.bgs_.STwhite.transform

			if 1 < arg_219_1.time_ and arg_219_1.time_ <= 1 + arg_222_0 then
				arg_219_1.var_.moveOldPosSTwhite = var_222_8.localPosition
				var_222_8.localScale = Vector3.New(10, 10, 10)
			end

			local var_222_9 = 0.001

			if 1 <= arg_219_1.time_ and arg_219_1.time_ < 1 + var_222_9 then
				var_222_8.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_219_1.time_ - 1) / var_222_9)
			end

			if arg_219_1.time_ >= 1 + var_222_9 and arg_219_1.time_ < 1 + var_222_9 + arg_222_0 then
				var_222_8.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_10 = 2
			local var_222_11 = 1.15

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_12 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_12:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_13 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(900701050).content)

				arg_219_1.text_.text = var_222_13

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_15 = 46 <= 0 and var_222_11 or var_222_11 * (utf8.len(var_222_13) / 46)

				if (46 <= 0 and var_222_11 or var_222_11 * (utf8.len(var_222_13) / 46)) > 0 and var_222_11 < var_222_15 then
					arg_219_1.talkMaxDuration = var_222_15
					var_222_10 = var_222_10 + 0.3

					if var_222_15 + var_222_10 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_15 + var_222_10
					end
				end

				arg_219_1.text_.text = var_222_13
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = var_222_10 + 0.3
			local var_222_17 = math.max(var_222_11, arg_219_1.talkMaxDuration)

			if var_222_10 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_16) / var_222_17

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play900701051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 900701051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play900701052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_228_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_225_1.bgmTxt_.text ~= var_228_2 and arg_225_1.bgmTxt_.text ~= "" then
						if arg_225_1.bgmTxt2_.text ~= "" then
							arg_225_1.bgmTxt_.text = arg_225_1.bgmTxt2_.text
						end

						arg_225_1.bgmTxt2_.text = var_228_2

						arg_225_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_225_1.bgmTxt_.text = var_228_2
						arg_225_1.bgmTxt2_.text = var_228_2
					end

					if arg_225_1.bgmTimer then
						arg_225_1.bgmTimer:Stop()

						arg_225_1.bgmTimer = nil
					end

					if arg_225_1.settingData.show_music_name == 1 then
						arg_225_1.musicController:SetSelectedState("show")
						arg_225_1.musicAnimator_:Play("open", 0, 0)

						if arg_225_1.settingData.music_time ~= 0 then
							arg_225_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_225_1.settingData.music_time), function()
								if arg_225_1 == nil or isNil(arg_225_1.bgmTxt_) then
									return
								end

								arg_225_1.musicController:SetSelectedState("hide")
								arg_225_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_228_3 = 0
			local var_228_4 = 0.75

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_5 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(900701051).content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 30 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 30)

				if (30 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 30)) > 0 and var_228_4 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_3
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_4, arg_225_1.talkMaxDuration)

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_3) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_3 + var_228_8 and arg_225_1.time_ < var_228_3 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play900701052 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 900701052
		arg_230_1.duration_ = 7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play900701053(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				local var_233_0 = arg_230_1.bgs_.ST22a

				arg_230_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_233_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_1 = var_233_0:GetComponent("SpriteRenderer")

				if var_233_1 and var_233_1.sprite then
					local var_233_2 = 2 * (var_233_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_233_0.transform.localScale = Vector3.New(var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, var_233_2 / var_233_1.sprite.bounds.size.y < var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x and var_233_2 * manager.ui.mainCameraCom_.aspect / var_233_1.sprite.bounds.size.x or var_233_2 / var_233_1.sprite.bounds.size.y, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST22a" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_3 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_4 = 2

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_4 then
				local var_233_5 = Color.New(1, 1, 1)

				var_233_5.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_3) / var_233_4)
				arg_230_1.mask_.color = var_233_5
			end

			if arg_230_1.time_ >= var_233_3 + var_233_4 and arg_230_1.time_ < var_233_3 + var_233_4 + arg_233_0 then
				local var_233_6 = Color.New(1, 1, 1)

				arg_230_1.mask_.enabled = false
				var_233_6.a = 0
				arg_230_1.mask_.color = var_233_6
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_7 = 2
			local var_233_8 = 0.85

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_9 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_9:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(900701052).content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_12 = 34 <= 0 and var_233_8 or var_233_8 * (utf8.len(var_233_10) / 34)

				if (34 <= 0 and var_233_8 or var_233_8 * (utf8.len(var_233_10) / 34)) > 0 and var_233_8 < var_233_12 then
					arg_230_1.talkMaxDuration = var_233_12
					var_233_7 = var_233_7 + 0.3

					if var_233_12 + var_233_7 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_7
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = var_233_7 + 0.3
			local var_233_14 = math.max(var_233_8, arg_230_1.talkMaxDuration)

			if var_233_7 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_13 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_13) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_13 + var_233_14 and arg_230_1.time_ < var_233_13 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play900701053 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 900701053
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play900701054(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1033 = arg_236_1.actors_["1033"].transform.localPosition
				arg_236_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1033", 2)

				for iter_239_0 = 0, arg_236_1.actors_["1033"].transform.childCount - 1 do
					local var_239_0 = arg_236_1.actors_["1033"].transform:GetChild(iter_239_0)

					if var_239_0.name == "split_5" or not string.find(var_239_0.name, "split") then
						var_239_0.gameObject:SetActive(true)
					else
						var_239_0.gameObject:SetActive(false)
					end
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_236_1.time_ - 0) / var_239_1)
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_239_2 = arg_236_1.actors_["1033"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps1033 == nil then
				arg_236_1.var_.actorSpriteComps1033 = var_239_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_3 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.actorSpriteComps1033 then
					for iter_239_1, iter_239_2 in pairs(arg_236_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_239_2 then
							if arg_236_1.isInRecall_ then
								iter_239_2.color = Color.New(Mathf.Lerp(iter_239_2.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_3), Mathf.Lerp(iter_239_2.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_3), (Mathf.Lerp(iter_239_2.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_3)))
							else
								local var_239_4 = Mathf.Lerp(iter_239_2.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_3)

								iter_239_2.color = Color.New(var_239_4, var_239_4, var_239_4)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps1033 then
				for iter_239_3, iter_239_4 in pairs(arg_236_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_239_4 then
						iter_239_4.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps1033 = nil
			end

			local var_239_5 = arg_236_1.actors_["10022"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10022 = var_239_5.localPosition
				var_239_5.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10022", 4)

				for iter_239_5 = 0, var_239_5.childCount - 1 do
					local var_239_6 = var_239_5:GetChild(iter_239_5)

					if var_239_6.name == "split_3" or not string.find(var_239_6.name, "split") then
						var_239_6.gameObject:SetActive(true)
					else
						var_239_6.gameObject:SetActive(false)
					end
				end
			end

			local var_239_7 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				var_239_5.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10022, Vector3.New(390, -350, -180), (arg_236_1.time_ - 0) / var_239_7)
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				var_239_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_239_8 = arg_236_1.actors_["10022"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_9 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_9 and not isNil(var_239_8) then
				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_7 then
							if arg_236_1.isInRecall_ then
								iter_239_7.color = Color.New(Mathf.Lerp(iter_239_7.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_9), Mathf.Lerp(iter_239_7.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_9), (Mathf.Lerp(iter_239_7.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_9)))
							else
								local var_239_10 = Mathf.Lerp(iter_239_7.color.r, 1, (arg_236_1.time_ - 0) / var_239_9)

								iter_239_7.color = Color.New(var_239_10, var_239_10, var_239_10)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_9 and arg_236_1.time_ < 0 + var_239_9 + arg_239_0 and not isNil(var_239_8) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_8, iter_239_9 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_9 then
						iter_239_9.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				local var_239_11 = arg_236_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_239_11 then
					arg_236_1.var_.alphaOldValue1033 = var_239_11.alpha
					arg_236_1.var_.characterEffect1033 = var_239_11
				end

				arg_236_1.var_.alphaOldValue1033 = 0
			end

			local var_239_12 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_12 then
				if arg_236_1.var_.characterEffect1033 then
					arg_236_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_236_1.var_.alphaOldValue1033, 1, (arg_236_1.time_ - 0) / var_239_12)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_12 and arg_236_1.time_ < 0 + var_239_12 + arg_239_0 and arg_236_1.var_.characterEffect1033 then
				arg_236_1.var_.characterEffect1033.alpha = 1
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				local var_239_13 = arg_236_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_239_13 then
					arg_236_1.var_.alphaOldValue10022 = var_239_13.alpha
					arg_236_1.var_.characterEffect10022 = var_239_13
				end

				arg_236_1.var_.alphaOldValue10022 = 0
			end

			local var_239_14 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_14 then
				if arg_236_1.var_.characterEffect10022 then
					arg_236_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_236_1.var_.alphaOldValue10022, 1, (arg_236_1.time_ - 0) / var_239_14)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_14 and arg_236_1.time_ < 0 + var_239_14 + arg_239_0 and arg_236_1.var_.characterEffect10022 then
				arg_236_1.var_.characterEffect10022.alpha = 1
			end

			local var_239_15 = 0
			local var_239_16 = 0.275

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[235].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_17 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(900701053).content)

				arg_236_1.text_.text = var_239_17

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_19 = 11 <= 0 and var_239_16 or var_239_16 * (utf8.len(var_239_17) / 11)

				if (11 <= 0 and var_239_16 or var_239_16 * (utf8.len(var_239_17) / 11)) > 0 and var_239_16 < var_239_19 then
					arg_236_1.talkMaxDuration = var_239_19

					if var_239_19 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_19 + var_239_15
					end
				end

				arg_236_1.text_.text = var_239_17
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_20 = math.max(var_239_16, arg_236_1.talkMaxDuration)

			if var_239_15 <= arg_236_1.time_ and arg_236_1.time_ < var_239_15 + var_239_20 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_15) / var_239_20

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_15 + var_239_20 and arg_236_1.time_ < var_239_15 + var_239_20 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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

		arg_236_1:InitPlayNodeList()
	end,
	Play900701054 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 900701054
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play900701055(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1033"]) and arg_240_1.var_.actorSpriteComps1033 == nil then
				arg_240_1.var_.actorSpriteComps1033 = arg_240_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1033"]) then
				if arg_240_1.var_.actorSpriteComps1033 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								iter_243_1.color = Color.New(Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_0), Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_0), (Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_0)))
							else
								local var_243_1 = Mathf.Lerp(iter_243_1.color.r, 1, (arg_240_1.time_ - 0) / var_243_0)

								iter_243_1.color = Color.New(var_243_1, var_243_1, var_243_1)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1033"]) and arg_240_1.var_.actorSpriteComps1033 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps1033 = nil
			end

			local var_243_2 = arg_240_1.actors_["10022"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10022 == nil then
				arg_240_1.var_.actorSpriteComps10022 = var_243_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_3 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.actorSpriteComps10022 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								iter_243_5.color = Color.New(Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, (arg_240_1.time_ - 0) / var_243_3), Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, (arg_240_1.time_ - 0) / var_243_3), (Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, (arg_240_1.time_ - 0) / var_243_3)))
							else
								local var_243_4 = Mathf.Lerp(iter_243_5.color.r, 0.5, (arg_240_1.time_ - 0) / var_243_3)

								iter_243_5.color = Color.New(var_243_4, var_243_4, var_243_4)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10022 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_243_7 then
						iter_243_7.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_240_1.var_.actorSpriteComps10022 = nil
			end

			local var_243_5 = 0
			local var_243_6 = 0.675

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(900701054).content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 27 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_7) / 27)

				if (27 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_7) / 27)) > 0 and var_243_6 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_5
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_6, arg_240_1.talkMaxDuration)

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_5) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_5 + var_243_10 and arg_240_1.time_ < var_243_5 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play900701055 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 900701055
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play900701056(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1033 = arg_244_1.actors_["1033"].transform.localPosition
				arg_244_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1033", 7)

				for iter_247_0 = 0, arg_244_1.actors_["1033"].transform.childCount - 1 do
					local var_247_0 = arg_244_1.actors_["1033"].transform:GetChild(iter_247_0)

					if var_247_0.name == "split_5" or not string.find(var_247_0.name, "split") then
						var_247_0.gameObject:SetActive(true)
					else
						var_247_0.gameObject:SetActive(false)
					end
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_244_1.time_ - 0) / var_247_1)
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_247_2 = arg_244_1.actors_["10022"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10022 = var_247_2.localPosition
				var_247_2.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10022", 7)

				for iter_247_1 = 0, var_247_2.childCount - 1 do
					local var_247_3 = var_247_2:GetChild(iter_247_1)

					if var_247_3.name == "split_3" or not string.find(var_247_3.name, "split") then
						var_247_3.gameObject:SetActive(true)
					else
						var_247_3.gameObject:SetActive(false)
					end
				end
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_2.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_244_1.time_ - 0) / var_247_4)
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_247_5 = 0
			local var_247_6 = 0.675

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(900701055).content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 27 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 27)

				if (27 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 27)) > 0 and var_247_6 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_10 and arg_244_1.time_ < var_247_5 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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

		arg_244_1:InitPlayNodeList()
	end,
	Play900701056 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 900701056
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play900701057(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1038 = arg_248_1.actors_["1038"].transform.localPosition
				arg_248_1.actors_["1038"].transform.localScale = Vector3.New(-1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("1038", 4)

				for iter_251_0 = 0, arg_248_1.actors_["1038"].transform.childCount - 1 do
					local var_251_0 = arg_248_1.actors_["1038"].transform:GetChild(iter_251_0)

					if var_251_0.name == "split_1" or not string.find(var_251_0.name, "split") then
						var_251_0.gameObject:SetActive(true)
					else
						var_251_0.gameObject:SetActive(false)
					end
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_248_1.time_ - 0) / var_251_1)
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["1038"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_251_2 = arg_248_1.actors_["1038"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1038 == nil then
				arg_248_1.var_.actorSpriteComps1038 = var_251_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_3 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 and not isNil(var_251_2) then
				if arg_248_1.var_.actorSpriteComps1038 then
					for iter_251_1, iter_251_2 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_251_2 then
							if arg_248_1.isInRecall_ then
								iter_251_2.color = Color.New(Mathf.Lerp(iter_251_2.color.r, arg_248_1.hightColor1.r, (arg_248_1.time_ - 0) / var_251_3), Mathf.Lerp(iter_251_2.color.g, arg_248_1.hightColor1.g, (arg_248_1.time_ - 0) / var_251_3), (Mathf.Lerp(iter_251_2.color.b, arg_248_1.hightColor1.b, (arg_248_1.time_ - 0) / var_251_3)))
							else
								local var_251_4 = Mathf.Lerp(iter_251_2.color.r, 1, (arg_248_1.time_ - 0) / var_251_3)

								iter_251_2.color = Color.New(var_251_4, var_251_4, var_251_4)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1038 then
				for iter_251_3, iter_251_4 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_251_4 then
						iter_251_4.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_248_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				local var_251_5 = arg_248_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_251_5 then
					arg_248_1.var_.alphaOldValue1038 = var_251_5.alpha
					arg_248_1.var_.characterEffect1038 = var_251_5
				end

				arg_248_1.var_.alphaOldValue1038 = 0
			end

			local var_251_6 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_6 then
				if arg_248_1.var_.characterEffect1038 then
					arg_248_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_248_1.var_.alphaOldValue1038, 1, (arg_248_1.time_ - 0) / var_251_6)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_6 and arg_248_1.time_ < 0 + var_251_6 + arg_251_0 and arg_248_1.var_.characterEffect1038 then
				arg_248_1.var_.characterEffect1038.alpha = 1
			end

			local var_251_7 = 0
			local var_251_8 = 0.25

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				arg_248_1.dialog_:SetActive(true)

				arg_248_1.dialogCg_.alpha = 0

				local var_251_9 = LeanTween.value(arg_248_1.dialog_, 0, 1, 0.3)

				var_251_9:setOnUpdate(LuaHelper.FloatAction(function(arg_252_0)
					arg_248_1.dialogCg_.alpha = arg_252_0
				end))
				var_251_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_248_1.dialog_)
					var_251_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_248_1.duration_ = arg_248_1.duration_ + 0.3

				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(900701056).content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_12 = 10 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_10) / 10)

				if (10 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_10) / 10)) > 0 and var_251_8 < var_251_12 then
					arg_248_1.talkMaxDuration = var_251_12
					var_251_7 = var_251_7 + 0.3

					if var_251_12 + var_251_7 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_7
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_13 = var_251_7 + 0.3
			local var_251_14 = math.max(var_251_8, arg_248_1.talkMaxDuration)

			if var_251_7 + 0.3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_13 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_13) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_13 + var_251_14 and arg_248_1.time_ < var_251_13 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play900701057 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 900701057
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play900701058(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if arg_254_1.actors_["1019"] == nil then
				local var_257_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_257_0) then
					local var_257_1 = Object.Instantiate(var_257_0, arg_254_1.canvasGo_.transform)

					var_257_1.transform:SetSiblingIndex(1)

					var_257_1.name = "1019"
					var_257_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_254_1.actors_["1019"] = var_257_1

					if arg_254_1.isInRecall_ then
						for iter_257_0, iter_257_1 in ipairs((var_257_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_257_1.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_257_2 = arg_254_1.actors_["1019"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1019 = var_257_2.localPosition
				var_257_2.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1019", 2)

				for iter_257_2 = 0, var_257_2.childCount - 1 do
					local var_257_3 = var_257_2:GetChild(iter_257_2)

					if var_257_3.name == "split_1" or not string.find(var_257_3.name, "split") then
						var_257_3.gameObject:SetActive(true)
					else
						var_257_3.gameObject:SetActive(false)
					end
				end
			end

			local var_257_4 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1019, Vector3.New(-600, -340, 200), (arg_254_1.time_ - 0) / var_257_4)
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_257_5 = arg_254_1.actors_["1019"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_5) and arg_254_1.var_.actorSpriteComps1019 == nil then
				arg_254_1.var_.actorSpriteComps1019 = var_257_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_6 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_6 and not isNil(var_257_5) then
				if arg_254_1.var_.actorSpriteComps1019 then
					for iter_257_3, iter_257_4 in pairs(arg_254_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_257_4 then
							if arg_254_1.isInRecall_ then
								iter_257_4.color = Color.New(Mathf.Lerp(iter_257_4.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_6), Mathf.Lerp(iter_257_4.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_6), (Mathf.Lerp(iter_257_4.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_6)))
							else
								local var_257_7 = Mathf.Lerp(iter_257_4.color.r, 1, (arg_254_1.time_ - 0) / var_257_6)

								iter_257_4.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_6 and arg_254_1.time_ < 0 + var_257_6 + arg_257_0 and not isNil(var_257_5) and arg_254_1.var_.actorSpriteComps1019 then
				for iter_257_5, iter_257_6 in pairs(arg_254_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_257_6 then
						iter_257_6.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps1019 = nil
			end

			local var_257_8 = arg_254_1.actors_["1038"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps1038 == nil then
				arg_254_1.var_.actorSpriteComps1038 = var_257_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_9 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_9 and not isNil(var_257_8) then
				if arg_254_1.var_.actorSpriteComps1038 then
					for iter_257_7, iter_257_8 in pairs(arg_254_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_257_8 then
							if arg_254_1.isInRecall_ then
								iter_257_8.color = Color.New(Mathf.Lerp(iter_257_8.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_9), Mathf.Lerp(iter_257_8.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_9), (Mathf.Lerp(iter_257_8.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_9)))
							else
								local var_257_10 = Mathf.Lerp(iter_257_8.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_9)

								iter_257_8.color = Color.New(var_257_10, var_257_10, var_257_10)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_9 and arg_254_1.time_ < 0 + var_257_9 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps1038 then
				for iter_257_9, iter_257_10 in pairs(arg_254_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_257_10 then
						iter_257_10.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				local var_257_11 = arg_254_1.actors_["1019"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_257_11 then
					arg_254_1.var_.alphaOldValue1019 = var_257_11.alpha
					arg_254_1.var_.characterEffect1019 = var_257_11
				end

				arg_254_1.var_.alphaOldValue1019 = 0
			end

			local var_257_12 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_12 then
				if arg_254_1.var_.characterEffect1019 then
					arg_254_1.var_.characterEffect1019.alpha = Mathf.Lerp(arg_254_1.var_.alphaOldValue1019, 1, (arg_254_1.time_ - 0) / var_257_12)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_12 and arg_254_1.time_ < 0 + var_257_12 + arg_257_0 and arg_254_1.var_.characterEffect1019 then
				arg_254_1.var_.characterEffect1019.alpha = 1
			end

			local var_257_13 = 0
			local var_257_14 = 0.25

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_15 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(900701057).content)

				arg_254_1.text_.text = var_257_15

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_17 = 10 <= 0 and var_257_14 or var_257_14 * (utf8.len(var_257_15) / 10)

				if (10 <= 0 and var_257_14 or var_257_14 * (utf8.len(var_257_15) / 10)) > 0 and var_257_14 < var_257_17 then
					arg_254_1.talkMaxDuration = var_257_17

					if var_257_17 + var_257_13 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_13
					end
				end

				arg_254_1.text_.text = var_257_15
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_18 = math.max(var_257_14, arg_254_1.talkMaxDuration)

			if var_257_13 <= arg_254_1.time_ and arg_254_1.time_ < var_257_13 + var_257_18 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_13) / var_257_18

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_13 + var_257_18 and arg_254_1.time_ < var_257_13 + var_257_18 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play900701058 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 900701058
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play900701059(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1019 = arg_258_1.actors_["1019"].transform.localPosition
				arg_258_1.actors_["1019"].transform.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1019", 7)

				for iter_261_0 = 0, arg_258_1.actors_["1019"].transform.childCount - 1 do
					local var_261_0 = arg_258_1.actors_["1019"].transform:GetChild(iter_261_0)

					if var_261_0.name == "split_1" or not string.find(var_261_0.name, "split") then
						var_261_0.gameObject:SetActive(true)
					else
						var_261_0.gameObject:SetActive(false)
					end
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["1019"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_258_1.time_ - 0) / var_261_1)
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["1019"].transform.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_261_2 = arg_258_1.actors_["1038"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1038 = var_261_2.localPosition
				var_261_2.localScale = Vector3.New(-1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1038", 7)

				for iter_261_1 = 0, var_261_2.childCount - 1 do
					local var_261_3 = var_261_2:GetChild(iter_261_1)

					if var_261_3.name == "split_1" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_2.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_258_1.time_ - 0) / var_261_4)
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_5 = arg_258_1.actors_["1033"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1033 = var_261_5.localPosition
				var_261_5.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1033", 3)

				for iter_261_2 = 0, var_261_5.childCount - 1 do
					local var_261_6 = var_261_5:GetChild(iter_261_2)

					if var_261_6.name == "split_4" or not string.find(var_261_6.name, "split") then
						var_261_6.gameObject:SetActive(true)
					else
						var_261_6.gameObject:SetActive(false)
					end
				end
			end

			local var_261_7 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_258_1.time_ - 0) / var_261_7)
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(0, -420, 0)
			end

			local var_261_8 = arg_258_1.actors_["1033"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps1033 == nil then
				arg_258_1.var_.actorSpriteComps1033 = var_261_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_9 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_9 and not isNil(var_261_8) then
				if arg_258_1.var_.actorSpriteComps1033 then
					for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_261_4 then
							if arg_258_1.isInRecall_ then
								iter_261_4.color = Color.New(Mathf.Lerp(iter_261_4.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 0) / var_261_9), Mathf.Lerp(iter_261_4.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 0) / var_261_9), (Mathf.Lerp(iter_261_4.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 0) / var_261_9)))
							else
								local var_261_10 = Mathf.Lerp(iter_261_4.color.r, 1, (arg_258_1.time_ - 0) / var_261_9)

								iter_261_4.color = Color.New(var_261_10, var_261_10, var_261_10)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_9 and arg_258_1.time_ < 0 + var_261_9 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps1033 then
				for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_261_6 then
						iter_261_6.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps1033 = nil
			end

			local var_261_11 = 0
			local var_261_12 = 0.325

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_11 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_13 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(900701058).content)

				arg_258_1.text_.text = var_261_13

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_15 = 13 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_13) / 13)

				if (13 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_13) / 13)) > 0 and var_261_12 < var_261_15 then
					arg_258_1.talkMaxDuration = var_261_15

					if var_261_15 + var_261_11 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_15 + var_261_11
					end
				end

				arg_258_1.text_.text = var_261_13
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_12, arg_258_1.talkMaxDuration)

			if var_261_11 <= arg_258_1.time_ and arg_258_1.time_ < var_261_11 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_11) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_11 + var_261_16 and arg_258_1.time_ < var_261_11 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play900701059 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 900701059
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play900701060(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1019 = arg_262_1.actors_["1019"].transform.localPosition
				arg_262_1.actors_["1019"].transform.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1019", 2)

				for iter_265_0 = 0, arg_262_1.actors_["1019"].transform.childCount - 1 do
					local var_265_0 = arg_262_1.actors_["1019"].transform:GetChild(iter_265_0)

					if var_265_0.name == "split_1" or not string.find(var_265_0.name, "split") then
						var_265_0.gameObject:SetActive(true)
					else
						var_265_0.gameObject:SetActive(false)
					end
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["1019"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1019, Vector3.New(-600, -340, 200), (arg_262_1.time_ - 0) / var_265_1)
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["1019"].transform.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_265_2 = arg_262_1.actors_["1038"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1038 = var_265_2.localPosition
				var_265_2.localScale = Vector3.New(-1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1038", 4)

				for iter_265_1 = 0, var_265_2.childCount - 1 do
					local var_265_3 = var_265_2:GetChild(iter_265_1)

					if var_265_3.name == "split_2" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				var_265_2.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_262_1.time_ - 0) / var_265_4)
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				var_265_2.localPosition = Vector3.New(390, -400, 0)
			end

			local var_265_5 = arg_262_1.actors_["1019"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.actorSpriteComps1019 == nil then
				arg_262_1.var_.actorSpriteComps1019 = var_265_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_6 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_6 and not isNil(var_265_5) then
				if arg_262_1.var_.actorSpriteComps1019 then
					for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_265_3 then
							if arg_262_1.isInRecall_ then
								iter_265_3.color = Color.New(Mathf.Lerp(iter_265_3.color.r, arg_262_1.hightColor2.r, (arg_262_1.time_ - 0) / var_265_6), Mathf.Lerp(iter_265_3.color.g, arg_262_1.hightColor2.g, (arg_262_1.time_ - 0) / var_265_6), (Mathf.Lerp(iter_265_3.color.b, arg_262_1.hightColor2.b, (arg_262_1.time_ - 0) / var_265_6)))
							else
								local var_265_7 = Mathf.Lerp(iter_265_3.color.r, 0.5, (arg_262_1.time_ - 0) / var_265_6)

								iter_265_3.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_6 and arg_262_1.time_ < 0 + var_265_6 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.actorSpriteComps1019 then
				for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_265_5 then
						iter_265_5.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_262_1.var_.actorSpriteComps1019 = nil
			end

			local var_265_8 = arg_262_1.actors_["1038"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps1038 == nil then
				arg_262_1.var_.actorSpriteComps1038 = var_265_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_9 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_9 and not isNil(var_265_8) then
				if arg_262_1.var_.actorSpriteComps1038 then
					for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_265_7 then
							if arg_262_1.isInRecall_ then
								iter_265_7.color = Color.New(Mathf.Lerp(iter_265_7.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_9), Mathf.Lerp(iter_265_7.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_9), (Mathf.Lerp(iter_265_7.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_9)))
							else
								local var_265_10 = Mathf.Lerp(iter_265_7.color.r, 1, (arg_262_1.time_ - 0) / var_265_9)

								iter_265_7.color = Color.New(var_265_10, var_265_10, var_265_10)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_9 and arg_262_1.time_ < 0 + var_265_9 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps1038 then
				for iter_265_8, iter_265_9 in pairs(arg_262_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_265_9 then
						iter_265_9.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps1038 = nil
			end

			local var_265_11 = arg_262_1.actors_["1033"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1033 = var_265_11.localPosition
				var_265_11.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1033", 7)

				for iter_265_10 = 0, var_265_11.childCount - 1 do
					local var_265_12 = var_265_11:GetChild(iter_265_10)

					if var_265_12.name == "split_4" or not string.find(var_265_12.name, "split") then
						var_265_12.gameObject:SetActive(true)
					else
						var_265_12.gameObject:SetActive(false)
					end
				end
			end

			local var_265_13 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_13 then
				var_265_11.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_262_1.time_ - 0) / var_265_13)
			end

			if arg_262_1.time_ >= 0 + var_265_13 and arg_262_1.time_ < 0 + var_265_13 + arg_265_0 then
				var_265_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_14 = 0
			local var_265_15 = 0.475

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_16 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(900701059).content)

				arg_262_1.text_.text = var_265_16

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_18 = 19 <= 0 and var_265_15 or var_265_15 * (utf8.len(var_265_16) / 19)

				if (19 <= 0 and var_265_15 or var_265_15 * (utf8.len(var_265_16) / 19)) > 0 and var_265_15 < var_265_18 then
					arg_262_1.talkMaxDuration = var_265_18

					if var_265_18 + var_265_14 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_14
					end
				end

				arg_262_1.text_.text = var_265_16
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_19 = math.max(var_265_15, arg_262_1.talkMaxDuration)

			if var_265_14 <= arg_262_1.time_ and arg_262_1.time_ < var_265_14 + var_265_19 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_14) / var_265_19

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_14 + var_265_19 and arg_262_1.time_ < var_265_14 + var_265_19 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play900701060 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 900701060
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play900701061(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1019"]) and arg_266_1.var_.actorSpriteComps1019 == nil then
				arg_266_1.var_.actorSpriteComps1019 = arg_266_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1019"]) then
				if arg_266_1.var_.actorSpriteComps1019 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 1, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1019"]) and arg_266_1.var_.actorSpriteComps1019 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps1019 = nil
			end

			local var_269_2 = arg_266_1.actors_["1038"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps1038 == nil then
				arg_266_1.var_.actorSpriteComps1038 = var_269_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_3 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.actorSpriteComps1038 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_269_5 then
							if arg_266_1.isInRecall_ then
								iter_269_5.color = Color.New(Mathf.Lerp(iter_269_5.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_3), Mathf.Lerp(iter_269_5.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_3), (Mathf.Lerp(iter_269_5.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_3)))
							else
								local var_269_4 = Mathf.Lerp(iter_269_5.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_3)

								iter_269_5.color = Color.New(var_269_4, var_269_4, var_269_4)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps1038 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_269_7 then
						iter_269_7.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps1038 = nil
			end

			local var_269_5 = 0
			local var_269_6 = 0.275

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(900701060).content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 11 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 11)

				if (11 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 11)) > 0 and var_269_6 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_10 and arg_266_1.time_ < var_269_5 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play900701061 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 900701061
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play900701062(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1033 = arg_270_1.actors_["1033"].transform.localPosition
				arg_270_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1033", 3)

				for iter_273_0 = 0, arg_270_1.actors_["1033"].transform.childCount - 1 do
					local var_273_0 = arg_270_1.actors_["1033"].transform:GetChild(iter_273_0)

					if var_273_0.name == "split_2" or not string.find(var_273_0.name, "split") then
						var_273_0.gameObject:SetActive(true)
					else
						var_273_0.gameObject:SetActive(false)
					end
				end
			end

			local var_273_1 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 then
				arg_270_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_270_1.time_ - 0) / var_273_1)
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 then
				arg_270_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_273_2 = arg_270_1.actors_["1033"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1033 == nil then
				arg_270_1.var_.actorSpriteComps1033 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps1033 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								iter_273_2.color = Color.New(Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_2.color.r, 1, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_2.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1033 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_273_4 then
						iter_273_4.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps1033 = nil
			end

			local var_273_5 = arg_270_1.actors_["1019"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1019 = var_273_5.localPosition
				var_273_5.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1019", 7)

				for iter_273_5 = 0, var_273_5.childCount - 1 do
					local var_273_6 = var_273_5:GetChild(iter_273_5)

					if var_273_6.name == "split_1" or not string.find(var_273_6.name, "split") then
						var_273_6.gameObject:SetActive(true)
					else
						var_273_6.gameObject:SetActive(false)
					end
				end
			end

			local var_273_7 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_270_1.time_ - 0) / var_273_7)
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_273_8 = arg_270_1.actors_["1038"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(-1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1038", 7)

				for iter_273_6 = 0, var_273_8.childCount - 1 do
					local var_273_9 = var_273_8:GetChild(iter_273_6)

					if var_273_9.name == "split_2" or not string.find(var_273_9.name, "split") then
						var_273_9.gameObject:SetActive(true)
					else
						var_273_9.gameObject:SetActive(false)
					end
				end
			end

			local var_273_10 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_10 then
				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_270_1.time_ - 0) / var_273_10)
			end

			if arg_270_1.time_ >= 0 + var_273_10 and arg_270_1.time_ < 0 + var_273_10 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_11 = 0
			local var_273_12 = 0.3

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(900701061).content)

				arg_270_1.text_.text = var_273_13

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 12 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 12)

				if (12 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 12)) > 0 and var_273_12 < var_273_15 then
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
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900701062 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 900701062
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play900701063(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1033 = arg_274_1.actors_["1033"].transform.localPosition
				arg_274_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1033", 7)

				for iter_277_0 = 0, arg_274_1.actors_["1033"].transform.childCount - 1 do
					local var_277_0 = arg_274_1.actors_["1033"].transform:GetChild(iter_277_0)

					if var_277_0.name == "split_2" or not string.find(var_277_0.name, "split") then
						var_277_0.gameObject:SetActive(true)
					else
						var_277_0.gameObject:SetActive(false)
					end
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_274_1.time_ - 0) / var_277_1)
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_277_2 = arg_274_1.actors_["1038"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps1038 == nil then
				arg_274_1.var_.actorSpriteComps1038 = var_277_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_3 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 and not isNil(var_277_2) then
				if arg_274_1.var_.actorSpriteComps1038 then
					for iter_277_1, iter_277_2 in pairs(arg_274_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_277_2 then
							if arg_274_1.isInRecall_ then
								iter_277_2.color = Color.New(Mathf.Lerp(iter_277_2.color.r, arg_274_1.hightColor1.r, (arg_274_1.time_ - 0) / var_277_3), Mathf.Lerp(iter_277_2.color.g, arg_274_1.hightColor1.g, (arg_274_1.time_ - 0) / var_277_3), (Mathf.Lerp(iter_277_2.color.b, arg_274_1.hightColor1.b, (arg_274_1.time_ - 0) / var_277_3)))
							else
								local var_277_4 = Mathf.Lerp(iter_277_2.color.r, 1, (arg_274_1.time_ - 0) / var_277_3)

								iter_277_2.color = Color.New(var_277_4, var_277_4, var_277_4)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps1038 then
				for iter_277_3, iter_277_4 in pairs(arg_274_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_277_4 then
						iter_277_4.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_274_1.var_.actorSpriteComps1038 = nil
			end

			local var_277_5 = arg_274_1.actors_["1019"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1019 = var_277_5.localPosition
				var_277_5.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1019", 7)

				for iter_277_5 = 0, var_277_5.childCount - 1 do
					local var_277_6 = var_277_5:GetChild(iter_277_5)

					if var_277_6.name == "split_1" or not string.find(var_277_6.name, "split") then
						var_277_6.gameObject:SetActive(true)
					else
						var_277_6.gameObject:SetActive(false)
					end
				end
			end

			local var_277_7 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				var_277_5.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_274_1.time_ - 0) / var_277_7)
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				var_277_5.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_277_8 = arg_274_1.actors_["1038"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1038 = var_277_8.localPosition
				var_277_8.localScale = Vector3.New(-1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1038", 4)

				for iter_277_6 = 0, var_277_8.childCount - 1 do
					local var_277_9 = var_277_8:GetChild(iter_277_6)

					if var_277_9.name == "split_9" or not string.find(var_277_9.name, "split") then
						var_277_9.gameObject:SetActive(true)
					else
						var_277_9.gameObject:SetActive(false)
					end
				end
			end

			local var_277_10 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_10 then
				var_277_8.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_274_1.time_ - 0) / var_277_10)
			end

			if arg_274_1.time_ >= 0 + var_277_10 and arg_274_1.time_ < 0 + var_277_10 + arg_277_0 then
				var_277_8.localPosition = Vector3.New(390, -400, 0)
			end

			local var_277_11 = 0
			local var_277_12 = 0.65

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_11 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_13 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(900701062).content)

				arg_274_1.text_.text = var_277_13

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_15 = 26 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_13) / 26)

				if (26 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_13) / 26)) > 0 and var_277_12 < var_277_15 then
					arg_274_1.talkMaxDuration = var_277_15

					if var_277_15 + var_277_11 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_15 + var_277_11
					end
				end

				arg_274_1.text_.text = var_277_13
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_12, arg_274_1.talkMaxDuration)

			if var_277_11 <= arg_274_1.time_ and arg_274_1.time_ < var_277_11 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_11) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_11 + var_277_16 and arg_274_1.time_ < var_277_11 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play900701063 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 900701063
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play900701064(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1019 = arg_278_1.actors_["1019"].transform.localPosition
				arg_278_1.actors_["1019"].transform.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("1019", 2)

				for iter_281_0 = 0, arg_278_1.actors_["1019"].transform.childCount - 1 do
					local var_281_0 = arg_278_1.actors_["1019"].transform:GetChild(iter_281_0)

					if var_281_0.name == "split_1" or not string.find(var_281_0.name, "split") then
						var_281_0.gameObject:SetActive(true)
					else
						var_281_0.gameObject:SetActive(false)
					end
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["1019"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1019, Vector3.New(-600, -340, 200), (arg_278_1.time_ - 0) / var_281_1)
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["1019"].transform.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_281_2 = arg_278_1.actors_["1019"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps1019 == nil then
				arg_278_1.var_.actorSpriteComps1019 = var_281_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_3 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.actorSpriteComps1019 then
					for iter_281_1, iter_281_2 in pairs(arg_278_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_281_2 then
							if arg_278_1.isInRecall_ then
								iter_281_2.color = Color.New(Mathf.Lerp(iter_281_2.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 0) / var_281_3), Mathf.Lerp(iter_281_2.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 0) / var_281_3), (Mathf.Lerp(iter_281_2.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 0) / var_281_3)))
							else
								local var_281_4 = Mathf.Lerp(iter_281_2.color.r, 1, (arg_278_1.time_ - 0) / var_281_3)

								iter_281_2.color = Color.New(var_281_4, var_281_4, var_281_4)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps1019 then
				for iter_281_3, iter_281_4 in pairs(arg_278_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_281_4 then
						iter_281_4.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps1019 = nil
			end

			local var_281_5 = arg_278_1.actors_["1038"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps1038 == nil then
				arg_278_1.var_.actorSpriteComps1038 = var_281_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_6 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_6 and not isNil(var_281_5) then
				if arg_278_1.var_.actorSpriteComps1038 then
					for iter_281_5, iter_281_6 in pairs(arg_278_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_281_6 then
							if arg_278_1.isInRecall_ then
								iter_281_6.color = Color.New(Mathf.Lerp(iter_281_6.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_6), Mathf.Lerp(iter_281_6.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_6), (Mathf.Lerp(iter_281_6.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_6)))
							else
								local var_281_7 = Mathf.Lerp(iter_281_6.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_6)

								iter_281_6.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_6 and arg_278_1.time_ < 0 + var_281_6 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps1038 then
				for iter_281_7, iter_281_8 in pairs(arg_278_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_281_8 then
						iter_281_8.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps1038 = nil
			end

			local var_281_8 = 0
			local var_281_9 = 0.2

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_10 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(900701063).content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_12 = 8 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_10) / 8)

				if (8 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_10) / 8)) > 0 and var_281_9 < var_281_12 then
					arg_278_1.talkMaxDuration = var_281_12

					if var_281_12 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_12 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_13 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_13 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_13

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_13 and arg_278_1.time_ < var_281_8 + var_281_13 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
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
	Play900701064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 900701064
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play900701065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1038 = arg_282_1.actors_["1038"].transform.localPosition
				arg_282_1.actors_["1038"].transform.localScale = Vector3.New(-1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("1038", 4)

				for iter_285_0 = 0, arg_282_1.actors_["1038"].transform.childCount - 1 do
					local var_285_0 = arg_282_1.actors_["1038"].transform:GetChild(iter_285_0)

					if var_285_0.name == "split_5" or not string.find(var_285_0.name, "split") then
						var_285_0.gameObject:SetActive(true)
					else
						var_285_0.gameObject:SetActive(false)
					end
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_282_1.time_ - 0) / var_285_1)
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["1038"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_285_2 = arg_282_1.actors_["1038"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps1038 == nil then
				arg_282_1.var_.actorSpriteComps1038 = var_285_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_3 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.actorSpriteComps1038 then
					for iter_285_1, iter_285_2 in pairs(arg_282_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_285_2 then
							if arg_282_1.isInRecall_ then
								iter_285_2.color = Color.New(Mathf.Lerp(iter_285_2.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_3), Mathf.Lerp(iter_285_2.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_3), (Mathf.Lerp(iter_285_2.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_3)))
							else
								local var_285_4 = Mathf.Lerp(iter_285_2.color.r, 1, (arg_282_1.time_ - 0) / var_285_3)

								iter_285_2.color = Color.New(var_285_4, var_285_4, var_285_4)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps1038 then
				for iter_285_3, iter_285_4 in pairs(arg_282_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_285_4 then
						iter_285_4.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps1038 = nil
			end

			local var_285_5 = arg_282_1.actors_["1019"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps1019 == nil then
				arg_282_1.var_.actorSpriteComps1019 = var_285_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_6 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_6 and not isNil(var_285_5) then
				if arg_282_1.var_.actorSpriteComps1019 then
					for iter_285_5, iter_285_6 in pairs(arg_282_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_285_6 then
							if arg_282_1.isInRecall_ then
								iter_285_6.color = Color.New(Mathf.Lerp(iter_285_6.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_6), Mathf.Lerp(iter_285_6.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_6), (Mathf.Lerp(iter_285_6.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_6)))
							else
								local var_285_7 = Mathf.Lerp(iter_285_6.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_6)

								iter_285_6.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_6 and arg_282_1.time_ < 0 + var_285_6 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps1019 then
				for iter_285_7, iter_285_8 in pairs(arg_282_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_285_8 then
						iter_285_8.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps1019 = nil
			end

			local var_285_8 = 0
			local var_285_9 = 0.125

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_10 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(900701064).content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_12 = 6 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 6)

				if (6 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_10) / 6)) > 0 and var_285_9 < var_285_12 then
					arg_282_1.talkMaxDuration = var_285_12

					if var_285_12 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_13 and arg_282_1.time_ < var_285_8 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play900701065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 900701065
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
			arg_286_1.auto_ = false
		end

		function arg_286_1.playNext_(arg_288_0)
			arg_286_1.onStoryFinished_()
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.75

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(900701065).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 30 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 30)

				if (30 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 30)) > 0 and var_289_0 < var_289_3 then
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
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/OM0602",
		"TextureConfig/Background/OM0601"
	},
	voices = {}
}
