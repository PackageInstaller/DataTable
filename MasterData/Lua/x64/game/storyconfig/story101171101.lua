return {
	Play117111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_4_0.name = "ST03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
			local var_4_15 = 0.85

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(117111001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)

				if (34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)) > 0 and var_4_15 < var_4_19 then
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
	Play117111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 117111002
		arg_9_1.duration_ = 10.97

		local var_9_0 = {
			zh = 10.966,
			ja = 9.533
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play117111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10035"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10035"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10035"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10035"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10035 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10035", 2)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_4" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10035, Vector3.New(-390, -410, -235), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_12_5 = arg_9_1.actors_["10035"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10035 == nil then
				arg_9_1.var_.actorSpriteComps10035 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10035 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10035 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10035 = var_12_8.alpha
					arg_9_1.var_.characterEffect10035 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10035 = 0
			end

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10035 then
					arg_9_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10035, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10035 then
				arg_9_1.var_.characterEffect10035.alpha = 1
			end

			local var_12_10 = "1033"

			if arg_9_1.actors_["1033"] == nil then
				local var_12_11 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_12_11) then
					local var_12_12 = Object.Instantiate(var_12_11, arg_9_1.canvasGo_.transform)

					var_12_12.transform:SetSiblingIndex(1)

					var_12_12.name = var_12_10
					var_12_12.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_10] = var_12_12

					if arg_9_1.isInRecall_ then
						for iter_12_7, iter_12_8 in ipairs((var_12_12:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_8.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_13 = arg_9_1.actors_["1033"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_13.localPosition
				var_12_13.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 4)

				for iter_12_9 = 0, var_12_13.childCount - 1 do
					local var_12_14 = var_12_13:GetChild(iter_12_9)

					if var_12_14.name == "split_6" or not string.find(var_12_14.name, "split") then
						var_12_14.gameObject:SetActive(true)
					else
						var_12_14.gameObject:SetActive(false)
					end
				end
			end

			local var_12_15 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 then
				var_12_13.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_9_1.time_ - 0) / var_12_15)
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 then
				var_12_13.localPosition = Vector3.New(390, -420, 0)
			end

			local var_12_16 = arg_9_1.actors_["1033"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.actorSpriteComps1033 == nil then
				arg_9_1.var_.actorSpriteComps1033 = var_12_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_17 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_17 and not isNil(var_12_16) then
				if arg_9_1.var_.actorSpriteComps1033 then
					for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_12_11 then
							if arg_9_1.isInRecall_ then
								iter_12_11.color = Color.New(Mathf.Lerp(iter_12_11.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_17), Mathf.Lerp(iter_12_11.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_17), (Mathf.Lerp(iter_12_11.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_17)))
							else
								local var_12_18 = Mathf.Lerp(iter_12_11.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_17)

								iter_12_11.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_17 and arg_9_1.time_ < 0 + var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.actorSpriteComps1033 then
				for iter_12_12, iter_12_13 in pairs(arg_9_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_12_13 then
						iter_12_13.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_19 = arg_9_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_19 then
					arg_9_1.var_.alphaOldValue1033 = var_12_19.alpha
					arg_9_1.var_.characterEffect1033 = var_12_19
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_20 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_20 then
				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, (arg_9_1.time_ - 0) / var_12_20)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_20 and arg_9_1.time_ < 0 + var_12_20 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_21 = 0
			local var_12_22 = 1.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(117111002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 59 <= 0 and var_12_22 or var_12_22 * (utf8.len(var_12_24) / 59)

				if (59 <= 0 and var_12_22 or var_12_22 * (utf8.len(var_12_24) / 59)) > 0 and var_12_22 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_21
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111002", "story_v_out_117111.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_117111", "117111002", "story_v_out_117111.awb") / 1000

					if var_12_27 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_21
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_117111", "117111002", "story_v_out_117111.awb")

						arg_9_1:RecordAudio("117111002", var_12_28)
						arg_9_1:RecordAudio("117111002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_117111", "117111002", "story_v_out_117111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_117111", "117111002", "story_v_out_117111.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_22, arg_9_1.talkMaxDuration)

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_29 and arg_9_1.time_ < var_12_21 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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

		arg_9_1:InitPlayNodeList()
	end,
	Play117111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 117111003
		arg_13_1.duration_ = 9.53

		local var_13_0 = {
			zh = 9.533,
			ja = 6.8
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
				arg_13_0:Play117111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(117111003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 56)

				if (56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 56)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111003", "story_v_out_117111.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_117111", "117111003", "story_v_out_117111.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_117111", "117111003", "story_v_out_117111.awb")

						arg_13_1:RecordAudio("117111003", var_16_6)
						arg_13_1:RecordAudio("117111003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_117111", "117111003", "story_v_out_117111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_117111", "117111003", "story_v_out_117111.awb")
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
	Play117111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 117111004
		arg_17_1.duration_ = 9.2

		local var_17_0 = {
			zh = 8.333,
			ja = 9.2
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
				arg_17_0:Play117111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(117111004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 50 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 50)

				if (50 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 50)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111004", "story_v_out_117111.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_117111", "117111004", "story_v_out_117111.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_117111", "117111004", "story_v_out_117111.awb")

						arg_17_1:RecordAudio("117111004", var_20_6)
						arg_17_1:RecordAudio("117111004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_117111", "117111004", "story_v_out_117111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_117111", "117111004", "story_v_out_117111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play117111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 117111005
		arg_21_1.duration_ = 7.77

		local var_21_0 = {
			zh = 5.466,
			ja = 7.766
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
				arg_21_0:Play117111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10035"]) and arg_21_1.var_.actorSpriteComps10035 == nil then
				arg_21_1.var_.actorSpriteComps10035 = arg_21_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10035"]) then
				if arg_21_1.var_.actorSpriteComps10035 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10035"]) and arg_21_1.var_.actorSpriteComps10035 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10035 = nil
			end

			local var_24_2 = arg_21_1.actors_["1033"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1033 == nil then
				arg_21_1.var_.actorSpriteComps1033 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1033 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1033 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1033 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(117111005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 22 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 22)

				if (22 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 22)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111005", "story_v_out_117111.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_117111", "117111005", "story_v_out_117111.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_117111", "117111005", "story_v_out_117111.awb")

						arg_21_1:RecordAudio("117111005", var_24_12)
						arg_21_1:RecordAudio("117111005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_117111", "117111005", "story_v_out_117111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_117111", "117111005", "story_v_out_117111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play117111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 117111006
		arg_25_1.duration_ = 6.4

		local var_25_0 = {
			zh = 3.333,
			ja = 6.4
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
				arg_25_0:Play117111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10035"]) and arg_25_1.var_.actorSpriteComps10035 == nil then
				arg_25_1.var_.actorSpriteComps10035 = arg_25_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10035"]) then
				if arg_25_1.var_.actorSpriteComps10035 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 1, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10035"]) and arg_25_1.var_.actorSpriteComps10035 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10035 = nil
			end

			local var_28_2 = arg_25_1.actors_["1033"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1033 == nil then
				arg_25_1.var_.actorSpriteComps1033 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1033 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1033 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1033 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(117111006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 12 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 12)

				if (12 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 12)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111006", "story_v_out_117111.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_117111", "117111006", "story_v_out_117111.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_117111", "117111006", "story_v_out_117111.awb")

						arg_25_1:RecordAudio("117111006", var_28_12)
						arg_25_1:RecordAudio("117111006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_117111", "117111006", "story_v_out_117111.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_117111", "117111006", "story_v_out_117111.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play117111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 117111007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play117111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10035"]) and arg_29_1.var_.actorSpriteComps10035 == nil then
				arg_29_1.var_.actorSpriteComps10035 = arg_29_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10035"]) then
				if arg_29_1.var_.actorSpriteComps10035 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10035"]) and arg_29_1.var_.actorSpriteComps10035 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10035 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 1.375

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

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(117111007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 55 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 55)

				if (55 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 55)) > 0 and var_32_3 < var_32_6 then
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play117111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 117111008
		arg_33_1.duration_ = 4.6

		local var_33_0 = {
			zh = 4.3,
			ja = 4.6
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play117111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1033 = arg_33_1.actors_["1033"].transform.localPosition
				arg_33_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1033", 4)

				for iter_36_0 = 0, arg_33_1.actors_["1033"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1033"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_4" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_36_2 = arg_33_1.actors_["1033"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1033 == nil then
				arg_33_1.var_.actorSpriteComps1033 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.0166666666666667

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1033 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1033 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1033 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(117111008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 22 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 22)

				if (22 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 22)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111008", "story_v_out_117111.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_117111", "117111008", "story_v_out_117111.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_117111", "117111008", "story_v_out_117111.awb")

						arg_33_1:RecordAudio("117111008", var_36_12)
						arg_33_1:RecordAudio("117111008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_117111", "117111008", "story_v_out_117111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_117111", "117111008", "story_v_out_117111.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play117111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 117111009
		arg_37_1.duration_ = 3.13

		local var_37_0 = {
			zh = 1.233,
			ja = 3.133
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
				arg_37_0:Play117111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10035"]) and arg_37_1.var_.actorSpriteComps10035 == nil then
				arg_37_1.var_.actorSpriteComps10035 = arg_37_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10035"]) then
				if arg_37_1.var_.actorSpriteComps10035 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10035:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10035"]) and arg_37_1.var_.actorSpriteComps10035 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10035 = nil
			end

			local var_40_2 = arg_37_1.actors_["1033"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(117111009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 5 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 5)

				if (5 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 5)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111009", "story_v_out_117111.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_117111", "117111009", "story_v_out_117111.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_117111", "117111009", "story_v_out_117111.awb")

						arg_37_1:RecordAudio("117111009", var_40_12)
						arg_37_1:RecordAudio("117111009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_117111", "117111009", "story_v_out_117111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_117111", "117111009", "story_v_out_117111.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play117111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 117111010
		arg_41_1.duration_ = 3.97

		local var_41_0 = {
			zh = 3.966,
			ja = 1.8
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
				arg_41_0:Play117111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10035"]) and arg_41_1.var_.actorSpriteComps10035 == nil then
				arg_41_1.var_.actorSpriteComps10035 = arg_41_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10035"]) then
				if arg_41_1.var_.actorSpriteComps10035 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10035"]) and arg_41_1.var_.actorSpriteComps10035 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10035 = nil
			end

			local var_44_2 = arg_41_1.actors_["1033"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1033 == nil then
				arg_41_1.var_.actorSpriteComps1033 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1033 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1033 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1033 = nil
			end

			local var_44_5 = arg_41_1.actors_["1033"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1033 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1033", 4)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "split_6" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(390, -420, 0)
			end

			local var_44_8 = 0
			local var_44_9 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(117111010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 25 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 25)

				if (25 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 25)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111010", "story_v_out_117111.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_117111", "117111010", "story_v_out_117111.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_117111", "117111010", "story_v_out_117111.awb")

						arg_41_1:RecordAudio("117111010", var_44_15)
						arg_41_1:RecordAudio("117111010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_117111", "117111010", "story_v_out_117111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_117111", "117111010", "story_v_out_117111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play117111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 117111011
		arg_45_1.duration_ = 2.5

		local var_45_0 = {
			zh = 2.5,
			ja = 2.333
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play117111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10035 = arg_45_1.actors_["10035"].transform.localPosition
				arg_45_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10035", 2)

				for iter_48_0 = 0, arg_45_1.actors_["10035"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10035"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_5" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10035, Vector3.New(-390, -410, -235), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10035"].transform.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_48_2 = arg_45_1.actors_["10035"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10035 == nil then
				arg_45_1.var_.actorSpriteComps10035 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10035 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10035 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10035 = nil
			end

			local var_48_5 = arg_45_1.actors_["1033"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1033 == nil then
				arg_45_1.var_.actorSpriteComps1033 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps1033 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_6.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_6.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps1033 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1033 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(117111011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 9 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 9)

				if (9 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 9)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111011", "story_v_out_117111.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_117111", "117111011", "story_v_out_117111.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_117111", "117111011", "story_v_out_117111.awb")

						arg_45_1:RecordAudio("117111011", var_48_15)
						arg_45_1:RecordAudio("117111011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_117111", "117111011", "story_v_out_117111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_117111", "117111011", "story_v_out_117111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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
	Play117111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 117111012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play117111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10035"]) and arg_49_1.var_.actorSpriteComps10035 == nil then
				arg_49_1.var_.actorSpriteComps10035 = arg_49_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10035"]) then
				if arg_49_1.var_.actorSpriteComps10035 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10035"]) and arg_49_1.var_.actorSpriteComps10035 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10035 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.475

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

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(117111012).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 19 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 19)

				if (19 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 19)) > 0 and var_52_3 < var_52_6 then
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play117111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 117111013
		arg_53_1.duration_ = 12.6

		local var_53_0 = {
			zh = 7.466,
			ja = 12.6
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
				arg_53_0:Play117111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10035 = arg_53_1.actors_["10035"].transform.localPosition
				arg_53_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10035", 2)

				for iter_56_0 = 0, arg_53_1.actors_["10035"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10035"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_4" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10035, Vector3.New(-390, -410, -235), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10035"].transform.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_56_2 = arg_53_1.actors_["1033"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1033 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1033", 4)

				for iter_56_1 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_1)

					if var_56_3.name == "split_6" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(390, -420, 0)
			end

			local var_56_5 = arg_53_1.actors_["1033"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1033 == nil then
				arg_53_1.var_.actorSpriteComps1033 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1033 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								iter_56_3.color = Color.New(Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_3.color.r, 1, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_3.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1033 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_56_5 then
						iter_56_5.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1033 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.925

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(117111013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 37 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 37)

				if (37 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 37)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111013", "story_v_out_117111.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_117111", "117111013", "story_v_out_117111.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_117111", "117111013", "story_v_out_117111.awb")

						arg_53_1:RecordAudio("117111013", var_56_15)
						arg_53_1:RecordAudio("117111013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_117111", "117111013", "story_v_out_117111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_117111", "117111013", "story_v_out_117111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
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

		arg_53_1:InitPlayNodeList()
	end,
	Play117111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 117111014
		arg_57_1.duration_ = 5.9

		local var_57_0 = {
			zh = 4.666,
			ja = 5.9
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
				arg_57_0:Play117111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(117111014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)

				if (23 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 23)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111014", "story_v_out_117111.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_117111", "117111014", "story_v_out_117111.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_117111", "117111014", "story_v_out_117111.awb")

						arg_57_1:RecordAudio("117111014", var_60_6)
						arg_57_1:RecordAudio("117111014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_117111", "117111014", "story_v_out_117111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_117111", "117111014", "story_v_out_117111.awb")
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
	Play117111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 117111015
		arg_61_1.duration_ = 4.5

		local var_61_0 = {
			zh = 2.166,
			ja = 4.5
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play117111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033 = arg_61_1.actors_["1033"].transform.localPosition
				arg_61_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1033", 4)

				for iter_64_0 = 0, arg_61_1.actors_["1033"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1033"].transform:GetChild(iter_64_0)

					if var_64_0.name == "split_6" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_64_2 = arg_61_1.actors_["10035"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10035 == nil then
				arg_61_1.var_.actorSpriteComps10035 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10035 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								iter_64_2.color = Color.New(Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_2.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_2.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10035 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_64_4 then
						iter_64_4.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10035 = nil
			end

			local var_64_5 = arg_61_1.actors_["1033"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_6 then
							if arg_61_1.isInRecall_ then
								iter_64_6.color = Color.New(Mathf.Lerp(iter_64_6.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_6.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_6.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_6.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_6.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_7, iter_64_8 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_8 then
						iter_64_8.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(117111015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 6 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 6)

				if (6 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 6)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111015", "story_v_out_117111.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_117111", "117111015", "story_v_out_117111.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_117111", "117111015", "story_v_out_117111.awb")

						arg_61_1:RecordAudio("117111015", var_64_15)
						arg_61_1:RecordAudio("117111015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_117111", "117111015", "story_v_out_117111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_117111", "117111015", "story_v_out_117111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play117111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 117111016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play117111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = arg_65_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_68_0 then
					arg_65_1.var_.alphaOldValue1033 = var_68_0.alpha
					arg_65_1.var_.characterEffect1033 = var_68_0
				end

				arg_65_1.var_.alphaOldValue1033 = 1
			end

			local var_68_1 = 0.5

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				if arg_65_1.var_.characterEffect1033 then
					arg_65_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_65_1.var_.alphaOldValue1033, 0, (arg_65_1.time_ - 0) / var_68_1)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and arg_65_1.var_.characterEffect1033 then
				arg_65_1.var_.characterEffect1033.alpha = 0
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_2 = arg_65_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_68_2 then
					arg_65_1.var_.alphaOldValue10035 = var_68_2.alpha
					arg_65_1.var_.characterEffect10035 = var_68_2
				end

				arg_65_1.var_.alphaOldValue10035 = 1
			end

			local var_68_3 = 0.5

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 then
				if arg_65_1.var_.characterEffect10035 then
					arg_65_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_65_1.var_.alphaOldValue10035, 0, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and arg_65_1.var_.characterEffect10035 then
				arg_65_1.var_.characterEffect10035.alpha = 0
			end

			local var_68_4 = 0
			local var_68_5 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(117111016).content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 14)

				if (14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 14)) > 0 and var_68_5 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_9 and arg_65_1.time_ < var_68_4 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play117111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 117111017
		arg_69_1.duration_ = 13.67

		local var_69_0 = {
			zh = 9,
			ja = 13.666
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play117111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = arg_69_1.actors_["1033"].transform.localPosition
				arg_69_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 3)

				for iter_72_0 = 0, arg_69_1.actors_["1033"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1033"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_6" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_72_2 = arg_69_1.actors_["1033"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1033 == nil then
				arg_69_1.var_.actorSpriteComps1033 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1033 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1033 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_5 = arg_69_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_5 then
					arg_69_1.var_.alphaOldValue1033 = var_72_5.alpha
					arg_69_1.var_.characterEffect1033 = var_72_5
				end

				arg_69_1.var_.alphaOldValue1033 = 0
			end

			local var_72_6 = 0.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 then
				if arg_69_1.var_.characterEffect1033 then
					arg_69_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue1033, 1, (arg_69_1.time_ - 0) / var_72_6)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and arg_69_1.var_.characterEffect1033 then
				arg_69_1.var_.characterEffect1033.alpha = 1
			end

			local var_72_7 = 0
			local var_72_8 = 1.225

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
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

				local var_72_9 = arg_69_1:GetWordFromCfg(117111017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 49 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_10) / 49)

				if (49 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_10) / 49)) > 0 and var_72_8 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111017", "story_v_out_117111.awb") ~= 0 then
					local var_72_13 = manager.audio:GetVoiceLength("story_v_out_117111", "117111017", "story_v_out_117111.awb") / 1000

					if var_72_13 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_7
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_117111", "117111017", "story_v_out_117111.awb")

						arg_69_1:RecordAudio("117111017", var_72_14)
						arg_69_1:RecordAudio("117111017", var_72_14)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_117111", "117111017", "story_v_out_117111.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_117111", "117111017", "story_v_out_117111.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_15 and arg_69_1.time_ < var_72_7 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play117111018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 117111018
		arg_73_1.duration_ = 2.63

		local var_73_0 = {
			zh = 1.833,
			ja = 2.633
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
			arg_73_1.auto_ = false
		end

		function arg_73_1.playNext_(arg_75_0)
			arg_73_1.onStoryFinished_()
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
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

				local var_76_1 = arg_73_1:GetWordFromCfg(117111018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 8 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 8)

				if (8 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 8)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117111", "117111018", "story_v_out_117111.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_117111", "117111018", "story_v_out_117111.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_117111", "117111018", "story_v_out_117111.awb")

						arg_73_1:RecordAudio("117111018", var_76_6)
						arg_73_1:RecordAudio("117111018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_117111", "117111018", "story_v_out_117111.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_117111", "117111018", "story_v_out_117111.awb")
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
	assets = {
		"TextureConfig/Background/ST03"
	},
	voices = {
		"story_v_out_117111.awb"
	}
}
