return {
	Play117122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I08a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08a")
				var_4_0.name = "I08a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I08a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I08a

				arg_1_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I08a" then
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

			local var_4_8 = manager.ui.mainCamera.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 0) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 2
			local var_4_19 = 0.55

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(117122001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 22 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_20) / 22)

				if (22 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_20) / 22)) > 0 and var_4_19 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22

					if var_4_22 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_23 and arg_1_1.time_ < var_4_18 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play117122002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 117122002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play117122003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk1", "")
			end

			local var_10_1 = 0
			local var_10_2 = 1.575

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(117122002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 63 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 63)

				if (63 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 63)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play117122003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 117122003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play117122004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fall02", "")
			end

			local var_14_1 = 0
			local var_14_2 = 1.175

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(117122003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 47 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 47)

				if (47 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 47)) > 0 and var_14_2 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_6 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_6 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_6

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_6 and arg_11_1.time_ < var_14_1 + var_14_6 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play117122004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 117122004
		arg_15_1.duration_ = 5.77

		local var_15_0 = {
			zh = 5.766,
			ja = 4.166
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
				arg_15_0:Play117122005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1132"] == nil then
				local var_18_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_18_0) then
					local var_18_1 = Object.Instantiate(var_18_0, arg_15_1.canvasGo_.transform)

					var_18_1.transform:SetSiblingIndex(1)

					var_18_1.name = "1132"
					var_18_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_["1132"] = var_18_1

					if arg_15_1.isInRecall_ then
						for iter_18_0, iter_18_1 in ipairs((var_18_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_18_1.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_2 = arg_15_1.actors_["1132"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1132 = var_18_2.localPosition
				var_18_2.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1132", 3)

				for iter_18_2 = 0, var_18_2.childCount - 1 do
					local var_18_3 = var_18_2:GetChild(iter_18_2)

					if var_18_3.name == "split_6" or not string.find(var_18_3.name, "split") then
						var_18_3.gameObject:SetActive(true)
					else
						var_18_3.gameObject:SetActive(false)
					end
				end
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_2.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1132, Vector3.New(0, -413, -185), (arg_15_1.time_ - 0) / var_18_4)
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_2.localPosition = Vector3.New(0, -413, -185)
			end

			local var_18_5 = arg_15_1.actors_["1132"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.actorSpriteComps1132 == nil then
				arg_15_1.var_.actorSpriteComps1132 = var_18_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_6 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.actorSpriteComps1132 then
					for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_18_4 then
							if arg_15_1.isInRecall_ then
								iter_18_4.color = Color.New(Mathf.Lerp(iter_18_4.color.r, arg_15_1.hightColor1.r, (arg_15_1.time_ - 0) / var_18_6), Mathf.Lerp(iter_18_4.color.g, arg_15_1.hightColor1.g, (arg_15_1.time_ - 0) / var_18_6), (Mathf.Lerp(iter_18_4.color.b, arg_15_1.hightColor1.b, (arg_15_1.time_ - 0) / var_18_6)))
							else
								local var_18_7 = Mathf.Lerp(iter_18_4.color.r, 1, (arg_15_1.time_ - 0) / var_18_6)

								iter_18_4.color = Color.New(var_18_7, var_18_7, var_18_7)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.actorSpriteComps1132 then
				for iter_18_5, iter_18_6 in pairs(arg_15_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_18_6 then
						iter_18_6.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps1132 = nil
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_8 = arg_15_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_8 then
					arg_15_1.var_.alphaOldValue1132 = var_18_8.alpha
					arg_15_1.var_.characterEffect1132 = var_18_8
				end

				arg_15_1.var_.alphaOldValue1132 = 0
			end

			local var_18_9 = 0.5

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 then
				if arg_15_1.var_.characterEffect1132 then
					arg_15_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_15_1.var_.alphaOldValue1132, 1, (arg_15_1.time_ - 0) / var_18_9)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 and arg_15_1.var_.characterEffect1132 then
				arg_15_1.var_.characterEffect1132.alpha = 1
			end

			local var_18_10 = 0
			local var_18_11 = 0.275

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_12 = arg_15_1:GetWordFromCfg(117122004)
				local var_18_13 = arg_15_1:FormatText(var_18_12.content)

				arg_15_1.text_.text = var_18_13

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_15 = 11 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 11)

				if (11 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 11)) > 0 and var_18_11 < var_18_15 then
					arg_15_1.talkMaxDuration = var_18_15

					if var_18_15 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_15 + var_18_10
					end
				end

				arg_15_1.text_.text = var_18_13
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122004", "story_v_out_117122.awb") ~= 0 then
					local var_18_16 = manager.audio:GetVoiceLength("story_v_out_117122", "117122004", "story_v_out_117122.awb") / 1000

					if var_18_16 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_10
					end

					if var_18_12.prefab_name ~= "" and arg_15_1.actors_[var_18_12.prefab_name] ~= nil then
						local var_18_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_12.prefab_name].transform, "story_v_out_117122", "117122004", "story_v_out_117122.awb")

						arg_15_1:RecordAudio("117122004", var_18_17)
						arg_15_1:RecordAudio("117122004", var_18_17)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_117122", "117122004", "story_v_out_117122.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_117122", "117122004", "story_v_out_117122.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_18 = math.max(var_18_11, arg_15_1.talkMaxDuration)

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_10) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_10 + var_18_18 and arg_15_1.time_ < var_18_10 + var_18_18 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play117122005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 117122005
		arg_19_1.duration_ = 1.9

		local var_19_0 = {
			zh = 1.9,
			ja = 1.433
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
				arg_19_0:Play117122006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1132"]) and arg_19_1.var_.actorSpriteComps1132 == nil then
				arg_19_1.var_.actorSpriteComps1132 = arg_19_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_0 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1132"]) then
				if arg_19_1.var_.actorSpriteComps1132 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								iter_22_1.color = Color.New(Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_0), Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_0), (Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_0)))
							else
								local var_22_1 = Mathf.Lerp(iter_22_1.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_0)

								iter_22_1.color = Color.New(var_22_1, var_22_1, var_22_1)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1132"]) and arg_19_1.var_.actorSpriteComps1132 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps1132 = nil
			end

			local var_22_2 = 0
			local var_22_3 = 0.075

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_4 = arg_19_1:GetWordFromCfg(117122005)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 3 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 3)

				if (3 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 3)) > 0 and var_22_3 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122005", "story_v_out_117122.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_117122", "117122005", "story_v_out_117122.awb") / 1000

					if var_22_8 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_2
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_117122", "117122005", "story_v_out_117122.awb")

						arg_19_1:RecordAudio("117122005", var_22_9)
						arg_19_1:RecordAudio("117122005", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_117122", "117122005", "story_v_out_117122.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_117122", "117122005", "story_v_out_117122.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_10 and arg_19_1.time_ < var_22_2 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play117122006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 117122006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play117122007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1132 = arg_23_1.actors_["1132"].transform.localPosition
				arg_23_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1132", 7)

				for iter_26_0 = 0, arg_23_1.actors_["1132"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["1132"].transform:GetChild(iter_26_0)

					if var_26_0.name == "split_5" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1132, Vector3.New(0, -2000, -185), (arg_23_1.time_ - 0) / var_26_1)
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["1132"].transform.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_26_2 = 0
			local var_26_3 = 0.8

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(117122006).content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_6 = 32 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 32)

				if (32 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 32)) > 0 and var_26_3 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_7 and arg_23_1.time_ < var_26_2 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
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
	Play117122007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 117122007
		arg_27_1.duration_ = 2.67

		local var_27_0 = {
			zh = 1.5,
			ja = 2.666
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
				arg_27_0:Play117122008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["10035"] == nil then
				local var_30_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_30_0) then
					local var_30_1 = Object.Instantiate(var_30_0, arg_27_1.canvasGo_.transform)

					var_30_1.transform:SetSiblingIndex(1)

					var_30_1.name = "10035"
					var_30_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_27_1.actors_["10035"] = var_30_1

					if arg_27_1.isInRecall_ then
						for iter_30_0, iter_30_1 in ipairs((var_30_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_30_1.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_30_2 = arg_27_1.actors_["10035"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10035 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10035", 4)

				for iter_30_2 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_2)

					if var_30_3.name == "split_4" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_27_1.time_ - 0) / var_30_4)
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_30_5 = "1033"

			if arg_27_1.actors_["1033"] == nil then
				local var_30_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_30_6) then
					local var_30_7 = Object.Instantiate(var_30_6, arg_27_1.canvasGo_.transform)

					var_30_7.transform:SetSiblingIndex(1)

					var_30_7.name = var_30_5
					var_30_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_27_1.actors_[var_30_5] = var_30_7

					if arg_27_1.isInRecall_ then
						for iter_30_3, iter_30_4 in ipairs((var_30_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_30_4.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_30_8 = arg_27_1.actors_["1033"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1033 = var_30_8.localPosition
				var_30_8.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1033", 2)

				for iter_30_5 = 0, var_30_8.childCount - 1 do
					local var_30_9 = var_30_8:GetChild(iter_30_5)

					if var_30_9.name == "split_6" or not string.find(var_30_9.name, "split") then
						var_30_9.gameObject:SetActive(true)
					else
						var_30_9.gameObject:SetActive(false)
					end
				end
			end

			local var_30_10 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_10 then
				var_30_8.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_27_1.time_ - 0) / var_30_10)
			end

			if arg_27_1.time_ >= 0 + var_30_10 and arg_27_1.time_ < 0 + var_30_10 + arg_30_0 then
				var_30_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_30_11 = arg_27_1.actors_["1033"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_11) and arg_27_1.var_.actorSpriteComps1033 == nil then
				arg_27_1.var_.actorSpriteComps1033 = var_30_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_12 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_12 and not isNil(var_30_11) then
				if arg_27_1.var_.actorSpriteComps1033 then
					for iter_30_6, iter_30_7 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_30_7 then
							if arg_27_1.isInRecall_ then
								iter_30_7.color = Color.New(Mathf.Lerp(iter_30_7.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_12), Mathf.Lerp(iter_30_7.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_12), (Mathf.Lerp(iter_30_7.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_12)))
							else
								local var_30_13 = Mathf.Lerp(iter_30_7.color.r, 1, (arg_27_1.time_ - 0) / var_30_12)

								iter_30_7.color = Color.New(var_30_13, var_30_13, var_30_13)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_12 and arg_27_1.time_ < 0 + var_30_12 + arg_30_0 and not isNil(var_30_11) and arg_27_1.var_.actorSpriteComps1033 then
				for iter_30_8, iter_30_9 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_30_9 then
						iter_30_9.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1033 = nil
			end

			local var_30_14 = arg_27_1.actors_["10035"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.actorSpriteComps10035 == nil then
				arg_27_1.var_.actorSpriteComps10035 = var_30_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_15 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_15 and not isNil(var_30_14) then
				if arg_27_1.var_.actorSpriteComps10035 then
					for iter_30_10, iter_30_11 in pairs(arg_27_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_30_11 then
							if arg_27_1.isInRecall_ then
								iter_30_11.color = Color.New(Mathf.Lerp(iter_30_11.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_15), Mathf.Lerp(iter_30_11.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_15), (Mathf.Lerp(iter_30_11.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_15)))
							else
								local var_30_16 = Mathf.Lerp(iter_30_11.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_15)

								iter_30_11.color = Color.New(var_30_16, var_30_16, var_30_16)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_15 and arg_27_1.time_ < 0 + var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.actorSpriteComps10035 then
				for iter_30_12, iter_30_13 in pairs(arg_27_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_30_13 then
						iter_30_13.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_17 = arg_27_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_17 then
					arg_27_1.var_.alphaOldValue1132 = var_30_17.alpha
					arg_27_1.var_.characterEffect1132 = var_30_17
				end

				arg_27_1.var_.alphaOldValue1132 = 1
			end

			local var_30_18 = 0.5

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_18 then
				if arg_27_1.var_.characterEffect1132 then
					arg_27_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue1132, 0, (arg_27_1.time_ - 0) / var_30_18)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_18 and arg_27_1.time_ < 0 + var_30_18 + arg_30_0 and arg_27_1.var_.characterEffect1132 then
				arg_27_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_19 = arg_27_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_19 then
					arg_27_1.var_.alphaOldValue1033 = var_30_19.alpha
					arg_27_1.var_.characterEffect1033 = var_30_19
				end

				arg_27_1.var_.alphaOldValue1033 = 0
			end

			local var_30_20 = 0.5

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_20 then
				if arg_27_1.var_.characterEffect1033 then
					arg_27_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue1033, 1, (arg_27_1.time_ - 0) / var_30_20)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_20 and arg_27_1.time_ < 0 + var_30_20 + arg_30_0 and arg_27_1.var_.characterEffect1033 then
				arg_27_1.var_.characterEffect1033.alpha = 1
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_21 = arg_27_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_21 then
					arg_27_1.var_.alphaOldValue10035 = var_30_21.alpha
					arg_27_1.var_.characterEffect10035 = var_30_21
				end

				arg_27_1.var_.alphaOldValue10035 = 0
			end

			local var_30_22 = 0.5

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_22 then
				if arg_27_1.var_.characterEffect10035 then
					arg_27_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_27_1.var_.alphaOldValue10035, 1, (arg_27_1.time_ - 0) / var_30_22)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_22 and arg_27_1.time_ < 0 + var_30_22 + arg_30_0 and arg_27_1.var_.characterEffect10035 then
				arg_27_1.var_.characterEffect10035.alpha = 1
			end

			local var_30_23 = 0
			local var_30_24 = 0.075

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_23 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_25 = arg_27_1:GetWordFromCfg(117122007)
				local var_30_26 = arg_27_1:FormatText(var_30_25.content)

				arg_27_1.text_.text = var_30_26

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_28 = 3 <= 0 and var_30_24 or var_30_24 * (utf8.len(var_30_26) / 3)

				if (3 <= 0 and var_30_24 or var_30_24 * (utf8.len(var_30_26) / 3)) > 0 and var_30_24 < var_30_28 then
					arg_27_1.talkMaxDuration = var_30_28

					if var_30_28 + var_30_23 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_23
					end
				end

				arg_27_1.text_.text = var_30_26
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122007", "story_v_out_117122.awb") ~= 0 then
					local var_30_29 = manager.audio:GetVoiceLength("story_v_out_117122", "117122007", "story_v_out_117122.awb") / 1000

					if var_30_29 + var_30_23 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_29 + var_30_23
					end

					if var_30_25.prefab_name ~= "" and arg_27_1.actors_[var_30_25.prefab_name] ~= nil then
						local var_30_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_25.prefab_name].transform, "story_v_out_117122", "117122007", "story_v_out_117122.awb")

						arg_27_1:RecordAudio("117122007", var_30_30)
						arg_27_1:RecordAudio("117122007", var_30_30)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_117122", "117122007", "story_v_out_117122.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_117122", "117122007", "story_v_out_117122.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_31 = math.max(var_30_24, arg_27_1.talkMaxDuration)

			if var_30_23 <= arg_27_1.time_ and arg_27_1.time_ < var_30_23 + var_30_31 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_23) / var_30_31

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_23 + var_30_31 and arg_27_1.time_ < var_30_23 + var_30_31 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play117122008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 117122008
		arg_31_1.duration_ = 5.17

		local var_31_0 = {
			zh = 5.166,
			ja = 4.2
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
				arg_31_0:Play117122009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10035 = arg_31_1.actors_["10035"].transform.localPosition
				arg_31_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10035", 4)

				for iter_34_0 = 0, arg_31_1.actors_["10035"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["10035"].transform:GetChild(iter_34_0)

					if var_34_0.name == "split_5" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_34_2 = arg_31_1.actors_["1033"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1033 = var_34_2.localPosition
				var_34_2.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1033", 2)

				for iter_34_1 = 0, var_34_2.childCount - 1 do
					local var_34_3 = var_34_2:GetChild(iter_34_1)

					if var_34_3.name == "split_6" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_2.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_31_1.time_ - 0) / var_34_4)
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_34_5 = arg_31_1.actors_["1033"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.actorSpriteComps1033 == nil then
				arg_31_1.var_.actorSpriteComps1033 = var_34_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_6 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.actorSpriteComps1033 then
					for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_34_3 then
							if arg_31_1.isInRecall_ then
								iter_34_3.color = Color.New(Mathf.Lerp(iter_34_3.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_6), Mathf.Lerp(iter_34_3.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_6), (Mathf.Lerp(iter_34_3.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_6)))
							else
								local var_34_7 = Mathf.Lerp(iter_34_3.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_6)

								iter_34_3.color = Color.New(var_34_7, var_34_7, var_34_7)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.actorSpriteComps1033 then
				for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_34_5 then
						iter_34_5.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps1033 = nil
			end

			local var_34_8 = arg_31_1.actors_["10035"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.actorSpriteComps10035 == nil then
				arg_31_1.var_.actorSpriteComps10035 = var_34_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_9 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_9 and not isNil(var_34_8) then
				if arg_31_1.var_.actorSpriteComps10035 then
					for iter_34_6, iter_34_7 in pairs(arg_31_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_34_7 then
							if arg_31_1.isInRecall_ then
								iter_34_7.color = Color.New(Mathf.Lerp(iter_34_7.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_9), Mathf.Lerp(iter_34_7.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_9), (Mathf.Lerp(iter_34_7.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_9)))
							else
								local var_34_10 = Mathf.Lerp(iter_34_7.color.r, 1, (arg_31_1.time_ - 0) / var_34_9)

								iter_34_7.color = Color.New(var_34_10, var_34_10, var_34_10)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_9 and arg_31_1.time_ < 0 + var_34_9 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.actorSpriteComps10035 then
				for iter_34_8, iter_34_9 in pairs(arg_31_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_34_9 then
						iter_34_9.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps10035 = nil
			end

			local var_34_11 = 0
			local var_34_12 = 0.675

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_13 = arg_31_1:GetWordFromCfg(117122008)
				local var_34_14 = arg_31_1:FormatText(var_34_13.content)

				arg_31_1.text_.text = var_34_14

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 27 <= 0 and var_34_12 or var_34_12 * (utf8.len(var_34_14) / 27)

				if (27 <= 0 and var_34_12 or var_34_12 * (utf8.len(var_34_14) / 27)) > 0 and var_34_12 < var_34_16 then
					arg_31_1.talkMaxDuration = var_34_16

					if var_34_16 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_14
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122008", "story_v_out_117122.awb") ~= 0 then
					local var_34_17 = manager.audio:GetVoiceLength("story_v_out_117122", "117122008", "story_v_out_117122.awb") / 1000

					if var_34_17 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_17 + var_34_11
					end

					if var_34_13.prefab_name ~= "" and arg_31_1.actors_[var_34_13.prefab_name] ~= nil then
						local var_34_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_13.prefab_name].transform, "story_v_out_117122", "117122008", "story_v_out_117122.awb")

						arg_31_1:RecordAudio("117122008", var_34_18)
						arg_31_1:RecordAudio("117122008", var_34_18)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_117122", "117122008", "story_v_out_117122.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_117122", "117122008", "story_v_out_117122.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_19 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_19 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_11) / var_34_19

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_11 + var_34_19 and arg_31_1.time_ < var_34_11 + var_34_19 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play117122009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 117122009
		arg_35_1.duration_ = 3.23

		local var_35_0 = {
			zh = 3.233,
			ja = 2.366
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
				arg_35_0:Play117122010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10035 = arg_35_1.actors_["10035"].transform.localPosition
				arg_35_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10035", 4)

				for iter_38_0 = 0, arg_35_1.actors_["10035"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["10035"].transform:GetChild(iter_38_0)

					if var_38_0.name == "split_5" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_38_2 = arg_35_1.actors_["10035"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10035 == nil then
				arg_35_1.var_.actorSpriteComps10035 = var_38_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_3 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.actorSpriteComps10035 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_38_2 then
							if arg_35_1.isInRecall_ then
								iter_38_2.color = Color.New(Mathf.Lerp(iter_38_2.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_3), Mathf.Lerp(iter_38_2.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_3), (Mathf.Lerp(iter_38_2.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_3)))
							else
								local var_38_4 = Mathf.Lerp(iter_38_2.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_3)

								iter_38_2.color = Color.New(var_38_4, var_38_4, var_38_4)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10035 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_38_4 then
						iter_38_4.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps10035 = nil
			end

			local var_38_5 = arg_35_1.actors_["1033"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.actorSpriteComps1033 == nil then
				arg_35_1.var_.actorSpriteComps1033 = var_38_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_6 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.actorSpriteComps1033 then
					for iter_38_5, iter_38_6 in pairs(arg_35_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_38_6 then
							if arg_35_1.isInRecall_ then
								iter_38_6.color = Color.New(Mathf.Lerp(iter_38_6.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_6), Mathf.Lerp(iter_38_6.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_6), (Mathf.Lerp(iter_38_6.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_6)))
							else
								local var_38_7 = Mathf.Lerp(iter_38_6.color.r, 1, (arg_35_1.time_ - 0) / var_38_6)

								iter_38_6.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.actorSpriteComps1033 then
				for iter_38_7, iter_38_8 in pairs(arg_35_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_38_8 then
						iter_38_8.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps1033 = nil
			end

			local var_38_8 = 0
			local var_38_9 = 0.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
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

				local var_38_10 = arg_35_1:GetWordFromCfg(117122009)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 11 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 11)

				if (11 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 11)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122009", "story_v_out_117122.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_117122", "117122009", "story_v_out_117122.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_117122", "117122009", "story_v_out_117122.awb")

						arg_35_1:RecordAudio("117122009", var_38_15)
						arg_35_1:RecordAudio("117122009", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_117122", "117122009", "story_v_out_117122.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_117122", "117122009", "story_v_out_117122.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play117122010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 117122010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play117122011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_0 = arg_39_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_0 then
					arg_39_1.var_.alphaOldValue1033 = var_42_0.alpha
					arg_39_1.var_.characterEffect1033 = var_42_0
				end

				arg_39_1.var_.alphaOldValue1033 = 1
			end

			local var_42_1 = 0.3

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				if arg_39_1.var_.characterEffect1033 then
					arg_39_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_39_1.var_.alphaOldValue1033, 0, (arg_39_1.time_ - 0) / var_42_1)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and arg_39_1.var_.characterEffect1033 then
				arg_39_1.var_.characterEffect1033.alpha = 0
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_2 = arg_39_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_2 then
					arg_39_1.var_.alphaOldValue10035 = var_42_2.alpha
					arg_39_1.var_.characterEffect10035 = var_42_2
				end

				arg_39_1.var_.alphaOldValue10035 = 1
			end

			local var_42_3 = 0.3

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 then
				if arg_39_1.var_.characterEffect10035 then
					arg_39_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_39_1.var_.alphaOldValue10035, 0, (arg_39_1.time_ - 0) / var_42_3)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and arg_39_1.var_.characterEffect10035 then
				arg_39_1.var_.characterEffect10035.alpha = 0
			end

			local var_42_4 = 0
			local var_42_5 = 0.5

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(117122010).content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 20 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_6) / 20)

				if (20 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_6) / 20)) > 0 and var_42_5 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_9 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_9 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_9

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_9 and arg_39_1.time_ < var_42_4 + var_42_9 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play117122011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 117122011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play117122012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.775

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(117122011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 31 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 31)

				if (31 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 31)) > 0 and var_46_0 < var_46_3 then
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
	Play117122012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 117122012
		arg_47_1.duration_ = 5.77

		local var_47_0 = {
			zh = 5.766,
			ja = 3.366
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
				arg_47_0:Play117122013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1033 = arg_47_1.actors_["1033"].transform.localPosition
				arg_47_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1033", 3)

				for iter_50_0 = 0, arg_47_1.actors_["1033"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["1033"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_6" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_50_2 = arg_47_1.actors_["1033"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1033 == nil then
				arg_47_1.var_.actorSpriteComps1033 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps1033 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1033 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_5 = arg_47_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_50_5 then
					arg_47_1.var_.alphaOldValue1033 = var_50_5.alpha
					arg_47_1.var_.characterEffect1033 = var_50_5
				end

				arg_47_1.var_.alphaOldValue1033 = 0
			end

			local var_50_6 = 0.5

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 then
				if arg_47_1.var_.characterEffect1033 then
					arg_47_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_47_1.var_.alphaOldValue1033, 1, (arg_47_1.time_ - 0) / var_50_6)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and arg_47_1.var_.characterEffect1033 then
				arg_47_1.var_.characterEffect1033.alpha = 1
			end

			local var_50_7 = 0
			local var_50_8 = 0.75

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
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

				local var_50_9 = arg_47_1:GetWordFromCfg(117122012)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 30 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 30)

				if (30 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 30)) > 0 and var_50_8 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122012", "story_v_out_117122.awb") ~= 0 then
					local var_50_13 = manager.audio:GetVoiceLength("story_v_out_117122", "117122012", "story_v_out_117122.awb") / 1000

					if var_50_13 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_7
					end

					if var_50_9.prefab_name ~= "" and arg_47_1.actors_[var_50_9.prefab_name] ~= nil then
						local var_50_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_9.prefab_name].transform, "story_v_out_117122", "117122012", "story_v_out_117122.awb")

						arg_47_1:RecordAudio("117122012", var_50_14)
						arg_47_1:RecordAudio("117122012", var_50_14)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_117122", "117122012", "story_v_out_117122.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_117122", "117122012", "story_v_out_117122.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_15 and arg_47_1.time_ < var_50_7 + var_50_15 + arg_50_0 then
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
	Play117122013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 117122013
		arg_51_1.duration_ = 14.67

		local var_51_0 = {
			zh = 10.7,
			ja = 14.666
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
				arg_51_0:Play117122014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
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

				local var_54_1 = arg_51_1:GetWordFromCfg(117122013)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 50 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 50)

				if (50 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 50)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122013", "story_v_out_117122.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122013", "story_v_out_117122.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_117122", "117122013", "story_v_out_117122.awb")

						arg_51_1:RecordAudio("117122013", var_54_6)
						arg_51_1:RecordAudio("117122013", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_117122", "117122013", "story_v_out_117122.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_117122", "117122013", "story_v_out_117122.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play117122014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 117122014
		arg_55_1.duration_ = 14.57

		local var_55_0 = {
			zh = 13.333,
			ja = 14.566
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
				arg_55_0:Play117122015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(117122014)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 67 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 67)

				if (67 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 67)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122014", "story_v_out_117122.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122014", "story_v_out_117122.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_117122", "117122014", "story_v_out_117122.awb")

						arg_55_1:RecordAudio("117122014", var_58_6)
						arg_55_1:RecordAudio("117122014", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_117122", "117122014", "story_v_out_117122.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_117122", "117122014", "story_v_out_117122.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play117122015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 117122015
		arg_59_1.duration_ = 11.67

		local var_59_0 = {
			zh = 9.766,
			ja = 11.666
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
				arg_59_0:Play117122016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1033 = arg_59_1.actors_["1033"].transform.localPosition
				arg_59_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1033", 3)

				for iter_62_0 = 0, arg_59_1.actors_["1033"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["1033"].transform:GetChild(iter_62_0)

					if var_62_0.name == "split_6" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_62_2 = 0
			local var_62_3 = 1.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(117122015)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 51 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 51)

				if (51 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 51)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122015", "story_v_out_117122.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_117122", "117122015", "story_v_out_117122.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_117122", "117122015", "story_v_out_117122.awb")

						arg_59_1:RecordAudio("117122015", var_62_9)
						arg_59_1:RecordAudio("117122015", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_117122", "117122015", "story_v_out_117122.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_117122", "117122015", "story_v_out_117122.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play117122016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 117122016
		arg_63_1.duration_ = 6.7

		local var_63_0 = {
			zh = 6.066,
			ja = 6.7
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
				arg_63_0:Play117122017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.75

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(117122016)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)

				if (30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122016", "story_v_out_117122.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122016", "story_v_out_117122.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_117122", "117122016", "story_v_out_117122.awb")

						arg_63_1:RecordAudio("117122016", var_66_6)
						arg_63_1:RecordAudio("117122016", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_117122", "117122016", "story_v_out_117122.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_117122", "117122016", "story_v_out_117122.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play117122017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 117122017
		arg_67_1.duration_ = 3.13

		local var_67_0 = {
			zh = 2.933,
			ja = 3.133
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
				arg_67_0:Play117122018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1033 = arg_67_1.actors_["1033"].transform.localPosition
				arg_67_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1033", 4)

				for iter_70_0 = 0, arg_67_1.actors_["1033"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["1033"].transform:GetChild(iter_70_0)

					if var_70_0.name == "split_6" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_70_2 = arg_67_1.actors_["1132"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1132 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1132", 2)

				for iter_70_1 = 0, var_70_2.childCount - 1 do
					local var_70_3 = var_70_2:GetChild(iter_70_1)

					if var_70_3.name == "split_6" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_67_1.time_ - 0) / var_70_4)
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_70_5 = arg_67_1.actors_["1132"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps1132 == nil then
				arg_67_1.var_.actorSpriteComps1132 = var_70_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_6 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.actorSpriteComps1132 then
					for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_70_3 then
							if arg_67_1.isInRecall_ then
								iter_70_3.color = Color.New(Mathf.Lerp(iter_70_3.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_6), Mathf.Lerp(iter_70_3.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_6), (Mathf.Lerp(iter_70_3.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_6)))
							else
								local var_70_7 = Mathf.Lerp(iter_70_3.color.r, 1, (arg_67_1.time_ - 0) / var_70_6)

								iter_70_3.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps1132 then
				for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_70_5 then
						iter_70_5.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1132 = nil
			end

			local var_70_8 = arg_67_1.actors_["1033"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1033 == nil then
				arg_67_1.var_.actorSpriteComps1033 = var_70_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_9 and not isNil(var_70_8) then
				if arg_67_1.var_.actorSpriteComps1033 then
					for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_70_7 then
							if arg_67_1.isInRecall_ then
								iter_70_7.color = Color.New(Mathf.Lerp(iter_70_7.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_9), Mathf.Lerp(iter_70_7.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_9), (Mathf.Lerp(iter_70_7.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_9)))
							else
								local var_70_10 = Mathf.Lerp(iter_70_7.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_9)

								iter_70_7.color = Color.New(var_70_10, var_70_10, var_70_10)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_9 and arg_67_1.time_ < 0 + var_70_9 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1033 then
				for iter_70_8, iter_70_9 in pairs(arg_67_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_70_9 then
						iter_70_9.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				local var_70_11 = arg_67_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_70_11 then
					arg_67_1.var_.alphaOldValue1132 = var_70_11.alpha
					arg_67_1.var_.characterEffect1132 = var_70_11
				end

				arg_67_1.var_.alphaOldValue1132 = 0
			end

			local var_70_12 = 0.5

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_12 then
				if arg_67_1.var_.characterEffect1132 then
					arg_67_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_67_1.var_.alphaOldValue1132, 1, (arg_67_1.time_ - 0) / var_70_12)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_12 and arg_67_1.time_ < 0 + var_70_12 + arg_70_0 and arg_67_1.var_.characterEffect1132 then
				arg_67_1.var_.characterEffect1132.alpha = 1
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				local var_70_13 = arg_67_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_70_13 then
					arg_67_1.var_.alphaOldValue1033 = var_70_13.alpha
					arg_67_1.var_.characterEffect1033 = var_70_13
				end

				arg_67_1.var_.alphaOldValue1033 = 0
			end

			local var_70_14 = 0.5

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_14 then
				if arg_67_1.var_.characterEffect1033 then
					arg_67_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_67_1.var_.alphaOldValue1033, 1, (arg_67_1.time_ - 0) / var_70_14)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_14 and arg_67_1.time_ < 0 + var_70_14 + arg_70_0 and arg_67_1.var_.characterEffect1033 then
				arg_67_1.var_.characterEffect1033.alpha = 1
			end

			local var_70_15 = 0
			local var_70_16 = 0.2

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_17 = arg_67_1:GetWordFromCfg(117122017)
				local var_70_18 = arg_67_1:FormatText(var_70_17.content)

				arg_67_1.text_.text = var_70_18

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 8 <= 0 and var_70_16 or var_70_16 * (utf8.len(var_70_18) / 8)

				if (8 <= 0 and var_70_16 or var_70_16 * (utf8.len(var_70_18) / 8)) > 0 and var_70_16 < var_70_20 then
					arg_67_1.talkMaxDuration = var_70_20

					if var_70_20 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_18
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122017", "story_v_out_117122.awb") ~= 0 then
					local var_70_21 = manager.audio:GetVoiceLength("story_v_out_117122", "117122017", "story_v_out_117122.awb") / 1000

					if var_70_21 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_15
					end

					if var_70_17.prefab_name ~= "" and arg_67_1.actors_[var_70_17.prefab_name] ~= nil then
						local var_70_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_17.prefab_name].transform, "story_v_out_117122", "117122017", "story_v_out_117122.awb")

						arg_67_1:RecordAudio("117122017", var_70_22)
						arg_67_1:RecordAudio("117122017", var_70_22)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_117122", "117122017", "story_v_out_117122.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_117122", "117122017", "story_v_out_117122.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_23 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_23 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_23

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_23 and arg_67_1.time_ < var_70_15 + var_70_23 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
				actorName = "1132",
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
	Play117122018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 117122018
		arg_71_1.duration_ = 10.2

		local var_71_0 = {
			zh = 5.633,
			ja = 10.2
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play117122019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1033 = arg_71_1.actors_["1033"].transform.localPosition
				arg_71_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1033", 4)

				for iter_74_0 = 0, arg_71_1.actors_["1033"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["1033"].transform:GetChild(iter_74_0)

					if var_74_0.name == "split_6" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_74_2 = arg_71_1.actors_["1132"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1132 == nil then
				arg_71_1.var_.actorSpriteComps1132 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps1132 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								iter_74_2.color = Color.New(Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_2.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_2.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1132 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_74_4 then
						iter_74_4.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps1132 = nil
			end

			local var_74_5 = arg_71_1.actors_["1033"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps1033 == nil then
				arg_71_1.var_.actorSpriteComps1033 = var_74_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_6 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.actorSpriteComps1033 then
					for iter_74_5, iter_74_6 in pairs(arg_71_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_74_6 then
							if arg_71_1.isInRecall_ then
								iter_74_6.color = Color.New(Mathf.Lerp(iter_74_6.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_6), Mathf.Lerp(iter_74_6.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_6), (Mathf.Lerp(iter_74_6.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_6)))
							else
								local var_74_7 = Mathf.Lerp(iter_74_6.color.r, 1, (arg_71_1.time_ - 0) / var_74_6)

								iter_74_6.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps1033 then
				for iter_74_7, iter_74_8 in pairs(arg_71_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_74_8 then
						iter_74_8.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps1033 = nil
			end

			local var_74_8 = 0
			local var_74_9 = 0.75

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(117122018)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 30 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 30)

				if (30 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 30)) > 0 and var_74_9 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122018", "story_v_out_117122.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_117122", "117122018", "story_v_out_117122.awb") / 1000

					if var_74_14 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_8
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_117122", "117122018", "story_v_out_117122.awb")

						arg_71_1:RecordAudio("117122018", var_74_15)
						arg_71_1:RecordAudio("117122018", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_117122", "117122018", "story_v_out_117122.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_117122", "117122018", "story_v_out_117122.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play117122019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 117122019
		arg_75_1.duration_ = 2.83

		local var_75_0 = {
			zh = 2.233,
			ja = 2.833
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play117122020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1132"]) and arg_75_1.var_.actorSpriteComps1132 == nil then
				arg_75_1.var_.actorSpriteComps1132 = arg_75_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1132"]) then
				if arg_75_1.var_.actorSpriteComps1132 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 1, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1132"]) and arg_75_1.var_.actorSpriteComps1132 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1132 = nil
			end

			local var_78_2 = arg_75_1.actors_["1033"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1033 == nil then
				arg_75_1.var_.actorSpriteComps1033 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1033 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								iter_78_5.color = Color.New(Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_5.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_5.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1033 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_78_7 then
						iter_78_7.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps1033 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.175

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(117122019)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 7 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 7)

				if (7 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 7)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122019", "story_v_out_117122.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_117122", "117122019", "story_v_out_117122.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_117122", "117122019", "story_v_out_117122.awb")

						arg_75_1:RecordAudio("117122019", var_78_12)
						arg_75_1:RecordAudio("117122019", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_117122", "117122019", "story_v_out_117122.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_117122", "117122019", "story_v_out_117122.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play117122020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 117122020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play117122021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1132"]) and arg_79_1.var_.actorSpriteComps1132 == nil then
				arg_79_1.var_.actorSpriteComps1132 = arg_79_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1132"]) then
				if arg_79_1.var_.actorSpriteComps1132 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1132"]) and arg_79_1.var_.actorSpriteComps1132 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1132 = nil
			end

			local var_82_2 = arg_79_1.actors_["1033"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1033 == nil then
				arg_79_1.var_.actorSpriteComps1033 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps1033 then
					for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_82_5 then
							if arg_79_1.isInRecall_ then
								iter_82_5.color = Color.New(Mathf.Lerp(iter_82_5.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_5.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_5.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_5.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_5.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1033 then
				for iter_82_6, iter_82_7 in pairs(arg_79_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_82_7 then
						iter_82_7.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1033 = nil
			end

			local var_82_5 = 0
			local var_82_6 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(117122020).content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 8 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 8)

				if (8 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 8)) > 0 and var_82_6 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_10 and arg_79_1.time_ < var_82_5 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play117122021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 117122021
		arg_83_1.duration_ = 11.23

		local var_83_0 = {
			zh = 11.233,
			ja = 6.266
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play117122022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1132"]) and arg_83_1.var_.actorSpriteComps1132 == nil then
				arg_83_1.var_.actorSpriteComps1132 = arg_83_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1132"]) then
				if arg_83_1.var_.actorSpriteComps1132 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 1, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1132"]) and arg_83_1.var_.actorSpriteComps1132 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps1132 = nil
			end

			local var_86_2 = 0
			local var_86_3 = 0.7

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(117122021)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 28 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 28)

				if (28 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 28)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122021", "story_v_out_117122.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_117122", "117122021", "story_v_out_117122.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_117122", "117122021", "story_v_out_117122.awb")

						arg_83_1:RecordAudio("117122021", var_86_9)
						arg_83_1:RecordAudio("117122021", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_117122", "117122021", "story_v_out_117122.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_117122", "117122021", "story_v_out_117122.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play117122022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 117122022
		arg_87_1.duration_ = 10.83

		local var_87_0 = {
			zh = 10.833,
			ja = 7.5
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play117122023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.925

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(117122022)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 37 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 37)

				if (37 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 37)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122022", "story_v_out_117122.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122022", "story_v_out_117122.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_117122", "117122022", "story_v_out_117122.awb")

						arg_87_1:RecordAudio("117122022", var_90_6)
						arg_87_1:RecordAudio("117122022", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_117122", "117122022", "story_v_out_117122.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_117122", "117122022", "story_v_out_117122.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play117122023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 117122023
		arg_91_1.duration_ = 11.17

		local var_91_0 = {
			zh = 11.166,
			ja = 6.2
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play117122024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.175

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(117122023)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 47 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 47)

				if (47 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 47)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122023", "story_v_out_117122.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122023", "story_v_out_117122.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_117122", "117122023", "story_v_out_117122.awb")

						arg_91_1:RecordAudio("117122023", var_94_6)
						arg_91_1:RecordAudio("117122023", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_117122", "117122023", "story_v_out_117122.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_117122", "117122023", "story_v_out_117122.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play117122024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 117122024
		arg_95_1.duration_ = 7.53

		local var_95_0 = {
			zh = 7.533,
			ja = 5.433
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play117122025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1033 = arg_95_1.actors_["1033"].transform.localPosition
				arg_95_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1033", 4)

				for iter_98_0 = 0, arg_95_1.actors_["1033"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1033"].transform:GetChild(iter_98_0)

					if var_98_0.name == "split_6" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_98_2 = arg_95_1.actors_["1132"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1132 == nil then
				arg_95_1.var_.actorSpriteComps1132 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps1132 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1132 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps1132 = nil
			end

			local var_98_5 = arg_95_1.actors_["1033"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1033 == nil then
				arg_95_1.var_.actorSpriteComps1033 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps1033 then
					for iter_98_5, iter_98_6 in pairs(arg_95_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_98_6 then
							if arg_95_1.isInRecall_ then
								iter_98_6.color = Color.New(Mathf.Lerp(iter_98_6.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_6), Mathf.Lerp(iter_98_6.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_6), (Mathf.Lerp(iter_98_6.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_6.color.r, 1, (arg_95_1.time_ - 0) / var_98_6)

								iter_98_6.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1033 then
				for iter_98_7, iter_98_8 in pairs(arg_95_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_98_8 then
						iter_98_8.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps1033 = nil
			end

			local var_98_8 = 0
			local var_98_9 = 1.05

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
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

				local var_98_10 = arg_95_1:GetWordFromCfg(117122024)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 42 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 42)

				if (42 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 42)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122024", "story_v_out_117122.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_117122", "117122024", "story_v_out_117122.awb") / 1000

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_117122", "117122024", "story_v_out_117122.awb")

						arg_95_1:RecordAudio("117122024", var_98_15)
						arg_95_1:RecordAudio("117122024", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_117122", "117122024", "story_v_out_117122.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_117122", "117122024", "story_v_out_117122.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_16 and arg_95_1.time_ < var_98_8 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play117122025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 117122025
		arg_99_1.duration_ = 5.6

		local var_99_0 = {
			zh = 5.6,
			ja = 4.366
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
				arg_99_0:Play117122026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.675

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(117122025)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 27 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 27)

				if (27 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 27)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122025", "story_v_out_117122.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122025", "story_v_out_117122.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_117122", "117122025", "story_v_out_117122.awb")

						arg_99_1:RecordAudio("117122025", var_102_6)
						arg_99_1:RecordAudio("117122025", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_117122", "117122025", "story_v_out_117122.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_117122", "117122025", "story_v_out_117122.awb")
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
	Play117122026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 117122026
		arg_103_1.duration_ = 7.37

		local var_103_0 = {
			zh = 7.366,
			ja = 4.1
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play117122027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1132"]) and arg_103_1.var_.actorSpriteComps1132 == nil then
				arg_103_1.var_.actorSpriteComps1132 = arg_103_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1132"]) then
				if arg_103_1.var_.actorSpriteComps1132 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1132"]) and arg_103_1.var_.actorSpriteComps1132 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1132 = nil
			end

			local var_106_2 = arg_103_1.actors_["1033"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1033 == nil then
				arg_103_1.var_.actorSpriteComps1033 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1033 then
					for iter_106_4, iter_106_5 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_106_5 then
							if arg_103_1.isInRecall_ then
								iter_106_5.color = Color.New(Mathf.Lerp(iter_106_5.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_3), Mathf.Lerp(iter_106_5.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_3), (Mathf.Lerp(iter_106_5.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_3)))
							else
								local var_106_4 = Mathf.Lerp(iter_106_5.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_3)

								iter_106_5.color = Color.New(var_106_4, var_106_4, var_106_4)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1033 then
				for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_106_7 then
						iter_106_7.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps1033 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 0.6

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(117122026)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 24 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 24)

				if (24 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 24)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122026", "story_v_out_117122.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_117122", "117122026", "story_v_out_117122.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_117122", "117122026", "story_v_out_117122.awb")

						arg_103_1:RecordAudio("117122026", var_106_12)
						arg_103_1:RecordAudio("117122026", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_117122", "117122026", "story_v_out_117122.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_117122", "117122026", "story_v_out_117122.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play117122027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 117122027
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play117122028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1132"]) and arg_107_1.var_.actorSpriteComps1132 == nil then
				arg_107_1.var_.actorSpriteComps1132 = arg_107_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1132"]) then
				if arg_107_1.var_.actorSpriteComps1132 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1132"]) and arg_107_1.var_.actorSpriteComps1132 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1132 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.55

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(117122027).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 22 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 22)

				if (22 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 22)) > 0 and var_110_3 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_7 and arg_107_1.time_ < var_110_2 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play117122028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 117122028
		arg_111_1.duration_ = 4.87

		local var_111_0 = {
			zh = 4.866,
			ja = 3.7
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play117122029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1132"]) and arg_111_1.var_.actorSpriteComps1132 == nil then
				arg_111_1.var_.actorSpriteComps1132 = arg_111_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1132"]) then
				if arg_111_1.var_.actorSpriteComps1132 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1132"]) and arg_111_1.var_.actorSpriteComps1132 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1132 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.4

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(117122028)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 16 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 16)

				if (16 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 16)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122028", "story_v_out_117122.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_117122", "117122028", "story_v_out_117122.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_117122", "117122028", "story_v_out_117122.awb")

						arg_111_1:RecordAudio("117122028", var_114_9)
						arg_111_1:RecordAudio("117122028", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_117122", "117122028", "story_v_out_117122.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_117122", "117122028", "story_v_out_117122.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play117122029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 117122029
		arg_115_1.duration_ = 8.3

		local var_115_0 = {
			zh = 6.2,
			ja = 8.3
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play117122030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1132"]) and arg_115_1.var_.actorSpriteComps1132 == nil then
				arg_115_1.var_.actorSpriteComps1132 = arg_115_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1132"]) then
				if arg_115_1.var_.actorSpriteComps1132 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1132"]) and arg_115_1.var_.actorSpriteComps1132 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1132 = nil
			end

			local var_118_2 = arg_115_1.actors_["1033"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1033 == nil then
				arg_115_1.var_.actorSpriteComps1033 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps1033 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								iter_118_5.color = Color.New(Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_5.color.r, 1, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_5.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1033 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_118_7 then
						iter_118_7.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps1033 = nil
			end

			local var_118_5 = 0
			local var_118_6 = 0.575

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(117122029)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 23 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 23)

				if (23 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 23)) > 0 and var_118_6 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122029", "story_v_out_117122.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_out_117122", "117122029", "story_v_out_117122.awb") / 1000

					if var_118_11 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_5
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_117122", "117122029", "story_v_out_117122.awb")

						arg_115_1:RecordAudio("117122029", var_118_12)
						arg_115_1:RecordAudio("117122029", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_117122", "117122029", "story_v_out_117122.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_117122", "117122029", "story_v_out_117122.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_13 and arg_115_1.time_ < var_118_5 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play117122030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 117122030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play117122031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 == nil then
				arg_119_1.var_.actorSpriteComps1033 = arg_119_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1033"]) then
				if arg_119_1.var_.actorSpriteComps1033 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps1033 = nil
			end

			local var_122_2 = 0
			local var_122_3 = 1.025

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(117122030).content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 41 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 41)

				if (41 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 41)) > 0 and var_122_3 < var_122_6 then
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

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play117122031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 117122031
		arg_123_1.duration_ = 2.47

		local var_123_0 = {
			zh = 2.466,
			ja = 2.1
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play117122032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1033 = arg_123_1.actors_["1033"].transform.localPosition
				arg_123_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1033", 7)

				for iter_126_0 = 0, arg_123_1.actors_["1033"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["1033"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_4" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_2 = arg_123_1.actors_["10035"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10035 == nil then
				arg_123_1.var_.actorSpriteComps10035 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10035 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								iter_126_2.color = Color.New(Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_2.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_2.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10035 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_5 = arg_123_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_5 then
					arg_123_1.var_.alphaOldValue10035 = var_126_5.alpha
					arg_123_1.var_.characterEffect10035 = var_126_5
				end

				arg_123_1.var_.alphaOldValue10035 = 0
			end

			local var_126_6 = 0.333333333333333

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 then
				if arg_123_1.var_.characterEffect10035 then
					arg_123_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue10035, 1, (arg_123_1.time_ - 0) / var_126_6)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and arg_123_1.var_.characterEffect10035 then
				arg_123_1.var_.characterEffect10035.alpha = 1
			end

			local var_126_7 = 0
			local var_126_8 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_4")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_9 = arg_123_1:GetWordFromCfg(117122031)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 10 <= 0 and var_126_8 or var_126_8 * (utf8.len(var_126_10) / 10)

				if (10 <= 0 and var_126_8 or var_126_8 * (utf8.len(var_126_10) / 10)) > 0 and var_126_8 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122031", "story_v_out_117122.awb") ~= 0 then
					local var_126_13 = manager.audio:GetVoiceLength("story_v_out_117122", "117122031", "story_v_out_117122.awb") / 1000

					if var_126_13 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_7
					end

					if var_126_9.prefab_name ~= "" and arg_123_1.actors_[var_126_9.prefab_name] ~= nil then
						local var_126_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_9.prefab_name].transform, "story_v_out_117122", "117122031", "story_v_out_117122.awb")

						arg_123_1:RecordAudio("117122031", var_126_14)
						arg_123_1:RecordAudio("117122031", var_126_14)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_117122", "117122031", "story_v_out_117122.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_117122", "117122031", "story_v_out_117122.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_15 and arg_123_1.time_ < var_126_7 + var_126_15 + arg_126_0 then
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
	Play117122032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 117122032
		arg_127_1.duration_ = 1.8

		local var_127_0 = {
			zh = 1.8,
			ja = 1.433
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
				arg_127_0:Play117122033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1132"]) and arg_127_1.var_.actorSpriteComps1132 == nil then
				arg_127_1.var_.actorSpriteComps1132 = arg_127_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1132"]) then
				if arg_127_1.var_.actorSpriteComps1132 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1132"]) and arg_127_1.var_.actorSpriteComps1132 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1132 = nil
			end

			local var_130_2 = arg_127_1.actors_["10035"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10035 == nil then
				arg_127_1.var_.actorSpriteComps10035 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10035 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								iter_130_5.color = Color.New(Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_5.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_5.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10035 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_130_7 then
						iter_130_7.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10035 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 0.1

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(117122032)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 4 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 4)

				if (4 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 4)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122032", "story_v_out_117122.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_117122", "117122032", "story_v_out_117122.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_117122", "117122032", "story_v_out_117122.awb")

						arg_127_1:RecordAudio("117122032", var_130_12)
						arg_127_1:RecordAudio("117122032", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_117122", "117122032", "story_v_out_117122.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_117122", "117122032", "story_v_out_117122.awb")
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

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play117122033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 117122033
		arg_131_1.duration_ = 3.57

		local var_131_0 = {
			zh = 3.566,
			ja = 2.666
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
				arg_131_0:Play117122034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.325

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(117122033)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 13 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 13)

				if (13 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 13)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122033", "story_v_out_117122.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122033", "story_v_out_117122.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_117122", "117122033", "story_v_out_117122.awb")

						arg_131_1:RecordAudio("117122033", var_134_6)
						arg_131_1:RecordAudio("117122033", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_117122", "117122033", "story_v_out_117122.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_117122", "117122033", "story_v_out_117122.awb")
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
	Play117122034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 117122034
		arg_135_1.duration_ = 9.43

		local var_135_0 = {
			zh = 6,
			ja = 9.433
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play117122035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10035 = arg_135_1.actors_["10035"].transform.localPosition
				arg_135_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10035", 4)

				for iter_138_0 = 0, arg_135_1.actors_["10035"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10035"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_5" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_138_2 = arg_135_1.actors_["1132"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1132 == nil then
				arg_135_1.var_.actorSpriteComps1132 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1132 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1132 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1132 = nil
			end

			local var_138_5 = arg_135_1.actors_["10035"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10035 == nil then
				arg_135_1.var_.actorSpriteComps10035 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps10035 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 1, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10035 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_8 = arg_135_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_8 then
					arg_135_1.var_.alphaOldValue10035 = var_138_8.alpha
					arg_135_1.var_.characterEffect10035 = var_138_8
				end

				arg_135_1.var_.alphaOldValue10035 = 0
			end

			local var_138_9 = 0.0166666666666667

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 then
				if arg_135_1.var_.characterEffect10035 then
					arg_135_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_135_1.var_.alphaOldValue10035, 1, (arg_135_1.time_ - 0) / var_138_9)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 and arg_135_1.var_.characterEffect10035 then
				arg_135_1.var_.characterEffect10035.alpha = 1
			end

			local var_138_10 = 0
			local var_138_11 = 0.775

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(117122034)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 31 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 31)

				if (31 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 31)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122034", "story_v_out_117122.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_117122", "117122034", "story_v_out_117122.awb") / 1000

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_117122", "117122034", "story_v_out_117122.awb")

						arg_135_1:RecordAudio("117122034", var_138_17)
						arg_135_1:RecordAudio("117122034", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_117122", "117122034", "story_v_out_117122.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_117122", "117122034", "story_v_out_117122.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_18 and arg_135_1.time_ < var_138_10 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play117122035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 117122035
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play117122036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_0 = arg_139_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_0 then
					arg_139_1.var_.alphaOldValue1132 = var_142_0.alpha
					arg_139_1.var_.characterEffect1132 = var_142_0
				end

				arg_139_1.var_.alphaOldValue1132 = 1
			end

			local var_142_1 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				if arg_139_1.var_.characterEffect1132 then
					arg_139_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_139_1.var_.alphaOldValue1132, 0, (arg_139_1.time_ - 0) / var_142_1)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 and arg_139_1.var_.characterEffect1132 then
				arg_139_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_2 = arg_139_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_2 then
					arg_139_1.var_.alphaOldValue10035 = var_142_2.alpha
					arg_139_1.var_.characterEffect10035 = var_142_2
				end

				arg_139_1.var_.alphaOldValue10035 = 1
			end

			local var_142_3 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 then
				if arg_139_1.var_.characterEffect10035 then
					arg_139_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_139_1.var_.alphaOldValue10035, 0, (arg_139_1.time_ - 0) / var_142_3)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and arg_139_1.var_.characterEffect10035 then
				arg_139_1.var_.characterEffect10035.alpha = 0
			end

			local var_142_4 = 0
			local var_142_5 = 1.375

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(117122035).content)

				arg_139_1.text_.text = var_142_6

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_8 = 55 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_6) / 55)

				if (55 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_6) / 55)) > 0 and var_142_5 < var_142_8 then
					arg_139_1.talkMaxDuration = var_142_8

					if var_142_8 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_6
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_9 and arg_139_1.time_ < var_142_4 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play117122036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 117122036
		arg_143_1.duration_ = 11.73

		local var_143_0 = {
			zh = 8.7,
			ja = 11.733
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
				arg_143_0:Play117122037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10035 = arg_143_1.actors_["10035"].transform.localPosition
				arg_143_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10035", 4)

				for iter_146_0 = 0, arg_143_1.actors_["10035"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10035"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_4" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_146_2 = arg_143_1.actors_["1132"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1132 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1132", 2)

				for iter_146_1 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_1)

					if var_146_3.name == "split_6" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_146_5 = arg_143_1.actors_["1132"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps1132 == nil then
				arg_143_1.var_.actorSpriteComps1132 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps1132 then
					for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_146_3 then
							if arg_143_1.isInRecall_ then
								iter_146_3.color = Color.New(Mathf.Lerp(iter_146_3.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_3.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_3.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_3.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_3.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps1132 then
				for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_146_5 then
						iter_146_5.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1132 = nil
			end

			local var_146_8 = arg_143_1.actors_["10035"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10035 == nil then
				arg_143_1.var_.actorSpriteComps10035 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_9 and not isNil(var_146_8) then
				if arg_143_1.var_.actorSpriteComps10035 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_146_7 then
							if arg_143_1.isInRecall_ then
								iter_146_7.color = Color.New(Mathf.Lerp(iter_146_7.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_9), Mathf.Lerp(iter_146_7.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_9), (Mathf.Lerp(iter_146_7.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_9)))
							else
								local var_146_10 = Mathf.Lerp(iter_146_7.color.r, 1, (arg_143_1.time_ - 0) / var_146_9)

								iter_146_7.color = Color.New(var_146_10, var_146_10, var_146_10)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_9 and arg_143_1.time_ < 0 + var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps10035 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_146_9 then
						iter_146_9.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_11 = arg_143_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_11 then
					arg_143_1.var_.alphaOldValue1132 = var_146_11.alpha
					arg_143_1.var_.characterEffect1132 = var_146_11
				end

				arg_143_1.var_.alphaOldValue1132 = 0
			end

			local var_146_12 = 0.5

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_12 then
				if arg_143_1.var_.characterEffect1132 then
					arg_143_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_143_1.var_.alphaOldValue1132, 1, (arg_143_1.time_ - 0) / var_146_12)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_12 and arg_143_1.time_ < 0 + var_146_12 + arg_146_0 and arg_143_1.var_.characterEffect1132 then
				arg_143_1.var_.characterEffect1132.alpha = 1
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_13 = arg_143_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_13 then
					arg_143_1.var_.alphaOldValue10035 = var_146_13.alpha
					arg_143_1.var_.characterEffect10035 = var_146_13
				end

				arg_143_1.var_.alphaOldValue10035 = 0
			end

			local var_146_14 = 0.5

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_14 then
				if arg_143_1.var_.characterEffect10035 then
					arg_143_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_143_1.var_.alphaOldValue10035, 1, (arg_143_1.time_ - 0) / var_146_14)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_14 and arg_143_1.time_ < 0 + var_146_14 + arg_146_0 and arg_143_1.var_.characterEffect10035 then
				arg_143_1.var_.characterEffect10035.alpha = 1
			end

			local var_146_15 = 0
			local var_146_16 = 1.15

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_17 = arg_143_1:GetWordFromCfg(117122036)
				local var_146_18 = arg_143_1:FormatText(var_146_17.content)

				arg_143_1.text_.text = var_146_18

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 46 <= 0 and var_146_16 or var_146_16 * (utf8.len(var_146_18) / 46)

				if (46 <= 0 and var_146_16 or var_146_16 * (utf8.len(var_146_18) / 46)) > 0 and var_146_16 < var_146_20 then
					arg_143_1.talkMaxDuration = var_146_20

					if var_146_20 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_20 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_18
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122036", "story_v_out_117122.awb") ~= 0 then
					local var_146_21 = manager.audio:GetVoiceLength("story_v_out_117122", "117122036", "story_v_out_117122.awb") / 1000

					if var_146_21 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_21 + var_146_15
					end

					if var_146_17.prefab_name ~= "" and arg_143_1.actors_[var_146_17.prefab_name] ~= nil then
						local var_146_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_17.prefab_name].transform, "story_v_out_117122", "117122036", "story_v_out_117122.awb")

						arg_143_1:RecordAudio("117122036", var_146_22)
						arg_143_1:RecordAudio("117122036", var_146_22)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_117122", "117122036", "story_v_out_117122.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_117122", "117122036", "story_v_out_117122.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_23 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_23 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_23

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_23 and arg_143_1.time_ < var_146_15 + var_146_23 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play117122037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 117122037
		arg_147_1.duration_ = 8.4

		local var_147_0 = {
			zh = 4.133,
			ja = 8.4
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
				arg_147_0:Play117122038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.475

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(117122037)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 19 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 19)

				if (19 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 19)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122037", "story_v_out_117122.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122037", "story_v_out_117122.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_117122", "117122037", "story_v_out_117122.awb")

						arg_147_1:RecordAudio("117122037", var_150_6)
						arg_147_1:RecordAudio("117122037", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_117122", "117122037", "story_v_out_117122.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_117122", "117122037", "story_v_out_117122.awb")
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
	Play117122038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 117122038
		arg_151_1.duration_ = 13.43

		local var_151_0 = {
			zh = 6.833,
			ja = 13.433
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
				arg_151_0:Play117122039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.8

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(117122038)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 32)

				if (32 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 32)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122038", "story_v_out_117122.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122038", "story_v_out_117122.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_117122", "117122038", "story_v_out_117122.awb")

						arg_151_1:RecordAudio("117122038", var_154_6)
						arg_151_1:RecordAudio("117122038", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_117122", "117122038", "story_v_out_117122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_117122", "117122038", "story_v_out_117122.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play117122039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 117122039
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play117122040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10035"]) and arg_155_1.var_.actorSpriteComps10035 == nil then
				arg_155_1.var_.actorSpriteComps10035 = arg_155_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10035"]) then
				if arg_155_1.var_.actorSpriteComps10035 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10035"]) and arg_155_1.var_.actorSpriteComps10035 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10035 = nil
			end

			local var_158_2 = 0
			local var_158_3 = 1.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(117122039).content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 46 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 46)

				if (46 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 46)) > 0 and var_158_3 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_7 and arg_155_1.time_ < var_158_2 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play117122040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 117122040
		arg_159_1.duration_ = 5.33

		local var_159_0 = {
			zh = 5.333,
			ja = 3.333
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
				arg_159_0:Play117122041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10035 = arg_159_1.actors_["10035"].transform.localPosition
				arg_159_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10035", 4)

				for iter_162_0 = 0, arg_159_1.actors_["10035"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10035"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_4" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_162_2 = arg_159_1.actors_["1132"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1132 = var_162_2.localPosition
				var_162_2.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1132", 2)

				for iter_162_1 = 0, var_162_2.childCount - 1 do
					local var_162_3 = var_162_2:GetChild(iter_162_1)

					if var_162_3.name == "split_1" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_2.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_159_1.time_ - 0) / var_162_4)
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_2.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_162_5 = arg_159_1.actors_["1132"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps1132 == nil then
				arg_159_1.var_.actorSpriteComps1132 = var_162_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_6 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.actorSpriteComps1132 then
					for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_162_3 then
							if arg_159_1.isInRecall_ then
								iter_162_3.color = Color.New(Mathf.Lerp(iter_162_3.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_6), Mathf.Lerp(iter_162_3.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_6), (Mathf.Lerp(iter_162_3.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_6)))
							else
								local var_162_7 = Mathf.Lerp(iter_162_3.color.r, 1, (arg_159_1.time_ - 0) / var_162_6)

								iter_162_3.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps1132 then
				for iter_162_4, iter_162_5 in pairs(arg_159_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_162_5 then
						iter_162_5.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps1132 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.525

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(117122040)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 20 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 20)

				if (20 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 20)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122040", "story_v_out_117122.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_117122", "117122040", "story_v_out_117122.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_117122", "117122040", "story_v_out_117122.awb")

						arg_159_1:RecordAudio("117122040", var_162_15)
						arg_159_1:RecordAudio("117122040", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_117122", "117122040", "story_v_out_117122.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_117122", "117122040", "story_v_out_117122.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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
				actorName = "1132",
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
	Play117122041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 117122041
		arg_163_1.duration_ = 5.13

		local var_163_0 = {
			zh = 3.5,
			ja = 5.133
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
				arg_163_0:Play117122042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(117122041)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 12 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 12)

				if (12 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 12)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122041", "story_v_out_117122.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122041", "story_v_out_117122.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_117122", "117122041", "story_v_out_117122.awb")

						arg_163_1:RecordAudio("117122041", var_166_6)
						arg_163_1:RecordAudio("117122041", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_117122", "117122041", "story_v_out_117122.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_117122", "117122041", "story_v_out_117122.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play117122042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 117122042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play117122043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				local var_170_0 = arg_167_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_0 then
					arg_167_1.var_.alphaOldValue1132 = var_170_0.alpha
					arg_167_1.var_.characterEffect1132 = var_170_0
				end

				arg_167_1.var_.alphaOldValue1132 = 1
			end

			local var_170_1 = 0.5

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				if arg_167_1.var_.characterEffect1132 then
					arg_167_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_167_1.var_.alphaOldValue1132, 0, (arg_167_1.time_ - 0) / var_170_1)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 and arg_167_1.var_.characterEffect1132 then
				arg_167_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				local var_170_2 = arg_167_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_2 then
					arg_167_1.var_.alphaOldValue10035 = var_170_2.alpha
					arg_167_1.var_.characterEffect10035 = var_170_2
				end

				arg_167_1.var_.alphaOldValue10035 = 1
			end

			local var_170_3 = 0.5

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 then
				if arg_167_1.var_.characterEffect10035 then
					arg_167_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_167_1.var_.alphaOldValue10035, 0, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and arg_167_1.var_.characterEffect10035 then
				arg_167_1.var_.characterEffect10035.alpha = 0
			end

			local var_170_4 = 0
			local var_170_5 = 0.525

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(117122042).content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 21 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 21)

				if (21 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 21)) > 0 and var_170_5 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_9 and arg_167_1.time_ < var_170_4 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play117122043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 117122043
		arg_171_1.duration_ = 7

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play117122044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.bgs_.TI0106 == nil then
				local var_174_0 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "TI0106")
				var_174_0.name = "TI0106"
				var_174_0.transform.parent = arg_171_1.stage_.transform
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_.TI0106 = var_174_0
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				local var_174_1 = arg_171_1.bgs_.TI0106

				arg_171_1.bgs_.TI0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_2 = var_174_1:GetComponent("SpriteRenderer")

				if var_174_2 and var_174_2.sprite then
					local var_174_3 = 2 * (var_174_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_1.transform.localScale = Vector3.New(var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "TI0106" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_4 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_5 = 2

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_5 then
				local var_174_6 = Color.New(1, 1, 1)

				var_174_6.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_4) / var_174_5)
				arg_171_1.mask_.color = var_174_6
			end

			if arg_171_1.time_ >= var_174_4 + var_174_5 and arg_171_1.time_ < var_174_4 + var_174_5 + arg_174_0 then
				local var_174_7 = Color.New(1, 1, 1)

				arg_171_1.mask_.enabled = false
				var_174_7.a = 0
				arg_171_1.mask_.color = var_174_7
			end

			local var_174_8 = arg_171_1.bgs_.TI0106.transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPosTI0106 = var_174_8.localPosition
			end

			local var_174_9 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_9 then
				var_174_8.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosTI0106, Vector3.New(0, 2.5, 1), (arg_171_1.time_ - 0) / var_174_9)
			end

			if arg_171_1.time_ >= 0 + var_174_9 and arg_171_1.time_ < 0 + var_174_9 + arg_174_0 then
				var_174_8.localPosition = Vector3.New(0, 2.5, 1)
			end

			local var_174_10 = arg_171_1.bgs_.TI0106.transform

			if 0.0333333333333332 < arg_171_1.time_ and arg_171_1.time_ <= 0.0333333333333332 + arg_174_0 then
				arg_171_1.var_.moveOldPosTI0106 = var_174_10.localPosition
			end

			local var_174_11 = 3.33333333333333

			if 0.0333333333333332 <= arg_171_1.time_ and arg_171_1.time_ < 0.0333333333333332 + var_174_11 then
				var_174_10.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosTI0106, Vector3.New(0, 2.5, 2), (arg_171_1.time_ - 0.0333333333333332) / var_174_11)
			end

			if arg_171_1.time_ >= 0.0333333333333332 + var_174_11 and arg_171_1.time_ < 0.0333333333333332 + var_174_11 + arg_174_0 then
				var_174_10.localPosition = Vector3.New(0, 2.5, 2)
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_12 = 2
			local var_174_13 = 1.35

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_14 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_14:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(117122043).content)

				arg_171_1.text_.text = var_174_15

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 50 <= 0 and var_174_13 or var_174_13 * (utf8.len(var_174_15) / 50)

				if (50 <= 0 and var_174_13 or var_174_13 * (utf8.len(var_174_15) / 50)) > 0 and var_174_13 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17
					var_174_12 = var_174_12 + 0.3

					if var_174_17 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_15
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_18 = var_174_12 + 0.3
			local var_174_19 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_18) / var_174_19

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.33333333333333,
				className = "StoryMoveNode",
				startTime = 0.0333333333333332,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play117122044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 117122044
		arg_177_1.duration_ = 1.47

		local var_177_0 = {
			zh = 1.466,
			ja = 1.033
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
				arg_177_0:Play117122045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(117122044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 4 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 4)

				if (4 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 4)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122044", "story_v_out_117122.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122044", "story_v_out_117122.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_117122", "117122044", "story_v_out_117122.awb")

						arg_177_1:RecordAudio("117122044", var_180_6)
						arg_177_1:RecordAudio("117122044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_117122", "117122044", "story_v_out_117122.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_117122", "117122044", "story_v_out_117122.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play117122045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 117122045
		arg_181_1.duration_ = 5.03

		local var_181_0 = {
			zh = 5.033,
			ja = 3.433
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
				arg_181_0:Play117122046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(117122045)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)

				if (18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122045", "story_v_out_117122.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122045", "story_v_out_117122.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_117122", "117122045", "story_v_out_117122.awb")

						arg_181_1:RecordAudio("117122045", var_184_6)
						arg_181_1:RecordAudio("117122045", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_117122", "117122045", "story_v_out_117122.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_117122", "117122045", "story_v_out_117122.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play117122046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 117122046
		arg_185_1.duration_ = 1.4

		local var_185_0 = {
			zh = 1.133,
			ja = 1.4
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
				arg_185_0:Play117122047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.075

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(117122046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 3 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 3)

				if (3 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 3)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122046", "story_v_out_117122.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122046", "story_v_out_117122.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_117122", "117122046", "story_v_out_117122.awb")

						arg_185_1:RecordAudio("117122046", var_188_6)
						arg_185_1:RecordAudio("117122046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_117122", "117122046", "story_v_out_117122.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_117122", "117122046", "story_v_out_117122.awb")
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
	Play117122047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 117122047
		arg_189_1.duration_ = 4.83

		local var_189_0 = {
			zh = 4.166,
			ja = 4.833
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
				arg_189_0:Play117122048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.375

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(117122047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 15 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 15)

				if (15 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 15)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122047", "story_v_out_117122.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122047", "story_v_out_117122.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_117122", "117122047", "story_v_out_117122.awb")

						arg_189_1:RecordAudio("117122047", var_192_6)
						arg_189_1:RecordAudio("117122047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_117122", "117122047", "story_v_out_117122.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_117122", "117122047", "story_v_out_117122.awb")
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
	Play117122048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 117122048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play117122049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.05

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(117122048).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 2 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 2)

				if (2 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 2)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play117122049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 117122049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play117122050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.2

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

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(117122049).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 48 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 48)

				if (48 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 48)) > 0 and var_200_0 < var_200_3 then
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
	Play117122050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 117122050
		arg_201_1.duration_ = 8.5

		local var_201_0 = {
			zh = 2.566,
			ja = 8.5
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
				arg_201_0:Play117122051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.3

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(117122050)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 12 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 12)

				if (12 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 12)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122050", "story_v_out_117122.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122050", "story_v_out_117122.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_117122", "117122050", "story_v_out_117122.awb")

						arg_201_1:RecordAudio("117122050", var_204_6)
						arg_201_1:RecordAudio("117122050", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_117122", "117122050", "story_v_out_117122.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_117122", "117122050", "story_v_out_117122.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play117122051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 117122051
		arg_205_1.duration_ = 3

		local var_205_0 = {
			zh = 2.033,
			ja = 3
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
				arg_205_0:Play117122052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.225

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(117122051)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 9 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 9)

				if (9 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 9)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122051", "story_v_out_117122.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122051", "story_v_out_117122.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_117122", "117122051", "story_v_out_117122.awb")

						arg_205_1:RecordAudio("117122051", var_208_6)
						arg_205_1:RecordAudio("117122051", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_117122", "117122051", "story_v_out_117122.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_117122", "117122051", "story_v_out_117122.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play117122052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 117122052
		arg_209_1.duration_ = 4.6

		local var_209_0 = {
			zh = 4.6,
			ja = 4.366
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
				arg_209_0:Play117122053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(117122052)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 12 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 12)

				if (12 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 12)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122052", "story_v_out_117122.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122052", "story_v_out_117122.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_117122", "117122052", "story_v_out_117122.awb")

						arg_209_1:RecordAudio("117122052", var_212_6)
						arg_209_1:RecordAudio("117122052", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_117122", "117122052", "story_v_out_117122.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_117122", "117122052", "story_v_out_117122.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play117122053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 117122053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play117122054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.9

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(117122053).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 36)

				if (36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 36)) > 0 and var_216_0 < var_216_3 then
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
	Play117122054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 117122054
		arg_217_1.duration_ = 9.2

		local var_217_0 = {
			zh = 9.2,
			ja = 7.6
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
				arg_217_0:Play117122055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_0 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				local var_220_1 = Color.New(0, 0, 0)

				var_220_1.a = Mathf.Lerp(0, 1, (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.mask_.color = var_220_1
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				local var_220_2 = Color.New(0, 0, 0)

				var_220_2.a = 1
				arg_217_1.mask_.color = var_220_2
			end

			local var_220_3 = 2

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_4 = 2

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_4 then
				local var_220_5 = Color.New(0, 0, 0)

				var_220_5.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_3) / var_220_4)
				arg_217_1.mask_.color = var_220_5
			end

			if arg_217_1.time_ >= var_220_3 + var_220_4 and arg_217_1.time_ < var_220_3 + var_220_4 + arg_220_0 then
				local var_220_6 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_6.a = 0
				arg_217_1.mask_.color = var_220_6
			end

			local var_220_7 = arg_217_1.bgs_.TI0106.transform

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= 2 + arg_220_0 then
				arg_217_1.var_.moveOldPosTI0106 = var_220_7.localPosition
			end

			local var_220_8 = 0.001

			if 2 <= arg_217_1.time_ and arg_217_1.time_ < 2 + var_220_8 then
				var_220_7.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosTI0106, Vector3.New(0, 1, 9), (arg_217_1.time_ - 2) / var_220_8)
			end

			if arg_217_1.time_ >= 2 + var_220_8 and arg_217_1.time_ < 2 + var_220_8 + arg_220_0 then
				var_220_7.localPosition = Vector3.New(0, 1, 9)
			end

			local var_220_9 = arg_217_1.bgs_.TI0106.transform

			if 2.01666666666667 < arg_217_1.time_ and arg_217_1.time_ <= 2.01666666666667 + arg_220_0 then
				arg_217_1.var_.moveOldPosTI0106 = var_220_9.localPosition
			end

			local var_220_10 = 3

			if 2.01666666666667 <= arg_217_1.time_ and arg_217_1.time_ < 2.01666666666667 + var_220_10 then
				var_220_9.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosTI0106, Vector3.New(0, 1, 9.5), (arg_217_1.time_ - 2.01666666666667) / var_220_10)
			end

			if arg_217_1.time_ >= 2.01666666666667 + var_220_10 and arg_217_1.time_ < 2.01666666666667 + var_220_10 + arg_220_0 then
				var_220_9.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_220_11 = 4

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_11 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_11 + 1.01666666666667 and arg_217_1.time_ < var_220_11 + 1.01666666666667 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_12 = 4
			local var_220_13 = 0.425

			if 4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_14 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_14:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_15 = arg_217_1:GetWordFromCfg(117122054)
				local var_220_16 = arg_217_1:FormatText(var_220_15.content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_18 = 17 <= 0 and var_220_13 or var_220_13 * (utf8.len(var_220_16) / 17)

				if (17 <= 0 and var_220_13 or var_220_13 * (utf8.len(var_220_16) / 17)) > 0 and var_220_13 < var_220_18 then
					arg_217_1.talkMaxDuration = var_220_18
					var_220_12 = var_220_12 + 0.3

					if var_220_18 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_18 + var_220_12
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122054", "story_v_out_117122.awb") ~= 0 then
					local var_220_19 = manager.audio:GetVoiceLength("story_v_out_117122", "117122054", "story_v_out_117122.awb") / 1000

					if var_220_19 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_19 + var_220_12
					end

					if var_220_15.prefab_name ~= "" and arg_217_1.actors_[var_220_15.prefab_name] ~= nil then
						local var_220_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_15.prefab_name].transform, "story_v_out_117122", "117122054", "story_v_out_117122.awb")

						arg_217_1:RecordAudio("117122054", var_220_20)
						arg_217_1:RecordAudio("117122054", var_220_20)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_117122", "117122054", "story_v_out_117122.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_117122", "117122054", "story_v_out_117122.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_21 = var_220_12 + 0.3
			local var_220_22 = math.max(var_220_13, arg_217_1.talkMaxDuration)

			if var_220_12 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_21 + var_220_22 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_21) / var_220_22

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_21 + var_220_22 and arg_217_1.time_ < var_220_21 + var_220_22 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play117122055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 117122055
		arg_223_1.duration_ = 17.93

		local var_223_0 = {
			zh = 6.1,
			ja = 17.933
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
				arg_223_0:Play117122056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.525

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[372].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(117122055)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 21 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 21)

				if (21 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 21)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122055", "story_v_out_117122.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122055", "story_v_out_117122.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_117122", "117122055", "story_v_out_117122.awb")

						arg_223_1:RecordAudio("117122055", var_226_6)
						arg_223_1:RecordAudio("117122055", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_117122", "117122055", "story_v_out_117122.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_117122", "117122055", "story_v_out_117122.awb")
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
	Play117122056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 117122056
		arg_227_1.duration_ = 5.73

		local var_227_0 = {
			zh = 2.966,
			ja = 5.733
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
				arg_227_0:Play117122057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.15

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(117122056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 6 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 6)

				if (6 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 6)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122056", "story_v_out_117122.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_117122", "117122056", "story_v_out_117122.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_117122", "117122056", "story_v_out_117122.awb")

						arg_227_1:RecordAudio("117122056", var_230_6)
						arg_227_1:RecordAudio("117122056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_117122", "117122056", "story_v_out_117122.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_117122", "117122056", "story_v_out_117122.awb")
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
	Play117122057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 117122057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play117122058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.875

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(117122057).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 35 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 35)

				if (35 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 35)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play117122058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 117122058
		arg_235_1.duration_ = 9

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play117122059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 2 < arg_235_1.time_ and arg_235_1.time_ <= 2 + arg_238_0 then
				local var_238_0 = arg_235_1.bgs_.I08a

				arg_235_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_1 = var_238_0:GetComponent("SpriteRenderer")

				if var_238_1 and var_238_1.sprite then
					local var_238_2 = 2 * (var_238_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_0.transform.localScale = Vector3.New(var_238_2 / var_238_1.sprite.bounds.size.y < var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x and var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x or var_238_2 / var_238_1.sprite.bounds.size.y, var_238_2 / var_238_1.sprite.bounds.size.y < var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x and var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x or var_238_2 / var_238_1.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "I08a" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_3 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_4 = 2

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_4 then
				local var_238_5 = Color.New(0, 0, 0)

				var_238_5.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_3) / var_238_4)
				arg_235_1.mask_.color = var_238_5
			end

			if arg_235_1.time_ >= var_238_3 + var_238_4 and arg_235_1.time_ < var_238_3 + var_238_4 + arg_238_0 then
				local var_238_6 = Color.New(0, 0, 0)

				var_238_6.a = 1
				arg_235_1.mask_.color = var_238_6
			end

			local var_238_7 = 2

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_7 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_8 = 2

			if var_238_7 <= arg_235_1.time_ and arg_235_1.time_ < var_238_7 + var_238_8 then
				local var_238_9 = Color.New(0, 0, 0)

				var_238_9.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_7) / var_238_8)
				arg_235_1.mask_.color = var_238_9
			end

			if arg_235_1.time_ >= var_238_7 + var_238_8 and arg_235_1.time_ < var_238_7 + var_238_8 + arg_238_0 then
				local var_238_10 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_10.a = 0
				arg_235_1.mask_.color = var_238_10
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_11 = 4
			local var_238_12 = 0.8

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_13 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_13:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(117122058).content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 32 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 32)

				if (32 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 32)) > 0 and var_238_12 < var_238_16 then
					arg_235_1.talkMaxDuration = var_238_16
					var_238_11 = var_238_11 + 0.3

					if var_238_16 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_17 = var_238_11 + 0.3
			local var_238_18 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_18 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_17) / var_238_18

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_17 + var_238_18 and arg_235_1.time_ < var_238_17 + var_238_18 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play117122059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 117122059
		arg_241_1.duration_ = 5.83

		local var_241_0 = {
			zh = 4.866,
			ja = 5.833
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
				arg_241_0:Play117122060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1033 = arg_241_1.actors_["1033"].transform.localPosition
				arg_241_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1033", 3)

				for iter_244_0 = 0, arg_241_1.actors_["1033"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["1033"].transform:GetChild(iter_244_0)

					if var_244_0.name == "split_6" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_244_2 = arg_241_1.actors_["1033"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1033 == nil then
				arg_241_1.var_.actorSpriteComps1033 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps1033 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								iter_244_2.color = Color.New(Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_2.color.r, 1, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_2.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1033 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				local var_244_5 = arg_241_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_244_5 then
					arg_241_1.var_.alphaOldValue1033 = var_244_5.alpha
					arg_241_1.var_.characterEffect1033 = var_244_5
				end

				arg_241_1.var_.alphaOldValue1033 = 0
			end

			local var_244_6 = 0.333333333333333

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 then
				if arg_241_1.var_.characterEffect1033 then
					arg_241_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_241_1.var_.alphaOldValue1033, 1, (arg_241_1.time_ - 0) / var_244_6)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 and arg_241_1.var_.characterEffect1033 then
				arg_241_1.var_.characterEffect1033.alpha = 1
			end

			local var_244_7 = 0
			local var_244_8 = 0.375

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:GetWordFromCfg(117122059)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_12 = 15 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_10) / 15)

				if (15 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_10) / 15)) > 0 and var_244_8 < var_244_12 then
					arg_241_1.talkMaxDuration = var_244_12

					if var_244_12 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_7
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122059", "story_v_out_117122.awb") ~= 0 then
					local var_244_13 = manager.audio:GetVoiceLength("story_v_out_117122", "117122059", "story_v_out_117122.awb") / 1000

					if var_244_13 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_7
					end

					if var_244_9.prefab_name ~= "" and arg_241_1.actors_[var_244_9.prefab_name] ~= nil then
						local var_244_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_9.prefab_name].transform, "story_v_out_117122", "117122059", "story_v_out_117122.awb")

						arg_241_1:RecordAudio("117122059", var_244_14)
						arg_241_1:RecordAudio("117122059", var_244_14)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_117122", "117122059", "story_v_out_117122.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_117122", "117122059", "story_v_out_117122.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_15 = math.max(var_244_8, arg_241_1.talkMaxDuration)

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_15 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_7) / var_244_15

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_7 + var_244_15 and arg_241_1.time_ < var_244_7 + var_244_15 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play117122060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 117122060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play117122061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_248_0 then
					arg_245_1.var_.alphaOldValue1033 = var_248_0.alpha
					arg_245_1.var_.characterEffect1033 = var_248_0
				end

				arg_245_1.var_.alphaOldValue1033 = 1
			end

			local var_248_1 = 0.5

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				if arg_245_1.var_.characterEffect1033 then
					arg_245_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_245_1.var_.alphaOldValue1033, 0, (arg_245_1.time_ - 0) / var_248_1)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 and arg_245_1.var_.characterEffect1033 then
				arg_245_1.var_.characterEffect1033.alpha = 0
			end

			local var_248_2 = 0
			local var_248_3 = 0.925

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(117122060).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 37 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 37)

				if (37 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 37)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play117122061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 117122061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play117122062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.025

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(117122061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 41 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 41)

				if (41 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 41)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play117122062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 117122062
		arg_253_1.duration_ = 6.1

		local var_253_0 = {
			zh = 6.1,
			ja = 2.466
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
				arg_253_0:Play117122063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1132 = arg_253_1.actors_["1132"].transform.localPosition
				arg_253_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1132", 2)

				for iter_256_0 = 0, arg_253_1.actors_["1132"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1132"].transform:GetChild(iter_256_0)

					if var_256_0.name == "split_6" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_256_2 = arg_253_1.actors_["1132"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1132 == nil then
				arg_253_1.var_.actorSpriteComps1132 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1132 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								iter_256_2.color = Color.New(Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_2.color.r, 1, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_2.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1132 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1132 = nil
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_5 = arg_253_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_256_5 then
					arg_253_1.var_.alphaOldValue1132 = var_256_5.alpha
					arg_253_1.var_.characterEffect1132 = var_256_5
				end

				arg_253_1.var_.alphaOldValue1132 = 0
			end

			local var_256_6 = 0.5

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 then
				if arg_253_1.var_.characterEffect1132 then
					arg_253_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_253_1.var_.alphaOldValue1132, 1, (arg_253_1.time_ - 0) / var_256_6)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and arg_253_1.var_.characterEffect1132 then
				arg_253_1.var_.characterEffect1132.alpha = 1
			end

			local var_256_7 = 0
			local var_256_8 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(117122062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_12 = 21 <= 0 and var_256_8 or var_256_8 * (utf8.len(var_256_10) / 21)

				if (21 <= 0 and var_256_8 or var_256_8 * (utf8.len(var_256_10) / 21)) > 0 and var_256_8 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_7 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_7
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122062", "story_v_out_117122.awb") ~= 0 then
					local var_256_13 = manager.audio:GetVoiceLength("story_v_out_117122", "117122062", "story_v_out_117122.awb") / 1000

					if var_256_13 + var_256_7 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_7
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_117122", "117122062", "story_v_out_117122.awb")

						arg_253_1:RecordAudio("117122062", var_256_14)
						arg_253_1:RecordAudio("117122062", var_256_14)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_117122", "117122062", "story_v_out_117122.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_117122", "117122062", "story_v_out_117122.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_15 = math.max(var_256_8, arg_253_1.talkMaxDuration)

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_15 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_7) / var_256_15

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_7 + var_256_15 and arg_253_1.time_ < var_256_7 + var_256_15 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play117122063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 117122063
		arg_257_1.duration_ = 2.1

		local var_257_0 = {
			zh = 2.1,
			ja = 1.366
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
				arg_257_0:Play117122064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10035 = arg_257_1.actors_["10035"].transform.localPosition
				arg_257_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10035", 4)

				for iter_260_0 = 0, arg_257_1.actors_["10035"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["10035"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_4" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_260_2 = arg_257_1.actors_["1132"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1132 == nil then
				arg_257_1.var_.actorSpriteComps1132 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1132 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								iter_260_2.color = Color.New(Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_2.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_2.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1132 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps1132 = nil
			end

			local var_260_5 = arg_257_1.actors_["10035"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10035 == nil then
				arg_257_1.var_.actorSpriteComps10035 = var_260_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_6 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.actorSpriteComps10035 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_260_6 then
							if arg_257_1.isInRecall_ then
								iter_260_6.color = Color.New(Mathf.Lerp(iter_260_6.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_6), Mathf.Lerp(iter_260_6.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_6), (Mathf.Lerp(iter_260_6.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_6)))
							else
								local var_260_7 = Mathf.Lerp(iter_260_6.color.r, 1, (arg_257_1.time_ - 0) / var_260_6)

								iter_260_6.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10035 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_260_8 then
						iter_260_8.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				local var_260_8 = arg_257_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_260_8 then
					arg_257_1.var_.alphaOldValue10035 = var_260_8.alpha
					arg_257_1.var_.characterEffect10035 = var_260_8
				end

				arg_257_1.var_.alphaOldValue10035 = 0
			end

			local var_260_9 = 0.5

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_9 then
				if arg_257_1.var_.characterEffect10035 then
					arg_257_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_257_1.var_.alphaOldValue10035, 1, (arg_257_1.time_ - 0) / var_260_9)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_9 and arg_257_1.time_ < 0 + var_260_9 + arg_260_0 and arg_257_1.var_.characterEffect10035 then
				arg_257_1.var_.characterEffect10035.alpha = 1
			end

			local var_260_10 = 0
			local var_260_11 = 0.1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_12 = arg_257_1:GetWordFromCfg(117122063)
				local var_260_13 = arg_257_1:FormatText(var_260_12.content)

				arg_257_1.text_.text = var_260_13

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_15 = 4 <= 0 and var_260_11 or var_260_11 * (utf8.len(var_260_13) / 4)

				if (4 <= 0 and var_260_11 or var_260_11 * (utf8.len(var_260_13) / 4)) > 0 and var_260_11 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_10
					end
				end

				arg_257_1.text_.text = var_260_13
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122063", "story_v_out_117122.awb") ~= 0 then
					local var_260_16 = manager.audio:GetVoiceLength("story_v_out_117122", "117122063", "story_v_out_117122.awb") / 1000

					if var_260_16 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_10
					end

					if var_260_12.prefab_name ~= "" and arg_257_1.actors_[var_260_12.prefab_name] ~= nil then
						local var_260_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_12.prefab_name].transform, "story_v_out_117122", "117122063", "story_v_out_117122.awb")

						arg_257_1:RecordAudio("117122063", var_260_17)
						arg_257_1:RecordAudio("117122063", var_260_17)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_117122", "117122063", "story_v_out_117122.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_117122", "117122063", "story_v_out_117122.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = math.max(var_260_11, arg_257_1.talkMaxDuration)

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_18 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_10) / var_260_18

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_10 + var_260_18 and arg_257_1.time_ < var_260_10 + var_260_18 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play117122064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 117122064
		arg_261_1.duration_ = 5.03

		local var_261_0 = {
			zh = 3.5,
			ja = 5.033
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
				arg_261_0:Play117122065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10035 = arg_261_1.actors_["10035"].transform.localPosition
				arg_261_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10035", 4)

				for iter_264_0 = 0, arg_261_1.actors_["10035"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10035"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_4" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_264_2 = arg_261_1.actors_["1132"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1132 = var_264_2.localPosition
				var_264_2.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1132", 2)

				for iter_264_1 = 0, var_264_2.childCount - 1 do
					local var_264_3 = var_264_2:GetChild(iter_264_1)

					if var_264_3.name == "split_1" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_2.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_261_1.time_ - 0) / var_264_4)
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_2.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_264_5 = arg_261_1.actors_["1132"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1132 == nil then
				arg_261_1.var_.actorSpriteComps1132 = var_264_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_6 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.actorSpriteComps1132 then
					for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_264_3 then
							if arg_261_1.isInRecall_ then
								iter_264_3.color = Color.New(Mathf.Lerp(iter_264_3.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_6), Mathf.Lerp(iter_264_3.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_6), (Mathf.Lerp(iter_264_3.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_6)))
							else
								local var_264_7 = Mathf.Lerp(iter_264_3.color.r, 1, (arg_261_1.time_ - 0) / var_264_6)

								iter_264_3.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1132 then
				for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_264_5 then
						iter_264_5.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1132 = nil
			end

			local var_264_8 = arg_261_1.actors_["10035"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10035 == nil then
				arg_261_1.var_.actorSpriteComps10035 = var_264_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_9 and not isNil(var_264_8) then
				if arg_261_1.var_.actorSpriteComps10035 then
					for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_264_7 then
							if arg_261_1.isInRecall_ then
								iter_264_7.color = Color.New(Mathf.Lerp(iter_264_7.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_9), Mathf.Lerp(iter_264_7.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_9), (Mathf.Lerp(iter_264_7.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_9)))
							else
								local var_264_10 = Mathf.Lerp(iter_264_7.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_9)

								iter_264_7.color = Color.New(var_264_10, var_264_10, var_264_10)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_9 and arg_261_1.time_ < 0 + var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10035 then
				for iter_264_8, iter_264_9 in pairs(arg_261_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_264_9 then
						iter_264_9.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				local var_264_11 = arg_261_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_11 then
					arg_261_1.var_.alphaOldValue1132 = var_264_11.alpha
					arg_261_1.var_.characterEffect1132 = var_264_11
				end

				arg_261_1.var_.alphaOldValue1132 = 0
			end

			local var_264_12 = 0.0166666666666667

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_12 then
				if arg_261_1.var_.characterEffect1132 then
					arg_261_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_261_1.var_.alphaOldValue1132, 1, (arg_261_1.time_ - 0) / var_264_12)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_12 and arg_261_1.time_ < 0 + var_264_12 + arg_264_0 and arg_261_1.var_.characterEffect1132 then
				arg_261_1.var_.characterEffect1132.alpha = 1
			end

			local var_264_13 = 0
			local var_264_14 = 0.25

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(117122064)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_18 = 10 <= 0 and var_264_14 or var_264_14 * (utf8.len(var_264_16) / 10)

				if (10 <= 0 and var_264_14 or var_264_14 * (utf8.len(var_264_16) / 10)) > 0 and var_264_14 < var_264_18 then
					arg_261_1.talkMaxDuration = var_264_18

					if var_264_18 + var_264_13 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_13
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122064", "story_v_out_117122.awb") ~= 0 then
					local var_264_19 = manager.audio:GetVoiceLength("story_v_out_117122", "117122064", "story_v_out_117122.awb") / 1000

					if var_264_19 + var_264_13 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_13
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_117122", "117122064", "story_v_out_117122.awb")

						arg_261_1:RecordAudio("117122064", var_264_20)
						arg_261_1:RecordAudio("117122064", var_264_20)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_117122", "117122064", "story_v_out_117122.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_117122", "117122064", "story_v_out_117122.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_21 = math.max(var_264_14, arg_261_1.talkMaxDuration)

			if var_264_13 <= arg_261_1.time_ and arg_261_1.time_ < var_264_13 + var_264_21 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_13) / var_264_21

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_13 + var_264_21 and arg_261_1.time_ < var_264_13 + var_264_21 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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
				actorName = "1132",
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
	Play117122065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 117122065
		arg_265_1.duration_ = 2.7

		local var_265_0 = {
			zh = 0.999999999999,
			ja = 2.7
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
			arg_265_1.auto_ = false
		end

		function arg_265_1.playNext_(arg_267_0)
			arg_265_1.onStoryFinished_()
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10035 = arg_265_1.actors_["10035"].transform.localPosition
				arg_265_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10035", 4)

				for iter_268_0 = 0, arg_265_1.actors_["10035"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["10035"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_2" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_268_2 = arg_265_1.actors_["1132"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1132 == nil then
				arg_265_1.var_.actorSpriteComps1132 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps1132 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1132:ToTable()) do
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

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1132 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps1132 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 0.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:GetWordFromCfg(117122065)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 2 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 2)

				if (2 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 2)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117122", "117122065", "story_v_out_117122.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_out_117122", "117122065", "story_v_out_117122.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_out_117122", "117122065", "story_v_out_117122.awb")

						arg_265_1:RecordAudio("117122065", var_268_12)
						arg_265_1:RecordAudio("117122065", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_117122", "117122065", "story_v_out_117122.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_117122", "117122065", "story_v_out_117122.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_13 and arg_265_1.time_ < var_268_5 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/TI0106"
	},
	voices = {
		"story_v_out_117122.awb"
	}
}
