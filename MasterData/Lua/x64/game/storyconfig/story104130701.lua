return {
	Play413071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F10g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_4_0.name = "F10g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F10g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F10g

				arg_1_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F10g" then
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
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 1.4

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413071001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 56 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 56)

				if (56 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 56)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 413071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play413071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(413071002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 48 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 48)

				if (48 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 48)) > 0 and var_11_0 < var_11_3 then
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
	Play413071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 413071003
		arg_12_1.duration_ = 7.31

		local var_12_0 = {
			zh = 3.975,
			ja = 7.308
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play413071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["10092"] == nil then
				local var_15_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_15_0) then
					local var_15_1 = Object.Instantiate(var_15_0, arg_12_1.canvasGo_.transform)

					var_15_1.transform:SetSiblingIndex(1)

					var_15_1.name = "10092"
					var_15_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_["10092"] = var_15_1

					if arg_12_1.isInRecall_ then
						for iter_15_0, iter_15_1 in ipairs((var_15_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_15_1.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_2 = arg_12_1.actors_["10092"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10092 = var_15_2.localPosition
				var_15_2.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10092", 2)

				for iter_15_2 = 0, var_15_2.childCount - 1 do
					local var_15_3 = var_15_2:GetChild(iter_15_2)

					if var_15_3.name == "split_8" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_2.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_12_1.time_ - 0) / var_15_4)
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_15_5 = arg_12_1.actors_["10092"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.actorSpriteComps10092 == nil then
				arg_12_1.var_.actorSpriteComps10092 = var_15_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_6 = 2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.actorSpriteComps10092 then
					for iter_15_3, iter_15_4 in pairs(arg_12_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_15_4 then
							if arg_12_1.isInRecall_ then
								iter_15_4.color = Color.New(Mathf.Lerp(iter_15_4.color.r, arg_12_1.hightColor1.r, (arg_12_1.time_ - 0) / var_15_6), Mathf.Lerp(iter_15_4.color.g, arg_12_1.hightColor1.g, (arg_12_1.time_ - 0) / var_15_6), (Mathf.Lerp(iter_15_4.color.b, arg_12_1.hightColor1.b, (arg_12_1.time_ - 0) / var_15_6)))
							else
								local var_15_7 = Mathf.Lerp(iter_15_4.color.r, 1, (arg_12_1.time_ - 0) / var_15_6)

								iter_15_4.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.actorSpriteComps10092 then
				for iter_15_5, iter_15_6 in pairs(arg_12_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_15_6 then
						iter_15_6.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_8 = arg_12_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_15_8 then
					arg_12_1.var_.alphaOldValue10092 = var_15_8.alpha
					arg_12_1.var_.characterEffect10092 = var_15_8
				end

				arg_12_1.var_.alphaOldValue10092 = 0
			end

			local var_15_9 = 0.5

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				if arg_12_1.var_.characterEffect10092 then
					arg_12_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_12_1.var_.alphaOldValue10092, 1, (arg_12_1.time_ - 0) / var_15_9)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 and arg_12_1.var_.characterEffect10092 then
				arg_12_1.var_.characterEffect10092.alpha = 1
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_15_12 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_12 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_12

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_12
						arg_12_1.bgmTxt2_.text = var_15_12
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_13 = 0.475
			local var_15_14 = 0.525

			if 0.475 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_15 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_15:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_12_1.dialogCg_.alpha = arg_17_0
				end))
				var_15_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:GetWordFromCfg(413071003)
				local var_15_17 = arg_12_1:FormatText(var_15_16.content)

				arg_12_1.text_.text = var_15_17

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 21 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_17) / 21)

				if (21 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_17) / 21)) > 0 and var_15_14 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19
					var_15_13 = var_15_13 + 0.3

					if var_15_19 + var_15_13 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_13
					end
				end

				arg_12_1.text_.text = var_15_17
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071003", "story_v_out_413071.awb") ~= 0 then
					local var_15_20 = manager.audio:GetVoiceLength("story_v_out_413071", "413071003", "story_v_out_413071.awb") / 1000

					if var_15_20 + var_15_13 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_13
					end

					if var_15_16.prefab_name ~= "" and arg_12_1.actors_[var_15_16.prefab_name] ~= nil then
						local var_15_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_16.prefab_name].transform, "story_v_out_413071", "413071003", "story_v_out_413071.awb")

						arg_12_1:RecordAudio("413071003", var_15_21)
						arg_12_1:RecordAudio("413071003", var_15_21)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_413071", "413071003", "story_v_out_413071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_413071", "413071003", "story_v_out_413071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = var_15_13 + 0.3
			local var_15_23 = math.max(var_15_14, arg_12_1.talkMaxDuration)

			if var_15_13 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_23 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_23

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_23 and arg_12_1.time_ < var_15_22 + var_15_23 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play413071004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413071004
		arg_19_1.duration_ = 6

		local var_19_0 = {
			zh = 2.7,
			ja = 6
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
				arg_19_0:Play413071005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["10094"] == nil then
				local var_22_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_22_0) then
					local var_22_1 = Object.Instantiate(var_22_0, arg_19_1.canvasGo_.transform)

					var_22_1.transform:SetSiblingIndex(1)

					var_22_1.name = "10094"
					var_22_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_["10094"] = var_22_1

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs((var_22_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_2 = arg_19_1.actors_["10094"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos10094 = var_22_2.localPosition
				var_22_2.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("10094", 4)

				for iter_22_2 = 0, var_22_2.childCount - 1 do
					local var_22_3 = var_22_2:GetChild(iter_22_2)

					if var_22_3.name == "" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_2.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_19_1.time_ - 0) / var_22_4)
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_22_5 = arg_19_1.actors_["10092"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps10092 == nil then
				arg_19_1.var_.actorSpriteComps10092 = var_22_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_6 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.actorSpriteComps10092 then
					for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_22_4 then
							if arg_19_1.isInRecall_ then
								iter_22_4.color = Color.New(Mathf.Lerp(iter_22_4.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_6), Mathf.Lerp(iter_22_4.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_6), (Mathf.Lerp(iter_22_4.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_6)))
							else
								local var_22_7 = Mathf.Lerp(iter_22_4.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_6)

								iter_22_4.color = Color.New(var_22_7, var_22_7, var_22_7)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.actorSpriteComps10092 then
				for iter_22_5, iter_22_6 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_22_6 then
						iter_22_6.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps10092 = nil
			end

			local var_22_8 = arg_19_1.actors_["10094"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10094 == nil then
				arg_19_1.var_.actorSpriteComps10094 = var_22_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_9 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 and not isNil(var_22_8) then
				if arg_19_1.var_.actorSpriteComps10094 then
					for iter_22_7, iter_22_8 in pairs(arg_19_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_22_8 then
							if arg_19_1.isInRecall_ then
								iter_22_8.color = Color.New(Mathf.Lerp(iter_22_8.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_9), Mathf.Lerp(iter_22_8.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_9), (Mathf.Lerp(iter_22_8.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_9)))
							else
								local var_22_10 = Mathf.Lerp(iter_22_8.color.r, 1, (arg_19_1.time_ - 0) / var_22_9)

								iter_22_8.color = Color.New(var_22_10, var_22_10, var_22_10)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10094 then
				for iter_22_9, iter_22_10 in pairs(arg_19_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_22_10 then
						iter_22_10.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_11 = arg_19_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_11 then
					arg_19_1.var_.alphaOldValue10094 = var_22_11.alpha
					arg_19_1.var_.characterEffect10094 = var_22_11
				end

				arg_19_1.var_.alphaOldValue10094 = 0
			end

			local var_22_12 = 0.5

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_12 then
				if arg_19_1.var_.characterEffect10094 then
					arg_19_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue10094, 1, (arg_19_1.time_ - 0) / var_22_12)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_12 and arg_19_1.time_ < 0 + var_22_12 + arg_22_0 and arg_19_1.var_.characterEffect10094 then
				arg_19_1.var_.characterEffect10094.alpha = 1
			end

			local var_22_13 = 0
			local var_22_14 = 0.35

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_15 = arg_19_1:GetWordFromCfg(413071004)
				local var_22_16 = arg_19_1:FormatText(var_22_15.content)

				arg_19_1.text_.text = var_22_16

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_18 = 14 <= 0 and var_22_14 or var_22_14 * (utf8.len(var_22_16) / 14)

				if (14 <= 0 and var_22_14 or var_22_14 * (utf8.len(var_22_16) / 14)) > 0 and var_22_14 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18

					if var_22_18 + var_22_13 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_13
					end
				end

				arg_19_1.text_.text = var_22_16
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071004", "story_v_out_413071.awb") ~= 0 then
					local var_22_19 = manager.audio:GetVoiceLength("story_v_out_413071", "413071004", "story_v_out_413071.awb") / 1000

					if var_22_19 + var_22_13 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_13
					end

					if var_22_15.prefab_name ~= "" and arg_19_1.actors_[var_22_15.prefab_name] ~= nil then
						local var_22_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_15.prefab_name].transform, "story_v_out_413071", "413071004", "story_v_out_413071.awb")

						arg_19_1:RecordAudio("413071004", var_22_20)
						arg_19_1:RecordAudio("413071004", var_22_20)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413071", "413071004", "story_v_out_413071.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413071", "413071004", "story_v_out_413071.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_14, arg_19_1.talkMaxDuration)

			if var_22_13 <= arg_19_1.time_ and arg_19_1.time_ < var_22_13 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_13) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_13 + var_22_21 and arg_19_1.time_ < var_22_13 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play413071005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413071005
		arg_23_1.duration_ = 5.53

		local var_23_0 = {
			zh = 3.733,
			ja = 5.533
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
				arg_23_0:Play413071006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10092 = arg_23_1.actors_["10092"].transform.localPosition
				arg_23_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10092", 2)

				for iter_26_0 = 0, arg_23_1.actors_["10092"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["10092"].transform:GetChild(iter_26_0)

					if var_26_0.name == "split_8" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_23_1.time_ - 0) / var_26_1)
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_26_2 = arg_23_1.actors_["10094"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10094 = var_26_2.localPosition
				var_26_2.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10094", 4)

				for iter_26_1 = 0, var_26_2.childCount - 1 do
					local var_26_3 = var_26_2:GetChild(iter_26_1)

					if var_26_3.name == "" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_23_1.time_ - 0) / var_26_4)
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_26_5 = arg_23_1.actors_["10092"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.actorSpriteComps10092 == nil then
				arg_23_1.var_.actorSpriteComps10092 = var_26_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_6 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.actorSpriteComps10092 then
					for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_26_3 then
							if arg_23_1.isInRecall_ then
								iter_26_3.color = Color.New(Mathf.Lerp(iter_26_3.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 0) / var_26_6), Mathf.Lerp(iter_26_3.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 0) / var_26_6), (Mathf.Lerp(iter_26_3.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 0) / var_26_6)))
							else
								local var_26_7 = Mathf.Lerp(iter_26_3.color.r, 1, (arg_23_1.time_ - 0) / var_26_6)

								iter_26_3.color = Color.New(var_26_7, var_26_7, var_26_7)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.actorSpriteComps10092 then
				for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_26_5 then
						iter_26_5.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps10092 = nil
			end

			local var_26_8 = arg_23_1.actors_["10094"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10094 == nil then
				arg_23_1.var_.actorSpriteComps10094 = var_26_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_9 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_9 and not isNil(var_26_8) then
				if arg_23_1.var_.actorSpriteComps10094 then
					for iter_26_6, iter_26_7 in pairs(arg_23_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_26_7 then
							if arg_23_1.isInRecall_ then
								iter_26_7.color = Color.New(Mathf.Lerp(iter_26_7.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_9), Mathf.Lerp(iter_26_7.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_9), (Mathf.Lerp(iter_26_7.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_9)))
							else
								local var_26_10 = Mathf.Lerp(iter_26_7.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_9)

								iter_26_7.color = Color.New(var_26_10, var_26_10, var_26_10)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_9 and arg_23_1.time_ < 0 + var_26_9 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10094 then
				for iter_26_8, iter_26_9 in pairs(arg_23_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_26_9 then
						iter_26_9.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps10094 = nil
			end

			local var_26_11 = 0
			local var_26_12 = 0.55

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_13 = arg_23_1:GetWordFromCfg(413071005)
				local var_26_14 = arg_23_1:FormatText(var_26_13.content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 22 <= 0 and var_26_12 or var_26_12 * (utf8.len(var_26_14) / 22)

				if (22 <= 0 and var_26_12 or var_26_12 * (utf8.len(var_26_14) / 22)) > 0 and var_26_12 < var_26_16 then
					arg_23_1.talkMaxDuration = var_26_16

					if var_26_16 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071005", "story_v_out_413071.awb") ~= 0 then
					local var_26_17 = manager.audio:GetVoiceLength("story_v_out_413071", "413071005", "story_v_out_413071.awb") / 1000

					if var_26_17 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_17 + var_26_11
					end

					if var_26_13.prefab_name ~= "" and arg_23_1.actors_[var_26_13.prefab_name] ~= nil then
						local var_26_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_13.prefab_name].transform, "story_v_out_413071", "413071005", "story_v_out_413071.awb")

						arg_23_1:RecordAudio("413071005", var_26_18)
						arg_23_1:RecordAudio("413071005", var_26_18)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413071", "413071005", "story_v_out_413071.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413071", "413071005", "story_v_out_413071.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_19 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_19 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_19

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_19 and arg_23_1.time_ < var_26_11 + var_26_19 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play413071006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413071006
		arg_27_1.duration_ = 8.37

		local var_27_0 = {
			zh = 3.166,
			ja = 8.366
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
				arg_27_0:Play413071007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10094 = arg_27_1.actors_["10094"].transform.localPosition
				arg_27_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10094", 4)

				for iter_30_0 = 0, arg_27_1.actors_["10094"].transform.childCount - 1 do
					local var_30_0 = arg_27_1.actors_["10094"].transform:GetChild(iter_30_0)

					if var_30_0.name == "" or not string.find(var_30_0.name, "split") then
						var_30_0.gameObject:SetActive(true)
					else
						var_30_0.gameObject:SetActive(false)
					end
				end
			end

			local var_30_1 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				arg_27_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_27_1.time_ - 0) / var_30_1)
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 then
				arg_27_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_30_2 = arg_27_1.actors_["10092"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10092 == nil then
				arg_27_1.var_.actorSpriteComps10092 = var_30_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_3 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.actorSpriteComps10092 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								iter_30_2.color = Color.New(Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_3), Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_3), (Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_3)))
							else
								local var_30_4 = Mathf.Lerp(iter_30_2.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_3)

								iter_30_2.color = Color.New(var_30_4, var_30_4, var_30_4)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps10092 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_30_4 then
						iter_30_4.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps10092 = nil
			end

			local var_30_5 = arg_27_1.actors_["10094"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.actorSpriteComps10094 == nil then
				arg_27_1.var_.actorSpriteComps10094 = var_30_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_6 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.actorSpriteComps10094 then
					for iter_30_5, iter_30_6 in pairs(arg_27_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_30_6 then
							if arg_27_1.isInRecall_ then
								iter_30_6.color = Color.New(Mathf.Lerp(iter_30_6.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_6), Mathf.Lerp(iter_30_6.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_6), (Mathf.Lerp(iter_30_6.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_6)))
							else
								local var_30_7 = Mathf.Lerp(iter_30_6.color.r, 1, (arg_27_1.time_ - 0) / var_30_6)

								iter_30_6.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.actorSpriteComps10094 then
				for iter_30_7, iter_30_8 in pairs(arg_27_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_30_8 then
						iter_30_8.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps10094 = nil
			end

			local var_30_8 = 0
			local var_30_9 = 0.425

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(413071006)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 17 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 17)

				if (17 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 17)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071006", "story_v_out_413071.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_413071", "413071006", "story_v_out_413071.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_413071", "413071006", "story_v_out_413071.awb")

						arg_27_1:RecordAudio("413071006", var_30_15)
						arg_27_1:RecordAudio("413071006", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413071", "413071006", "story_v_out_413071.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413071", "413071006", "story_v_out_413071.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play413071007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413071007
		arg_31_1.duration_ = 6.4

		local var_31_0 = {
			zh = 3.133,
			ja = 6.4
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
				arg_31_0:Play413071008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(413071007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 18 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 18)

				if (18 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 18)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071007", "story_v_out_413071.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071007", "story_v_out_413071.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_413071", "413071007", "story_v_out_413071.awb")

						arg_31_1:RecordAudio("413071007", var_34_6)
						arg_31_1:RecordAudio("413071007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413071", "413071007", "story_v_out_413071.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413071", "413071007", "story_v_out_413071.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play413071008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413071008
		arg_35_1.duration_ = 4.7

		local var_35_0 = {
			zh = 2.766,
			ja = 4.7
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
				arg_35_0:Play413071009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = arg_35_1.actors_["10092"].transform.localPosition
				arg_35_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 2)

				for iter_38_0 = 0, arg_35_1.actors_["10092"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["10092"].transform:GetChild(iter_38_0)

					if var_38_0.name == "split_8" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_38_2 = arg_35_1.actors_["10094"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10094 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10094", 4)

				for iter_38_1 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_1)

					if var_38_3.name == "split_1" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_35_1.time_ - 0) / var_38_4)
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_38_5 = arg_35_1.actors_["10092"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.actorSpriteComps10092 == nil then
				arg_35_1.var_.actorSpriteComps10092 = var_38_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_6 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.actorSpriteComps10092 then
					for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_38_3 then
							if arg_35_1.isInRecall_ then
								iter_38_3.color = Color.New(Mathf.Lerp(iter_38_3.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_6), Mathf.Lerp(iter_38_3.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_6), (Mathf.Lerp(iter_38_3.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_6)))
							else
								local var_38_7 = Mathf.Lerp(iter_38_3.color.r, 1, (arg_35_1.time_ - 0) / var_38_6)

								iter_38_3.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.actorSpriteComps10092 then
				for iter_38_4, iter_38_5 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_38_5 then
						iter_38_5.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps10092 = nil
			end

			local var_38_8 = arg_35_1.actors_["10094"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_8) and arg_35_1.var_.actorSpriteComps10094 == nil then
				arg_35_1.var_.actorSpriteComps10094 = var_38_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_9 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_9 and not isNil(var_38_8) then
				if arg_35_1.var_.actorSpriteComps10094 then
					for iter_38_6, iter_38_7 in pairs(arg_35_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_38_7 then
							if arg_35_1.isInRecall_ then
								iter_38_7.color = Color.New(Mathf.Lerp(iter_38_7.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_9), Mathf.Lerp(iter_38_7.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_9), (Mathf.Lerp(iter_38_7.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_9)))
							else
								local var_38_10 = Mathf.Lerp(iter_38_7.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_9)

								iter_38_7.color = Color.New(var_38_10, var_38_10, var_38_10)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_9 and arg_35_1.time_ < 0 + var_38_9 + arg_38_0 and not isNil(var_38_8) and arg_35_1.var_.actorSpriteComps10094 then
				for iter_38_8, iter_38_9 in pairs(arg_35_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_38_9 then
						iter_38_9.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps10094 = nil
			end

			local var_38_11 = 0
			local var_38_12 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
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

				local var_38_13 = arg_35_1:GetWordFromCfg(413071008)
				local var_38_14 = arg_35_1:FormatText(var_38_13.content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 16 <= 0 and var_38_12 or var_38_12 * (utf8.len(var_38_14) / 16)

				if (16 <= 0 and var_38_12 or var_38_12 * (utf8.len(var_38_14) / 16)) > 0 and var_38_12 < var_38_16 then
					arg_35_1.talkMaxDuration = var_38_16

					if var_38_16 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_16 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071008", "story_v_out_413071.awb") ~= 0 then
					local var_38_17 = manager.audio:GetVoiceLength("story_v_out_413071", "413071008", "story_v_out_413071.awb") / 1000

					if var_38_17 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_17 + var_38_11
					end

					if var_38_13.prefab_name ~= "" and arg_35_1.actors_[var_38_13.prefab_name] ~= nil then
						local var_38_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_13.prefab_name].transform, "story_v_out_413071", "413071008", "story_v_out_413071.awb")

						arg_35_1:RecordAudio("413071008", var_38_18)
						arg_35_1:RecordAudio("413071008", var_38_18)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413071", "413071008", "story_v_out_413071.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413071", "413071008", "story_v_out_413071.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_19 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_19 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_19

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_19 and arg_35_1.time_ < var_38_11 + var_38_19 + arg_38_0 then
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

		arg_35_1:InitPlayNodeList()
	end,
	Play413071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413071009
		arg_39_1.duration_ = 8.9

		local var_39_0 = {
			zh = 4.7,
			ja = 8.9
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
				arg_39_0:Play413071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10092 = arg_39_1.actors_["10092"].transform.localPosition
				arg_39_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10092", 2)

				for iter_42_0 = 0, arg_39_1.actors_["10092"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["10092"].transform:GetChild(iter_42_0)

					if var_42_0.name == "split_8" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_42_2 = 0
			local var_42_3 = 0.675

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_4 = arg_39_1:GetWordFromCfg(413071009)
				local var_42_5 = arg_39_1:FormatText(var_42_4.content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 27 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 27)

				if (27 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 27)) > 0 and var_42_3 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071009", "story_v_out_413071.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071009", "story_v_out_413071.awb") / 1000

					if var_42_8 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_2
					end

					if var_42_4.prefab_name ~= "" and arg_39_1.actors_[var_42_4.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_4.prefab_name].transform, "story_v_out_413071", "413071009", "story_v_out_413071.awb")

						arg_39_1:RecordAudio("413071009", var_42_9)
						arg_39_1:RecordAudio("413071009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413071", "413071009", "story_v_out_413071.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413071", "413071009", "story_v_out_413071.awb")
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

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play413071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413071010
		arg_43_1.duration_ = 5.17

		local var_43_0 = {
			zh = 3.8,
			ja = 5.166
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
				arg_43_0:Play413071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10094 = arg_43_1.actors_["10094"].transform.localPosition
				arg_43_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10094", 4)

				for iter_46_0 = 0, arg_43_1.actors_["10094"].transform.childCount - 1 do
					local var_46_0 = arg_43_1.actors_["10094"].transform:GetChild(iter_46_0)

					if var_46_0.name == "" or not string.find(var_46_0.name, "split") then
						var_46_0.gameObject:SetActive(true)
					else
						var_46_0.gameObject:SetActive(false)
					end
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_43_1.time_ - 0) / var_46_1)
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_46_2 = arg_43_1.actors_["10092"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10092 == nil then
				arg_43_1.var_.actorSpriteComps10092 = var_46_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_3 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.actorSpriteComps10092 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								iter_46_2.color = Color.New(Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_3), Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_3), (Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_3)))
							else
								local var_46_4 = Mathf.Lerp(iter_46_2.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_3)

								iter_46_2.color = Color.New(var_46_4, var_46_4, var_46_4)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps10092 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_46_4 then
						iter_46_4.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10092 = nil
			end

			local var_46_5 = arg_43_1.actors_["10094"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10094 == nil then
				arg_43_1.var_.actorSpriteComps10094 = var_46_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_6 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.actorSpriteComps10094 then
					for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_46_6 then
							if arg_43_1.isInRecall_ then
								iter_46_6.color = Color.New(Mathf.Lerp(iter_46_6.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_6), Mathf.Lerp(iter_46_6.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_6), (Mathf.Lerp(iter_46_6.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_6)))
							else
								local var_46_7 = Mathf.Lerp(iter_46_6.color.r, 1, (arg_43_1.time_ - 0) / var_46_6)

								iter_46_6.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10094 then
				for iter_46_7, iter_46_8 in pairs(arg_43_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_46_8 then
						iter_46_8.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10094 = nil
			end

			local var_46_8 = 0
			local var_46_9 = 0.5

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(413071010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 20 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 20)

				if (20 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 20)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071010", "story_v_out_413071.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_413071", "413071010", "story_v_out_413071.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_413071", "413071010", "story_v_out_413071.awb")

						arg_43_1:RecordAudio("413071010", var_46_15)
						arg_43_1:RecordAudio("413071010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413071", "413071010", "story_v_out_413071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413071", "413071010", "story_v_out_413071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play413071011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413071011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413071012(arg_47_1)
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
				arg_47_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_2 = arg_47_1.actors_["10094"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10094 = var_50_2.localPosition
				var_50_2.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10094", 7)

				for iter_50_1 = 0, var_50_2.childCount - 1 do
					local var_50_3 = var_50_2:GetChild(iter_50_1)

					if var_50_3.name == "" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_2.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_47_1.time_ - 0) / var_50_4)
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_47_1.time_ and arg_47_1.time_ <= 0.133333333333333 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_engine", "")
			end

			local var_50_6 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			if arg_47_1.time_ >= var_50_6 + 1.56666666666667 and arg_47_1.time_ < var_50_6 + 1.56666666666667 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_7 = 0
			local var_50_8 = 1.75

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_9 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_9:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(413071011).content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 70 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 70)

				if (70 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 70)) > 0 and var_50_8 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12
					var_50_7 = var_50_7 + 0.3

					if var_50_12 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = var_50_7 + 0.3
			local var_50_14 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_13 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_13) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_13 + var_50_14 and arg_47_1.time_ < var_50_13 + var_50_14 + arg_50_0 then
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
	Play413071012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413071012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play413071013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.15

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_2 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_2:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(413071012).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 46 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 46)

				if (46 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 46)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5
					var_56_0 = var_56_0 + 0.3

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = var_56_0 + 0.3
			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413071013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413071013
		arg_59_1.duration_ = 4.3

		local var_59_0 = {
			zh = 4.2,
			ja = 4.3
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
				arg_59_0:Play413071014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10092 = arg_59_1.actors_["10092"].transform.localPosition
				arg_59_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10092", 3)

				for iter_62_0 = 0, arg_59_1.actors_["10092"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["10092"].transform:GetChild(iter_62_0)

					if var_62_0.name == "split_8" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_62_2 = arg_59_1.actors_["10092"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10092 == nil then
				arg_59_1.var_.actorSpriteComps10092 = var_62_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_3 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.actorSpriteComps10092 then
					for iter_62_1, iter_62_2 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_62_2 then
							if arg_59_1.isInRecall_ then
								iter_62_2.color = Color.New(Mathf.Lerp(iter_62_2.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_3), Mathf.Lerp(iter_62_2.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_3), (Mathf.Lerp(iter_62_2.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_3)))
							else
								local var_62_4 = Mathf.Lerp(iter_62_2.color.r, 1, (arg_59_1.time_ - 0) / var_62_3)

								iter_62_2.color = Color.New(var_62_4, var_62_4, var_62_4)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10092 then
				for iter_62_3, iter_62_4 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_62_4 then
						iter_62_4.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps10092 = nil
			end

			local var_62_5 = 0
			local var_62_6 = 0.575

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
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

				local var_62_7 = arg_59_1:GetWordFromCfg(413071013)
				local var_62_8 = arg_59_1:FormatText(var_62_7.content)

				arg_59_1.text_.text = var_62_8

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 23 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 23)

				if (23 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 23)) > 0 and var_62_6 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_5
					end
				end

				arg_59_1.text_.text = var_62_8
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071013", "story_v_out_413071.awb") ~= 0 then
					local var_62_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071013", "story_v_out_413071.awb") / 1000

					if var_62_11 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_5
					end

					if var_62_7.prefab_name ~= "" and arg_59_1.actors_[var_62_7.prefab_name] ~= nil then
						local var_62_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_7.prefab_name].transform, "story_v_out_413071", "413071013", "story_v_out_413071.awb")

						arg_59_1:RecordAudio("413071013", var_62_12)
						arg_59_1:RecordAudio("413071013", var_62_12)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413071", "413071013", "story_v_out_413071.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413071", "413071013", "story_v_out_413071.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_6, arg_59_1.talkMaxDuration)

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_5) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_5 + var_62_13 and arg_59_1.time_ < var_62_5 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play413071014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413071014
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413071015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_0 = arg_63_1.bgs_.F10g

				arg_63_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_1 = var_66_0:GetComponent("SpriteRenderer")

				if var_66_1 and var_66_1.sprite then
					local var_66_2 = 2 * (var_66_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_0.transform.localScale = Vector3.New(var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "F10g" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_3 = 4

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_3 + 0.3 and arg_63_1.time_ < var_66_3 + 0.3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_4 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_5 = 2

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_5 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_4) / var_66_5)
				arg_63_1.mask_.color = var_66_6
			end

			if arg_63_1.time_ >= var_66_4 + var_66_5 and arg_63_1.time_ < var_66_4 + var_66_5 + arg_66_0 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = 1
				arg_63_1.mask_.color = var_66_7
			end

			local var_66_8 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_9 = 2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 then
				local var_66_10 = Color.New(0, 0, 0)

				var_66_10.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_8) / var_66_9)
				arg_63_1.mask_.color = var_66_10
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 then
				local var_66_11 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_11.a = 0
				arg_63_1.mask_.color = var_66_11
			end

			local var_66_12 = arg_63_1.actors_["10092"].transform

			if 1.966 < arg_63_1.time_ and arg_63_1.time_ <= 1.966 + arg_66_0 then
				arg_63_1.var_.moveOldPos10092 = var_66_12.localPosition
				var_66_12.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10092", 0)

				for iter_66_2 = 0, var_66_12.childCount - 1 do
					local var_66_13 = var_66_12:GetChild(iter_66_2)

					if var_66_13.name == "" or not string.find(var_66_13.name, "split") then
						var_66_13.gameObject:SetActive(true)
					else
						var_66_13.gameObject:SetActive(false)
					end
				end
			end

			local var_66_14 = 0.001

			if 1.966 <= arg_63_1.time_ and arg_63_1.time_ < 1.966 + var_66_14 then
				var_66_12.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_63_1.time_ - 1.966) / var_66_14)
			end

			if arg_63_1.time_ >= 1.966 + var_66_14 and arg_63_1.time_ < 1.966 + var_66_14 + arg_66_0 then
				var_66_12.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_66_15 = arg_63_1.actors_["10094"].transform

			if 1.966 < arg_63_1.time_ and arg_63_1.time_ <= 1.966 + arg_66_0 then
				arg_63_1.var_.moveOldPos10094 = var_66_15.localPosition
				var_66_15.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10094", 7)

				for iter_66_3 = 0, var_66_15.childCount - 1 do
					local var_66_16 = var_66_15:GetChild(iter_66_3)

					if var_66_16.name == "" or not string.find(var_66_16.name, "split") then
						var_66_16.gameObject:SetActive(true)
					else
						var_66_16.gameObject:SetActive(false)
					end
				end
			end

			local var_66_17 = 0.001

			if 1.966 <= arg_63_1.time_ and arg_63_1.time_ < 1.966 + var_66_17 then
				var_66_15.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 1.966) / var_66_17)
			end

			if arg_63_1.time_ >= 1.966 + var_66_17 and arg_63_1.time_ < 1.966 + var_66_17 + arg_66_0 then
				var_66_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_18 = arg_63_1.actors_["10092"]

			if 1.966 < arg_63_1.time_ and arg_63_1.time_ <= 1.966 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.actorSpriteComps10092 == nil then
				arg_63_1.var_.actorSpriteComps10092 = var_66_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_19 = 0.034

			if 1.966 <= arg_63_1.time_ and arg_63_1.time_ < 1.966 + var_66_19 and not isNil(var_66_18) then
				if arg_63_1.var_.actorSpriteComps10092 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 1.966) / var_66_19), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 1.966) / var_66_19), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 1.966) / var_66_19)))
							else
								local var_66_20 = Mathf.Lerp(iter_66_5.color.r, 0.5, (arg_63_1.time_ - 1.966) / var_66_19)

								iter_66_5.color = Color.New(var_66_20, var_66_20, var_66_20)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 1.966 + var_66_19 and arg_63_1.time_ < 1.966 + var_66_19 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.actorSpriteComps10092 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10092 = nil
			end

			local var_66_21 = arg_63_1.actors_["10094"]

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= 3.8 + arg_66_0 and not isNil(var_66_21) and arg_63_1.var_.actorSpriteComps10094 == nil then
				arg_63_1.var_.actorSpriteComps10094 = var_66_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_22 = 0.2

			if 3.8 <= arg_63_1.time_ and arg_63_1.time_ < 3.8 + var_66_22 and not isNil(var_66_21) then
				if arg_63_1.var_.actorSpriteComps10094 then
					for iter_66_8, iter_66_9 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_66_9 then
							if arg_63_1.isInRecall_ then
								iter_66_9.color = Color.New(Mathf.Lerp(iter_66_9.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 3.8) / var_66_22), Mathf.Lerp(iter_66_9.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 3.8) / var_66_22), (Mathf.Lerp(iter_66_9.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 3.8) / var_66_22)))
							else
								local var_66_23 = Mathf.Lerp(iter_66_9.color.r, 0.5, (arg_63_1.time_ - 3.8) / var_66_22)

								iter_66_9.color = Color.New(var_66_23, var_66_23, var_66_23)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 3.8 + var_66_22 and arg_63_1.time_ < 3.8 + var_66_22 + arg_66_0 and not isNil(var_66_21) and arg_63_1.var_.actorSpriteComps10094 then
				for iter_66_10, iter_66_11 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_66_11 then
						iter_66_11.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10094 = nil
			end

			if 0.366666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 0.366666666666667 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow1", "")
			end

			if 2.8 < arg_63_1.time_ and arg_63_1.time_ <= 2.8 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_26 = 4
			local var_66_27 = 1.3

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_26 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_28 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_28:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_29 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(413071014).content)

				arg_63_1.text_.text = var_66_29

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_31 = 52 <= 0 and var_66_27 or var_66_27 * (utf8.len(var_66_29) / 52)

				if (52 <= 0 and var_66_27 or var_66_27 * (utf8.len(var_66_29) / 52)) > 0 and var_66_27 < var_66_31 then
					arg_63_1.talkMaxDuration = var_66_31
					var_66_26 = var_66_26 + 0.3

					if var_66_31 + var_66_26 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_31 + var_66_26
					end
				end

				arg_63_1.text_.text = var_66_29
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_32 = var_66_26 + 0.3
			local var_66_33 = math.max(var_66_27, arg_63_1.talkMaxDuration)

			if var_66_26 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_32 + var_66_33 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_32) / var_66_33

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_32 + var_66_33 and arg_63_1.time_ < var_66_32 + var_66_33 + arg_66_0 then
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
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play413071015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413071015
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413071016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["10093"] == nil then
				local var_72_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_72_0) then
					local var_72_1 = Object.Instantiate(var_72_0, arg_69_1.canvasGo_.transform)

					var_72_1.transform:SetSiblingIndex(1)

					var_72_1.name = "10093"
					var_72_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_["10093"] = var_72_1

					if arg_69_1.isInRecall_ then
						for iter_72_0, iter_72_1 in ipairs((var_72_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_72_1.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_2 = arg_69_1.actors_["10093"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10093 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10093", 3)

				for iter_72_2 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_2)

					if var_72_3.name == "split_5" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_72_5 = arg_69_1.actors_["10093"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10093 == nil then
				arg_69_1.var_.actorSpriteComps10093 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps10093 then
					for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_72_4 then
							if arg_69_1.isInRecall_ then
								iter_72_4.color = Color.New(Mathf.Lerp(iter_72_4.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_4.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_4.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_4.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_4.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10093 then
				for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_72_6 then
						iter_72_6.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10093 = nil
			end

			local var_72_8 = arg_69_1.actors_["10093"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.shakeOldPos10093 = var_72_8.localPosition
			end

			local var_72_9 = 0.6

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				local var_72_10, var_72_11 = math.modf((arg_69_1.time_ - 0) / 0.066)

				var_72_8.localPosition = Vector3.New(var_72_11 * 0.13, var_72_11 * 0.13, var_72_11 * 0.13) + arg_69_1.var_.shakeOldPos10093
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_8.localPosition = arg_69_1.var_.shakeOldPos10093
			end

			local var_72_12 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_12 + 0.6 and arg_69_1.time_ < var_72_12 + 0.6 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_13 = 0
			local var_72_14 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(413071015)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 8 <= 0 and var_72_14 or var_72_14 * (utf8.len(var_72_16) / 8)

				if (8 <= 0 and var_72_14 or var_72_14 * (utf8.len(var_72_16) / 8)) > 0 and var_72_14 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_13
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071015", "story_v_out_413071.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_413071", "413071015", "story_v_out_413071.awb") / 1000

					if var_72_19 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_13
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_413071", "413071015", "story_v_out_413071.awb")

						arg_69_1:RecordAudio("413071015", var_72_20)
						arg_69_1:RecordAudio("413071015", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413071", "413071015", "story_v_out_413071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413071", "413071015", "story_v_out_413071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_14, arg_69_1.talkMaxDuration)

			if var_72_13 <= arg_69_1.time_ and arg_69_1.time_ < var_72_13 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_13) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_13 + var_72_21 and arg_69_1.time_ < var_72_13 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413071016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413071016
		arg_73_1.duration_ = 2.5

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 2.5
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
				arg_73_0:Play413071017(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword", "")
			end

			local var_76_1 = arg_73_1.actors_["10093"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.actorSpriteComps10093 == nil then
				arg_73_1.var_.actorSpriteComps10093 = var_76_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.actorSpriteComps10093 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_2), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_2), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_2)))
							else
								local var_76_3 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_2)

								iter_76_1.color = Color.New(var_76_3, var_76_3, var_76_3)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.actorSpriteComps10093 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10093 = nil
			end

			local var_76_4 = 0
			local var_76_5 = 0.225

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_6 = arg_73_1:GetWordFromCfg(413071016)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 9 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 9)

				if (9 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 9)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071016", "story_v_out_413071.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_413071", "413071016", "story_v_out_413071.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_413071", "413071016", "story_v_out_413071.awb")

						arg_73_1:RecordAudio("413071016", var_76_11)
						arg_73_1:RecordAudio("413071016", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413071", "413071016", "story_v_out_413071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413071", "413071016", "story_v_out_413071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413071017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413071017
		arg_77_1.duration_ = 5.93

		local var_77_0 = {
			zh = 5.933,
			ja = 4.633
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
				arg_77_0:Play413071018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10093 = arg_77_1.actors_["10093"].transform.localPosition
				arg_77_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10093", 3)

				for iter_80_0 = 0, arg_77_1.actors_["10093"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10093"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_6" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_80_2 = arg_77_1.actors_["10093"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413071017)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 20 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 20)

				if (20 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 20)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071017", "story_v_out_413071.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071017", "story_v_out_413071.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413071", "413071017", "story_v_out_413071.awb")

						arg_77_1:RecordAudio("413071017", var_80_12)
						arg_77_1:RecordAudio("413071017", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413071", "413071017", "story_v_out_413071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413071", "413071017", "story_v_out_413071.awb")
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
				actorName = "10093",
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
	Play413071018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413071018
		arg_81_1.duration_ = 3.9

		local var_81_0 = {
			zh = 3.733,
			ja = 3.9
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
				arg_81_0:Play413071019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(413071018)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 18 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 18)

				if (18 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 18)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071018", "story_v_out_413071.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071018", "story_v_out_413071.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_413071", "413071018", "story_v_out_413071.awb")

						arg_81_1:RecordAudio("413071018", var_84_6)
						arg_81_1:RecordAudio("413071018", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413071", "413071018", "story_v_out_413071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413071", "413071018", "story_v_out_413071.awb")
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
	Play413071019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413071019
		arg_85_1.duration_ = 5.57

		local var_85_0 = {
			zh = 4.166,
			ja = 5.566
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play413071020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10093"]) and arg_85_1.var_.actorSpriteComps10093 == nil then
				arg_85_1.var_.actorSpriteComps10093 = arg_85_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10093"]) then
				if arg_85_1.var_.actorSpriteComps10093 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10093"]) and arg_85_1.var_.actorSpriteComps10093 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10093 = nil
			end

			local var_88_2 = 0
			local var_88_3 = 0.575

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_4 = arg_85_1:GetWordFromCfg(413071019)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 23 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 23)

				if (23 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 23)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071019", "story_v_out_413071.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071019", "story_v_out_413071.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_413071", "413071019", "story_v_out_413071.awb")

						arg_85_1:RecordAudio("413071019", var_88_9)
						arg_85_1:RecordAudio("413071019", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413071", "413071019", "story_v_out_413071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413071", "413071019", "story_v_out_413071.awb")
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
	Play413071020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413071020
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play413071021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10093"]) and arg_89_1.var_.actorSpriteComps10093 == nil then
				arg_89_1.var_.actorSpriteComps10093 = arg_89_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10093"]) then
				if arg_89_1.var_.actorSpriteComps10093 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10093"]) and arg_89_1.var_.actorSpriteComps10093 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10093 = nil
			end

			local var_92_2 = arg_89_1.actors_["10093"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 3)

				for iter_92_4 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_4)

					if var_92_3.name == "split_1" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_92_5 = 0
			local var_92_6 = 0.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
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

				local var_92_7 = arg_89_1:GetWordFromCfg(413071020)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 4 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 4)

				if (4 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 4)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071020", "story_v_out_413071.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071020", "story_v_out_413071.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_413071", "413071020", "story_v_out_413071.awb")

						arg_89_1:RecordAudio("413071020", var_92_12)
						arg_89_1:RecordAudio("413071020", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413071", "413071020", "story_v_out_413071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413071", "413071020", "story_v_out_413071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
	Play413071021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413071021
		arg_93_1.duration_ = 8.9

		local var_93_0 = {
			zh = 3.766,
			ja = 8.9
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
				arg_93_0:Play413071022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10093"]) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = arg_93_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10093"]) then
				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10093"]) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_2 = 0
			local var_96_3 = 0.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_4 = arg_93_1:GetWordFromCfg(413071021)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 19 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 19)

				if (19 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 19)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071021", "story_v_out_413071.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071021", "story_v_out_413071.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_413071", "413071021", "story_v_out_413071.awb")

						arg_93_1:RecordAudio("413071021", var_96_9)
						arg_93_1:RecordAudio("413071021", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413071", "413071021", "story_v_out_413071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413071", "413071021", "story_v_out_413071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413071022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413071022
		arg_97_1.duration_ = 8.83

		local var_97_0 = {
			zh = 4.8,
			ja = 8.833
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
				arg_97_0:Play413071023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.675

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
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(413071022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 27)

				if (27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 27)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071022", "story_v_out_413071.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071022", "story_v_out_413071.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_413071", "413071022", "story_v_out_413071.awb")

						arg_97_1:RecordAudio("413071022", var_100_6)
						arg_97_1:RecordAudio("413071022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413071", "413071022", "story_v_out_413071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413071", "413071022", "story_v_out_413071.awb")
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
	Play413071023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413071023
		arg_101_1.duration_ = 2.23

		local var_101_0 = {
			zh = 2,
			ja = 2.233
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
				arg_101_0:Play413071024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10093"]) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = arg_101_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10093"]) then
				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 1, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10093"]) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_2 = 0
			local var_104_3 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
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

				local var_104_4 = arg_101_1:GetWordFromCfg(413071023)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 11 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 11)

				if (11 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 11)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071023", "story_v_out_413071.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071023", "story_v_out_413071.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_413071", "413071023", "story_v_out_413071.awb")

						arg_101_1:RecordAudio("413071023", var_104_9)
						arg_101_1:RecordAudio("413071023", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413071", "413071023", "story_v_out_413071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413071", "413071023", "story_v_out_413071.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413071024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413071024
		arg_105_1.duration_ = 7.1

		local var_105_0 = {
			zh = 3.166,
			ja = 7.1
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
				arg_105_0:Play413071025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10093"]) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = arg_105_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10093"]) then
				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10093"]) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_2")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_4 = arg_105_1:GetWordFromCfg(413071024)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 17)

				if (17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 17)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071024", "story_v_out_413071.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071024", "story_v_out_413071.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_413071", "413071024", "story_v_out_413071.awb")

						arg_105_1:RecordAudio("413071024", var_108_9)
						arg_105_1:RecordAudio("413071024", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413071", "413071024", "story_v_out_413071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413071", "413071024", "story_v_out_413071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play413071025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413071025
		arg_109_1.duration_ = 8.3

		local var_109_0 = {
			zh = 5.766,
			ja = 8.3
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
				arg_109_0:Play413071026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10093 = arg_109_1.actors_["10093"].transform.localPosition
				arg_109_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10093", 3)

				for iter_112_0 = 0, arg_109_1.actors_["10093"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10093"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_112_2 = arg_109_1.actors_["10093"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10093 == nil then
				arg_109_1.var_.actorSpriteComps10093 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps10093 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10093 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10093 = nil
			end

			local var_112_5 = 0
			local var_112_6 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(413071025)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 30 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 30)

				if (30 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 30)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071025", "story_v_out_413071.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071025", "story_v_out_413071.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_413071", "413071025", "story_v_out_413071.awb")

						arg_109_1:RecordAudio("413071025", var_112_12)
						arg_109_1:RecordAudio("413071025", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413071", "413071025", "story_v_out_413071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413071", "413071025", "story_v_out_413071.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play413071026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413071026
		arg_113_1.duration_ = 5.5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play413071027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10092 = arg_113_1.actors_["10092"].transform.localPosition
				arg_113_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10092", 7)

				for iter_116_0 = 0, arg_113_1.actors_["10092"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10092"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_2 = arg_113_1.actors_["10093"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			local var_116_5 = arg_113_1.actors_["10093"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_5.localPosition
				var_116_5.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 7)

				for iter_116_5 = 0, var_116_5.childCount - 1 do
					local var_116_6 = var_116_5:GetChild(iter_116_5)

					if var_116_6.name == "" or not string.find(var_116_6.name, "split") then
						var_116_6.gameObject:SetActive(true)
					else
						var_116_6.gameObject:SetActive(false)
					end
				end
			end

			local var_116_7 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_113_1.time_ - 0) / var_116_7)
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_8 = manager.ui.mainCamera.transform

			if 0.2 < arg_113_1.time_ and arg_113_1.time_ <= 0.2 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = var_116_8.localPosition
			end

			local var_116_9 = 0.6

			if 0.2 <= arg_113_1.time_ and arg_113_1.time_ < 0.2 + var_116_9 then
				local var_116_10, var_116_11 = math.modf((arg_113_1.time_ - 0.2) / 0.066)

				var_116_8.localPosition = Vector3.New(var_116_11 * 0.13, var_116_11 * 0.13, var_116_11 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= 0.2 + var_116_9 and arg_113_1.time_ < 0.2 + var_116_9 + arg_116_0 then
				var_116_8.localPosition = arg_113_1.var_.shakeOldPos
			end

			local var_116_12 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_12 + 0.5 and arg_113_1.time_ < var_116_12 + 0.5 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			if 0.0666666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 0.0666666666666667 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_wave", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_14 = 0.5
			local var_116_15 = 1.125

			if 0.5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_16 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_16:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(413071026).content)

				arg_113_1.text_.text = var_116_17

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 45 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 45)

				if (45 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 45)) > 0 and var_116_15 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19
					var_116_14 = var_116_14 + 0.3

					if var_116_19 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_17
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = var_116_14 + 0.3
			local var_116_21 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_20 + var_116_21 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_20) / var_116_21

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_20 + var_116_21 and arg_113_1.time_ < var_116_20 + var_116_21 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play413071027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413071027
		arg_119_1.duration_ = 2.33

		local var_119_0 = {
			zh = 2.333,
			ja = 2.266
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play413071028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10093 = arg_119_1.actors_["10093"].transform.localPosition
				arg_119_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10093", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10093"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10093"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_5" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_122_2 = arg_119_1.actors_["10093"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10093 == nil then
				arg_119_1.var_.actorSpriteComps10093 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10093 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10093 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10093 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.175

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(413071027)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 7 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 7)

				if (7 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 7)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071027", "story_v_out_413071.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071027", "story_v_out_413071.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_413071", "413071027", "story_v_out_413071.awb")

						arg_119_1:RecordAudio("413071027", var_122_12)
						arg_119_1:RecordAudio("413071027", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413071", "413071027", "story_v_out_413071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413071", "413071027", "story_v_out_413071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play413071028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413071028
		arg_123_1.duration_ = 8.2

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413071029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10093 = arg_123_1.actors_["10093"].transform.localPosition
				arg_123_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10093", 7)

				for iter_126_0 = 0, arg_123_1.actors_["10093"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10093"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_2 = arg_123_1.actors_["10092"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092", 7)

				for iter_126_1 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_1)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_5 = "SS1305"

			if arg_123_1.bgs_.SS1305 == nil then
				local var_126_6 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_5)
				var_126_6.name = var_126_5
				var_126_6.transform.parent = arg_123_1.stage_.transform
				var_126_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_5] = var_126_6
			end

			if 1.33333333333333 < arg_123_1.time_ and arg_123_1.time_ <= 1.33333333333333 + arg_126_0 then
				local var_126_7 = arg_123_1.bgs_.SS1305

				arg_123_1.bgs_.SS1305.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_8 = var_126_7:GetComponent("SpriteRenderer")

				if var_126_8 and var_126_8.sprite then
					local var_126_9 = 2 * (var_126_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_7.transform.localScale = Vector3.New(var_126_9 / var_126_8.sprite.bounds.size.y < var_126_9 * manager.ui.mainCameraCom_.aspect / var_126_8.sprite.bounds.size.x and var_126_9 * manager.ui.mainCameraCom_.aspect / var_126_8.sprite.bounds.size.x or var_126_9 / var_126_8.sprite.bounds.size.y, var_126_9 / var_126_8.sprite.bounds.size.y < var_126_9 * manager.ui.mainCameraCom_.aspect / var_126_8.sprite.bounds.size.x and var_126_9 * manager.ui.mainCameraCom_.aspect / var_126_8.sprite.bounds.size.x or var_126_9 / var_126_8.sprite.bounds.size.y, 0)
				end

				for iter_126_2, iter_126_3 in pairs(arg_123_1.bgs_) do
					if iter_126_2 ~= "SS1305" then
						iter_126_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_10 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_11 = 1.33333333333333

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 then
				local var_126_12 = Color.New(0, 0, 0)

				var_126_12.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_10) / var_126_11)
				arg_123_1.mask_.color = var_126_12
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 then
				local var_126_13 = Color.New(0, 0, 0)

				var_126_13.a = 1
				arg_123_1.mask_.color = var_126_13
			end

			local var_126_14 = 1.33333333333333

			if 1.33333333333333 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_15 = 2

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_15 then
				local var_126_16 = Color.New(0, 0, 0)

				var_126_16.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_14) / var_126_15)
				arg_123_1.mask_.color = var_126_16
			end

			if arg_123_1.time_ >= var_126_14 + var_126_15 and arg_123_1.time_ < var_126_14 + var_126_15 + arg_126_0 then
				local var_126_17 = Color.New(0, 0, 0)

				arg_123_1.mask_.enabled = false
				var_126_17.a = 0
				arg_123_1.mask_.color = var_126_17
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_18 = 3.2
			local var_126_19 = 1.5

			if 3.2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_20 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_20:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_21 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(413071028).content)

				arg_123_1.text_.text = var_126_21

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_23 = 60 <= 0 and var_126_19 or var_126_19 * (utf8.len(var_126_21) / 60)

				if (60 <= 0 and var_126_19 or var_126_19 * (utf8.len(var_126_21) / 60)) > 0 and var_126_19 < var_126_23 then
					arg_123_1.talkMaxDuration = var_126_23
					var_126_18 = var_126_18 + 0.3

					if var_126_23 + var_126_18 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_18
					end
				end

				arg_123_1.text_.text = var_126_21
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_24 = var_126_18 + 0.3
			local var_126_25 = math.max(var_126_19, arg_123_1.talkMaxDuration)

			if var_126_18 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_24 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_24) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_24 + var_126_25 and arg_123_1.time_ < var_126_24 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play413071029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413071029
		arg_129_1.duration_ = 4.3

		local var_129_0 = {
			zh = 2.766,
			ja = 4.3
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
				arg_129_0:Play413071030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(413071029)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 14)

				if (14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 14)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071029", "story_v_out_413071.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071029", "story_v_out_413071.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_413071", "413071029", "story_v_out_413071.awb")

						arg_129_1:RecordAudio("413071029", var_132_6)
						arg_129_1:RecordAudio("413071029", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413071", "413071029", "story_v_out_413071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413071", "413071029", "story_v_out_413071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413071030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413071030
		arg_133_1.duration_ = 5.17

		local var_133_0 = {
			zh = 2.7,
			ja = 5.166
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
				arg_133_0:Play413071031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.375

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(413071030)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 15 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 15)

				if (15 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 15)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071030", "story_v_out_413071.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071030", "story_v_out_413071.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_413071", "413071030", "story_v_out_413071.awb")

						arg_133_1:RecordAudio("413071030", var_136_6)
						arg_133_1:RecordAudio("413071030", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413071", "413071030", "story_v_out_413071.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413071", "413071030", "story_v_out_413071.awb")
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
	Play413071031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413071031
		arg_137_1.duration_ = 6.37

		local var_137_0 = {
			zh = 4.8,
			ja = 6.366
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
				arg_137_0:Play413071032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.45

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(413071031)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 18 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 18)

				if (18 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 18)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071031", "story_v_out_413071.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071031", "story_v_out_413071.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_413071", "413071031", "story_v_out_413071.awb")

						arg_137_1:RecordAudio("413071031", var_140_6)
						arg_137_1:RecordAudio("413071031", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413071", "413071031", "story_v_out_413071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413071", "413071031", "story_v_out_413071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play413071032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413071032
		arg_141_1.duration_ = 3.4

		local var_141_0 = {
			zh = 3.4,
			ja = 2.833
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
				arg_141_0:Play413071033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(413071032)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 12 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 12)

				if (12 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 12)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071032", "story_v_out_413071.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071032", "story_v_out_413071.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_413071", "413071032", "story_v_out_413071.awb")

						arg_141_1:RecordAudio("413071032", var_144_6)
						arg_141_1:RecordAudio("413071032", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413071", "413071032", "story_v_out_413071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413071", "413071032", "story_v_out_413071.awb")
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
	Play413071033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413071033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play413071034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.05

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(413071033).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 42 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 42)

				if (42 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 42)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play413071034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413071034
		arg_149_1.duration_ = 7.3

		local var_149_0 = {
			zh = 4.7,
			ja = 7.3
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
				arg_149_0:Play413071035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.375

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(413071034)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 15 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 15)

				if (15 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 15)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071034", "story_v_out_413071.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071034", "story_v_out_413071.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_413071", "413071034", "story_v_out_413071.awb")

						arg_149_1:RecordAudio("413071034", var_152_6)
						arg_149_1:RecordAudio("413071034", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413071", "413071034", "story_v_out_413071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413071", "413071034", "story_v_out_413071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play413071035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413071035
		arg_153_1.duration_ = 4.6

		local var_153_0 = {
			zh = 4.6,
			ja = 3.766
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play413071036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(413071035)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)

				if (16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071035", "story_v_out_413071.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071035", "story_v_out_413071.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_413071", "413071035", "story_v_out_413071.awb")

						arg_153_1:RecordAudio("413071035", var_156_6)
						arg_153_1:RecordAudio("413071035", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413071", "413071035", "story_v_out_413071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413071", "413071035", "story_v_out_413071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413071036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413071036
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413071037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.825

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(413071036).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 33 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 33)

				if (33 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 33)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413071037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413071037
		arg_161_1.duration_ = 2.5

		local var_161_0 = {
			zh = 1.233,
			ja = 2.5
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413071038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(413071037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 4 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 4)

				if (4 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 4)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071037", "story_v_out_413071.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071037", "story_v_out_413071.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_413071", "413071037", "story_v_out_413071.awb")

						arg_161_1:RecordAudio("413071037", var_164_6)
						arg_161_1:RecordAudio("413071037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413071", "413071037", "story_v_out_413071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413071", "413071037", "story_v_out_413071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play413071038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413071038
		arg_165_1.duration_ = 6.9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play413071039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = false

				arg_165_1:SetGaussion(false)
			end

			local var_168_0 = 0.633333333333333

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				local var_168_1 = Color.New(1, 1, 1)

				var_168_1.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.mask_.color = var_168_1
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				local var_168_2 = Color.New(1, 1, 1)

				arg_165_1.mask_.enabled = false
				var_168_2.a = 0
				arg_165_1.mask_.color = var_168_2
			end

			local var_168_3 = arg_165_1.bgs_.SS1305.transform

			if 0.266666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.266666666666667 + arg_168_0 then
				arg_165_1.var_.moveOldPosSS1305 = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0.266666666666667 <= arg_165_1.time_ and arg_165_1.time_ < 0.266666666666667 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSS1305, Vector3.New(0, 1, 10), (arg_165_1.time_ - 0.266666666666667) / var_168_4)
			end

			if arg_165_1.time_ >= 0.266666666666667 + var_168_4 and arg_165_1.time_ < 0.266666666666667 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(0, 1, 10)
			end

			local var_168_5 = arg_165_1.bgs_.SS1305.transform

			if 0.300666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.300666666666667 + arg_168_0 then
				arg_165_1.var_.moveOldPosSS1305 = var_168_5.localPosition
			end

			local var_168_6 = 1.83266666666667

			if 0.300666666666667 <= arg_165_1.time_ and arg_165_1.time_ < 0.300666666666667 + var_168_6 then
				var_168_5.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSS1305, Vector3.New(0, 1, 8.97), (arg_165_1.time_ - 0.300666666666667) / var_168_6)
			end

			if arg_165_1.time_ >= 0.300666666666667 + var_168_6 and arg_165_1.time_ < 0.300666666666667 + var_168_6 + arg_168_0 then
				var_168_5.localPosition = Vector3.New(0, 1, 8.97)
			end

			local var_168_7 = 0.266666666666667

			if 0.266666666666667 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_7 + 1.86666666666667 and arg_165_1.time_ < var_168_7 + 1.86666666666667 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_8 = 1.9
			local var_168_9 = 1.3

			if 1.9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_10 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_10:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(413071038).content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 52 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 52)

				if (52 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 52)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13
					var_168_8 = var_168_8 + 0.3

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = var_168_8 + 0.3
			local var_168_15 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_14) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.266666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.83266666666667,
				className = "StoryMoveNode",
				startTime = 0.300666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play413071039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413071039
		arg_171_1.duration_ = 2.77

		local var_171_0 = {
			zh = 1.9,
			ja = 2.766
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
				arg_171_0:Play413071040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(413071039)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 8 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 8)

				if (8 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 8)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071039", "story_v_out_413071.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071039", "story_v_out_413071.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_413071", "413071039", "story_v_out_413071.awb")

						arg_171_1:RecordAudio("413071039", var_174_6)
						arg_171_1:RecordAudio("413071039", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413071", "413071039", "story_v_out_413071.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413071", "413071039", "story_v_out_413071.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play413071040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413071040
		arg_175_1.duration_ = 7.8

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413071041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if arg_175_1.bgs_.F08i == nil then
				local var_178_0 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_178_0.name = "F08i"
				var_178_0.transform.parent = arg_175_1.stage_.transform
				var_178_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_.F08i = var_178_0
			end

			if 1.3 < arg_175_1.time_ and arg_175_1.time_ <= 1.3 + arg_178_0 then
				local var_178_1 = arg_175_1.bgs_.F08i

				arg_175_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_2 = var_178_1:GetComponent("SpriteRenderer")

				if var_178_2 and var_178_2.sprite then
					local var_178_3 = 2 * (var_178_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_1.transform.localScale = Vector3.New(var_178_3 / var_178_2.sprite.bounds.size.y < var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x and var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x or var_178_3 / var_178_2.sprite.bounds.size.y, var_178_3 / var_178_2.sprite.bounds.size.y < var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x and var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x or var_178_3 / var_178_2.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "F08i" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_4 = 2.5

			if 2.5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_4 + 0.3 and arg_175_1.time_ < var_178_4 + 0.3 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_5 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_6 = 1.3

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 then
				local var_178_7 = Color.New(0, 0, 0)

				var_178_7.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_5) / var_178_6)
				arg_175_1.mask_.color = var_178_7
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 then
				local var_178_8 = Color.New(0, 0, 0)

				var_178_8.a = 1
				arg_175_1.mask_.color = var_178_8
			end

			local var_178_9 = 1.3

			if 1.3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_10 = 1.5

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 then
				local var_178_11 = Color.New(0, 0, 0)

				var_178_11.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_9) / var_178_10)
				arg_175_1.mask_.color = var_178_11
			end

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 then
				local var_178_12 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_12.a = 0
				arg_175_1.mask_.color = var_178_12
			end

			local var_178_13 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_13 + 0.5 and arg_175_1.time_ < var_178_13 + 0.5 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			if 1.5 < arg_175_1.time_ and arg_175_1.time_ <= 1.5 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_15 = 2.8
			local var_178_16 = 1.6

			if 2.8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_17 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_17:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(413071040).content)

				arg_175_1.text_.text = var_178_18

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 64 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_18) / 64)

				if (64 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_18) / 64)) > 0 and var_178_16 < var_178_20 then
					arg_175_1.talkMaxDuration = var_178_20
					var_178_15 = var_178_15 + 0.3

					if var_178_20 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_20 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_18
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_21 = var_178_15 + 0.3
			local var_178_22 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_21) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play413071041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413071041
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play413071042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.2

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

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(413071041).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)

				if (48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)) > 0 and var_184_0 < var_184_3 then
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
	Play413071042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413071042
		arg_185_1.duration_ = 6.17

		local var_185_0 = {
			zh = 6.166,
			ja = 5.7
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
				arg_185_0:Play413071043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.575

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(413071042)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 23 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 23)

				if (23 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 23)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071042", "story_v_out_413071.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071042", "story_v_out_413071.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_413071", "413071042", "story_v_out_413071.awb")

						arg_185_1:RecordAudio("413071042", var_188_6)
						arg_185_1:RecordAudio("413071042", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413071", "413071042", "story_v_out_413071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413071", "413071042", "story_v_out_413071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413071043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413071043
		arg_189_1.duration_ = 8.67

		local var_189_0 = {
			zh = 7.9,
			ja = 8.666
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
				arg_189_0:Play413071044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.475

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(413071043)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 19 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 19)

				if (19 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 19)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071043", "story_v_out_413071.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071043", "story_v_out_413071.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_413071", "413071043", "story_v_out_413071.awb")

						arg_189_1:RecordAudio("413071043", var_192_6)
						arg_189_1:RecordAudio("413071043", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413071", "413071043", "story_v_out_413071.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413071", "413071043", "story_v_out_413071.awb")
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
	Play413071044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413071044
		arg_193_1.duration_ = 8.78

		local var_193_0 = {
			zh = 6.816,
			ja = 8.783
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
				arg_193_0:Play413071045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.actors_["10096"] == nil then
				local var_196_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_196_0) then
					local var_196_1 = Object.Instantiate(var_196_0, arg_193_1.canvasGo_.transform)

					var_196_1.transform:SetSiblingIndex(1)

					var_196_1.name = "10096"
					var_196_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_193_1.actors_["10096"] = var_196_1

					if arg_193_1.isInRecall_ then
						for iter_196_0, iter_196_1 in ipairs((var_196_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_196_1.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_196_2 = arg_193_1.actors_["10096"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10096 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10096", 3)

				for iter_196_2 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_2)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_196_5 = arg_193_1.actors_["10096"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10096 == nil then
				arg_193_1.var_.actorSpriteComps10096 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps10096 then
					for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_196_4 then
							if arg_193_1.isInRecall_ then
								iter_196_4.color = Color.New(Mathf.Lerp(iter_196_4.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_4.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_4.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_4.color.r, 1, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_4.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10096 then
				for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_196_6 then
						iter_196_6.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10096 = nil
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_8 = arg_193_1.actors_["10096"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_8 then
					arg_193_1.var_.alphaOldValue10096 = var_196_8.alpha
					arg_193_1.var_.characterEffect10096 = var_196_8
				end

				arg_193_1.var_.alphaOldValue10096 = 0
			end

			local var_196_9 = 0.5

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 then
				if arg_193_1.var_.characterEffect10096 then
					arg_193_1.var_.characterEffect10096.alpha = Mathf.Lerp(arg_193_1.var_.alphaOldValue10096, 1, (arg_193_1.time_ - 0) / var_196_9)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and arg_193_1.var_.characterEffect10096 then
				arg_193_1.var_.characterEffect10096.alpha = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_10 = 0.25
			local var_196_11 = 0.25

			if 0.25 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_12 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_12:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(413071044)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 10 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_14) / 10)

				if (10 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_14) / 10)) > 0 and var_196_11 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16
					var_196_10 = var_196_10 + 0.3

					if var_196_16 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071044", "story_v_out_413071.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_413071", "413071044", "story_v_out_413071.awb") / 1000

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_413071", "413071044", "story_v_out_413071.awb")

						arg_193_1:RecordAudio("413071044", var_196_18)
						arg_193_1:RecordAudio("413071044", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413071", "413071044", "story_v_out_413071.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413071", "413071044", "story_v_out_413071.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = var_196_10 + 0.3
			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_19) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413071045
		arg_199_1.duration_ = 6.2

		local var_199_0 = {
			zh = 5.333,
			ja = 6.2
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
				arg_199_0:Play413071046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10096"]) and arg_199_1.var_.actorSpriteComps10096 == nil then
				arg_199_1.var_.actorSpriteComps10096 = arg_199_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10096"]) then
				if arg_199_1.var_.actorSpriteComps10096 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10096"]) and arg_199_1.var_.actorSpriteComps10096 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10096 = nil
			end

			local var_202_2 = 0
			local var_202_3 = 0.525

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_4 = arg_199_1:GetWordFromCfg(413071045)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 21 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 21)

				if (21 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 21)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071045", "story_v_out_413071.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071045", "story_v_out_413071.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_out_413071", "413071045", "story_v_out_413071.awb")

						arg_199_1:RecordAudio("413071045", var_202_9)
						arg_199_1:RecordAudio("413071045", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413071", "413071045", "story_v_out_413071.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413071", "413071045", "story_v_out_413071.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play413071046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413071046
		arg_203_1.duration_ = 6.8

		local var_203_0 = {
			zh = 4.7,
			ja = 6.8
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
				arg_203_0:Play413071047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10096 = arg_203_1.actors_["10096"].transform.localPosition
				arg_203_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10096", 3)

				for iter_206_0 = 0, arg_203_1.actors_["10096"].transform.childCount - 1 do
					local var_206_0 = arg_203_1.actors_["10096"].transform:GetChild(iter_206_0)

					if var_206_0.name == "" or not string.find(var_206_0.name, "split") then
						var_206_0.gameObject:SetActive(true)
					else
						var_206_0.gameObject:SetActive(false)
					end
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_203_1.time_ - 0) / var_206_1)
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["10096"].transform.localPosition = Vector3.New(0, -350, -210)
			end

			local var_206_2 = arg_203_1.actors_["10096"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps10096 == nil then
				arg_203_1.var_.actorSpriteComps10096 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps10096 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								iter_206_2.color = Color.New(Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_2.color.r, 1, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_2.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps10096 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_206_4 then
						iter_206_4.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps10096 = nil
			end

			local var_206_5 = 0
			local var_206_6 = 0.2

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(413071046)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 8 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 8)

				if (8 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 8)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071046", "story_v_out_413071.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071046", "story_v_out_413071.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_413071", "413071046", "story_v_out_413071.awb")

						arg_203_1:RecordAudio("413071046", var_206_12)
						arg_203_1:RecordAudio("413071046", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_413071", "413071046", "story_v_out_413071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_413071", "413071046", "story_v_out_413071.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 413071047
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play413071048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10096 = arg_207_1.actors_["10096"].transform.localPosition
				arg_207_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10096", 7)

				for iter_210_0 = 0, arg_207_1.actors_["10096"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10096"].transform:GetChild(iter_210_0)

					if var_210_0.name == "" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10096, Vector3.New(0, -2000, -180), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10096"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_210_2 = arg_207_1.actors_["10096"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10096 == nil then
				arg_207_1.var_.actorSpriteComps10096 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps10096 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								iter_210_2.color = Color.New(Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_2.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_2.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10096 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_210_4 then
						iter_210_4.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps10096 = nil
			end

			local var_210_5 = 0
			local var_210_6 = 1.6

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(413071047).content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 64 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_7) / 64)

				if (64 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_7) / 64)) > 0 and var_210_6 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_10 and arg_207_1.time_ < var_210_5 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413071048
		arg_211_1.duration_ = 5.5

		local var_211_0 = {
			zh = 4.133,
			ja = 5.5
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play413071049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.5

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:GetWordFromCfg(413071048)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 20 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 20)

				if (20 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 20)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071048", "story_v_out_413071.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071048", "story_v_out_413071.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_413071", "413071048", "story_v_out_413071.awb")

						arg_211_1:RecordAudio("413071048", var_214_6)
						arg_211_1:RecordAudio("413071048", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_413071", "413071048", "story_v_out_413071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_413071", "413071048", "story_v_out_413071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play413071049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413071049
		arg_215_1.duration_ = 4.57

		local var_215_0 = {
			zh = 4.433,
			ja = 4.566
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413071050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_129", "se_story_129_break", "")
			end

			local var_218_1 = 0
			local var_218_2 = 0.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(413071049)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 7)

				if (7 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 7)) > 0 and var_218_2 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071049", "story_v_out_413071.awb") ~= 0 then
					local var_218_7 = manager.audio:GetVoiceLength("story_v_out_413071", "413071049", "story_v_out_413071.awb") / 1000

					if var_218_7 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_1
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_413071", "413071049", "story_v_out_413071.awb")

						arg_215_1:RecordAudio("413071049", var_218_8)
						arg_215_1:RecordAudio("413071049", var_218_8)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413071", "413071049", "story_v_out_413071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413071", "413071049", "story_v_out_413071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_9 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_9 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_9

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_9 and arg_215_1.time_ < var_218_1 + var_218_9 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play413071050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413071050
		arg_219_1.duration_ = 7.53

		local var_219_0 = {
			zh = 5.266,
			ja = 7.533
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413071051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10096"]) and arg_219_1.var_.actorSpriteComps10096 == nil then
				arg_219_1.var_.actorSpriteComps10096 = arg_219_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10096"]) then
				if arg_219_1.var_.actorSpriteComps10096 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 0.5, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10096"]) and arg_219_1.var_.actorSpriteComps10096 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps10096 = nil
			end

			local var_222_2 = 0
			local var_222_3 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_4 = arg_219_1:GetWordFromCfg(413071050)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 19 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 19)

				if (19 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 19)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071050", "story_v_out_413071.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071050", "story_v_out_413071.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_413071", "413071050", "story_v_out_413071.awb")

						arg_219_1:RecordAudio("413071050", var_222_9)
						arg_219_1:RecordAudio("413071050", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_413071", "413071050", "story_v_out_413071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_413071", "413071050", "story_v_out_413071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play413071051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413071051
		arg_223_1.duration_ = 4.8

		local var_223_0 = {
			zh = 3.9,
			ja = 4.8
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play413071052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.15

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:GetWordFromCfg(413071051)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 6 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 6)

				if (6 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 6)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071051", "story_v_out_413071.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071051", "story_v_out_413071.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_413071", "413071051", "story_v_out_413071.awb")

						arg_223_1:RecordAudio("413071051", var_226_6)
						arg_223_1:RecordAudio("413071051", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413071", "413071051", "story_v_out_413071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413071", "413071051", "story_v_out_413071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play413071052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413071052
		arg_227_1.duration_ = 4.97

		local var_227_0 = {
			zh = 4.3,
			ja = 4.966
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play413071053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.325

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(413071052)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 13)

				if (13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 13)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071052", "story_v_out_413071.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071052", "story_v_out_413071.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_413071", "413071052", "story_v_out_413071.awb")

						arg_227_1:RecordAudio("413071052", var_230_6)
						arg_227_1:RecordAudio("413071052", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413071", "413071052", "story_v_out_413071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413071", "413071052", "story_v_out_413071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play413071053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413071053
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413071054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_9000

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10096 = arg_231_1.actors_["10096"].transform.localPosition
				arg_231_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10096", 7)

				for iter_234_0 = 0, arg_231_1.actors_["10096"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["10096"].transform:GetChild(iter_234_0)

					if var_234_0.name == "" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10096, Vector3.New(0, -2000, -180), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["10096"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_234_2 = arg_231_1.actors_["10096"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10096 == nil then
				arg_231_1.var_.actorSpriteComps10096 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps10096 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								iter_234_2.color = Color.New(Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_2.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_2.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10096 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_234_4 then
						iter_234_4.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10096 = nil
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				local var_234_5 = arg_231_1.var_.effect逃离1

				if not arg_231_1.var_.effect逃离1 then
					var_234_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_234_5.name = "逃离1"
					arg_231_1.var_.effect逃离1 = var_234_5
				else
					var_234_5.transform:SetParent(var_234_9000)
				end

				var_234_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_234_7 = 0
			local var_234_8 = 1.9

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_9 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(413071053).content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 76 <= 0 and var_234_8 or var_234_8 * (utf8.len(var_234_9) / 76)

				if (76 <= 0 and var_234_8 or var_234_8 * (utf8.len(var_234_9) / 76)) > 0 and var_234_8 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_7
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_8, arg_231_1.talkMaxDuration)

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_7) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_7 + var_234_12 and arg_231_1.time_ < var_234_7 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413071054
		arg_235_1.duration_ = 10.03

		local var_235_0 = {
			zh = 7.833,
			ja = 10.033
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
				arg_235_0:Play413071055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.bgs_.F08g == nil then
				local var_238_0 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08g")
				var_238_0.name = "F08g"
				var_238_0.transform.parent = arg_235_1.stage_.transform
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_.F08g = var_238_0
			end

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= 2 + arg_238_0 then
				local var_238_1 = arg_235_1.bgs_.F08g

				arg_235_1.bgs_.F08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_2 = var_238_1:GetComponent("SpriteRenderer")

				if var_238_2 and var_238_2.sprite then
					local var_238_3 = 2 * (var_238_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_1.transform.localScale = Vector3.New(var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "F08g" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_4 = 4

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			if arg_235_1.time_ >= var_238_4 + 0.3 and arg_235_1.time_ < var_238_4 + 0.3 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			local var_238_5 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_6 = 2

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 then
				local var_238_7 = Color.New(0, 0, 0)

				var_238_7.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_5) / var_238_6)
				arg_235_1.mask_.color = var_238_7
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 then
				local var_238_8 = Color.New(0, 0, 0)

				var_238_8.a = 1
				arg_235_1.mask_.color = var_238_8
			end

			local var_238_9 = 2

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_10 = 2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 then
				local var_238_11 = Color.New(0, 0, 0)

				var_238_11.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_9) / var_238_10)
				arg_235_1.mask_.color = var_238_11
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 then
				local var_238_12 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_12.a = 0
				arg_235_1.mask_.color = var_238_12
			end

			local var_238_13 = "10022"

			if arg_235_1.actors_["10022"] == nil then
				local var_238_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_238_14) then
					local var_238_15 = Object.Instantiate(var_238_14, arg_235_1.canvasGo_.transform)

					var_238_15.transform:SetSiblingIndex(1)

					var_238_15.name = var_238_13
					var_238_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_235_1.actors_[var_238_13] = var_238_15

					if arg_235_1.isInRecall_ then
						for iter_238_2, iter_238_3 in ipairs((var_238_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_238_16 = arg_235_1.actors_["10022"].transform

			if 3.8 < arg_235_1.time_ and arg_235_1.time_ <= 3.8 + arg_238_0 then
				arg_235_1.var_.moveOldPos10022 = var_238_16.localPosition
				var_238_16.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10022", 3)

				for iter_238_4 = 0, var_238_16.childCount - 1 do
					local var_238_17 = var_238_16:GetChild(iter_238_4)

					if var_238_17.name == "split_8" or not string.find(var_238_17.name, "split") then
						var_238_17.gameObject:SetActive(true)
					else
						var_238_17.gameObject:SetActive(false)
					end
				end
			end

			local var_238_18 = 0.001

			if 3.8 <= arg_235_1.time_ and arg_235_1.time_ < 3.8 + var_238_18 then
				var_238_16.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_235_1.time_ - 3.8) / var_238_18)
			end

			if arg_235_1.time_ >= 3.8 + var_238_18 and arg_235_1.time_ < 3.8 + var_238_18 + arg_238_0 then
				var_238_16.localPosition = Vector3.New(0, -315, -320)
			end

			local var_238_19 = arg_235_1.actors_["10022"]

			if 3.8 < arg_235_1.time_ and arg_235_1.time_ <= 3.8 + arg_238_0 and not isNil(var_238_19) and arg_235_1.var_.actorSpriteComps10022 == nil then
				arg_235_1.var_.actorSpriteComps10022 = var_238_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_20 = 0.2

			if 3.8 <= arg_235_1.time_ and arg_235_1.time_ < 3.8 + var_238_20 and not isNil(var_238_19) then
				if arg_235_1.var_.actorSpriteComps10022 then
					for iter_238_5, iter_238_6 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_238_6 then
							if arg_235_1.isInRecall_ then
								iter_238_6.color = Color.New(Mathf.Lerp(iter_238_6.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 3.8) / var_238_20), Mathf.Lerp(iter_238_6.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 3.8) / var_238_20), (Mathf.Lerp(iter_238_6.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 3.8) / var_238_20)))
							else
								local var_238_21 = Mathf.Lerp(iter_238_6.color.r, 1, (arg_235_1.time_ - 3.8) / var_238_20)

								iter_238_6.color = Color.New(var_238_21, var_238_21, var_238_21)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 3.8 + var_238_20 and arg_235_1.time_ < 3.8 + var_238_20 + arg_238_0 and not isNil(var_238_19) and arg_235_1.var_.actorSpriteComps10022 then
				for iter_238_7, iter_238_8 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_238_8 then
						iter_238_8.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10022 = nil
			end

			if 1.76666666666667 < arg_235_1.time_ and arg_235_1.time_ <= 1.76666666666667 + arg_238_0 then
				if arg_235_1.var_.effect逃离1 then
					Object.Destroy(arg_235_1.var_.effect逃离1)

					arg_235_1.var_.effect逃离1 = nil
				end
			end

			if 3.8 < arg_235_1.time_ and arg_235_1.time_ <= 3.8 + arg_238_0 then
				local var_238_23 = arg_235_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_238_23 then
					arg_235_1.var_.alphaOldValue10022 = var_238_23.alpha
					arg_235_1.var_.characterEffect10022 = var_238_23
				end

				arg_235_1.var_.alphaOldValue10022 = 0
			end

			local var_238_24 = 0.2

			if 3.8 <= arg_235_1.time_ and arg_235_1.time_ < 3.8 + var_238_24 then
				if arg_235_1.var_.characterEffect10022 then
					arg_235_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_235_1.var_.alphaOldValue10022, 1, (arg_235_1.time_ - 3.8) / var_238_24)
				end
			end

			if arg_235_1.time_ >= 3.8 + var_238_24 and arg_235_1.time_ < 3.8 + var_238_24 + arg_238_0 and arg_235_1.var_.characterEffect10022 then
				arg_235_1.var_.characterEffect10022.alpha = 1
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_25 = 4
			local var_238_26 = 0.55

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_25 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_27 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_27:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_28 = arg_235_1:GetWordFromCfg(413071054)
				local var_238_29 = arg_235_1:FormatText(var_238_28.content)

				arg_235_1.text_.text = var_238_29

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_31 = 22 <= 0 and var_238_26 or var_238_26 * (utf8.len(var_238_29) / 22)

				if (22 <= 0 and var_238_26 or var_238_26 * (utf8.len(var_238_29) / 22)) > 0 and var_238_26 < var_238_31 then
					arg_235_1.talkMaxDuration = var_238_31
					var_238_25 = var_238_25 + 0.3

					if var_238_31 + var_238_25 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_31 + var_238_25
					end
				end

				arg_235_1.text_.text = var_238_29
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071054", "story_v_out_413071.awb") ~= 0 then
					local var_238_32 = manager.audio:GetVoiceLength("story_v_out_413071", "413071054", "story_v_out_413071.awb") / 1000

					if var_238_32 + var_238_25 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_32 + var_238_25
					end

					if var_238_28.prefab_name ~= "" and arg_235_1.actors_[var_238_28.prefab_name] ~= nil then
						local var_238_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_28.prefab_name].transform, "story_v_out_413071", "413071054", "story_v_out_413071.awb")

						arg_235_1:RecordAudio("413071054", var_238_33)
						arg_235_1:RecordAudio("413071054", var_238_33)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413071", "413071054", "story_v_out_413071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413071", "413071054", "story_v_out_413071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_34 = var_238_25 + 0.3
			local var_238_35 = math.max(var_238_26, arg_235_1.talkMaxDuration)

			if var_238_25 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_34 + var_238_35 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_34) / var_238_35

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_34 + var_238_35 and arg_235_1.time_ < var_238_34 + var_238_35 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play413071055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413071055
		arg_241_1.duration_ = 4.3

		local var_241_0 = {
			zh = 2.833,
			ja = 4.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413071056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.425

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(413071055)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 17 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 17)

				if (17 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 17)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071055", "story_v_out_413071.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071055", "story_v_out_413071.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_413071", "413071055", "story_v_out_413071.awb")

						arg_241_1:RecordAudio("413071055", var_244_6)
						arg_241_1:RecordAudio("413071055", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413071", "413071055", "story_v_out_413071.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413071", "413071055", "story_v_out_413071.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play413071056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413071056
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play413071057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10022"]) and arg_245_1.var_.actorSpriteComps10022 == nil then
				arg_245_1.var_.actorSpriteComps10022 = arg_245_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10022"]) then
				if arg_245_1.var_.actorSpriteComps10022 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10022"]) and arg_245_1.var_.actorSpriteComps10022 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps10022 = nil
			end

			local var_248_2 = arg_245_1.actors_["10022"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10022 = var_248_2.localPosition
				var_248_2.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10022", 0)

				for iter_248_4 = 0, var_248_2.childCount - 1 do
					local var_248_3 = var_248_2:GetChild(iter_248_4)

					if var_248_3.name == "" or not string.find(var_248_3.name, "split") then
						var_248_3.gameObject:SetActive(true)
					else
						var_248_3.gameObject:SetActive(false)
					end
				end
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_245_1.time_ - 0) / var_248_4)
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_248_5 = 0
			local var_248_6 = 1.475

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(413071056).content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 59 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_7) / 59)

				if (59 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_7) / 59)) > 0 and var_248_6 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_6, arg_245_1.talkMaxDuration)

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_5) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_5 + var_248_10 and arg_245_1.time_ < var_248_5 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play413071057 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413071057
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413071058(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_252_1 = 0
			local var_252_2 = 1.525

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(413071057).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 61 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 61)

				if (61 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 61)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play413071058 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413071058
		arg_253_1.duration_ = 3.93

		local var_253_0 = {
			zh = 2.133,
			ja = 3.933
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play413071059(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_256_0 = 0.6

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				local var_256_1, var_256_2 = math.modf((arg_253_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_256_2 * 0.13, var_256_2 * 0.13, var_256_2 * 0.13) + arg_253_1.var_.shakeOldPos
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				manager.ui.mainCamera.transform.localPosition = arg_253_1.var_.shakeOldPos
			end

			local var_256_3 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= var_256_3 + 0.6 and arg_253_1.time_ < var_256_3 + 0.6 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_4 = 0
			local var_256_5 = 0.275

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_253_1.callingController_:SetSelectedState("calling")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_6 = arg_253_1:GetWordFromCfg(413071058)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 11 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 11)

				if (11 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 11)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071058", "story_v_out_413071.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_413071", "413071058", "story_v_out_413071.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_413071", "413071058", "story_v_out_413071.awb")

						arg_253_1:RecordAudio("413071058", var_256_11)
						arg_253_1:RecordAudio("413071058", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413071", "413071058", "story_v_out_413071.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413071", "413071058", "story_v_out_413071.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play413071059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413071059
		arg_257_1.duration_ = 6.7

		local var_257_0 = {
			zh = 4.566,
			ja = 6.7
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
				arg_257_0:Play413071060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.7

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_257_1.callingController_:SetSelectedState("calling")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(413071059)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 28 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 28)

				if (28 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 28)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071059", "story_v_out_413071.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071059", "story_v_out_413071.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_413071", "413071059", "story_v_out_413071.awb")

						arg_257_1:RecordAudio("413071059", var_260_6)
						arg_257_1:RecordAudio("413071059", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413071", "413071059", "story_v_out_413071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413071", "413071059", "story_v_out_413071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413071060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413071060
		arg_261_1.duration_ = 4.97

		local var_261_0 = {
			zh = 3.6,
			ja = 4.966
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
				arg_261_0:Play413071061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 1 < arg_261_1.time_ and arg_261_1.time_ <= 1 + arg_264_0 then
				local var_264_0 = arg_261_1.var_.effecttongxunzhongduan1

				if not arg_261_1.var_.effecttongxunzhongduan1 then
					var_264_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_264_0.name = "tongxunzhongduan1"
					arg_261_1.var_.effecttongxunzhongduan1 = var_264_0
				else
					var_264_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_264_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_264_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.2 < arg_261_1.time_ and arg_261_1.time_ <= 2.2 + arg_264_0 then
				if arg_261_1.var_.effecttongxunzhongduan1 then
					Object.Destroy(arg_261_1.var_.effecttongxunzhongduan1)

					arg_261_1.var_.effecttongxunzhongduan1 = nil
				end
			end

			local var_264_3 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_3 + 1 and arg_261_1.time_ < var_264_3 + 1 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_4 = 0
			local var_264_5 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_261_1.callingController_:SetSelectedState("calling")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_6 = arg_261_1:GetWordFromCfg(413071060)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 13 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 13)

				if (13 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 13)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071060", "story_v_out_413071.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_413071", "413071060", "story_v_out_413071.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_413071", "413071060", "story_v_out_413071.awb")

						arg_261_1:RecordAudio("413071060", var_264_11)
						arg_261_1:RecordAudio("413071060", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413071", "413071060", "story_v_out_413071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413071", "413071060", "story_v_out_413071.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413071061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413071061
		arg_265_1.duration_ = 2.9

		local var_265_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413071062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10022 = arg_265_1.actors_["10022"].transform.localPosition
				arg_265_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10022", 3)

				for iter_268_0 = 0, arg_265_1.actors_["10022"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["10022"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_2" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_268_2 = arg_265_1.actors_["10022"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10022 == nil then
				arg_265_1.var_.actorSpriteComps10022 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps10022 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 1, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10022 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps10022 = nil
			end

			if 0.8 < arg_265_1.time_ and arg_265_1.time_ <= 0.8 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_268_6 = 0
			local var_268_7 = 0.175

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_8 = arg_265_1:GetWordFromCfg(413071061)
				local var_268_9 = arg_265_1:FormatText(var_268_8.content)

				arg_265_1.text_.text = var_268_9

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 7 <= 0 and var_268_7 or var_268_7 * (utf8.len(var_268_9) / 7)

				if (7 <= 0 and var_268_7 or var_268_7 * (utf8.len(var_268_9) / 7)) > 0 and var_268_7 < var_268_11 then
					arg_265_1.talkMaxDuration = var_268_11

					if var_268_11 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_9
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071061", "story_v_out_413071.awb") ~= 0 then
					local var_268_12 = manager.audio:GetVoiceLength("story_v_out_413071", "413071061", "story_v_out_413071.awb") / 1000

					if var_268_12 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_12 + var_268_6
					end

					if var_268_8.prefab_name ~= "" and arg_265_1.actors_[var_268_8.prefab_name] ~= nil then
						local var_268_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_8.prefab_name].transform, "story_v_out_413071", "413071061", "story_v_out_413071.awb")

						arg_265_1:RecordAudio("413071061", var_268_13)
						arg_265_1:RecordAudio("413071061", var_268_13)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_413071", "413071061", "story_v_out_413071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_413071", "413071061", "story_v_out_413071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play413071062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413071062
		arg_269_1.duration_ = 4.2

		local var_269_0 = {
			zh = 4.066,
			ja = 4.2
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
				arg_269_0:Play413071063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.325

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(413071062)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 13 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 13)

				if (13 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 13)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071062", "story_v_out_413071.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071062", "story_v_out_413071.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_413071", "413071062", "story_v_out_413071.awb")

						arg_269_1:RecordAudio("413071062", var_272_6)
						arg_269_1:RecordAudio("413071062", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413071", "413071062", "story_v_out_413071.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413071", "413071062", "story_v_out_413071.awb")
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
	Play413071063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413071063
		arg_273_1.duration_ = 6.9

		local var_273_0 = {
			zh = 5.566,
			ja = 6.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play413071064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.725

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(413071063)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 29 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 29)

				if (29 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 29)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071063", "story_v_out_413071.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071063", "story_v_out_413071.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_413071", "413071063", "story_v_out_413071.awb")

						arg_273_1:RecordAudio("413071063", var_276_6)
						arg_273_1:RecordAudio("413071063", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413071", "413071063", "story_v_out_413071.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413071", "413071063", "story_v_out_413071.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play413071064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413071064
		arg_277_1.duration_ = 9

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play413071065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 2 < arg_277_1.time_ and arg_277_1.time_ <= 2 + arg_280_0 then
				local var_280_0 = arg_277_1.bgs_.F08g

				arg_277_1.bgs_.F08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_280_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_1 = var_280_0:GetComponent("SpriteRenderer")

				if var_280_1 and var_280_1.sprite then
					local var_280_2 = 2 * (var_280_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_280_0.transform.localScale = Vector3.New(var_280_2 / var_280_1.sprite.bounds.size.y < var_280_2 * manager.ui.mainCameraCom_.aspect / var_280_1.sprite.bounds.size.x and var_280_2 * manager.ui.mainCameraCom_.aspect / var_280_1.sprite.bounds.size.x or var_280_2 / var_280_1.sprite.bounds.size.y, var_280_2 / var_280_1.sprite.bounds.size.y < var_280_2 * manager.ui.mainCameraCom_.aspect / var_280_1.sprite.bounds.size.x and var_280_2 * manager.ui.mainCameraCom_.aspect / var_280_1.sprite.bounds.size.x or var_280_2 / var_280_1.sprite.bounds.size.y, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "F08g" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_3 = 4

			if 4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_3 + 0.3 and arg_277_1.time_ < var_280_3 + 0.3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			local var_280_4 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_5 = 2

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_5 then
				local var_280_6 = Color.New(0, 0, 0)

				var_280_6.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_4) / var_280_5)
				arg_277_1.mask_.color = var_280_6
			end

			if arg_277_1.time_ >= var_280_4 + var_280_5 and arg_277_1.time_ < var_280_4 + var_280_5 + arg_280_0 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = 1
				arg_277_1.mask_.color = var_280_7
			end

			local var_280_8 = 2

			if 2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_9 = 2

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 then
				local var_280_10 = Color.New(0, 0, 0)

				var_280_10.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_8) / var_280_9)
				arg_277_1.mask_.color = var_280_10
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 then
				local var_280_11 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_11.a = 0
				arg_277_1.mask_.color = var_280_11
			end

			local var_280_12 = arg_277_1.actors_["10022"].transform

			if 1.966 < arg_277_1.time_ and arg_277_1.time_ <= 1.966 + arg_280_0 then
				arg_277_1.var_.moveOldPos10022 = var_280_12.localPosition
				var_280_12.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10022", 0)

				for iter_280_2 = 0, var_280_12.childCount - 1 do
					local var_280_13 = var_280_12:GetChild(iter_280_2)

					if var_280_13.name == "" or not string.find(var_280_13.name, "split") then
						var_280_13.gameObject:SetActive(true)
					else
						var_280_13.gameObject:SetActive(false)
					end
				end
			end

			local var_280_14 = 0.001

			if 1.966 <= arg_277_1.time_ and arg_277_1.time_ < 1.966 + var_280_14 then
				var_280_12.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_277_1.time_ - 1.966) / var_280_14)
			end

			if arg_277_1.time_ >= 1.966 + var_280_14 and arg_277_1.time_ < 1.966 + var_280_14 + arg_280_0 then
				var_280_12.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_280_15 = arg_277_1.actors_["10022"]

			if 1.966 < arg_277_1.time_ and arg_277_1.time_ <= 1.966 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.actorSpriteComps10022 == nil then
				arg_277_1.var_.actorSpriteComps10022 = var_280_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_16 = 0.034

			if 1.966 <= arg_277_1.time_ and arg_277_1.time_ < 1.966 + var_280_16 and not isNil(var_280_15) then
				if arg_277_1.var_.actorSpriteComps10022 then
					for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_280_4 then
							if arg_277_1.isInRecall_ then
								iter_280_4.color = Color.New(Mathf.Lerp(iter_280_4.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 1.966) / var_280_16), Mathf.Lerp(iter_280_4.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 1.966) / var_280_16), (Mathf.Lerp(iter_280_4.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 1.966) / var_280_16)))
							else
								local var_280_17 = Mathf.Lerp(iter_280_4.color.r, 0.5, (arg_277_1.time_ - 1.966) / var_280_16)

								iter_280_4.color = Color.New(var_280_17, var_280_17, var_280_17)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 1.966 + var_280_16 and arg_277_1.time_ < 1.966 + var_280_16 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.actorSpriteComps10022 then
				for iter_280_5, iter_280_6 in pairs(arg_277_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_280_6 then
						iter_280_6.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps10022 = nil
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_18 = 4
			local var_280_19 = 1.4

			if 4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_20 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_20:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_21 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(413071064).content)

				arg_277_1.text_.text = var_280_21

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_23 = 56 <= 0 and var_280_19 or var_280_19 * (utf8.len(var_280_21) / 56)

				if (56 <= 0 and var_280_19 or var_280_19 * (utf8.len(var_280_21) / 56)) > 0 and var_280_19 < var_280_23 then
					arg_277_1.talkMaxDuration = var_280_23
					var_280_18 = var_280_18 + 0.3

					if var_280_23 + var_280_18 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_18
					end
				end

				arg_277_1.text_.text = var_280_21
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_24 = var_280_18 + 0.3
			local var_280_25 = math.max(var_280_19, arg_277_1.talkMaxDuration)

			if var_280_18 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_24 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_24) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_24 + var_280_25 and arg_277_1.time_ < var_280_24 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play413071065 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 413071065
		arg_283_1.duration_ = 4.87

		local var_283_0 = {
			zh = 4.866,
			ja = 3.566
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play413071066(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.2

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:GetWordFromCfg(413071065)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 8 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 8)

				if (8 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 8)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071065", "story_v_out_413071.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071065", "story_v_out_413071.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_413071", "413071065", "story_v_out_413071.awb")

						arg_283_1:RecordAudio("413071065", var_286_6)
						arg_283_1:RecordAudio("413071065", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_413071", "413071065", "story_v_out_413071.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_413071", "413071065", "story_v_out_413071.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play413071066 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413071066
		arg_287_1.duration_ = 3.7

		local var_287_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play413071067(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10022 = arg_287_1.actors_["10022"].transform.localPosition
				arg_287_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10022", 3)

				for iter_290_0 = 0, arg_287_1.actors_["10022"].transform.childCount - 1 do
					local var_290_0 = arg_287_1.actors_["10022"].transform:GetChild(iter_290_0)

					if var_290_0.name == "split_8" or not string.find(var_290_0.name, "split") then
						var_290_0.gameObject:SetActive(true)
					else
						var_290_0.gameObject:SetActive(false)
					end
				end
			end

			local var_290_1 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				arg_287_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_287_1.time_ - 0) / var_290_1)
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 then
				arg_287_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_290_2 = arg_287_1.actors_["10022"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10022 == nil then
				arg_287_1.var_.actorSpriteComps10022 = var_290_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_3 = 2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.actorSpriteComps10022 then
					for iter_290_1, iter_290_2 in pairs(arg_287_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_290_2 then
							if arg_287_1.isInRecall_ then
								iter_290_2.color = Color.New(Mathf.Lerp(iter_290_2.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_3), Mathf.Lerp(iter_290_2.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_3), (Mathf.Lerp(iter_290_2.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_3)))
							else
								local var_290_4 = Mathf.Lerp(iter_290_2.color.r, 1, (arg_287_1.time_ - 0) / var_290_3)

								iter_290_2.color = Color.New(var_290_4, var_290_4, var_290_4)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10022 then
				for iter_290_3, iter_290_4 in pairs(arg_287_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_290_4 then
						iter_290_4.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10022 = nil
			end

			local var_290_5 = 0
			local var_290_6 = 0.225

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(413071066)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 9 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 9)

				if (9 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 9)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071066", "story_v_out_413071.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071066", "story_v_out_413071.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_413071", "413071066", "story_v_out_413071.awb")

						arg_287_1:RecordAudio("413071066", var_290_12)
						arg_287_1:RecordAudio("413071066", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_413071", "413071066", "story_v_out_413071.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_413071", "413071066", "story_v_out_413071.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_13 and arg_287_1.time_ < var_290_5 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play413071067 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413071067
		arg_291_1.duration_ = 7.27

		local var_291_0 = {
			zh = 3.533,
			ja = 7.266
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play413071068(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10022"]) and arg_291_1.var_.actorSpriteComps10022 == nil then
				arg_291_1.var_.actorSpriteComps10022 = arg_291_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10022"]) then
				if arg_291_1.var_.actorSpriteComps10022 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10022"]) and arg_291_1.var_.actorSpriteComps10022 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10022 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_4 = arg_291_1:GetWordFromCfg(413071067)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 12 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 12)

				if (12 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 12)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071067", "story_v_out_413071.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071067", "story_v_out_413071.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_out_413071", "413071067", "story_v_out_413071.awb")

						arg_291_1:RecordAudio("413071067", var_294_9)
						arg_291_1:RecordAudio("413071067", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413071", "413071067", "story_v_out_413071.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413071", "413071067", "story_v_out_413071.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play413071068 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413071068
		arg_295_1.duration_ = 5

		local var_295_0 = {
			zh = 5,
			ja = 3.066
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play413071069(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:AudioAction("play", "effect", "se_story_129", "se_story_129_break", "")
			end

			local var_298_1 = 0
			local var_298_2 = 0.15

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(413071068)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_6 = 6 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_4) / 6)

				if (6 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_4) / 6)) > 0 and var_298_2 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071068", "story_v_out_413071.awb") ~= 0 then
					local var_298_7 = manager.audio:GetVoiceLength("story_v_out_413071", "413071068", "story_v_out_413071.awb") / 1000

					if var_298_7 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_1
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_413071", "413071068", "story_v_out_413071.awb")

						arg_295_1:RecordAudio("413071068", var_298_8)
						arg_295_1:RecordAudio("413071068", var_298_8)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413071", "413071068", "story_v_out_413071.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413071", "413071068", "story_v_out_413071.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_9 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_9 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_9

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_9 and arg_295_1.time_ < var_298_1 + var_298_9 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play413071069 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413071069
		arg_299_1.duration_ = 3.57

		local var_299_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_299_0:Play413071070(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10022 = arg_299_1.actors_["10022"].transform.localPosition
				arg_299_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10022", 3)

				for iter_302_0 = 0, arg_299_1.actors_["10022"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10022"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_6" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_302_2 = arg_299_1.actors_["10022"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10022 == nil then
				arg_299_1.var_.actorSpriteComps10022 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10022 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 1, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10022 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10022 = nil
			end

			local var_302_5 = 0
			local var_302_6 = 0.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(413071069)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 8 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 8)

				if (8 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 8)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071069", "story_v_out_413071.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_413071", "413071069", "story_v_out_413071.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_413071", "413071069", "story_v_out_413071.awb")

						arg_299_1:RecordAudio("413071069", var_302_12)
						arg_299_1:RecordAudio("413071069", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413071", "413071069", "story_v_out_413071.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413071", "413071069", "story_v_out_413071.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_13 = math.max(var_302_6, arg_299_1.talkMaxDuration)

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_13 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_5) / var_302_13

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_5 + var_302_13 and arg_299_1.time_ < var_302_5 + var_302_13 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play413071070 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413071070
		arg_303_1.duration_ = 3.7

		local var_303_0 = {
			zh = 3.7,
			ja = 2.366
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
				arg_303_0:Play413071071(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.4

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(413071070)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 16 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 16)

				if (16 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 16)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071070", "story_v_out_413071.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071070", "story_v_out_413071.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_413071", "413071070", "story_v_out_413071.awb")

						arg_303_1:RecordAudio("413071070", var_306_6)
						arg_303_1:RecordAudio("413071070", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413071", "413071070", "story_v_out_413071.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413071", "413071070", "story_v_out_413071.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play413071071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413071071
		arg_307_1.duration_ = 6.57

		local var_307_0 = {
			zh = 4.366,
			ja = 6.566
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
			arg_307_1.auto_ = false
		end

		function arg_307_1.playNext_(arg_309_0)
			arg_307_1.onStoryFinished_()
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.45

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(413071071)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 18 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 18)

				if (18 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 18)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071071", "story_v_out_413071.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_413071", "413071071", "story_v_out_413071.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_413071", "413071071", "story_v_out_413071.awb")

						arg_307_1:RecordAudio("413071071", var_310_6)
						arg_307_1:RecordAudio("413071071", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413071", "413071071", "story_v_out_413071.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413071", "413071071", "story_v_out_413071.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1305",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F08g"
	},
	voices = {
		"story_v_out_413071.awb"
	}
}
