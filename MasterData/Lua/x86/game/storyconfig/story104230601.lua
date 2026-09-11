return {
	Play423061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play423061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0112 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0112")
				var_4_0.name = "ST0112"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0112 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0112

				arg_1_1.bgs_.ST0112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0112" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel")

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
				arg_1_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.75

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

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(423061001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 30)

				if (30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 30)) > 0 and var_4_17 < var_4_21 then
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
	Play423061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.1

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423061002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 44 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 44)

				if (44 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 44)) > 0 and var_12_0 < var_12_3 then
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
	Play423061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423061003
		arg_13_1.duration_ = 9.47

		local var_13_0 = {
			zh = 8.2,
			ja = 9.466
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
				arg_13_0:Play423061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10148"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10148"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10148"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10148"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10148 == nil then
				arg_13_1.var_.actorSpriteComps10148 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10148 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								iter_16_3.color = Color.New(Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_3.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_3.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10148 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10148 = nil
			end

			local var_16_5 = arg_13_1.actors_["10148"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10148 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10148", 3)

				for iter_16_6 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_6)

					if var_16_6.name == "split_4" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -350, -270)
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_8 = arg_13_1.actors_["10148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_8 then
					arg_13_1.var_.alphaOldValue10148 = var_16_8.alpha
					arg_13_1.var_.characterEffect10148 = var_16_8
				end

				arg_13_1.var_.alphaOldValue10148 = 0
			end

			local var_16_9 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				if arg_13_1.var_.characterEffect10148 then
					arg_13_1.var_.characterEffect10148.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10148, 1, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and arg_13_1.var_.characterEffect10148 then
				arg_13_1.var_.characterEffect10148.alpha = 1
			end

			local var_16_10 = 0
			local var_16_11 = 0.85

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(423061003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 34 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 34)

				if (34 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 34)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061003", "story_v_out_423061.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_423061", "423061003", "story_v_out_423061.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_423061", "423061003", "story_v_out_423061.awb")

						arg_13_1:RecordAudio("423061003", var_16_17)
						arg_13_1:RecordAudio("423061003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423061", "423061003", "story_v_out_423061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423061", "423061003", "story_v_out_423061.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423061004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10148"]) and arg_17_1.var_.actorSpriteComps10148 == nil then
				arg_17_1.var_.actorSpriteComps10148 = arg_17_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10148"]) then
				if arg_17_1.var_.actorSpriteComps10148 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10148"]) and arg_17_1.var_.actorSpriteComps10148 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10148 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 1.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(423061004).content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 58 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 58)

				if (58 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 58)) > 0 and var_20_3 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_7 and arg_17_1.time_ < var_20_2 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play423061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423061005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play423061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(423061005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 38 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 38)

				if (38 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 38)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play423061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423061006
		arg_25_1.duration_ = 6.03

		local var_25_0 = {
			zh = 5.333,
			ja = 6.033
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
				arg_25_0:Play423061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10148"]) and arg_25_1.var_.actorSpriteComps10148 == nil then
				arg_25_1.var_.actorSpriteComps10148 = arg_25_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10148"]) then
				if arg_25_1.var_.actorSpriteComps10148 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10148"]) and arg_25_1.var_.actorSpriteComps10148 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10148 = nil
			end

			local var_28_2 = arg_25_1.actors_["10148"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10148 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10148", 3)

				for iter_28_4 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_4)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_28_5 = 0
			local var_28_6 = 0.625

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(423061006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 25 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 25)

				if (25 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 25)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061006", "story_v_out_423061.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061006", "story_v_out_423061.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_423061", "423061006", "story_v_out_423061.awb")

						arg_25_1:RecordAudio("423061006", var_28_12)
						arg_25_1:RecordAudio("423061006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423061", "423061006", "story_v_out_423061.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423061", "423061006", "story_v_out_423061.awb")
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

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play423061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423061007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10148"]) and arg_29_1.var_.actorSpriteComps10148 == nil then
				arg_29_1.var_.actorSpriteComps10148 = arg_29_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10148"]) then
				if arg_29_1.var_.actorSpriteComps10148 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10148"]) and arg_29_1.var_.actorSpriteComps10148 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10148 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(423061007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 23 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 23)

				if (23 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 23)) > 0 and var_32_3 < var_32_6 then
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
	Play423061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423061008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play423061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.575

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(423061008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 23 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 23)

				if (23 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 23)) > 0 and var_36_0 < var_36_3 then
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
	Play423061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423061009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(423061009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 24 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 24)

				if (24 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 24)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423061010
		arg_41_1.duration_ = 6.33

		local var_41_0 = {
			zh = 6.333,
			ja = 6
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
				arg_41_0:Play423061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["1083"] == nil then
				local var_44_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_44_0) then
					local var_44_1 = Object.Instantiate(var_44_0, arg_41_1.canvasGo_.transform)

					var_44_1.transform:SetSiblingIndex(1)

					var_44_1.name = "1083"
					var_44_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_["1083"] = var_44_1

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs((var_44_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_2 = arg_41_1.actors_["1083"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1083 == nil then
				arg_41_1.var_.actorSpriteComps1083 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1083 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								iter_44_3.color = Color.New(Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_3.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_3.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1083 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1083 = nil
			end

			local var_44_5 = arg_41_1.actors_["1083"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 3)

				for iter_44_6 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_6)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_44_8 = arg_41_1.actors_["10148"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 7)

				for iter_44_7 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_7)

					if var_44_9.name == "" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_11 = arg_41_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_11 then
					arg_41_1.var_.alphaOldValue1083 = var_44_11.alpha
					arg_41_1.var_.characterEffect1083 = var_44_11
				end

				arg_41_1.var_.alphaOldValue1083 = 0
			end

			local var_44_12 = 0.5

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_12 then
				if arg_41_1.var_.characterEffect1083 then
					arg_41_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_41_1.var_.alphaOldValue1083, 1, (arg_41_1.time_ - 0) / var_44_12)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_12 and arg_41_1.time_ < 0 + var_44_12 + arg_44_0 and arg_41_1.var_.characterEffect1083 then
				arg_41_1.var_.characterEffect1083.alpha = 1
			end

			local var_44_13 = 0
			local var_44_14 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
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

				local var_44_15 = arg_41_1:GetWordFromCfg(423061010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_18 = 29 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 29)

				if (29 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 29)) > 0 and var_44_14 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061010", "story_v_out_423061.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_423061", "423061010", "story_v_out_423061.awb") / 1000

					if var_44_19 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_13
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_423061", "423061010", "story_v_out_423061.awb")

						arg_41_1:RecordAudio("423061010", var_44_20)
						arg_41_1:RecordAudio("423061010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423061", "423061010", "story_v_out_423061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423061", "423061010", "story_v_out_423061.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_13) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_13 + var_44_21 and arg_41_1.time_ < var_44_13 + var_44_21 + arg_44_0 then
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
			},
			{
				assetPath = "",
				actorName = "10148",
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
	Play423061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423061011
		arg_45_1.duration_ = 7.43

		local var_45_0 = {
			zh = 7.433,
			ja = 6.066
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
				arg_45_0:Play423061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = arg_45_1.actors_["1083"].transform.localPosition
				arg_45_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 3)

				for iter_48_0 = 0, arg_45_1.actors_["1083"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1083"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_48_2 = 0
			local var_48_3 = 0.725

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(423061011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 29 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 29)

				if (29 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 29)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061011", "story_v_out_423061.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061011", "story_v_out_423061.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_423061", "423061011", "story_v_out_423061.awb")

						arg_45_1:RecordAudio("423061011", var_48_9)
						arg_45_1:RecordAudio("423061011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423061", "423061011", "story_v_out_423061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423061", "423061011", "story_v_out_423061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
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
	Play423061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423061012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1083"]) and arg_49_1.var_.actorSpriteComps1083 == nil then
				arg_49_1.var_.actorSpriteComps1083 = arg_49_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1083"]) then
				if arg_49_1.var_.actorSpriteComps1083 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1083"]) and arg_49_1.var_.actorSpriteComps1083 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1083 = nil
			end

			if 1.23333333333333 < arg_49_1.time_ and arg_49_1.time_ <= 1.23333333333333 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_144", "se_story_144_clap03", "")
			end

			local var_52_3 = 0
			local var_52_4 = 1.55

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(423061012).content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 62 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 62)

				if (62 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_5) / 62)) > 0 and var_52_4 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_8 and arg_49_1.time_ < var_52_3 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play423061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423061013
		arg_53_1.duration_ = 3.03

		local var_53_0 = {
			zh = 3.033,
			ja = 2.8
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
				arg_53_0:Play423061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10148"]) and arg_53_1.var_.actorSpriteComps10148 == nil then
				arg_53_1.var_.actorSpriteComps10148 = arg_53_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10148"]) then
				if arg_53_1.var_.actorSpriteComps10148 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10148"]) and arg_53_1.var_.actorSpriteComps10148 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10148 = nil
			end

			local var_56_2 = arg_53_1.actors_["10148"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10148 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10148", 3)

				for iter_56_4 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_4)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_56_5 = 0
			local var_56_6 = 0.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(423061013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 11 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 11)

				if (11 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 11)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061013", "story_v_out_423061.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061013", "story_v_out_423061.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_423061", "423061013", "story_v_out_423061.awb")

						arg_53_1:RecordAudio("423061013", var_56_12)
						arg_53_1:RecordAudio("423061013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423061", "423061013", "story_v_out_423061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423061", "423061013", "story_v_out_423061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423061014
		arg_57_1.duration_ = 9.2

		local var_57_0 = {
			zh = 9.2,
			ja = 6.4
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
				arg_57_0:Play423061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10148"]) and arg_57_1.var_.actorSpriteComps10148 == nil then
				arg_57_1.var_.actorSpriteComps10148 = arg_57_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10148"]) then
				if arg_57_1.var_.actorSpriteComps10148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10148"]) and arg_57_1.var_.actorSpriteComps10148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10148 = nil
			end

			local var_60_2 = arg_57_1.actors_["10148"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10148 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10148", 7)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_5 = arg_57_1.actors_["1083"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1083 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1083", 7)

				for iter_60_5 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_5)

					if var_60_6.name == "" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_8 = 0
			local var_60_9 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_10 = arg_57_1:GetWordFromCfg(423061014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 29 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 29)

				if (29 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 29)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061014", "story_v_out_423061.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_423061", "423061014", "story_v_out_423061.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_423061", "423061014", "story_v_out_423061.awb")

						arg_57_1:RecordAudio("423061014", var_60_15)
						arg_57_1:RecordAudio("423061014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423061", "423061014", "story_v_out_423061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423061", "423061014", "story_v_out_423061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_57_1:InitPlayNodeList()
	end,
	Play423061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423061015
		arg_61_1.duration_ = 7.5

		local var_61_0 = {
			zh = 7.5,
			ja = 7.2
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
				arg_61_0:Play423061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(423061015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 40 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 40)

				if (40 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 40)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061015", "story_v_out_423061.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061015", "story_v_out_423061.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_423061", "423061015", "story_v_out_423061.awb")

						arg_61_1:RecordAudio("423061015", var_64_6)
						arg_61_1:RecordAudio("423061015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423061", "423061015", "story_v_out_423061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423061", "423061015", "story_v_out_423061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423061016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(423061016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 19 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 19)

				if (19 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 19)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423061017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.625

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

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(423061017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 25)

				if (25 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 25)) > 0 and var_72_0 < var_72_3 then
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
	Play423061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423061018
		arg_73_1.duration_ = 8.57

		local var_73_0 = {
			zh = 5.733,
			ja = 8.566
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
				arg_73_0:Play423061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.525

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(423061018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 21 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 21)

				if (21 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 21)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061018", "story_v_out_423061.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061018", "story_v_out_423061.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_423061", "423061018", "story_v_out_423061.awb")

						arg_73_1:RecordAudio("423061018", var_76_6)
						arg_73_1:RecordAudio("423061018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_423061", "423061018", "story_v_out_423061.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_423061", "423061018", "story_v_out_423061.awb")
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
	Play423061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423061019
		arg_77_1.duration_ = 12.27

		local var_77_0 = {
			zh = 10.6,
			ja = 12.266
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
				arg_77_0:Play423061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(423061019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 47 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 47)

				if (47 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 47)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061019", "story_v_out_423061.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061019", "story_v_out_423061.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_423061", "423061019", "story_v_out_423061.awb")

						arg_77_1:RecordAudio("423061019", var_80_6)
						arg_77_1:RecordAudio("423061019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423061", "423061019", "story_v_out_423061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423061", "423061019", "story_v_out_423061.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play423061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423061020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play423061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(423061020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 32)

				if (32 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 32)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play423061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423061021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(423061021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 20 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 20)

				if (20 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 20)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423061022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.475

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

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(423061022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 59 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 59)

				if (59 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 59)) > 0 and var_92_0 < var_92_3 then
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
	Play423061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423061023
		arg_93_1.duration_ = 14.2

		local var_93_0 = {
			zh = 9.8,
			ja = 14.2
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
				arg_93_0:Play423061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(423061023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 51 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 51)

				if (51 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 51)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061023", "story_v_out_423061.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061023", "story_v_out_423061.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_423061", "423061023", "story_v_out_423061.awb")

						arg_93_1:RecordAudio("423061023", var_96_6)
						arg_93_1:RecordAudio("423061023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_423061", "423061023", "story_v_out_423061.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_423061", "423061023", "story_v_out_423061.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423061024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423061024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play423061025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.9

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(423061024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 36 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 36)

				if (36 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 36)) > 0 and var_100_0 < var_100_3 then
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
	Play423061025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423061025
		arg_101_1.duration_ = 8.6

		local var_101_0 = {
			zh = 5.9,
			ja = 8.6
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
				arg_101_0:Play423061026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.75

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(423061025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 30 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 30)

				if (30 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 30)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061025", "story_v_out_423061.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061025", "story_v_out_423061.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_423061", "423061025", "story_v_out_423061.awb")

						arg_101_1:RecordAudio("423061025", var_104_6)
						arg_101_1:RecordAudio("423061025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423061", "423061025", "story_v_out_423061.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423061", "423061025", "story_v_out_423061.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play423061026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423061026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play423061027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.65

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(423061026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 26 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 26)

				if (26 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 26)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play423061027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423061027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play423061028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(423061027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 30 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 30)

				if (30 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 30)) > 0 and var_112_0 < var_112_3 then
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
	Play423061028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423061028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play423061029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(423061028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 51 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 51)

				if (51 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 51)) > 0 and var_116_0 < var_116_3 then
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
	Play423061029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423061029
		arg_117_1.duration_ = 7.87

		local var_117_0 = {
			zh = 7.866,
			ja = 5.366
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
				arg_117_0:Play423061030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(423061029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 13 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 13)

				if (13 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 13)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061029", "story_v_out_423061.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061029", "story_v_out_423061.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_423061", "423061029", "story_v_out_423061.awb")

						arg_117_1:RecordAudio("423061029", var_120_6)
						arg_117_1:RecordAudio("423061029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_423061", "423061029", "story_v_out_423061.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_423061", "423061029", "story_v_out_423061.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play423061030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423061030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play423061031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.075

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(423061030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 3 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 3)

				if (3 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 3)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play423061031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423061031
		arg_125_1.duration_ = 6.37

		local var_125_0 = {
			zh = 4.966,
			ja = 6.366
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play423061032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.625

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(423061031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 25 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 25)

				if (25 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 25)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061031", "story_v_out_423061.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061031", "story_v_out_423061.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_423061", "423061031", "story_v_out_423061.awb")

						arg_125_1:RecordAudio("423061031", var_128_6)
						arg_125_1:RecordAudio("423061031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423061", "423061031", "story_v_out_423061.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423061", "423061031", "story_v_out_423061.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play423061032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423061032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play423061033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.475

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(423061032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 19 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 19)

				if (19 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 19)) > 0 and var_132_0 < var_132_3 then
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
	Play423061033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423061033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play423061034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(423061033).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 44 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 44)

				if (44 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 44)) > 0 and var_136_0 < var_136_3 then
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
	Play423061034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423061034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play423061035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
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

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(423061034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 47 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 47)

				if (47 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 47)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play423061035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423061035
		arg_141_1.duration_ = 5.97

		local var_141_0 = {
			zh = 3.566,
			ja = 5.966
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
				arg_141_0:Play423061036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.425

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(423061035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 17 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 17)

				if (17 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 17)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061035", "story_v_out_423061.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061035", "story_v_out_423061.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_423061", "423061035", "story_v_out_423061.awb")

						arg_141_1:RecordAudio("423061035", var_144_6)
						arg_141_1:RecordAudio("423061035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_423061", "423061035", "story_v_out_423061.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_423061", "423061035", "story_v_out_423061.awb")
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
	Play423061036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423061036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play423061037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.525

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(423061036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 21)

				if (21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 21)) > 0 and var_148_0 < var_148_3 then
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
	Play423061037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423061037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423061038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.05

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(423061037).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 42 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 42)

				if (42 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 42)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play423061038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423061038
		arg_153_1.duration_ = 8.8

		local var_153_0 = {
			zh = 8.8,
			ja = 8.5
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
				arg_153_0:Play423061039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.925

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(423061038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)

				if (37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 37)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061038", "story_v_out_423061.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061038", "story_v_out_423061.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_423061", "423061038", "story_v_out_423061.awb")

						arg_153_1:RecordAudio("423061038", var_156_6)
						arg_153_1:RecordAudio("423061038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423061", "423061038", "story_v_out_423061.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423061", "423061038", "story_v_out_423061.awb")
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
	Play423061039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423061039
		arg_157_1.duration_ = 10.33

		local var_157_0 = {
			zh = 7.4,
			ja = 10.333
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play423061040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.9

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(423061039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)

				if (36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061039", "story_v_out_423061.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061039", "story_v_out_423061.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_423061", "423061039", "story_v_out_423061.awb")

						arg_157_1:RecordAudio("423061039", var_160_6)
						arg_157_1:RecordAudio("423061039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_423061", "423061039", "story_v_out_423061.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_423061", "423061039", "story_v_out_423061.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423061040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 423061040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play423061041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.875

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

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(423061040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 35 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 35)

				if (35 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 35)) > 0 and var_164_0 < var_164_3 then
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
	Play423061041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 423061041
		arg_165_1.duration_ = 11.13

		local var_165_0 = {
			zh = 11.133,
			ja = 10.8
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play423061042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10148"]) and arg_165_1.var_.actorSpriteComps10148 == nil then
				arg_165_1.var_.actorSpriteComps10148 = arg_165_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10148"]) then
				if arg_165_1.var_.actorSpriteComps10148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10148"]) and arg_165_1.var_.actorSpriteComps10148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10148 = nil
			end

			local var_168_2 = arg_165_1.actors_["10148"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10148 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10148", 3)

				for iter_168_4 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_4)

					if var_168_3.name == "split_4" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_168_5 = 0
			local var_168_6 = 1.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(423061041)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 45 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 45)

				if (45 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 45)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061041", "story_v_out_423061.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061041", "story_v_out_423061.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_423061", "423061041", "story_v_out_423061.awb")

						arg_165_1:RecordAudio("423061041", var_168_12)
						arg_165_1:RecordAudio("423061041", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_423061", "423061041", "story_v_out_423061.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_423061", "423061041", "story_v_out_423061.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423061042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 423061042
		arg_169_1.duration_ = 6.83

		local var_169_0 = {
			zh = 6.533,
			ja = 6.833
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play423061043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10148"]) and arg_169_1.var_.actorSpriteComps10148 == nil then
				arg_169_1.var_.actorSpriteComps10148 = arg_169_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10148"]) then
				if arg_169_1.var_.actorSpriteComps10148 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10148"]) and arg_169_1.var_.actorSpriteComps10148 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10148 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.775

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_4 = arg_169_1:GetWordFromCfg(423061042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 31 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 31)

				if (31 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 31)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061042", "story_v_out_423061.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061042", "story_v_out_423061.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_423061", "423061042", "story_v_out_423061.awb")

						arg_169_1:RecordAudio("423061042", var_172_9)
						arg_169_1:RecordAudio("423061042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_423061", "423061042", "story_v_out_423061.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_423061", "423061042", "story_v_out_423061.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play423061043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 423061043
		arg_173_1.duration_ = 11.3

		local var_173_0 = {
			zh = 8.033,
			ja = 11.3
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play423061044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.875

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(423061043)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 35 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 35)

				if (35 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 35)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061043", "story_v_out_423061.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061043", "story_v_out_423061.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_423061", "423061043", "story_v_out_423061.awb")

						arg_173_1:RecordAudio("423061043", var_176_6)
						arg_173_1:RecordAudio("423061043", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_423061", "423061043", "story_v_out_423061.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_423061", "423061043", "story_v_out_423061.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play423061044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 423061044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play423061045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.65

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

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(423061044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 26 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 26)

				if (26 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 26)) > 0 and var_180_0 < var_180_3 then
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
	Play423061045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 423061045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play423061046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10148 = arg_181_1.actors_["10148"].transform.localPosition
				arg_181_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10148", 7)

				for iter_184_0 = 0, arg_181_1.actors_["10148"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10148"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_184_2 = 0
			local var_184_3 = 1.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(423061045).content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 58 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 58)

				if (58 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 58)) > 0 and var_184_3 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_7 and arg_181_1.time_ < var_184_2 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423061046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 423061046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play423061047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.2

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(423061046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 48 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 48)

				if (48 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 48)) > 0 and var_188_0 < var_188_3 then
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
	Play423061047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 423061047
		arg_189_1.duration_ = 9.6

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play423061048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.ST0112a == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0112a")
				var_192_0.name = "ST0112a"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.ST0112a = var_192_0
			end

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.ST0112a

				arg_189_1.bgs_.ST0112a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST0112a" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 3.999999999999

			if 3.999999999999 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_4 + 0.3 and arg_189_1.time_ < var_192_4 + 0.3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_5 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_6 = 2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_5) / var_192_6)
				arg_189_1.mask_.color = var_192_7
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 then
				local var_192_8 = Color.New(0, 0, 0)

				var_192_8.a = 1
				arg_189_1.mask_.color = var_192_8
			end

			local var_192_9 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_10 = 2

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_10 then
				local var_192_11 = Color.New(0, 0, 0)

				var_192_11.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_9) / var_192_10)
				arg_189_1.mask_.color = var_192_11
			end

			if arg_189_1.time_ >= var_192_9 + var_192_10 and arg_189_1.time_ < var_192_9 + var_192_10 + arg_192_0 then
				local var_192_12 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_12.a = 0
				arg_189_1.mask_.color = var_192_12
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_13 = 3.999999999999
			local var_192_14 = 0.375

			if 3.999999999999 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_15 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_15:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_16 = arg_189_1:GetWordFromCfg(423061047)
				local var_192_17 = arg_189_1:FormatText(var_192_16.content)

				arg_189_1.text_.text = var_192_17

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_19 = 15 <= 0 and var_192_14 or var_192_14 * (utf8.len(var_192_17) / 15)

				if (15 <= 0 and var_192_14 or var_192_14 * (utf8.len(var_192_17) / 15)) > 0 and var_192_14 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19
					var_192_13 = var_192_13 + 0.3

					if var_192_19 + var_192_13 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_13
					end
				end

				arg_189_1.text_.text = var_192_17
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061047", "story_v_out_423061.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_423061", "423061047", "story_v_out_423061.awb") / 1000

					if var_192_20 + var_192_13 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_13
					end

					if var_192_16.prefab_name ~= "" and arg_189_1.actors_[var_192_16.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_16.prefab_name].transform, "story_v_out_423061", "423061047", "story_v_out_423061.awb")

						arg_189_1:RecordAudio("423061047", var_192_21)
						arg_189_1:RecordAudio("423061047", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_423061", "423061047", "story_v_out_423061.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_423061", "423061047", "story_v_out_423061.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = var_192_13 + 0.3
			local var_192_23 = math.max(var_192_14, arg_189_1.talkMaxDuration)

			if var_192_13 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_23 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_23

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_23 and arg_189_1.time_ < var_192_22 + var_192_23 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play423061048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423061048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423061049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.55

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(423061048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 62 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 62)

				if (62 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 62)) > 0 and var_198_0 < var_198_3 then
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
	Play423061049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423061049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play423061050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.575

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(423061049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 23 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 23)

				if (23 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 23)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play423061050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 423061050
		arg_203_1.duration_ = 8.37

		local var_203_0 = {
			zh = 7.766,
			ja = 8.366
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
				arg_203_0:Play423061051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1083"]) and arg_203_1.var_.actorSpriteComps1083 == nil then
				arg_203_1.var_.actorSpriteComps1083 = arg_203_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1083"]) then
				if arg_203_1.var_.actorSpriteComps1083 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1083"]) and arg_203_1.var_.actorSpriteComps1083 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1083 = nil
			end

			local var_206_2 = arg_203_1.actors_["1083"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1083 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1083", 3)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_203_1.time_ - 0) / var_206_4)
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_206_5 = 0
			local var_206_6 = 0.875

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(423061050)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 35 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 35)

				if (35 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 35)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061050", "story_v_out_423061.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061050", "story_v_out_423061.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_423061", "423061050", "story_v_out_423061.awb")

						arg_203_1:RecordAudio("423061050", var_206_12)
						arg_203_1:RecordAudio("423061050", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_423061", "423061050", "story_v_out_423061.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_423061", "423061050", "story_v_out_423061.awb")
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
				actorName = "1083",
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
	Play423061051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 423061051
		arg_207_1.duration_ = 7.27

		local var_207_0 = {
			zh = 5.8,
			ja = 7.266
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play423061052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1083"]) and arg_207_1.var_.actorSpriteComps1083 == nil then
				arg_207_1.var_.actorSpriteComps1083 = arg_207_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1083"]) then
				if arg_207_1.var_.actorSpriteComps1083 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1083"]) and arg_207_1.var_.actorSpriteComps1083 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps1083 = nil
			end

			local var_210_2 = 0
			local var_210_3 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_4 = arg_207_1:GetWordFromCfg(423061051)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 26 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 26)

				if (26 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 26)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061051", "story_v_out_423061.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061051", "story_v_out_423061.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_423061", "423061051", "story_v_out_423061.awb")

						arg_207_1:RecordAudio("423061051", var_210_9)
						arg_207_1:RecordAudio("423061051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_423061", "423061051", "story_v_out_423061.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_423061", "423061051", "story_v_out_423061.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play423061052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 423061052
		arg_211_1.duration_ = 7.7

		local var_211_0 = {
			zh = 6.5,
			ja = 7.7
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
				arg_211_0:Play423061053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.9

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:GetWordFromCfg(423061052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 36 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 36)

				if (36 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 36)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061052", "story_v_out_423061.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061052", "story_v_out_423061.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_423061", "423061052", "story_v_out_423061.awb")

						arg_211_1:RecordAudio("423061052", var_214_6)
						arg_211_1:RecordAudio("423061052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_423061", "423061052", "story_v_out_423061.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_423061", "423061052", "story_v_out_423061.awb")
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
	Play423061053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 423061053
		arg_215_1.duration_ = 1.4

		local var_215_0 = {
			zh = 1.166,
			ja = 1.4
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
				arg_215_0:Play423061054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1083"]) and arg_215_1.var_.actorSpriteComps1083 == nil then
				arg_215_1.var_.actorSpriteComps1083 = arg_215_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1083"]) then
				if arg_215_1.var_.actorSpriteComps1083 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1083"]) and arg_215_1.var_.actorSpriteComps1083 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1083 = nil
			end

			local var_218_2 = arg_215_1.actors_["1083"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1083 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1083", 3)

				for iter_218_4 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_4)

					if var_218_3.name == "split_7" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_218_5 = 0
			local var_218_6 = 0.05

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:GetWordFromCfg(423061053)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 2 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 2)

				if (2 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 2)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061053", "story_v_out_423061.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061053", "story_v_out_423061.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_423061", "423061053", "story_v_out_423061.awb")

						arg_215_1:RecordAudio("423061053", var_218_12)
						arg_215_1:RecordAudio("423061053", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_423061", "423061053", "story_v_out_423061.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_423061", "423061053", "story_v_out_423061.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_13 and arg_215_1.time_ < var_218_5 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play423061054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 423061054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play423061055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1083"]) and arg_219_1.var_.actorSpriteComps1083 == nil then
				arg_219_1.var_.actorSpriteComps1083 = arg_219_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1083"]) then
				if arg_219_1.var_.actorSpriteComps1083 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1083"]) and arg_219_1.var_.actorSpriteComps1083 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps1083 = nil
			end

			local var_222_2 = 0
			local var_222_3 = 0.675

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_4 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(423061054).content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 27 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_4) / 27)

				if (27 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_4) / 27)) > 0 and var_222_3 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_7 and arg_219_1.time_ < var_222_2 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play423061055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 423061055
		arg_223_1.duration_ = 8.83

		local var_223_0 = {
			zh = 6.766,
			ja = 8.833
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
				arg_223_0:Play423061056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1083"]) and arg_223_1.var_.actorSpriteComps1083 == nil then
				arg_223_1.var_.actorSpriteComps1083 = arg_223_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1083"]) then
				if arg_223_1.var_.actorSpriteComps1083 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1083"]) and arg_223_1.var_.actorSpriteComps1083 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1083 = nil
			end

			local var_226_2 = arg_223_1.actors_["1083"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1083 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1083", 3)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_226_5 = 0
			local var_226_6 = 0.8

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(423061055)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 32 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 32)

				if (32 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 32)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061055", "story_v_out_423061.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061055", "story_v_out_423061.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_423061", "423061055", "story_v_out_423061.awb")

						arg_223_1:RecordAudio("423061055", var_226_12)
						arg_223_1:RecordAudio("423061055", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_423061", "423061055", "story_v_out_423061.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_423061", "423061055", "story_v_out_423061.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play423061056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 423061056
		arg_227_1.duration_ = 4.7

		local var_227_0 = {
			zh = 3.833,
			ja = 4.7
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
				arg_227_0:Play423061057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1083 = arg_227_1.actors_["1083"].transform.localPosition
				arg_227_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1083", 3)

				for iter_230_0 = 0, arg_227_1.actors_["1083"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1083"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_230_2 = 0
			local var_230_3 = 0.475

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(423061056)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 19 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 19)

				if (19 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 19)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061056", "story_v_out_423061.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061056", "story_v_out_423061.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_423061", "423061056", "story_v_out_423061.awb")

						arg_227_1:RecordAudio("423061056", var_230_9)
						arg_227_1:RecordAudio("423061056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_423061", "423061056", "story_v_out_423061.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_423061", "423061056", "story_v_out_423061.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play423061057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 423061057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play423061058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1083"]) and arg_231_1.var_.actorSpriteComps1083 == nil then
				arg_231_1.var_.actorSpriteComps1083 = arg_231_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1083"]) then
				if arg_231_1.var_.actorSpriteComps1083 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1083"]) and arg_231_1.var_.actorSpriteComps1083 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1083 = nil
			end

			local var_234_2 = arg_231_1.actors_["1083"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1083 = var_234_2.localPosition
				var_234_2.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1083", 7)

				for iter_234_4 = 0, var_234_2.childCount - 1 do
					local var_234_3 = var_234_2:GetChild(iter_234_4)

					if var_234_3.name == "" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_231_1.time_ - 0) / var_234_4)
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_234_5 = 0
			local var_234_6 = 1.425

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(423061057).content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 57 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 57)

				if (57 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 57)) > 0 and var_234_6 < var_234_9 then
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
				actorName = "1083",
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
	Play423061058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 423061058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play423061059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(423061058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 62 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 62)

				if (62 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 62)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play423061059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 423061059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play423061060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.45

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(423061059).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 18)

				if (18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 18)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play423061060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 423061060
		arg_243_1.duration_ = 4.73

		local var_243_0 = {
			zh = 4.733,
			ja = 3.433
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
				arg_243_0:Play423061061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1083"]) and arg_243_1.var_.actorSpriteComps1083 == nil then
				arg_243_1.var_.actorSpriteComps1083 = arg_243_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1083"]) then
				if arg_243_1.var_.actorSpriteComps1083 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 1, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1083"]) and arg_243_1.var_.actorSpriteComps1083 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1083 = nil
			end

			local var_246_2 = arg_243_1.actors_["1083"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1083 = var_246_2.localPosition
				var_246_2.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1083", 3)

				for iter_246_4 = 0, var_246_2.childCount - 1 do
					local var_246_3 = var_246_2:GetChild(iter_246_4)

					if var_246_3.name == "" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_2.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_243_1.time_ - 0) / var_246_4)
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_246_5 = 0
			local var_246_6 = 0.625

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(423061060)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 25 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 25)

				if (25 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 25)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061060", "story_v_out_423061.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061060", "story_v_out_423061.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_423061", "423061060", "story_v_out_423061.awb")

						arg_243_1:RecordAudio("423061060", var_246_12)
						arg_243_1:RecordAudio("423061060", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_423061", "423061060", "story_v_out_423061.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_423061", "423061060", "story_v_out_423061.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_13 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_13

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_13 and arg_243_1.time_ < var_246_5 + var_246_13 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play423061061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 423061061
		arg_247_1.duration_ = 5.73

		local var_247_0 = {
			zh = 3.533,
			ja = 5.733
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
				arg_247_0:Play423061062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1083 = arg_247_1.actors_["1083"].transform.localPosition
				arg_247_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1083", 3)

				for iter_250_0 = 0, arg_247_1.actors_["1083"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["1083"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_250_2 = 0
			local var_250_3 = 0.625

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(423061061)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 25 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 25)

				if (25 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 25)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061061", "story_v_out_423061.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061061", "story_v_out_423061.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_423061", "423061061", "story_v_out_423061.awb")

						arg_247_1:RecordAudio("423061061", var_250_9)
						arg_247_1:RecordAudio("423061061", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_423061", "423061061", "story_v_out_423061.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_423061", "423061061", "story_v_out_423061.awb")
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

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play423061062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 423061062
		arg_251_1.duration_ = 1

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"

			SetActive(arg_251_1.choicesGo_, true)

			for iter_252_0, iter_252_1 in ipairs(arg_251_1.choices_) do
				SetActive(iter_252_1.go, iter_252_0 <= 2)
			end

			arg_251_1.choices_[1].txt.text = arg_251_1:FormatText(StoryChoiceCfg[1367].name)
			arg_251_1.choices_[2].txt.text = arg_251_1:FormatText(StoryChoiceCfg[1368].name)
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play423061063(arg_251_1)
			end

			if arg_253_0 == 2 then
				arg_251_0:Play423061063(arg_251_1)
			end

			arg_251_1:RecordChoiceLog(423061062, 1367, 1368)
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1083"]) and arg_251_1.var_.actorSpriteComps1083 == nil then
				arg_251_1.var_.actorSpriteComps1083 = arg_251_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1083"]) then
				if arg_251_1.var_.actorSpriteComps1083 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1083"]) and arg_251_1.var_.actorSpriteComps1083 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps1083 = nil
			end

			local var_254_2 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.allBtn_.enabled = false
			end

			if arg_251_1.time_ >= var_254_2 + 0.6 and arg_251_1.time_ < var_254_2 + 0.6 + arg_254_0 then
				arg_251_1.allBtn_.enabled = true
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play423061063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 423061063
		arg_255_1.duration_ = 6.17

		local var_255_0 = {
			zh = 5.366,
			ja = 6.166
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play423061064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1083"]) and arg_255_1.var_.actorSpriteComps1083 == nil then
				arg_255_1.var_.actorSpriteComps1083 = arg_255_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1083"]) then
				if arg_255_1.var_.actorSpriteComps1083 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1083"]) and arg_255_1.var_.actorSpriteComps1083 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1083 = nil
			end

			local var_258_2 = arg_255_1.actors_["1083"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1083 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1083", 3)

				for iter_258_4 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_4)

					if var_258_3.name == "split_2" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_258_5 = 0
			local var_258_6 = 0.475

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(423061063)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 19 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 19)

				if (19 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 19)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061063", "story_v_out_423061.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061063", "story_v_out_423061.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_423061", "423061063", "story_v_out_423061.awb")

						arg_255_1:RecordAudio("423061063", var_258_12)
						arg_255_1:RecordAudio("423061063", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_423061", "423061063", "story_v_out_423061.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_423061", "423061063", "story_v_out_423061.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play423061064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 423061064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play423061065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1083"]) and arg_259_1.var_.actorSpriteComps1083 == nil then
				arg_259_1.var_.actorSpriteComps1083 = arg_259_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1083"]) then
				if arg_259_1.var_.actorSpriteComps1083 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1083"]) and arg_259_1.var_.actorSpriteComps1083 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1083 = nil
			end

			local var_262_2 = 0
			local var_262_3 = 0.675

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_4 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(423061064).content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_6 = 27 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 27)

				if (27 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 27)) > 0 and var_262_3 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_7 and arg_259_1.time_ < var_262_2 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play423061065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 423061065
		arg_263_1.duration_ = 5.6

		local var_263_0 = {
			zh = 5.066,
			ja = 5.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play423061066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1083"]) and arg_263_1.var_.actorSpriteComps1083 == nil then
				arg_263_1.var_.actorSpriteComps1083 = arg_263_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1083"]) then
				if arg_263_1.var_.actorSpriteComps1083 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 1, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1083"]) and arg_263_1.var_.actorSpriteComps1083 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps1083 = nil
			end

			local var_266_2 = arg_263_1.actors_["1083"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1083 = var_266_2.localPosition
				var_266_2.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1083", 3)

				for iter_266_4 = 0, var_266_2.childCount - 1 do
					local var_266_3 = var_266_2:GetChild(iter_266_4)

					if var_266_3.name == "" or not string.find(var_266_3.name, "split") then
						var_266_3.gameObject:SetActive(true)
					else
						var_266_3.gameObject:SetActive(false)
					end
				end
			end

			local var_266_4 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				var_266_2.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_263_1.time_ - 0) / var_266_4)
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_266_5 = 0
			local var_266_6 = 0.65

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(423061065)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 26 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 26)

				if (26 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 26)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061065", "story_v_out_423061.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061065", "story_v_out_423061.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_423061", "423061065", "story_v_out_423061.awb")

						arg_263_1:RecordAudio("423061065", var_266_12)
						arg_263_1:RecordAudio("423061065", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_423061", "423061065", "story_v_out_423061.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_423061", "423061065", "story_v_out_423061.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_13 and arg_263_1.time_ < var_266_5 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play423061066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 423061066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play423061067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1083"]) and arg_267_1.var_.actorSpriteComps1083 == nil then
				arg_267_1.var_.actorSpriteComps1083 = arg_267_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1083"]) then
				if arg_267_1.var_.actorSpriteComps1083 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1083"]) and arg_267_1.var_.actorSpriteComps1083 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps1083 = nil
			end

			local var_270_2 = 0
			local var_270_3 = 0.65

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_4 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(423061066).content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_6 = 26 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 26)

				if (26 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 26)) > 0 and var_270_3 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_7 and arg_267_1.time_ < var_270_2 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play423061067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 423061067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play423061068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.925

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(423061067).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 37 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 37)

				if (37 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 37)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play423061068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 423061068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play423061069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.6

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(423061068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 24 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 24)

				if (24 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 24)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play423061069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 423061069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play423061070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1083 = arg_279_1.actors_["1083"].transform.localPosition
				arg_279_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1083", 7)

				for iter_282_0 = 0, arg_279_1.actors_["1083"].transform.childCount - 1 do
					local var_282_0 = arg_279_1.actors_["1083"].transform:GetChild(iter_282_0)

					if var_282_0.name == "" or not string.find(var_282_0.name, "split") then
						var_282_0.gameObject:SetActive(true)
					else
						var_282_0.gameObject:SetActive(false)
					end
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_279_1.time_ - 0) / var_282_1)
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_282_2 = 0
			local var_282_3 = 0.875

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(423061069).content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 35 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 35)

				if (35 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 35)) > 0 and var_282_3 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_7 and arg_279_1.time_ < var_282_2 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play423061070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 423061070
		arg_283_1.duration_ = 4.87

		local var_283_0 = {
			zh = 4.6,
			ja = 4.866
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
				arg_283_0:Play423061071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1083"]) and arg_283_1.var_.actorSpriteComps1083 == nil then
				arg_283_1.var_.actorSpriteComps1083 = arg_283_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1083"]) then
				if arg_283_1.var_.actorSpriteComps1083 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1083"]) and arg_283_1.var_.actorSpriteComps1083 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps1083 = nil
			end

			local var_286_2 = arg_283_1.actors_["1083"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1083 = var_286_2.localPosition
				var_286_2.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1083", 3)

				for iter_286_4 = 0, var_286_2.childCount - 1 do
					local var_286_3 = var_286_2:GetChild(iter_286_4)

					if var_286_3.name == "" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_2.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_283_1.time_ - 0) / var_286_4)
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_286_5 = 0
			local var_286_6 = 0.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_7 = arg_283_1:GetWordFromCfg(423061070)
				local var_286_8 = arg_283_1:FormatText(var_286_7.content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 20 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 20)

				if (20 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 20)) > 0 and var_286_6 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061070", "story_v_out_423061.awb") ~= 0 then
					local var_286_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061070", "story_v_out_423061.awb") / 1000

					if var_286_11 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_5
					end

					if var_286_7.prefab_name ~= "" and arg_283_1.actors_[var_286_7.prefab_name] ~= nil then
						local var_286_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_7.prefab_name].transform, "story_v_out_423061", "423061070", "story_v_out_423061.awb")

						arg_283_1:RecordAudio("423061070", var_286_12)
						arg_283_1:RecordAudio("423061070", var_286_12)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_423061", "423061070", "story_v_out_423061.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_423061", "423061070", "story_v_out_423061.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_13 and arg_283_1.time_ < var_286_5 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play423061071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 423061071
		arg_287_1.duration_ = 5.4

		local var_287_0 = {
			zh = 4.166,
			ja = 5.4
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
				arg_287_0:Play423061072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1083 = arg_287_1.actors_["1083"].transform.localPosition
				arg_287_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1083", 3)

				for iter_290_0 = 0, arg_287_1.actors_["1083"].transform.childCount - 1 do
					local var_290_0 = arg_287_1.actors_["1083"].transform:GetChild(iter_290_0)

					if var_290_0.name == "" or not string.find(var_290_0.name, "split") then
						var_290_0.gameObject:SetActive(true)
					else
						var_290_0.gameObject:SetActive(false)
					end
				end
			end

			local var_290_1 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				arg_287_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_287_1.time_ - 0) / var_290_1)
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 then
				arg_287_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_290_2 = 0
			local var_290_3 = 0.5

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(423061071)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 20 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 20)

				if (20 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 20)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061071", "story_v_out_423061.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061071", "story_v_out_423061.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_423061", "423061071", "story_v_out_423061.awb")

						arg_287_1:RecordAudio("423061071", var_290_9)
						arg_287_1:RecordAudio("423061071", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_423061", "423061071", "story_v_out_423061.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_423061", "423061071", "story_v_out_423061.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play423061072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 423061072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play423061073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1083"]) and arg_291_1.var_.actorSpriteComps1083 == nil then
				arg_291_1.var_.actorSpriteComps1083 = arg_291_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1083"]) then
				if arg_291_1.var_.actorSpriteComps1083 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1083"]) and arg_291_1.var_.actorSpriteComps1083 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps1083 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 1.175

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_4 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(423061072).content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_6 = 47 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 47)

				if (47 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 47)) > 0 and var_294_3 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_7 and arg_291_1.time_ < var_294_2 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play423061073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 423061073
		arg_295_1.duration_ = 2.5

		local var_295_0 = {
			zh = 2.166,
			ja = 2.5
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
				arg_295_0:Play423061074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1083"]) and arg_295_1.var_.actorSpriteComps1083 == nil then
				arg_295_1.var_.actorSpriteComps1083 = arg_295_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1083"]) then
				if arg_295_1.var_.actorSpriteComps1083 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1083"]) and arg_295_1.var_.actorSpriteComps1083 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps1083 = nil
			end

			local var_298_2 = arg_295_1.actors_["1083"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1083 = var_298_2.localPosition
				var_298_2.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("1083", 3)

				for iter_298_4 = 0, var_298_2.childCount - 1 do
					local var_298_3 = var_298_2:GetChild(iter_298_4)

					if var_298_3.name == "" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				var_298_2.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_295_1.time_ - 0) / var_298_4)
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				var_298_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_298_5 = 0
			local var_298_6 = 0.175

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:GetWordFromCfg(423061073)
				local var_298_8 = arg_295_1:FormatText(var_298_7.content)

				arg_295_1.text_.text = var_298_8

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 7 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 7)

				if (7 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 7)) > 0 and var_298_6 < var_298_10 then
					arg_295_1.talkMaxDuration = var_298_10

					if var_298_10 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_8
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061073", "story_v_out_423061.awb") ~= 0 then
					local var_298_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061073", "story_v_out_423061.awb") / 1000

					if var_298_11 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_5
					end

					if var_298_7.prefab_name ~= "" and arg_295_1.actors_[var_298_7.prefab_name] ~= nil then
						local var_298_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_7.prefab_name].transform, "story_v_out_423061", "423061073", "story_v_out_423061.awb")

						arg_295_1:RecordAudio("423061073", var_298_12)
						arg_295_1:RecordAudio("423061073", var_298_12)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_423061", "423061073", "story_v_out_423061.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_423061", "423061073", "story_v_out_423061.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_6, arg_295_1.talkMaxDuration)

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_5) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_5 + var_298_13 and arg_295_1.time_ < var_298_5 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play423061074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 423061074
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play423061075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1083"]) and arg_299_1.var_.actorSpriteComps1083 == nil then
				arg_299_1.var_.actorSpriteComps1083 = arg_299_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1083"]) then
				if arg_299_1.var_.actorSpriteComps1083 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								iter_302_1.color = Color.New(Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_0), Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_0), (Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_0)))
							else
								local var_302_1 = Mathf.Lerp(iter_302_1.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_0)

								iter_302_1.color = Color.New(var_302_1, var_302_1, var_302_1)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1083"]) and arg_299_1.var_.actorSpriteComps1083 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps1083 = nil
			end

			local var_302_2 = 0
			local var_302_3 = 0.45

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_4 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(423061074).content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_6 = 18 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 18)

				if (18 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 18)) > 0 and var_302_3 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_7 and arg_299_1.time_ < var_302_2 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play423061075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 423061075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play423061076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.475

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(423061075).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 19 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 19)

				if (19 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 19)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play423061076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 423061076
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play423061077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1083 = arg_307_1.actors_["1083"].transform.localPosition
				arg_307_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1083", 7)

				for iter_310_0 = 0, arg_307_1.actors_["1083"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["1083"].transform:GetChild(iter_310_0)

					if var_310_0.name == "" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_310_2 = 0
			local var_310_3 = 1.025

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

				local var_310_4 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(423061076).content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 41 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 41)

				if (41 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 41)) > 0 and var_310_3 < var_310_6 then
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
				actorName = "1083",
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
	Play423061077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 423061077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play423061078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.4

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(423061077).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 16 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 16)

				if (16 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 16)) > 0 and var_314_0 < var_314_3 then
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
	Play423061078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 423061078
		arg_315_1.duration_ = 6.17

		local var_315_0 = {
			zh = 4.5,
			ja = 6.166
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play423061079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1083"]) and arg_315_1.var_.actorSpriteComps1083 == nil then
				arg_315_1.var_.actorSpriteComps1083 = arg_315_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1083"]) then
				if arg_315_1.var_.actorSpriteComps1083 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1083"]) and arg_315_1.var_.actorSpriteComps1083 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps1083 = nil
			end

			local var_318_2 = arg_315_1.actors_["1083"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1083 = var_318_2.localPosition
				var_318_2.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1083", 3)

				for iter_318_4 = 0, var_318_2.childCount - 1 do
					local var_318_3 = var_318_2:GetChild(iter_318_4)

					if var_318_3.name == "" or not string.find(var_318_3.name, "split") then
						var_318_3.gameObject:SetActive(true)
					else
						var_318_3.gameObject:SetActive(false)
					end
				end
			end

			local var_318_4 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				var_318_2.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_315_1.time_ - 0) / var_318_4)
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				var_318_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_318_5 = 0
			local var_318_6 = 0.6

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_7 = arg_315_1:GetWordFromCfg(423061078)
				local var_318_8 = arg_315_1:FormatText(var_318_7.content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 24 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 24)

				if (24 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 24)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061078", "story_v_out_423061.awb") ~= 0 then
					local var_318_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061078", "story_v_out_423061.awb") / 1000

					if var_318_11 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_5
					end

					if var_318_7.prefab_name ~= "" and arg_315_1.actors_[var_318_7.prefab_name] ~= nil then
						local var_318_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_7.prefab_name].transform, "story_v_out_423061", "423061078", "story_v_out_423061.awb")

						arg_315_1:RecordAudio("423061078", var_318_12)
						arg_315_1:RecordAudio("423061078", var_318_12)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_423061", "423061078", "story_v_out_423061.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_423061", "423061078", "story_v_out_423061.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_13 and arg_315_1.time_ < var_318_5 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play423061079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 423061079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play423061080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1083"]) and arg_319_1.var_.actorSpriteComps1083 == nil then
				arg_319_1.var_.actorSpriteComps1083 = arg_319_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1083"]) then
				if arg_319_1.var_.actorSpriteComps1083 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1083"]) and arg_319_1.var_.actorSpriteComps1083 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps1083 = nil
			end

			local var_322_2 = arg_319_1.actors_["1083"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1083 = var_322_2.localPosition
				var_322_2.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1083", 7)

				for iter_322_4 = 0, var_322_2.childCount - 1 do
					local var_322_3 = var_322_2:GetChild(iter_322_4)

					if var_322_3.name == "" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				var_322_2.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_319_1.time_ - 0) / var_322_4)
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_319_1.time_ and arg_319_1.time_ <= 0.2 + arg_322_0 then
				arg_319_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_footstep_quiet", "")
			end

			local var_322_6 = 0
			local var_322_7 = 0.95

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_8 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(423061079).content)

				arg_319_1.text_.text = var_322_8

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_10 = 38 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_8) / 38)

				if (38 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_8) / 38)) > 0 and var_322_7 < var_322_10 then
					arg_319_1.talkMaxDuration = var_322_10

					if var_322_10 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_8
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_11 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_11 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_11

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_11 and arg_319_1.time_ < var_322_6 + var_322_11 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play423061080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 423061080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play423061081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 1.5

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(423061080).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 70 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 70)

				if (70 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 70)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play423061081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 423061081
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play423061082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
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

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(423061081).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 22 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 22)

				if (22 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 22)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play423061082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 423061082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play423061083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.725

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(423061082).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 29 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 29)

				if (29 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 29)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play423061083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 423061083
		arg_335_1.duration_ = 7.93

		local var_335_0 = {
			zh = 6.3,
			ja = 7.933
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
				arg_335_0:Play423061084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if arg_335_1.bgs_.ST75 == nil then
				local var_338_0 = Object.Instantiate(arg_335_1.paintGo_)

				var_338_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")
				var_338_0.name = "ST75"
				var_338_0.transform.parent = arg_335_1.stage_.transform
				var_338_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_335_1.bgs_.ST75 = var_338_0
			end

			if 2 < arg_335_1.time_ and arg_335_1.time_ <= 2 + arg_338_0 then
				local var_338_1 = arg_335_1.bgs_.ST75

				arg_335_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_338_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_338_2 = var_338_1:GetComponent("SpriteRenderer")

				if var_338_2 and var_338_2.sprite then
					local var_338_3 = 2 * (var_338_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_338_1.transform.localScale = Vector3.New(var_338_3 / var_338_2.sprite.bounds.size.y < var_338_3 * manager.ui.mainCameraCom_.aspect / var_338_2.sprite.bounds.size.x and var_338_3 * manager.ui.mainCameraCom_.aspect / var_338_2.sprite.bounds.size.x or var_338_3 / var_338_2.sprite.bounds.size.y, var_338_3 / var_338_2.sprite.bounds.size.y < var_338_3 * manager.ui.mainCameraCom_.aspect / var_338_2.sprite.bounds.size.x and var_338_3 * manager.ui.mainCameraCom_.aspect / var_338_2.sprite.bounds.size.x or var_338_3 / var_338_2.sprite.bounds.size.y, 0)
				end

				for iter_338_0, iter_338_1 in pairs(arg_335_1.bgs_) do
					if iter_338_0 ~= "ST75" then
						iter_338_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_338_4 = 4

			if 4 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			if arg_335_1.time_ >= var_338_4 + 0.3 and arg_335_1.time_ < var_338_4 + 0.3 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end

			local var_338_5 = 0

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_6 = 2

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_6 then
				local var_338_7 = Color.New(0, 0, 0)

				var_338_7.a = Mathf.Lerp(0, 1, (arg_335_1.time_ - var_338_5) / var_338_6)
				arg_335_1.mask_.color = var_338_7
			end

			if arg_335_1.time_ >= var_338_5 + var_338_6 and arg_335_1.time_ < var_338_5 + var_338_6 + arg_338_0 then
				local var_338_8 = Color.New(0, 0, 0)

				var_338_8.a = 1
				arg_335_1.mask_.color = var_338_8
			end

			local var_338_9 = 2

			if 2 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_10 = 2

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_10 then
				local var_338_11 = Color.New(0, 0, 0)

				var_338_11.a = Mathf.Lerp(1, 0, (arg_335_1.time_ - var_338_9) / var_338_10)
				arg_335_1.mask_.color = var_338_11
			end

			if arg_335_1.time_ >= var_338_9 + var_338_10 and arg_335_1.time_ < var_338_9 + var_338_10 + arg_338_0 then
				local var_338_12 = Color.New(0, 0, 0)

				arg_335_1.mask_.enabled = false
				var_338_12.a = 0
				arg_335_1.mask_.color = var_338_12
			end

			local var_338_13 = "10146"

			if arg_335_1.actors_["10146"] == nil then
				local var_338_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_338_14) then
					local var_338_15 = Object.Instantiate(var_338_14, arg_335_1.canvasGo_.transform)

					var_338_15.transform:SetSiblingIndex(1)

					var_338_15.name = var_338_13
					var_338_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_335_1.actors_[var_338_13] = var_338_15

					if arg_335_1.isInRecall_ then
						for iter_338_2, iter_338_3 in ipairs((var_338_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_338_3.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_338_16 = arg_335_1.actors_["10146"]

			if 3.8 < arg_335_1.time_ and arg_335_1.time_ <= 3.8 + arg_338_0 and not isNil(var_338_16) and arg_335_1.var_.actorSpriteComps10146 == nil then
				arg_335_1.var_.actorSpriteComps10146 = var_338_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_17 = 0.2

			if 3.8 <= arg_335_1.time_ and arg_335_1.time_ < 3.8 + var_338_17 and not isNil(var_338_16) then
				if arg_335_1.var_.actorSpriteComps10146 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								iter_338_5.color = Color.New(Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 3.8) / var_338_17), Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 3.8) / var_338_17), (Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 3.8) / var_338_17)))
							else
								local var_338_18 = Mathf.Lerp(iter_338_5.color.r, 1, (arg_335_1.time_ - 3.8) / var_338_17)

								iter_338_5.color = Color.New(var_338_18, var_338_18, var_338_18)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 3.8 + var_338_17 and arg_335_1.time_ < 3.8 + var_338_17 + arg_338_0 and not isNil(var_338_16) and arg_335_1.var_.actorSpriteComps10146 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_338_7 then
						iter_338_7.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10146 = nil
			end

			local var_338_19 = arg_335_1.actors_["10146"].transform

			if 3.8 < arg_335_1.time_ and arg_335_1.time_ <= 3.8 + arg_338_0 then
				arg_335_1.var_.moveOldPos10146 = var_338_19.localPosition
				var_338_19.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10146", 3)

				for iter_338_8 = 0, var_338_19.childCount - 1 do
					local var_338_20 = var_338_19:GetChild(iter_338_8)

					if var_338_20.name == "split_6" or not string.find(var_338_20.name, "split") then
						var_338_20.gameObject:SetActive(true)
					else
						var_338_20.gameObject:SetActive(false)
					end
				end
			end

			local var_338_21 = 0.001

			if 3.8 <= arg_335_1.time_ and arg_335_1.time_ < 3.8 + var_338_21 then
				var_338_19.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_335_1.time_ - 3.8) / var_338_21)
			end

			if arg_335_1.time_ >= 3.8 + var_338_21 and arg_335_1.time_ < 3.8 + var_338_21 + arg_338_0 then
				var_338_19.localPosition = Vector3.New(0, -350, -320)
			end

			if 3.8 < arg_335_1.time_ and arg_335_1.time_ <= 3.8 + arg_338_0 then
				local var_338_22 = arg_335_1.actors_["10146"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_338_22 then
					arg_335_1.var_.alphaOldValue10146 = var_338_22.alpha
					arg_335_1.var_.characterEffect10146 = var_338_22
				end

				arg_335_1.var_.alphaOldValue10146 = 0
			end

			local var_338_23 = 0.5

			if 3.8 <= arg_335_1.time_ and arg_335_1.time_ < 3.8 + var_338_23 then
				if arg_335_1.var_.characterEffect10146 then
					arg_335_1.var_.characterEffect10146.alpha = Mathf.Lerp(arg_335_1.var_.alphaOldValue10146, 1, (arg_335_1.time_ - 3.8) / var_338_23)
				end
			end

			if arg_335_1.time_ >= 3.8 + var_338_23 and arg_335_1.time_ < 3.8 + var_338_23 + arg_338_0 and arg_335_1.var_.characterEffect10146 then
				arg_335_1.var_.characterEffect10146.alpha = 1
			end

			if 0.166666666666667 < arg_335_1.time_ and arg_335_1.time_ <= 0.166666666666667 + arg_338_0 then
				arg_335_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 1.56666666666667 < arg_335_1.time_ and arg_335_1.time_ <= 1.56666666666667 + arg_338_0 then
				arg_335_1:AudioAction("play", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if arg_335_1.frameCnt_ <= 1 then
				arg_335_1.dialog_:SetActive(false)
			end

			local var_338_26 = 4
			local var_338_27 = 0.325

			if 4 < arg_335_1.time_ and arg_335_1.time_ <= var_338_26 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				arg_335_1.dialog_:SetActive(true)

				arg_335_1.dialogCg_.alpha = 0

				local var_338_28 = LeanTween.value(arg_335_1.dialog_, 0, 1, 0.3)

				var_338_28:setOnUpdate(LuaHelper.FloatAction(function(arg_339_0)
					arg_335_1.dialogCg_.alpha = arg_339_0
				end))
				var_338_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_335_1.dialog_)
					var_338_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_335_1.duration_ = arg_335_1.duration_ + 0.3

				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_29 = arg_335_1:GetWordFromCfg(423061083)
				local var_338_30 = arg_335_1:FormatText(var_338_29.content)

				arg_335_1.text_.text = var_338_30

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_32 = 13 <= 0 and var_338_27 or var_338_27 * (utf8.len(var_338_30) / 13)

				if (13 <= 0 and var_338_27 or var_338_27 * (utf8.len(var_338_30) / 13)) > 0 and var_338_27 < var_338_32 then
					arg_335_1.talkMaxDuration = var_338_32
					var_338_26 = var_338_26 + 0.3

					if var_338_32 + var_338_26 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_32 + var_338_26
					end
				end

				arg_335_1.text_.text = var_338_30
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061083", "story_v_out_423061.awb") ~= 0 then
					local var_338_33 = manager.audio:GetVoiceLength("story_v_out_423061", "423061083", "story_v_out_423061.awb") / 1000

					if var_338_33 + var_338_26 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_33 + var_338_26
					end

					if var_338_29.prefab_name ~= "" and arg_335_1.actors_[var_338_29.prefab_name] ~= nil then
						local var_338_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_29.prefab_name].transform, "story_v_out_423061", "423061083", "story_v_out_423061.awb")

						arg_335_1:RecordAudio("423061083", var_338_34)
						arg_335_1:RecordAudio("423061083", var_338_34)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_423061", "423061083", "story_v_out_423061.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_423061", "423061083", "story_v_out_423061.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_35 = var_338_26 + 0.3
			local var_338_36 = math.max(var_338_27, arg_335_1.talkMaxDuration)

			if var_338_26 + 0.3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_35 + var_338_36 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_35) / var_338_36

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_35 + var_338_36 and arg_335_1.time_ < var_338_35 + var_338_36 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play423061084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 423061084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play423061085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["10146"]) and arg_341_1.var_.actorSpriteComps10146 == nil then
				arg_341_1.var_.actorSpriteComps10146 = arg_341_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["10146"]) then
				if arg_341_1.var_.actorSpriteComps10146 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								iter_344_1.color = Color.New(Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_0), Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_0), (Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_0)))
							else
								local var_344_1 = Mathf.Lerp(iter_344_1.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_0)

								iter_344_1.color = Color.New(var_344_1, var_344_1, var_344_1)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["10146"]) and arg_341_1.var_.actorSpriteComps10146 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps10146 = nil
			end

			local var_344_2 = arg_341_1.actors_["10146"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10146 = var_344_2.localPosition
				var_344_2.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10146", 7)

				for iter_344_4 = 0, var_344_2.childCount - 1 do
					local var_344_3 = var_344_2:GetChild(iter_344_4)

					if var_344_3.name == "" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				var_344_2.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_341_1.time_ - 0) / var_344_4)
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				var_344_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_344_5 = 0
			local var_344_6 = 1.35

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(423061084).content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 54 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_7) / 54)

				if (54 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_7) / 54)) > 0 and var_344_6 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_10 and arg_341_1.time_ < var_344_5 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play423061085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 423061085
		arg_345_1.duration_ = 8

		local var_345_0 = {
			zh = 6.866,
			ja = 8
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play423061086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10146"]) and arg_345_1.var_.actorSpriteComps10146 == nil then
				arg_345_1.var_.actorSpriteComps10146 = arg_345_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10146"]) then
				if arg_345_1.var_.actorSpriteComps10146 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								iter_348_1.color = Color.New(Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_0), Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_0), (Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_0)))
							else
								local var_348_1 = Mathf.Lerp(iter_348_1.color.r, 1, (arg_345_1.time_ - 0) / var_348_0)

								iter_348_1.color = Color.New(var_348_1, var_348_1, var_348_1)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10146"]) and arg_345_1.var_.actorSpriteComps10146 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_348_3 then
						iter_348_3.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10146 = nil
			end

			local var_348_2 = arg_345_1.actors_["10146"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10146 = var_348_2.localPosition
				var_348_2.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10146", 3)

				for iter_348_4 = 0, var_348_2.childCount - 1 do
					local var_348_3 = var_348_2:GetChild(iter_348_4)

					if var_348_3.name == "split_6" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_2.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_345_1.time_ - 0) / var_348_4)
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_348_5 = 0
			local var_348_6 = 0.95

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_7 = arg_345_1:GetWordFromCfg(423061085)
				local var_348_8 = arg_345_1:FormatText(var_348_7.content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 38 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 38)

				if (38 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 38)) > 0 and var_348_6 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061085", "story_v_out_423061.awb") ~= 0 then
					local var_348_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061085", "story_v_out_423061.awb") / 1000

					if var_348_11 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_5
					end

					if var_348_7.prefab_name ~= "" and arg_345_1.actors_[var_348_7.prefab_name] ~= nil then
						local var_348_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_7.prefab_name].transform, "story_v_out_423061", "423061085", "story_v_out_423061.awb")

						arg_345_1:RecordAudio("423061085", var_348_12)
						arg_345_1:RecordAudio("423061085", var_348_12)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_423061", "423061085", "story_v_out_423061.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_423061", "423061085", "story_v_out_423061.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_13 and arg_345_1.time_ < var_348_5 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play423061086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 423061086
		arg_349_1.duration_ = 6.17

		local var_349_0 = {
			zh = 4.766,
			ja = 6.166
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play423061087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.675

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(423061086)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 27 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 27)

				if (27 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 27)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061086", "story_v_out_423061.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061086", "story_v_out_423061.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_423061", "423061086", "story_v_out_423061.awb")

						arg_349_1:RecordAudio("423061086", var_352_6)
						arg_349_1:RecordAudio("423061086", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_423061", "423061086", "story_v_out_423061.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_423061", "423061086", "story_v_out_423061.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play423061087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 423061087
		arg_353_1.duration_ = 9.13

		local var_353_0 = {
			zh = 4.433,
			ja = 9.133
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play423061088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10146 = arg_353_1.actors_["10146"].transform.localPosition
				arg_353_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10146", 3)

				for iter_356_0 = 0, arg_353_1.actors_["10146"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["10146"].transform:GetChild(iter_356_0)

					if var_356_0.name == "" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_356_2 = 0
			local var_356_3 = 0.5

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:GetWordFromCfg(423061087)
				local var_356_5 = arg_353_1:FormatText(var_356_4.content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 20 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 20)

				if (20 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 20)) > 0 and var_356_3 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061087", "story_v_out_423061.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061087", "story_v_out_423061.awb") / 1000

					if var_356_8 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_2
					end

					if var_356_4.prefab_name ~= "" and arg_353_1.actors_[var_356_4.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_4.prefab_name].transform, "story_v_out_423061", "423061087", "story_v_out_423061.awb")

						arg_353_1:RecordAudio("423061087", var_356_9)
						arg_353_1:RecordAudio("423061087", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_423061", "423061087", "story_v_out_423061.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_423061", "423061087", "story_v_out_423061.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play423061088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 423061088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play423061089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10146"]) and arg_357_1.var_.actorSpriteComps10146 == nil then
				arg_357_1.var_.actorSpriteComps10146 = arg_357_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10146"]) then
				if arg_357_1.var_.actorSpriteComps10146 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10146"]) and arg_357_1.var_.actorSpriteComps10146 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10146 = nil
			end

			local var_360_2 = arg_357_1.actors_["10146"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10146 = var_360_2.localPosition
				var_360_2.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10146", 7)

				for iter_360_4 = 0, var_360_2.childCount - 1 do
					local var_360_3 = var_360_2:GetChild(iter_360_4)

					if var_360_3.name == "" or not string.find(var_360_3.name, "split") then
						var_360_3.gameObject:SetActive(true)
					else
						var_360_3.gameObject:SetActive(false)
					end
				end
			end

			local var_360_4 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				var_360_2.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_357_1.time_ - 0) / var_360_4)
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				var_360_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_360_5 = 0
			local var_360_6 = 0.9

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(423061088).content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 36 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 36)

				if (36 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 36)) > 0 and var_360_6 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_10 and arg_357_1.time_ < var_360_5 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play423061089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 423061089
		arg_361_1.duration_ = 8.9

		local var_361_0 = {
			zh = 6.233,
			ja = 8.9
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play423061090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10146"]) and arg_361_1.var_.actorSpriteComps10146 == nil then
				arg_361_1.var_.actorSpriteComps10146 = arg_361_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10146"]) then
				if arg_361_1.var_.actorSpriteComps10146 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 1, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10146"]) and arg_361_1.var_.actorSpriteComps10146 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps10146 = nil
			end

			local var_364_2 = arg_361_1.actors_["10146"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10146 = var_364_2.localPosition
				var_364_2.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10146", 3)

				for iter_364_4 = 0, var_364_2.childCount - 1 do
					local var_364_3 = var_364_2:GetChild(iter_364_4)

					if var_364_3.name == "" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_2.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_361_1.time_ - 0) / var_364_4)
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_364_5 = 0
			local var_364_6 = 0.725

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:GetWordFromCfg(423061089)
				local var_364_8 = arg_361_1:FormatText(var_364_7.content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 29 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 29)

				if (29 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_8) / 29)) > 0 and var_364_6 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061089", "story_v_out_423061.awb") ~= 0 then
					local var_364_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061089", "story_v_out_423061.awb") / 1000

					if var_364_11 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_5
					end

					if var_364_7.prefab_name ~= "" and arg_361_1.actors_[var_364_7.prefab_name] ~= nil then
						local var_364_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_7.prefab_name].transform, "story_v_out_423061", "423061089", "story_v_out_423061.awb")

						arg_361_1:RecordAudio("423061089", var_364_12)
						arg_361_1:RecordAudio("423061089", var_364_12)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_423061", "423061089", "story_v_out_423061.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_423061", "423061089", "story_v_out_423061.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_13 and arg_361_1.time_ < var_364_5 + var_364_13 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play423061090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 423061090
		arg_365_1.duration_ = 5.33

		local var_365_0 = {
			zh = 5.333,
			ja = 4.266
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play423061091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.65

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(423061090)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 26 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 26)

				if (26 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 26)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061090", "story_v_out_423061.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061090", "story_v_out_423061.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_423061", "423061090", "story_v_out_423061.awb")

						arg_365_1:RecordAudio("423061090", var_368_6)
						arg_365_1:RecordAudio("423061090", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_423061", "423061090", "story_v_out_423061.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_423061", "423061090", "story_v_out_423061.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play423061091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 423061091
		arg_369_1.duration_ = 6.1

		local var_369_0 = {
			zh = 5.733,
			ja = 6.1
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play423061092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10146 = arg_369_1.actors_["10146"].transform.localPosition
				arg_369_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10146", 3)

				for iter_372_0 = 0, arg_369_1.actors_["10146"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["10146"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_3" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_372_2 = manager.ui.mainCamera.transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.shakeOldPos = var_372_2.localPosition
			end

			local var_372_3 = 0.6

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 then
				local var_372_4, var_372_5 = math.modf((arg_369_1.time_ - 0) / 0.066)

				var_372_2.localPosition = Vector3.New(var_372_5 * 0.1, var_372_5 * 0.1, var_372_5 * 0.1) + arg_369_1.var_.shakeOldPos
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 then
				var_372_2.localPosition = arg_369_1.var_.shakeOldPos
			end

			local var_372_6 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			if arg_369_1.time_ >= var_372_6 + 0.6 and arg_369_1.time_ < var_372_6 + 0.6 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			local var_372_7 = 0
			local var_372_8 = 0.525

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_9 = arg_369_1:GetWordFromCfg(423061091)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_12 = 21 <= 0 and var_372_8 or var_372_8 * (utf8.len(var_372_10) / 21)

				if (21 <= 0 and var_372_8 or var_372_8 * (utf8.len(var_372_10) / 21)) > 0 and var_372_8 < var_372_12 then
					arg_369_1.talkMaxDuration = var_372_12

					if var_372_12 + var_372_7 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_12 + var_372_7
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061091", "story_v_out_423061.awb") ~= 0 then
					local var_372_13 = manager.audio:GetVoiceLength("story_v_out_423061", "423061091", "story_v_out_423061.awb") / 1000

					if var_372_13 + var_372_7 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_7
					end

					if var_372_9.prefab_name ~= "" and arg_369_1.actors_[var_372_9.prefab_name] ~= nil then
						local var_372_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_9.prefab_name].transform, "story_v_out_423061", "423061091", "story_v_out_423061.awb")

						arg_369_1:RecordAudio("423061091", var_372_14)
						arg_369_1:RecordAudio("423061091", var_372_14)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_423061", "423061091", "story_v_out_423061.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_423061", "423061091", "story_v_out_423061.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_15 = math.max(var_372_8, arg_369_1.talkMaxDuration)

			if var_372_7 <= arg_369_1.time_ and arg_369_1.time_ < var_372_7 + var_372_15 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_7) / var_372_15

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_7 + var_372_15 and arg_369_1.time_ < var_372_7 + var_372_15 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play423061092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 423061092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play423061093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10146"]) and arg_373_1.var_.actorSpriteComps10146 == nil then
				arg_373_1.var_.actorSpriteComps10146 = arg_373_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10146"]) then
				if arg_373_1.var_.actorSpriteComps10146 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10146"]) and arg_373_1.var_.actorSpriteComps10146 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10146 = nil
			end

			local var_376_2 = arg_373_1.actors_["10146"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10146 = var_376_2.localPosition
				var_376_2.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10146", 7)

				for iter_376_4 = 0, var_376_2.childCount - 1 do
					local var_376_3 = var_376_2:GetChild(iter_376_4)

					if var_376_3.name == "" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				var_376_2.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_373_1.time_ - 0) / var_376_4)
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				var_376_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_373_1.time_ and arg_373_1.time_ <= 0.05 + arg_376_0 then
				arg_373_1:AudioAction("play", "effect", "se_story_139", "se_story_139_bed", "")
			end

			local var_376_6 = 0
			local var_376_7 = 1.05

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(423061092).content)

				arg_373_1.text_.text = var_376_8

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 42 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_8) / 42)

				if (42 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_8) / 42)) > 0 and var_376_7 < var_376_10 then
					arg_373_1.talkMaxDuration = var_376_10

					if var_376_10 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_8
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_11 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_11 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_11

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_11 and arg_373_1.time_ < var_376_6 + var_376_11 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play423061093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 423061093
		arg_377_1.duration_ = 4.93

		local var_377_0 = {
			zh = 4,
			ja = 4.933
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play423061094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["10146"]) and arg_377_1.var_.actorSpriteComps10146 == nil then
				arg_377_1.var_.actorSpriteComps10146 = arg_377_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["10146"]) then
				if arg_377_1.var_.actorSpriteComps10146 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 1, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["10146"]) and arg_377_1.var_.actorSpriteComps10146 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps10146 = nil
			end

			local var_380_2 = arg_377_1.actors_["10146"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10146 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10146", 3)

				for iter_380_4 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_4)

					if var_380_3.name == "split_3" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_380_5 = 0
			local var_380_6 = 0.425

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:GetWordFromCfg(423061093)
				local var_380_8 = arg_377_1:FormatText(var_380_7.content)

				arg_377_1.text_.text = var_380_8

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 17 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 17)

				if (17 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 17)) > 0 and var_380_6 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_8
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061093", "story_v_out_423061.awb") ~= 0 then
					local var_380_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061093", "story_v_out_423061.awb") / 1000

					if var_380_11 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_11 + var_380_5
					end

					if var_380_7.prefab_name ~= "" and arg_377_1.actors_[var_380_7.prefab_name] ~= nil then
						local var_380_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_7.prefab_name].transform, "story_v_out_423061", "423061093", "story_v_out_423061.awb")

						arg_377_1:RecordAudio("423061093", var_380_12)
						arg_377_1:RecordAudio("423061093", var_380_12)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_423061", "423061093", "story_v_out_423061.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_423061", "423061093", "story_v_out_423061.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_13 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_13

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_13 and arg_377_1.time_ < var_380_5 + var_380_13 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play423061094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 423061094
		arg_381_1.duration_ = 14.6

		local var_381_0 = {
			zh = 11.566,
			ja = 14.6
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play423061095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10146 = arg_381_1.actors_["10146"].transform.localPosition
				arg_381_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10146", 3)

				for iter_384_0 = 0, arg_381_1.actors_["10146"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["10146"].transform:GetChild(iter_384_0)

					if var_384_0.name == "" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_384_2 = 0
			local var_384_3 = 0.975

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(423061094)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 39 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 39)

				if (39 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 39)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061094", "story_v_out_423061.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061094", "story_v_out_423061.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_out_423061", "423061094", "story_v_out_423061.awb")

						arg_381_1:RecordAudio("423061094", var_384_9)
						arg_381_1:RecordAudio("423061094", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_423061", "423061094", "story_v_out_423061.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_423061", "423061094", "story_v_out_423061.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play423061095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 423061095
		arg_385_1.duration_ = 9.3

		local var_385_0 = {
			zh = 9.3,
			ja = 8.266
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play423061096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 2 < arg_385_1.time_ and arg_385_1.time_ <= 2 + arg_388_0 then
				local var_388_0 = arg_385_1.bgs_.ST0112a

				arg_385_1.bgs_.ST0112a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_388_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_388_1 = var_388_0:GetComponent("SpriteRenderer")

				if var_388_1 and var_388_1.sprite then
					local var_388_2 = 2 * (var_388_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_388_0.transform.localScale = Vector3.New(var_388_2 / var_388_1.sprite.bounds.size.y < var_388_2 * manager.ui.mainCameraCom_.aspect / var_388_1.sprite.bounds.size.x and var_388_2 * manager.ui.mainCameraCom_.aspect / var_388_1.sprite.bounds.size.x or var_388_2 / var_388_1.sprite.bounds.size.y, var_388_2 / var_388_1.sprite.bounds.size.y < var_388_2 * manager.ui.mainCameraCom_.aspect / var_388_1.sprite.bounds.size.x and var_388_2 * manager.ui.mainCameraCom_.aspect / var_388_1.sprite.bounds.size.x or var_388_2 / var_388_1.sprite.bounds.size.y, 0)
				end

				for iter_388_0, iter_388_1 in pairs(arg_385_1.bgs_) do
					if iter_388_0 ~= "ST0112a" then
						iter_388_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_388_3 = 4

			if 4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_3 + arg_388_0 then
				arg_385_1.allBtn_.enabled = false
			end

			if arg_385_1.time_ >= var_388_3 + 0.3 and arg_385_1.time_ < var_388_3 + 0.3 + arg_388_0 then
				arg_385_1.allBtn_.enabled = true
			end

			local var_388_4 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_5 = 2

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_5 then
				local var_388_6 = Color.New(0, 0, 0)

				var_388_6.a = Mathf.Lerp(0, 1, (arg_385_1.time_ - var_388_4) / var_388_5)
				arg_385_1.mask_.color = var_388_6
			end

			if arg_385_1.time_ >= var_388_4 + var_388_5 and arg_385_1.time_ < var_388_4 + var_388_5 + arg_388_0 then
				local var_388_7 = Color.New(0, 0, 0)

				var_388_7.a = 1
				arg_385_1.mask_.color = var_388_7
			end

			local var_388_8 = 2

			if 2 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_9 = 2

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 then
				local var_388_10 = Color.New(0, 0, 0)

				var_388_10.a = Mathf.Lerp(1, 0, (arg_385_1.time_ - var_388_8) / var_388_9)
				arg_385_1.mask_.color = var_388_10
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 then
				local var_388_11 = Color.New(0, 0, 0)

				arg_385_1.mask_.enabled = false
				var_388_11.a = 0
				arg_385_1.mask_.color = var_388_11
			end

			local var_388_12 = "3054"

			if arg_385_1.actors_["3054"] == nil then
				local var_388_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

				if not isNil(var_388_13) then
					local var_388_14 = Object.Instantiate(var_388_13, arg_385_1.canvasGo_.transform)

					var_388_14.transform:SetSiblingIndex(1)

					var_388_14.name = var_388_12
					var_388_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_385_1.actors_[var_388_12] = var_388_14

					if arg_385_1.isInRecall_ then
						for iter_388_2, iter_388_3 in ipairs((var_388_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_388_3.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_388_15 = arg_385_1.actors_["3054"]

			if 3.8 < arg_385_1.time_ and arg_385_1.time_ <= 3.8 + arg_388_0 and not isNil(var_388_15) and arg_385_1.var_.actorSpriteComps3054 == nil then
				arg_385_1.var_.actorSpriteComps3054 = var_388_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_16 = 0.2

			if 3.8 <= arg_385_1.time_ and arg_385_1.time_ < 3.8 + var_388_16 and not isNil(var_388_15) then
				if arg_385_1.var_.actorSpriteComps3054 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								iter_388_5.color = Color.New(Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 3.8) / var_388_16), Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 3.8) / var_388_16), (Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 3.8) / var_388_16)))
							else
								local var_388_17 = Mathf.Lerp(iter_388_5.color.r, 1, (arg_385_1.time_ - 3.8) / var_388_16)

								iter_388_5.color = Color.New(var_388_17, var_388_17, var_388_17)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 3.8 + var_388_16 and arg_385_1.time_ < 3.8 + var_388_16 + arg_388_0 and not isNil(var_388_15) and arg_385_1.var_.actorSpriteComps3054 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps3054 = nil
			end

			local var_388_18 = arg_385_1.actors_["10146"]

			if 1.8 < arg_385_1.time_ and arg_385_1.time_ <= 1.8 + arg_388_0 and not isNil(var_388_18) and arg_385_1.var_.actorSpriteComps10146 == nil then
				arg_385_1.var_.actorSpriteComps10146 = var_388_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_19 = 0.2

			if 1.8 <= arg_385_1.time_ and arg_385_1.time_ < 1.8 + var_388_19 and not isNil(var_388_18) then
				if arg_385_1.var_.actorSpriteComps10146 then
					for iter_388_8, iter_388_9 in pairs(arg_385_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_388_9 then
							if arg_385_1.isInRecall_ then
								iter_388_9.color = Color.New(Mathf.Lerp(iter_388_9.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 1.8) / var_388_19), Mathf.Lerp(iter_388_9.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 1.8) / var_388_19), (Mathf.Lerp(iter_388_9.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 1.8) / var_388_19)))
							else
								local var_388_20 = Mathf.Lerp(iter_388_9.color.r, 0.5, (arg_385_1.time_ - 1.8) / var_388_19)

								iter_388_9.color = Color.New(var_388_20, var_388_20, var_388_20)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 1.8 + var_388_19 and arg_385_1.time_ < 1.8 + var_388_19 + arg_388_0 and not isNil(var_388_18) and arg_385_1.var_.actorSpriteComps10146 then
				for iter_388_10, iter_388_11 in pairs(arg_385_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_388_11 then
						iter_388_11.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps10146 = nil
			end

			local var_388_21 = arg_385_1.actors_["10146"].transform

			if 1.966 < arg_385_1.time_ and arg_385_1.time_ <= 1.966 + arg_388_0 then
				arg_385_1.var_.moveOldPos10146 = var_388_21.localPosition
				var_388_21.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10146", 7)

				for iter_388_12 = 0, var_388_21.childCount - 1 do
					local var_388_22 = var_388_21:GetChild(iter_388_12)

					if var_388_22.name == "" or not string.find(var_388_22.name, "split") then
						var_388_22.gameObject:SetActive(true)
					else
						var_388_22.gameObject:SetActive(false)
					end
				end
			end

			local var_388_23 = 0.001

			if 1.966 <= arg_385_1.time_ and arg_385_1.time_ < 1.966 + var_388_23 then
				var_388_21.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_385_1.time_ - 1.966) / var_388_23)
			end

			if arg_385_1.time_ >= 1.966 + var_388_23 and arg_385_1.time_ < 1.966 + var_388_23 + arg_388_0 then
				var_388_21.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_388_24 = arg_385_1.actors_["3054"].transform

			if 3.8 < arg_385_1.time_ and arg_385_1.time_ <= 3.8 + arg_388_0 then
				arg_385_1.var_.moveOldPos3054 = var_388_24.localPosition
				var_388_24.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("3054", 3)

				for iter_388_13 = 0, var_388_24.childCount - 1 do
					local var_388_25 = var_388_24:GetChild(iter_388_13)

					if var_388_25.name == "split_3" or not string.find(var_388_25.name, "split") then
						var_388_25.gameObject:SetActive(true)
					else
						var_388_25.gameObject:SetActive(false)
					end
				end
			end

			local var_388_26 = 0.001

			if 3.8 <= arg_385_1.time_ and arg_385_1.time_ < 3.8 + var_388_26 then
				var_388_24.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_385_1.time_ - 3.8) / var_388_26)
			end

			if arg_385_1.time_ >= 3.8 + var_388_26 and arg_385_1.time_ < 3.8 + var_388_26 + arg_388_0 then
				var_388_24.localPosition = Vector3.New(0, -275, -280)
			end

			if 0.166666666666667 < arg_385_1.time_ and arg_385_1.time_ <= 0.166666666666667 + arg_388_0 then
				arg_385_1:AudioAction("stop", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if 1.53333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 1.53333333333333 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_29 = 4
			local var_388_30 = 0.65

			if 4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_29 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_31 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_31:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_385_1.dialogCg_.alpha = arg_389_0
				end))
				var_388_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_32 = arg_385_1:GetWordFromCfg(423061095)
				local var_388_33 = arg_385_1:FormatText(var_388_32.content)

				arg_385_1.text_.text = var_388_33

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_35 = 26 <= 0 and var_388_30 or var_388_30 * (utf8.len(var_388_33) / 26)

				if (26 <= 0 and var_388_30 or var_388_30 * (utf8.len(var_388_33) / 26)) > 0 and var_388_30 < var_388_35 then
					arg_385_1.talkMaxDuration = var_388_35
					var_388_29 = var_388_29 + 0.3

					if var_388_35 + var_388_29 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_35 + var_388_29
					end
				end

				arg_385_1.text_.text = var_388_33
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061095", "story_v_out_423061.awb") ~= 0 then
					local var_388_36 = manager.audio:GetVoiceLength("story_v_out_423061", "423061095", "story_v_out_423061.awb") / 1000

					if var_388_36 + var_388_29 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_36 + var_388_29
					end

					if var_388_32.prefab_name ~= "" and arg_385_1.actors_[var_388_32.prefab_name] ~= nil then
						local var_388_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_32.prefab_name].transform, "story_v_out_423061", "423061095", "story_v_out_423061.awb")

						arg_385_1:RecordAudio("423061095", var_388_37)
						arg_385_1:RecordAudio("423061095", var_388_37)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_423061", "423061095", "story_v_out_423061.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_423061", "423061095", "story_v_out_423061.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_38 = var_388_29 + 0.3
			local var_388_39 = math.max(var_388_30, arg_385_1.talkMaxDuration)

			if var_388_29 + 0.3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_38 + var_388_39 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_38) / var_388_39

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_38 + var_388_39 and arg_385_1.time_ < var_388_38 + var_388_39 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play423061096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 423061096
		arg_391_1.duration_ = 5.6

		local var_391_0 = {
			zh = 5.233,
			ja = 5.6
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
				arg_391_0:Play423061097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos3054 = arg_391_1.actors_["3054"].transform.localPosition
				arg_391_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("3054", 3)

				for iter_394_0 = 0, arg_391_1.actors_["3054"].transform.childCount - 1 do
					local var_394_0 = arg_391_1.actors_["3054"].transform:GetChild(iter_394_0)

					if var_394_0.name == "" or not string.find(var_394_0.name, "split") then
						var_394_0.gameObject:SetActive(true)
					else
						var_394_0.gameObject:SetActive(false)
					end
				end
			end

			local var_394_1 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_1 then
				arg_391_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_391_1.time_ - 0) / var_394_1)
			end

			if arg_391_1.time_ >= 0 + var_394_1 and arg_391_1.time_ < 0 + var_394_1 + arg_394_0 then
				arg_391_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_394_2 = 0
			local var_394_3 = 0.55

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(423061096)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 22 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 22)

				if (22 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 22)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061096", "story_v_out_423061.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061096", "story_v_out_423061.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_423061", "423061096", "story_v_out_423061.awb")

						arg_391_1:RecordAudio("423061096", var_394_9)
						arg_391_1:RecordAudio("423061096", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_423061", "423061096", "story_v_out_423061.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_423061", "423061096", "story_v_out_423061.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423061097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 423061097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play423061098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["3054"]) and arg_395_1.var_.actorSpriteComps3054 == nil then
				arg_395_1.var_.actorSpriteComps3054 = arg_395_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["3054"]) then
				if arg_395_1.var_.actorSpriteComps3054 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								iter_398_1.color = Color.New(Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, (arg_395_1.time_ - 0) / var_398_0), Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, (arg_395_1.time_ - 0) / var_398_0), (Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, (arg_395_1.time_ - 0) / var_398_0)))
							else
								local var_398_1 = Mathf.Lerp(iter_398_1.color.r, 0.5, (arg_395_1.time_ - 0) / var_398_0)

								iter_398_1.color = Color.New(var_398_1, var_398_1, var_398_1)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["3054"]) and arg_395_1.var_.actorSpriteComps3054 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_398_3 then
						iter_398_3.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_395_1.var_.actorSpriteComps3054 = nil
			end

			local var_398_2 = arg_395_1.actors_["3054"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos3054 = var_398_2.localPosition
				var_398_2.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("3054", 7)

				for iter_398_4 = 0, var_398_2.childCount - 1 do
					local var_398_3 = var_398_2:GetChild(iter_398_4)

					if var_398_3.name == "" or not string.find(var_398_3.name, "split") then
						var_398_3.gameObject:SetActive(true)
					else
						var_398_3.gameObject:SetActive(false)
					end
				end
			end

			local var_398_4 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				var_398_2.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_395_1.time_ - 0) / var_398_4)
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				var_398_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.13333333333333 < arg_395_1.time_ and arg_395_1.time_ <= 1.13333333333333 + arg_398_0 then
				arg_395_1:AudioAction("play", "effect", "se_story_144", "se_story_144_can", "")
			end

			local var_398_6 = 0
			local var_398_7 = 1.6

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_8 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(423061097).content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_10 = 64 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_8) / 64)

				if (64 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_8) / 64)) > 0 and var_398_7 < var_398_10 then
					arg_395_1.talkMaxDuration = var_398_10

					if var_398_10 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_11 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_11 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_11

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_11 and arg_395_1.time_ < var_398_6 + var_398_11 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play423061098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 423061098
		arg_399_1.duration_ = 6.27

		local var_399_0 = {
			zh = 6.266,
			ja = 6.033
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play423061099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.7

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:GetWordFromCfg(423061098)
				local var_402_2 = arg_399_1:FormatText(var_402_1.content)

				arg_399_1.text_.text = var_402_2

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 28 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 28)

				if (28 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 28)) > 0 and var_402_0 < var_402_4 then
					arg_399_1.talkMaxDuration = var_402_4

					if var_402_4 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_4 + 0
					end
				end

				arg_399_1.text_.text = var_402_2
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061098", "story_v_out_423061.awb") ~= 0 then
					local var_402_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061098", "story_v_out_423061.awb") / 1000

					if var_402_5 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + 0
					end

					if var_402_1.prefab_name ~= "" and arg_399_1.actors_[var_402_1.prefab_name] ~= nil then
						local var_402_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_1.prefab_name].transform, "story_v_out_423061", "423061098", "story_v_out_423061.awb")

						arg_399_1:RecordAudio("423061098", var_402_6)
						arg_399_1:RecordAudio("423061098", var_402_6)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_423061", "423061098", "story_v_out_423061.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_423061", "423061098", "story_v_out_423061.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_7 and arg_399_1.time_ < 0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play423061099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 423061099
		arg_403_1.duration_ = 6.1

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play423061100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["3054"]) and arg_403_1.var_.actorSpriteComps3054 == nil then
				arg_403_1.var_.actorSpriteComps3054 = arg_403_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["3054"]) then
				if arg_403_1.var_.actorSpriteComps3054 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["3054"]) and arg_403_1.var_.actorSpriteComps3054 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_406_3 then
						iter_406_3.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps3054 = nil
			end

			local var_406_2 = arg_403_1.actors_["3054"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos3054 = var_406_2.localPosition
				var_406_2.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("3054", 3)

				for iter_406_4 = 0, var_406_2.childCount - 1 do
					local var_406_3 = var_406_2:GetChild(iter_406_4)

					if var_406_3.name == "" or not string.find(var_406_3.name, "split") then
						var_406_3.gameObject:SetActive(true)
					else
						var_406_3.gameObject:SetActive(false)
					end
				end
			end

			local var_406_4 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				var_406_2.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_403_1.time_ - 0) / var_406_4)
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				var_406_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_406_5 = 0
			local var_406_6 = 0.675

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_7 = arg_403_1:GetWordFromCfg(423061099)
				local var_406_8 = arg_403_1:FormatText(var_406_7.content)

				arg_403_1.text_.text = var_406_8

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_10 = 27 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 27)

				if (27 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 27)) > 0 and var_406_6 < var_406_10 then
					arg_403_1.talkMaxDuration = var_406_10

					if var_406_10 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_5
					end
				end

				arg_403_1.text_.text = var_406_8
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061099", "story_v_out_423061.awb") ~= 0 then
					local var_406_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061099", "story_v_out_423061.awb") / 1000

					if var_406_11 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_11 + var_406_5
					end

					if var_406_7.prefab_name ~= "" and arg_403_1.actors_[var_406_7.prefab_name] ~= nil then
						local var_406_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_7.prefab_name].transform, "story_v_out_423061", "423061099", "story_v_out_423061.awb")

						arg_403_1:RecordAudio("423061099", var_406_12)
						arg_403_1:RecordAudio("423061099", var_406_12)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_423061", "423061099", "story_v_out_423061.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_423061", "423061099", "story_v_out_423061.awb")
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
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play423061100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 423061100
		arg_407_1.duration_ = 14.7

		local var_407_0 = {
			zh = 11,
			ja = 14.7
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
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play423061101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["3054"]) and arg_407_1.var_.actorSpriteComps3054 == nil then
				arg_407_1.var_.actorSpriteComps3054 = arg_407_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_0 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["3054"]) then
				if arg_407_1.var_.actorSpriteComps3054 then
					for iter_410_0, iter_410_1 in pairs(arg_407_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_410_1 then
							if arg_407_1.isInRecall_ then
								iter_410_1.color = Color.New(Mathf.Lerp(iter_410_1.color.r, arg_407_1.hightColor2.r, (arg_407_1.time_ - 0) / var_410_0), Mathf.Lerp(iter_410_1.color.g, arg_407_1.hightColor2.g, (arg_407_1.time_ - 0) / var_410_0), (Mathf.Lerp(iter_410_1.color.b, arg_407_1.hightColor2.b, (arg_407_1.time_ - 0) / var_410_0)))
							else
								local var_410_1 = Mathf.Lerp(iter_410_1.color.r, 0.5, (arg_407_1.time_ - 0) / var_410_0)

								iter_410_1.color = Color.New(var_410_1, var_410_1, var_410_1)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["3054"]) and arg_407_1.var_.actorSpriteComps3054 then
				for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_410_3 then
						iter_410_3.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps3054 = nil
			end

			local var_410_2 = 0
			local var_410_3 = 1.1

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_4 = arg_407_1:GetWordFromCfg(423061100)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 44 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 44)

				if (44 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 44)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061100", "story_v_out_423061.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061100", "story_v_out_423061.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_out_423061", "423061100", "story_v_out_423061.awb")

						arg_407_1:RecordAudio("423061100", var_410_9)
						arg_407_1:RecordAudio("423061100", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_423061", "423061100", "story_v_out_423061.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_423061", "423061100", "story_v_out_423061.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play423061101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 423061101
		arg_411_1.duration_ = 3.17

		local var_411_0 = {
			zh = 2.833,
			ja = 3.166
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play423061102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["3054"]) and arg_411_1.var_.actorSpriteComps3054 == nil then
				arg_411_1.var_.actorSpriteComps3054 = arg_411_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["3054"]) then
				if arg_411_1.var_.actorSpriteComps3054 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								iter_414_1.color = Color.New(Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_0), Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_0), (Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_0)))
							else
								local var_414_1 = Mathf.Lerp(iter_414_1.color.r, 1, (arg_411_1.time_ - 0) / var_414_0)

								iter_414_1.color = Color.New(var_414_1, var_414_1, var_414_1)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["3054"]) and arg_411_1.var_.actorSpriteComps3054 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_414_3 then
						iter_414_3.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps3054 = nil
			end

			local var_414_2 = arg_411_1.actors_["3054"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos3054 = var_414_2.localPosition
				var_414_2.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("3054", 3)

				for iter_414_4 = 0, var_414_2.childCount - 1 do
					local var_414_3 = var_414_2:GetChild(iter_414_4)

					if var_414_3.name == "" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				var_414_2.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_411_1.time_ - 0) / var_414_4)
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				var_414_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_414_5 = 0
			local var_414_6 = 0.325

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_7 = arg_411_1:GetWordFromCfg(423061101)
				local var_414_8 = arg_411_1:FormatText(var_414_7.content)

				arg_411_1.text_.text = var_414_8

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_10 = 13 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 13)

				if (13 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 13)) > 0 and var_414_6 < var_414_10 then
					arg_411_1.talkMaxDuration = var_414_10

					if var_414_10 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_8
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061101", "story_v_out_423061.awb") ~= 0 then
					local var_414_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061101", "story_v_out_423061.awb") / 1000

					if var_414_11 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_11 + var_414_5
					end

					if var_414_7.prefab_name ~= "" and arg_411_1.actors_[var_414_7.prefab_name] ~= nil then
						local var_414_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_7.prefab_name].transform, "story_v_out_423061", "423061101", "story_v_out_423061.awb")

						arg_411_1:RecordAudio("423061101", var_414_12)
						arg_411_1:RecordAudio("423061101", var_414_12)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_423061", "423061101", "story_v_out_423061.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_423061", "423061101", "story_v_out_423061.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_13 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_13 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_5) / var_414_13

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_5 + var_414_13 and arg_411_1.time_ < var_414_5 + var_414_13 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play423061102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 423061102
		arg_415_1.duration_ = 10.87

		local var_415_0 = {
			zh = 7.266,
			ja = 10.866
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play423061103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["3054"]) and arg_415_1.var_.actorSpriteComps3054 == nil then
				arg_415_1.var_.actorSpriteComps3054 = arg_415_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["3054"]) then
				if arg_415_1.var_.actorSpriteComps3054 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								iter_418_1.color = Color.New(Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor2.r, (arg_415_1.time_ - 0) / var_418_0), Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor2.g, (arg_415_1.time_ - 0) / var_418_0), (Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor2.b, (arg_415_1.time_ - 0) / var_418_0)))
							else
								local var_418_1 = Mathf.Lerp(iter_418_1.color.r, 0.5, (arg_415_1.time_ - 0) / var_418_0)

								iter_418_1.color = Color.New(var_418_1, var_418_1, var_418_1)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["3054"]) and arg_415_1.var_.actorSpriteComps3054 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_418_3 then
						iter_418_3.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_415_1.var_.actorSpriteComps3054 = nil
			end

			local var_418_2 = 0
			local var_418_3 = 0.75

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_4 = arg_415_1:GetWordFromCfg(423061102)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 30 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 30)

				if (30 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 30)) > 0 and var_418_3 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_2
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061102", "story_v_out_423061.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061102", "story_v_out_423061.awb") / 1000

					if var_418_8 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_2
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_out_423061", "423061102", "story_v_out_423061.awb")

						arg_415_1:RecordAudio("423061102", var_418_9)
						arg_415_1:RecordAudio("423061102", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_423061", "423061102", "story_v_out_423061.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_423061", "423061102", "story_v_out_423061.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_3, arg_415_1.talkMaxDuration)

			if var_418_2 <= arg_415_1.time_ and arg_415_1.time_ < var_418_2 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_2) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_2 + var_418_10 and arg_415_1.time_ < var_418_2 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play423061103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 423061103
		arg_419_1.duration_ = 6.93

		local var_419_0 = {
			zh = 6.133,
			ja = 6.933
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play423061104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["3054"]) and arg_419_1.var_.actorSpriteComps3054 == nil then
				arg_419_1.var_.actorSpriteComps3054 = arg_419_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_0 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["3054"]) then
				if arg_419_1.var_.actorSpriteComps3054 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								iter_422_1.color = Color.New(Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor1.r, (arg_419_1.time_ - 0) / var_422_0), Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor1.g, (arg_419_1.time_ - 0) / var_422_0), (Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor1.b, (arg_419_1.time_ - 0) / var_422_0)))
							else
								local var_422_1 = Mathf.Lerp(iter_422_1.color.r, 1, (arg_419_1.time_ - 0) / var_422_0)

								iter_422_1.color = Color.New(var_422_1, var_422_1, var_422_1)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["3054"]) and arg_419_1.var_.actorSpriteComps3054 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_422_3 then
						iter_422_3.color = arg_419_1.isInRecall_ and (arg_419_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_419_1.var_.actorSpriteComps3054 = nil
			end

			local var_422_2 = arg_419_1.actors_["3054"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos3054 = var_422_2.localPosition
				var_422_2.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("3054", 3)

				for iter_422_4 = 0, var_422_2.childCount - 1 do
					local var_422_3 = var_422_2:GetChild(iter_422_4)

					if var_422_3.name == "" or not string.find(var_422_3.name, "split") then
						var_422_3.gameObject:SetActive(true)
					else
						var_422_3.gameObject:SetActive(false)
					end
				end
			end

			local var_422_4 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				var_422_2.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_419_1.time_ - 0) / var_422_4)
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				var_422_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_422_5 = 0
			local var_422_6 = 0.575

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_5 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_7 = arg_419_1:GetWordFromCfg(423061103)
				local var_422_8 = arg_419_1:FormatText(var_422_7.content)

				arg_419_1.text_.text = var_422_8

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_10 = 23 <= 0 and var_422_6 or var_422_6 * (utf8.len(var_422_8) / 23)

				if (23 <= 0 and var_422_6 or var_422_6 * (utf8.len(var_422_8) / 23)) > 0 and var_422_6 < var_422_10 then
					arg_419_1.talkMaxDuration = var_422_10

					if var_422_10 + var_422_5 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_5
					end
				end

				arg_419_1.text_.text = var_422_8
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061103", "story_v_out_423061.awb") ~= 0 then
					local var_422_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061103", "story_v_out_423061.awb") / 1000

					if var_422_11 + var_422_5 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_11 + var_422_5
					end

					if var_422_7.prefab_name ~= "" and arg_419_1.actors_[var_422_7.prefab_name] ~= nil then
						local var_422_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_7.prefab_name].transform, "story_v_out_423061", "423061103", "story_v_out_423061.awb")

						arg_419_1:RecordAudio("423061103", var_422_12)
						arg_419_1:RecordAudio("423061103", var_422_12)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_423061", "423061103", "story_v_out_423061.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_423061", "423061103", "story_v_out_423061.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_13 = math.max(var_422_6, arg_419_1.talkMaxDuration)

			if var_422_5 <= arg_419_1.time_ and arg_419_1.time_ < var_422_5 + var_422_13 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_5) / var_422_13

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_5 + var_422_13 and arg_419_1.time_ < var_422_5 + var_422_13 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play423061104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 423061104
		arg_423_1.duration_ = 9.33

		local var_423_0 = {
			zh = 9.333,
			ja = 8.6
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play423061105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["3054"]) and arg_423_1.var_.actorSpriteComps3054 == nil then
				arg_423_1.var_.actorSpriteComps3054 = arg_423_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["3054"]) then
				if arg_423_1.var_.actorSpriteComps3054 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								iter_426_1.color = Color.New(Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_0), Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_0), (Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_0)))
							else
								local var_426_1 = Mathf.Lerp(iter_426_1.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_0)

								iter_426_1.color = Color.New(var_426_1, var_426_1, var_426_1)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["3054"]) and arg_423_1.var_.actorSpriteComps3054 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps3054 = nil
			end

			local var_426_2 = 0
			local var_426_3 = 0.975

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_4 = arg_423_1:GetWordFromCfg(423061104)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 39 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 39)

				if (39 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 39)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061104", "story_v_out_423061.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061104", "story_v_out_423061.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_out_423061", "423061104", "story_v_out_423061.awb")

						arg_423_1:RecordAudio("423061104", var_426_9)
						arg_423_1:RecordAudio("423061104", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_423061", "423061104", "story_v_out_423061.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_423061", "423061104", "story_v_out_423061.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_10 and arg_423_1.time_ < var_426_2 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play423061105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 423061105
		arg_427_1.duration_ = 4.53

		local var_427_0 = {
			zh = 4.533,
			ja = 2.233
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play423061106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["3054"]) and arg_427_1.var_.actorSpriteComps3054 == nil then
				arg_427_1.var_.actorSpriteComps3054 = arg_427_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["3054"]) then
				if arg_427_1.var_.actorSpriteComps3054 then
					for iter_430_0, iter_430_1 in pairs(arg_427_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_430_1 then
							if arg_427_1.isInRecall_ then
								iter_430_1.color = Color.New(Mathf.Lerp(iter_430_1.color.r, arg_427_1.hightColor1.r, (arg_427_1.time_ - 0) / var_430_0), Mathf.Lerp(iter_430_1.color.g, arg_427_1.hightColor1.g, (arg_427_1.time_ - 0) / var_430_0), (Mathf.Lerp(iter_430_1.color.b, arg_427_1.hightColor1.b, (arg_427_1.time_ - 0) / var_430_0)))
							else
								local var_430_1 = Mathf.Lerp(iter_430_1.color.r, 1, (arg_427_1.time_ - 0) / var_430_0)

								iter_430_1.color = Color.New(var_430_1, var_430_1, var_430_1)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["3054"]) and arg_427_1.var_.actorSpriteComps3054 then
				for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_430_3 then
						iter_430_3.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_427_1.var_.actorSpriteComps3054 = nil
			end

			local var_430_2 = arg_427_1.actors_["3054"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos3054 = var_430_2.localPosition
				var_430_2.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("3054", 3)

				for iter_430_4 = 0, var_430_2.childCount - 1 do
					local var_430_3 = var_430_2:GetChild(iter_430_4)

					if var_430_3.name == "" or not string.find(var_430_3.name, "split") then
						var_430_3.gameObject:SetActive(true)
					else
						var_430_3.gameObject:SetActive(false)
					end
				end
			end

			local var_430_4 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				var_430_2.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_427_1.time_ - 0) / var_430_4)
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				var_430_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_430_5 = 0
			local var_430_6 = 0.45

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_7 = arg_427_1:GetWordFromCfg(423061105)
				local var_430_8 = arg_427_1:FormatText(var_430_7.content)

				arg_427_1.text_.text = var_430_8

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_10 = 18 <= 0 and var_430_6 or var_430_6 * (utf8.len(var_430_8) / 18)

				if (18 <= 0 and var_430_6 or var_430_6 * (utf8.len(var_430_8) / 18)) > 0 and var_430_6 < var_430_10 then
					arg_427_1.talkMaxDuration = var_430_10

					if var_430_10 + var_430_5 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_5
					end
				end

				arg_427_1.text_.text = var_430_8
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061105", "story_v_out_423061.awb") ~= 0 then
					local var_430_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061105", "story_v_out_423061.awb") / 1000

					if var_430_11 + var_430_5 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_11 + var_430_5
					end

					if var_430_7.prefab_name ~= "" and arg_427_1.actors_[var_430_7.prefab_name] ~= nil then
						local var_430_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_7.prefab_name].transform, "story_v_out_423061", "423061105", "story_v_out_423061.awb")

						arg_427_1:RecordAudio("423061105", var_430_12)
						arg_427_1:RecordAudio("423061105", var_430_12)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_423061", "423061105", "story_v_out_423061.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_423061", "423061105", "story_v_out_423061.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_13 = math.max(var_430_6, arg_427_1.talkMaxDuration)

			if var_430_5 <= arg_427_1.time_ and arg_427_1.time_ < var_430_5 + var_430_13 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_5) / var_430_13

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_5 + var_430_13 and arg_427_1.time_ < var_430_5 + var_430_13 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play423061106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 423061106
		arg_431_1.duration_ = 5

		local var_431_0 = {
			zh = 3.833,
			ja = 5
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play423061107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["3054"]) and arg_431_1.var_.actorSpriteComps3054 == nil then
				arg_431_1.var_.actorSpriteComps3054 = arg_431_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["3054"]) then
				if arg_431_1.var_.actorSpriteComps3054 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								iter_434_1.color = Color.New(Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor2.r, (arg_431_1.time_ - 0) / var_434_0), Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor2.g, (arg_431_1.time_ - 0) / var_434_0), (Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor2.b, (arg_431_1.time_ - 0) / var_434_0)))
							else
								local var_434_1 = Mathf.Lerp(iter_434_1.color.r, 0.5, (arg_431_1.time_ - 0) / var_434_0)

								iter_434_1.color = Color.New(var_434_1, var_434_1, var_434_1)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["3054"]) and arg_431_1.var_.actorSpriteComps3054 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_431_1.var_.actorSpriteComps3054 = nil
			end

			local var_434_2 = 0
			local var_434_3 = 0.4

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_4 = arg_431_1:GetWordFromCfg(423061106)
				local var_434_5 = arg_431_1:FormatText(var_434_4.content)

				arg_431_1.text_.text = var_434_5

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_7 = 16 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 16)

				if (16 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 16)) > 0 and var_434_3 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_5
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061106", "story_v_out_423061.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061106", "story_v_out_423061.awb") / 1000

					if var_434_8 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_2
					end

					if var_434_4.prefab_name ~= "" and arg_431_1.actors_[var_434_4.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_4.prefab_name].transform, "story_v_out_423061", "423061106", "story_v_out_423061.awb")

						arg_431_1:RecordAudio("423061106", var_434_9)
						arg_431_1:RecordAudio("423061106", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_423061", "423061106", "story_v_out_423061.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_423061", "423061106", "story_v_out_423061.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_10 and arg_431_1.time_ < var_434_2 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play423061107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 423061107
		arg_435_1.duration_ = 11.67

		local var_435_0 = {
			zh = 11.333,
			ja = 11.666
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play423061108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["3054"]) and arg_435_1.var_.actorSpriteComps3054 == nil then
				arg_435_1.var_.actorSpriteComps3054 = arg_435_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["3054"]) then
				if arg_435_1.var_.actorSpriteComps3054 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								iter_438_1.color = Color.New(Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor1.r, (arg_435_1.time_ - 0) / var_438_0), Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor1.g, (arg_435_1.time_ - 0) / var_438_0), (Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor1.b, (arg_435_1.time_ - 0) / var_438_0)))
							else
								local var_438_1 = Mathf.Lerp(iter_438_1.color.r, 1, (arg_435_1.time_ - 0) / var_438_0)

								iter_438_1.color = Color.New(var_438_1, var_438_1, var_438_1)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["3054"]) and arg_435_1.var_.actorSpriteComps3054 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_435_1.var_.actorSpriteComps3054 = nil
			end

			local var_438_2 = arg_435_1.actors_["3054"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos3054 = var_438_2.localPosition
				var_438_2.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("3054", 3)

				for iter_438_4 = 0, var_438_2.childCount - 1 do
					local var_438_3 = var_438_2:GetChild(iter_438_4)

					if var_438_3.name == "" or not string.find(var_438_3.name, "split") then
						var_438_3.gameObject:SetActive(true)
					else
						var_438_3.gameObject:SetActive(false)
					end
				end
			end

			local var_438_4 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				var_438_2.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_435_1.time_ - 0) / var_438_4)
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				var_438_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_438_5 = 0
			local var_438_6 = 1.225

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_5 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_7 = arg_435_1:GetWordFromCfg(423061107)
				local var_438_8 = arg_435_1:FormatText(var_438_7.content)

				arg_435_1.text_.text = var_438_8

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_10 = 49 <= 0 and var_438_6 or var_438_6 * (utf8.len(var_438_8) / 49)

				if (49 <= 0 and var_438_6 or var_438_6 * (utf8.len(var_438_8) / 49)) > 0 and var_438_6 < var_438_10 then
					arg_435_1.talkMaxDuration = var_438_10

					if var_438_10 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_5
					end
				end

				arg_435_1.text_.text = var_438_8
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061107", "story_v_out_423061.awb") ~= 0 then
					local var_438_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061107", "story_v_out_423061.awb") / 1000

					if var_438_11 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_11 + var_438_5
					end

					if var_438_7.prefab_name ~= "" and arg_435_1.actors_[var_438_7.prefab_name] ~= nil then
						local var_438_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_7.prefab_name].transform, "story_v_out_423061", "423061107", "story_v_out_423061.awb")

						arg_435_1:RecordAudio("423061107", var_438_12)
						arg_435_1:RecordAudio("423061107", var_438_12)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_423061", "423061107", "story_v_out_423061.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_423061", "423061107", "story_v_out_423061.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_13 = math.max(var_438_6, arg_435_1.talkMaxDuration)

			if var_438_5 <= arg_435_1.time_ and arg_435_1.time_ < var_438_5 + var_438_13 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_5) / var_438_13

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_5 + var_438_13 and arg_435_1.time_ < var_438_5 + var_438_13 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play423061108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 423061108
		arg_439_1.duration_ = 7.1

		local var_439_0 = {
			zh = 7.1,
			ja = 4.3
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play423061109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos3054 = arg_439_1.actors_["3054"].transform.localPosition
				arg_439_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("3054", 3)

				for iter_442_0 = 0, arg_439_1.actors_["3054"].transform.childCount - 1 do
					local var_442_0 = arg_439_1.actors_["3054"].transform:GetChild(iter_442_0)

					if var_442_0.name == "" or not string.find(var_442_0.name, "split") then
						var_442_0.gameObject:SetActive(true)
					else
						var_442_0.gameObject:SetActive(false)
					end
				end
			end

			local var_442_1 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_1 then
				arg_439_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_439_1.time_ - 0) / var_442_1)
			end

			if arg_439_1.time_ >= 0 + var_442_1 and arg_439_1.time_ < 0 + var_442_1 + arg_442_0 then
				arg_439_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_442_2 = 0
			local var_442_3 = 0.675

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(423061108)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 27 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 27)

				if (27 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 27)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061108", "story_v_out_423061.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061108", "story_v_out_423061.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_out_423061", "423061108", "story_v_out_423061.awb")

						arg_439_1:RecordAudio("423061108", var_442_9)
						arg_439_1:RecordAudio("423061108", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_423061", "423061108", "story_v_out_423061.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_423061", "423061108", "story_v_out_423061.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play423061109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 423061109
		arg_443_1.duration_ = 5.4

		local var_443_0 = {
			zh = 5.4,
			ja = 4.933
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play423061110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["3054"]) and arg_443_1.var_.actorSpriteComps3054 == nil then
				arg_443_1.var_.actorSpriteComps3054 = arg_443_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["3054"]) then
				if arg_443_1.var_.actorSpriteComps3054 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								iter_446_1.color = Color.New(Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_0), Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_0), (Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_0)))
							else
								local var_446_1 = Mathf.Lerp(iter_446_1.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_0)

								iter_446_1.color = Color.New(var_446_1, var_446_1, var_446_1)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["3054"]) and arg_443_1.var_.actorSpriteComps3054 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps3054 = nil
			end

			local var_446_2 = 0
			local var_446_3 = 0.75

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_4 = arg_443_1:GetWordFromCfg(423061109)
				local var_446_5 = arg_443_1:FormatText(var_446_4.content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 30 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 30)

				if (30 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 30)) > 0 and var_446_3 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061109", "story_v_out_423061.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_423061", "423061109", "story_v_out_423061.awb") / 1000

					if var_446_8 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_2
					end

					if var_446_4.prefab_name ~= "" and arg_443_1.actors_[var_446_4.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_4.prefab_name].transform, "story_v_out_423061", "423061109", "story_v_out_423061.awb")

						arg_443_1:RecordAudio("423061109", var_446_9)
						arg_443_1:RecordAudio("423061109", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_423061", "423061109", "story_v_out_423061.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_423061", "423061109", "story_v_out_423061.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_10 and arg_443_1.time_ < var_446_2 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play423061110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 423061110
		arg_447_1.duration_ = 9.3

		local var_447_0 = {
			zh = 9.3,
			ja = 6.633
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play423061111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["3054"]) and arg_447_1.var_.actorSpriteComps3054 == nil then
				arg_447_1.var_.actorSpriteComps3054 = arg_447_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_0 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["3054"]) then
				if arg_447_1.var_.actorSpriteComps3054 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								iter_450_1.color = Color.New(Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor1.r, (arg_447_1.time_ - 0) / var_450_0), Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor1.g, (arg_447_1.time_ - 0) / var_450_0), (Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor1.b, (arg_447_1.time_ - 0) / var_450_0)))
							else
								local var_450_1 = Mathf.Lerp(iter_450_1.color.r, 1, (arg_447_1.time_ - 0) / var_450_0)

								iter_450_1.color = Color.New(var_450_1, var_450_1, var_450_1)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["3054"]) and arg_447_1.var_.actorSpriteComps3054 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_450_3 then
						iter_450_3.color = arg_447_1.isInRecall_ and (arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_447_1.var_.actorSpriteComps3054 = nil
			end

			local var_450_2 = arg_447_1.actors_["3054"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos3054 = var_450_2.localPosition
				var_450_2.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("3054", 3)

				for iter_450_4 = 0, var_450_2.childCount - 1 do
					local var_450_3 = var_450_2:GetChild(iter_450_4)

					if var_450_3.name == "split_3" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				var_450_2.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_447_1.time_ - 0) / var_450_4)
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				var_450_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_450_5 = 0
			local var_450_6 = 0.95

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_7 = arg_447_1:GetWordFromCfg(423061110)
				local var_450_8 = arg_447_1:FormatText(var_450_7.content)

				arg_447_1.text_.text = var_450_8

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_10 = 38 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 38)

				if (38 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_8) / 38)) > 0 and var_450_6 < var_450_10 then
					arg_447_1.talkMaxDuration = var_450_10

					if var_450_10 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_5
					end
				end

				arg_447_1.text_.text = var_450_8
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061110", "story_v_out_423061.awb") ~= 0 then
					local var_450_11 = manager.audio:GetVoiceLength("story_v_out_423061", "423061110", "story_v_out_423061.awb") / 1000

					if var_450_11 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_11 + var_450_5
					end

					if var_450_7.prefab_name ~= "" and arg_447_1.actors_[var_450_7.prefab_name] ~= nil then
						local var_450_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_7.prefab_name].transform, "story_v_out_423061", "423061110", "story_v_out_423061.awb")

						arg_447_1:RecordAudio("423061110", var_450_12)
						arg_447_1:RecordAudio("423061110", var_450_12)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_423061", "423061110", "story_v_out_423061.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_423061", "423061110", "story_v_out_423061.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_13 = math.max(var_450_6, arg_447_1.talkMaxDuration)

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_13 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_5) / var_450_13

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_5 + var_450_13 and arg_447_1.time_ < var_450_5 + var_450_13 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play423061111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 423061111
		arg_451_1.duration_ = 9

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play423061112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_9001
			local var_454_9000

			if 2 < arg_451_1.time_ and arg_451_1.time_ <= 2 + arg_454_0 then
				local var_454_0 = arg_451_1.bgs_.ST0112a

				arg_451_1.bgs_.ST0112a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_454_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_454_1 = var_454_0:GetComponent("SpriteRenderer")

				if var_454_1 and var_454_1.sprite then
					local var_454_2 = 2 * (var_454_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_454_0.transform.localScale = Vector3.New(var_454_2 / var_454_1.sprite.bounds.size.y < var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x and var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x or var_454_2 / var_454_1.sprite.bounds.size.y, var_454_2 / var_454_1.sprite.bounds.size.y < var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x and var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x or var_454_2 / var_454_1.sprite.bounds.size.y, 0)
				end

				for iter_454_0, iter_454_1 in pairs(arg_451_1.bgs_) do
					if iter_454_0 ~= "ST0112a" then
						iter_454_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_454_3 = 3.999999999999

			if 3.999999999999 < arg_451_1.time_ and arg_451_1.time_ <= var_454_3 + arg_454_0 then
				arg_451_1.allBtn_.enabled = false
			end

			if arg_451_1.time_ >= var_454_3 + 0.3 and arg_451_1.time_ < var_454_3 + 0.3 + arg_454_0 then
				arg_451_1.allBtn_.enabled = true
			end

			local var_454_4 = 0

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.mask_.enabled = true
				arg_451_1.mask_.raycastTarget = true

				arg_451_1:SetGaussion(false)
			end

			local var_454_5 = 2

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_5 then
				local var_454_6 = Color.New(0, 0, 0)

				var_454_6.a = Mathf.Lerp(0, 1, (arg_451_1.time_ - var_454_4) / var_454_5)
				arg_451_1.mask_.color = var_454_6
			end

			if arg_451_1.time_ >= var_454_4 + var_454_5 and arg_451_1.time_ < var_454_4 + var_454_5 + arg_454_0 then
				local var_454_7 = Color.New(0, 0, 0)

				var_454_7.a = 1
				arg_451_1.mask_.color = var_454_7
			end

			local var_454_8 = 2

			if 2 < arg_451_1.time_ and arg_451_1.time_ <= var_454_8 + arg_454_0 then
				arg_451_1.mask_.enabled = true
				arg_451_1.mask_.raycastTarget = true

				arg_451_1:SetGaussion(false)
			end

			local var_454_9 = 2

			if var_454_8 <= arg_451_1.time_ and arg_451_1.time_ < var_454_8 + var_454_9 then
				local var_454_10 = Color.New(0, 0, 0)

				var_454_10.a = Mathf.Lerp(1, 0, (arg_451_1.time_ - var_454_8) / var_454_9)
				arg_451_1.mask_.color = var_454_10
			end

			if arg_451_1.time_ >= var_454_8 + var_454_9 and arg_451_1.time_ < var_454_8 + var_454_9 + arg_454_0 then
				local var_454_11 = Color.New(0, 0, 0)

				arg_451_1.mask_.enabled = false
				var_454_11.a = 0
				arg_451_1.mask_.color = var_454_11
			end

			local var_454_12 = arg_451_1.actors_["3054"]

			if 1.966 < arg_451_1.time_ and arg_451_1.time_ <= 1.966 + arg_454_0 and not isNil(var_454_12) and arg_451_1.var_.actorSpriteComps3054 == nil then
				arg_451_1.var_.actorSpriteComps3054 = var_454_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_13 = 0.034

			if 1.966 <= arg_451_1.time_ and arg_451_1.time_ < 1.966 + var_454_13 and not isNil(var_454_12) then
				if arg_451_1.var_.actorSpriteComps3054 then
					for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_454_3 then
							if arg_451_1.isInRecall_ then
								iter_454_3.color = Color.New(Mathf.Lerp(iter_454_3.color.r, arg_451_1.hightColor2.r, (arg_451_1.time_ - 1.966) / var_454_13), Mathf.Lerp(iter_454_3.color.g, arg_451_1.hightColor2.g, (arg_451_1.time_ - 1.966) / var_454_13), (Mathf.Lerp(iter_454_3.color.b, arg_451_1.hightColor2.b, (arg_451_1.time_ - 1.966) / var_454_13)))
							else
								local var_454_14 = Mathf.Lerp(iter_454_3.color.r, 0.5, (arg_451_1.time_ - 1.966) / var_454_13)

								iter_454_3.color = Color.New(var_454_14, var_454_14, var_454_14)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= 1.966 + var_454_13 and arg_451_1.time_ < 1.966 + var_454_13 + arg_454_0 and not isNil(var_454_12) and arg_451_1.var_.actorSpriteComps3054 then
				for iter_454_4, iter_454_5 in pairs(arg_451_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_454_5 then
						iter_454_5.color = arg_451_1.isInRecall_ and (arg_451_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_451_1.var_.actorSpriteComps3054 = nil
			end

			local var_454_15 = arg_451_1.actors_["3054"].transform

			if 1.966 < arg_451_1.time_ and arg_451_1.time_ <= 1.966 + arg_454_0 then
				arg_451_1.var_.moveOldPos3054 = var_454_15.localPosition
				var_454_15.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("3054", 7)

				for iter_454_6 = 0, var_454_15.childCount - 1 do
					local var_454_16 = var_454_15:GetChild(iter_454_6)

					if var_454_16.name == "" or not string.find(var_454_16.name, "split") then
						var_454_16.gameObject:SetActive(true)
					else
						var_454_16.gameObject:SetActive(false)
					end
				end
			end

			local var_454_17 = 0.001

			if 1.966 <= arg_451_1.time_ and arg_451_1.time_ < 1.966 + var_454_17 then
				var_454_15.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_451_1.time_ - 1.966) / var_454_17)
			end

			if arg_451_1.time_ >= 1.966 + var_454_17 and arg_451_1.time_ < 1.966 + var_454_17 + arg_454_0 then
				var_454_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2 < arg_451_1.time_ and arg_451_1.time_ <= 2 + arg_454_0 then
				local var_454_18 = arg_451_1.var_.effectyaan1

				if not arg_451_1.var_.effectyaan1 then
					var_454_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_454_18.name = "yaan1"
					arg_451_1.var_.effectyaan1 = var_454_18
				else
					var_454_18.transform:SetParent(var_454_9001)
				end

				var_454_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_454_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_454_20 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_454_21 = var_454_18.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_454_7, iter_454_8 in ipairs((var_454_21:ToTable())) do
					iter_454_8.transform.localScale = Vector3.New(iter_454_8.transform.localScale.x / var_454_20 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_454_21 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_454_8.transform.localScale.y / var_454_20, iter_454_8.transform.localScale.z)
				end
			end

			if 2 < arg_451_1.time_ and arg_451_1.time_ <= 2 + arg_454_0 then
				local var_454_23 = arg_451_1.var_.effectyaan2

				if not arg_451_1.var_.effectyaan2 then
					var_454_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_454_23.name = "yaan2"
					arg_451_1.var_.effectyaan2 = var_454_23
				else
					var_454_23.transform:SetParent(var_454_9000)
				end

				var_454_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_454_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_454_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_454_26 = var_454_23.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_454_9, iter_454_10 in ipairs((var_454_26:ToTable())) do
					iter_454_10.transform.localScale = Vector3.New(iter_454_10.transform.localScale.x / var_454_25 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_454_26 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_454_10.transform.localScale.y / var_454_25, iter_454_10.transform.localScale.z)
				end
			end

			if arg_451_1.frameCnt_ <= 1 then
				arg_451_1.dialog_:SetActive(false)
			end

			local var_454_28 = 4
			local var_454_29 = 1.475

			if 4 < arg_451_1.time_ and arg_451_1.time_ <= var_454_28 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0

				arg_451_1.dialog_:SetActive(true)

				arg_451_1.dialogCg_.alpha = 0

				local var_454_30 = LeanTween.value(arg_451_1.dialog_, 0, 1, 0.3)

				var_454_30:setOnUpdate(LuaHelper.FloatAction(function(arg_455_0)
					arg_451_1.dialogCg_.alpha = arg_455_0
				end))
				var_454_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_451_1.dialog_)
					var_454_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_451_1.duration_ = arg_451_1.duration_ + 0.3

				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_31 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(423061111).content)

				arg_451_1.text_.text = var_454_31

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_33 = 70 <= 0 and var_454_29 or var_454_29 * (utf8.len(var_454_31) / 70)

				if (70 <= 0 and var_454_29 or var_454_29 * (utf8.len(var_454_31) / 70)) > 0 and var_454_29 < var_454_33 then
					arg_451_1.talkMaxDuration = var_454_33
					var_454_28 = var_454_28 + 0.3

					if var_454_33 + var_454_28 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_33 + var_454_28
					end
				end

				arg_451_1.text_.text = var_454_31
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_34 = var_454_28 + 0.3
			local var_454_35 = math.max(var_454_29, arg_451_1.talkMaxDuration)

			if var_454_28 + 0.3 <= arg_451_1.time_ and arg_451_1.time_ < var_454_34 + var_454_35 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_34) / var_454_35

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_34 + var_454_35 and arg_451_1.time_ < var_454_34 + var_454_35 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play423061112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 423061112
		arg_457_1.duration_ = 11.6

		local var_457_0 = {
			zh = 9.8,
			ja = 11.6
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play423061113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.375

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_1 = arg_457_1:GetWordFromCfg(423061112)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 55 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 55)

				if (55 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 55)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061112", "story_v_out_423061.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061112", "story_v_out_423061.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_423061", "423061112", "story_v_out_423061.awb")

						arg_457_1:RecordAudio("423061112", var_460_6)
						arg_457_1:RecordAudio("423061112", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_423061", "423061112", "story_v_out_423061.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_423061", "423061112", "story_v_out_423061.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play423061113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 423061113
		arg_461_1.duration_ = 4.9

		local var_461_0 = {
			zh = 3.433,
			ja = 4.9
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play423061114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.325

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:GetWordFromCfg(423061113)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 13 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 13)

				if (13 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 13)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061113", "story_v_out_423061.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061113", "story_v_out_423061.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_423061", "423061113", "story_v_out_423061.awb")

						arg_461_1:RecordAudio("423061113", var_464_6)
						arg_461_1:RecordAudio("423061113", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_423061", "423061113", "story_v_out_423061.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_423061", "423061113", "story_v_out_423061.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play423061114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 423061114
		arg_465_1.duration_ = 10.3

		local var_465_0 = {
			zh = 10.3,
			ja = 8.366
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play423061115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.075

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:GetWordFromCfg(423061114)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 43 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 43)

				if (43 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 43)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061114", "story_v_out_423061.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061114", "story_v_out_423061.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_423061", "423061114", "story_v_out_423061.awb")

						arg_465_1:RecordAudio("423061114", var_468_6)
						arg_465_1:RecordAudio("423061114", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_423061", "423061114", "story_v_out_423061.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_423061", "423061114", "story_v_out_423061.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play423061115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 423061115
		arg_469_1.duration_ = 6.83

		local var_469_0 = {
			zh = 6.333,
			ja = 6.833
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play423061116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.7

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_1 = arg_469_1:GetWordFromCfg(423061115)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 28 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 28)

				if (28 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 28)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061115", "story_v_out_423061.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061115", "story_v_out_423061.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_423061", "423061115", "story_v_out_423061.awb")

						arg_469_1:RecordAudio("423061115", var_472_6)
						arg_469_1:RecordAudio("423061115", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_423061", "423061115", "story_v_out_423061.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_423061", "423061115", "story_v_out_423061.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play423061116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 423061116
		arg_473_1.duration_ = 14.97

		local var_473_0 = {
			zh = 7.7,
			ja = 14.966
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play423061117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.925

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:GetWordFromCfg(423061116)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 37 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 37)

				if (37 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 37)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061116", "story_v_out_423061.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061116", "story_v_out_423061.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_423061", "423061116", "story_v_out_423061.awb")

						arg_473_1:RecordAudio("423061116", var_476_6)
						arg_473_1:RecordAudio("423061116", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_423061", "423061116", "story_v_out_423061.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_423061", "423061116", "story_v_out_423061.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play423061117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 423061117
		arg_477_1.duration_ = 5.23

		local var_477_0 = {
			zh = 5.233,
			ja = 5.066
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play423061118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.675

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:GetWordFromCfg(423061117)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 27 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 27)

				if (27 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 27)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061117", "story_v_out_423061.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061117", "story_v_out_423061.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_423061", "423061117", "story_v_out_423061.awb")

						arg_477_1:RecordAudio("423061117", var_480_6)
						arg_477_1:RecordAudio("423061117", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_423061", "423061117", "story_v_out_423061.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_423061", "423061117", "story_v_out_423061.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play423061118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 423061118
		arg_481_1.duration_ = 11.03

		local var_481_0 = {
			zh = 7.166,
			ja = 11.033
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play423061119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.95

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_1 = arg_481_1:GetWordFromCfg(423061118)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 38 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 38)

				if (38 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 38)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061118", "story_v_out_423061.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061118", "story_v_out_423061.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_423061", "423061118", "story_v_out_423061.awb")

						arg_481_1:RecordAudio("423061118", var_484_6)
						arg_481_1:RecordAudio("423061118", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_423061", "423061118", "story_v_out_423061.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_423061", "423061118", "story_v_out_423061.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play423061119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 423061119
		arg_485_1.duration_ = 7.17

		local var_485_0 = {
			zh = 6.666,
			ja = 7.166
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play423061120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.8

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:GetWordFromCfg(423061119)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 32 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 32)

				if (32 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 32)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061119", "story_v_out_423061.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061119", "story_v_out_423061.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_423061", "423061119", "story_v_out_423061.awb")

						arg_485_1:RecordAudio("423061119", var_488_6)
						arg_485_1:RecordAudio("423061119", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_423061", "423061119", "story_v_out_423061.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_423061", "423061119", "story_v_out_423061.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play423061120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 423061120
		arg_489_1.duration_ = 10.27

		local var_489_0 = {
			zh = 10.266,
			ja = 6.166
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play423061121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 1.025

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:GetWordFromCfg(423061120)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 41 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 41)

				if (41 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 41)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061120", "story_v_out_423061.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061120", "story_v_out_423061.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_423061", "423061120", "story_v_out_423061.awb")

						arg_489_1:RecordAudio("423061120", var_492_6)
						arg_489_1:RecordAudio("423061120", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_423061", "423061120", "story_v_out_423061.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_423061", "423061120", "story_v_out_423061.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play423061121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 423061121
		arg_493_1.duration_ = 5.97

		local var_493_0 = {
			zh = 5.7,
			ja = 5.966
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play423061122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.7

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:GetWordFromCfg(423061121)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 28 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 28)

				if (28 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 28)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061121", "story_v_out_423061.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061121", "story_v_out_423061.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_out_423061", "423061121", "story_v_out_423061.awb")

						arg_493_1:RecordAudio("423061121", var_496_6)
						arg_493_1:RecordAudio("423061121", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_423061", "423061121", "story_v_out_423061.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_423061", "423061121", "story_v_out_423061.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play423061122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 423061122
		arg_497_1.duration_ = 4.4

		local var_497_0 = {
			zh = 4.1,
			ja = 4.4
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play423061123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.325

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_1 = arg_497_1:GetWordFromCfg(423061122)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 13 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 13)

				if (13 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 13)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423061", "423061122", "story_v_out_423061.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_out_423061", "423061122", "story_v_out_423061.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_out_423061", "423061122", "story_v_out_423061.awb")

						arg_497_1:RecordAudio("423061122", var_500_6)
						arg_497_1:RecordAudio("423061122", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_423061", "423061122", "story_v_out_423061.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_423061", "423061122", "story_v_out_423061.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play423061123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 423061123
		arg_501_1.duration_ = 6.96

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
			arg_501_1.auto_ = false
		end

		function arg_501_1.playNext_(arg_503_0)
			arg_501_1.onStoryFinished_()
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if arg_501_1.bgs_.STblack == nil then
				local var_504_0 = Object.Instantiate(arg_501_1.paintGo_)

				var_504_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_504_0.name = "STblack"
				var_504_0.transform.parent = arg_501_1.stage_.transform
				var_504_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.bgs_.STblack = var_504_0
			end

			if 1 < arg_501_1.time_ and arg_501_1.time_ <= 1 + arg_504_0 then
				local var_504_1 = arg_501_1.bgs_.STblack

				arg_501_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_504_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_2 = var_504_1:GetComponent("SpriteRenderer")

				if var_504_2 and var_504_2.sprite then
					local var_504_3 = 2 * (var_504_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_504_1.transform.localScale = Vector3.New(var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "STblack" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_4 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_5 = 1

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_5 then
				local var_504_6 = Color.New(0, 0, 0)

				var_504_6.a = Mathf.Lerp(0, 1, (arg_501_1.time_ - var_504_4) / var_504_5)
				arg_501_1.mask_.color = var_504_6
			end

			if arg_501_1.time_ >= var_504_4 + var_504_5 and arg_501_1.time_ < var_504_4 + var_504_5 + arg_504_0 then
				local var_504_7 = Color.New(0, 0, 0)

				var_504_7.a = 1
				arg_501_1.mask_.color = var_504_7
			end

			local var_504_8 = 1

			if 1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_8 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_9 = 1

			if var_504_8 <= arg_501_1.time_ and arg_501_1.time_ < var_504_8 + var_504_9 then
				local var_504_10 = Color.New(0, 0, 0)

				var_504_10.a = Mathf.Lerp(1, 0, (arg_501_1.time_ - var_504_8) / var_504_9)
				arg_501_1.mask_.color = var_504_10
			end

			if arg_501_1.time_ >= var_504_8 + var_504_9 and arg_501_1.time_ < var_504_8 + var_504_9 + arg_504_0 then
				local var_504_11 = Color.New(0, 0, 0)

				arg_501_1.mask_.enabled = false
				var_504_11.a = 0
				arg_501_1.mask_.color = var_504_11
			end

			if 1 < arg_501_1.time_ and arg_501_1.time_ <= 1 + arg_504_0 then
				if arg_501_1.var_.effectyaan1 then
					Object.Destroy(arg_501_1.var_.effectyaan1)

					arg_501_1.var_.effectyaan1 = nil
				end
			end

			if 1 < arg_501_1.time_ and arg_501_1.time_ <= 1 + arg_504_0 then
				if arg_501_1.var_.effectyaan2 then
					Object.Destroy(arg_501_1.var_.effectyaan2)

					arg_501_1.var_.effectyaan2 = nil
				end
			end

			local var_504_14 = 1.95914009818807
			local var_504_15 = 1.65

			if 1.95914009818807 < arg_501_1.time_ and arg_501_1.time_ <= var_504_14 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_16 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(423061123).content)

				arg_501_1.text_.text = var_504_16

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_18 = 66 <= 0 and var_504_15 or var_504_15 * (utf8.len(var_504_16) / 66)

				if (66 <= 0 and var_504_15 or var_504_15 * (utf8.len(var_504_16) / 66)) > 0 and var_504_15 < var_504_18 then
					arg_501_1.talkMaxDuration = var_504_18

					if var_504_18 + var_504_14 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_18 + var_504_14
					end
				end

				arg_501_1.text_.text = var_504_16
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_19 = math.max(var_504_15, arg_501_1.talkMaxDuration)

			if var_504_14 <= arg_501_1.time_ and arg_501_1.time_ < var_504_14 + var_504_19 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_14) / var_504_19

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_14 + var_504_19 and arg_501_1.time_ < var_504_14 + var_504_19 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0112",
		"TextureConfig/Background/ST0112a",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_423061.awb"
	}
}
