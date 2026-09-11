return {
	Play413061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413061002(arg_1_1)
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

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 1.025

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413061001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 41 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 41)

				if (41 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 41)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.9

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(413061002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 36)

				if (36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 36)) > 0 and var_12_0 < var_12_3 then
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
	Play413061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413061003
		arg_13_1.duration_ = 7.13

		local var_13_0 = {
			zh = 5.2,
			ja = 7.133
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
				arg_13_0:Play413061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10098"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10098")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10098"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10098"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10098"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10098 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10098", 3)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_4" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -345, -300)
			end

			local var_16_5 = arg_13_1.actors_["10098"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10098 == nil then
				arg_13_1.var_.actorSpriteComps10098 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps10098 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_4.color.r, 1, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_4.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10098 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10098 = nil
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_8 = arg_13_1.actors_["10098"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_8 then
					arg_13_1.var_.alphaOldValue10098 = var_16_8.alpha
					arg_13_1.var_.characterEffect10098 = var_16_8
				end

				arg_13_1.var_.alphaOldValue10098 = 0
			end

			local var_16_9 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				if arg_13_1.var_.characterEffect10098 then
					arg_13_1.var_.characterEffect10098.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10098, 1, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and arg_13_1.var_.characterEffect10098 then
				arg_13_1.var_.characterEffect10098.alpha = 1
			end

			local var_16_10 = 0
			local var_16_11 = 0.675

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(413061003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 27 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 27)

				if (27 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 27)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061003", "story_v_out_413061.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_413061", "413061003", "story_v_out_413061.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_413061", "413061003", "story_v_out_413061.awb")

						arg_13_1:RecordAudio("413061003", var_16_17)
						arg_13_1:RecordAudio("413061003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413061", "413061003", "story_v_out_413061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413061", "413061003", "story_v_out_413061.awb")
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
				actorName = "10098",
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
	Play413061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413061004
		arg_17_1.duration_ = 8.43

		local var_17_0 = {
			zh = 6.666,
			ja = 8.433
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
				arg_17_0:Play413061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(413061004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)

				if (28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061004", "story_v_out_413061.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061004", "story_v_out_413061.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_413061", "413061004", "story_v_out_413061.awb")

						arg_17_1:RecordAudio("413061004", var_20_6)
						arg_17_1:RecordAudio("413061004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413061", "413061004", "story_v_out_413061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413061", "413061004", "story_v_out_413061.awb")
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
	Play413061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413061005
		arg_21_1.duration_ = 5.73

		local var_21_0 = {
			zh = 3.266,
			ja = 5.733
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
				arg_21_0:Play413061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10098"]) and arg_21_1.var_.actorSpriteComps10098 == nil then
				arg_21_1.var_.actorSpriteComps10098 = arg_21_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10098"]) then
				if arg_21_1.var_.actorSpriteComps10098 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10098:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10098"]) and arg_21_1.var_.actorSpriteComps10098 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10098 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(413061005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)

				if (18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061005", "story_v_out_413061.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061005", "story_v_out_413061.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_413061", "413061005", "story_v_out_413061.awb")

						arg_21_1:RecordAudio("413061005", var_24_9)
						arg_21_1:RecordAudio("413061005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413061", "413061005", "story_v_out_413061.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413061", "413061005", "story_v_out_413061.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413061006
		arg_25_1.duration_ = 9.43

		local var_25_0 = {
			zh = 4.966,
			ja = 9.433
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
				arg_25_0:Play413061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(413061006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061006", "story_v_out_413061.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061006", "story_v_out_413061.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_413061", "413061006", "story_v_out_413061.awb")

						arg_25_1:RecordAudio("413061006", var_28_6)
						arg_25_1:RecordAudio("413061006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413061", "413061006", "story_v_out_413061.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413061", "413061006", "story_v_out_413061.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play413061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413061007
		arg_29_1.duration_ = 11.53

		local var_29_0 = {
			zh = 6.533,
			ja = 11.533
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play413061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10098 = arg_29_1.actors_["10098"].transform.localPosition
				arg_29_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10098", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10098"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10098"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_1" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_32_2 = arg_29_1.actors_["10098"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10098 == nil then
				arg_29_1.var_.actorSpriteComps10098 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10098 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10098 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10098 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.575

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(413061007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 23 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 23)

				if (23 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 23)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061007", "story_v_out_413061.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061007", "story_v_out_413061.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_413061", "413061007", "story_v_out_413061.awb")

						arg_29_1:RecordAudio("413061007", var_32_12)
						arg_29_1:RecordAudio("413061007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413061", "413061007", "story_v_out_413061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413061", "413061007", "story_v_out_413061.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play413061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413061008
		arg_33_1.duration_ = 4.47

		local var_33_0 = {
			zh = 3.5,
			ja = 4.466
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
				arg_33_0:Play413061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10098 = arg_33_1.actors_["10098"].transform.localPosition
				arg_33_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10098", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10098"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10098"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_4" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_36_2 = 0
			local var_36_3 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(413061008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)

				if (19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061008", "story_v_out_413061.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061008", "story_v_out_413061.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_413061", "413061008", "story_v_out_413061.awb")

						arg_33_1:RecordAudio("413061008", var_36_9)
						arg_33_1:RecordAudio("413061008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413061", "413061008", "story_v_out_413061.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413061", "413061008", "story_v_out_413061.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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
	Play413061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413061009
		arg_37_1.duration_ = 3.9

		local var_37_0 = {
			zh = 3.433,
			ja = 3.9
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
				arg_37_0:Play413061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10098"]) and arg_37_1.var_.actorSpriteComps10098 == nil then
				arg_37_1.var_.actorSpriteComps10098 = arg_37_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10098"]) then
				if arg_37_1.var_.actorSpriteComps10098 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10098"]) and arg_37_1.var_.actorSpriteComps10098 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10098 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 0.45

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_4 = arg_37_1:GetWordFromCfg(413061009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 18 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 18)

				if (18 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 18)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061009", "story_v_out_413061.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061009", "story_v_out_413061.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_413061", "413061009", "story_v_out_413061.awb")

						arg_37_1:RecordAudio("413061009", var_40_9)
						arg_37_1:RecordAudio("413061009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413061", "413061009", "story_v_out_413061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413061", "413061009", "story_v_out_413061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play413061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413061010
		arg_41_1.duration_ = 7.57

		local var_41_0 = {
			zh = 2.933,
			ja = 7.566
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
				arg_41_0:Play413061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10098"]) and arg_41_1.var_.actorSpriteComps10098 == nil then
				arg_41_1.var_.actorSpriteComps10098 = arg_41_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10098"]) then
				if arg_41_1.var_.actorSpriteComps10098 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10098:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10098"]) and arg_41_1.var_.actorSpriteComps10098 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10098 = nil
			end

			local var_44_2 = 0
			local var_44_3 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_4 = arg_41_1:GetWordFromCfg(413061010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 18 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 18)

				if (18 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 18)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061010", "story_v_out_413061.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061010", "story_v_out_413061.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_413061", "413061010", "story_v_out_413061.awb")

						arg_41_1:RecordAudio("413061010", var_44_9)
						arg_41_1:RecordAudio("413061010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413061", "413061010", "story_v_out_413061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413061", "413061010", "story_v_out_413061.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play413061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413061011
		arg_45_1.duration_ = 14.5

		local var_45_0 = {
			zh = 6.9,
			ja = 14.5
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
				arg_45_0:Play413061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10098"]) and arg_45_1.var_.actorSpriteComps10098 == nil then
				arg_45_1.var_.actorSpriteComps10098 = arg_45_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10098"]) then
				if arg_45_1.var_.actorSpriteComps10098 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 1, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10098"]) and arg_45_1.var_.actorSpriteComps10098 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10098 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(413061011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 30 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 30)

				if (30 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 30)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061011", "story_v_out_413061.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061011", "story_v_out_413061.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_413061", "413061011", "story_v_out_413061.awb")

						arg_45_1:RecordAudio("413061011", var_48_9)
						arg_45_1:RecordAudio("413061011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413061", "413061011", "story_v_out_413061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413061", "413061011", "story_v_out_413061.awb")
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413061012
		arg_49_1.duration_ = 7.77

		local var_49_0 = {
			zh = 7.333,
			ja = 7.766
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.75

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(413061012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)

				if (30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061012", "story_v_out_413061.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061012", "story_v_out_413061.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_413061", "413061012", "story_v_out_413061.awb")

						arg_49_1:RecordAudio("413061012", var_52_6)
						arg_49_1:RecordAudio("413061012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413061", "413061012", "story_v_out_413061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413061", "413061012", "story_v_out_413061.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413061013
		arg_53_1.duration_ = 3.2

		local var_53_0 = {
			zh = 2.6,
			ja = 3.2
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
				arg_53_0:Play413061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10098"]) and arg_53_1.var_.actorSpriteComps10098 == nil then
				arg_53_1.var_.actorSpriteComps10098 = arg_53_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10098"]) then
				if arg_53_1.var_.actorSpriteComps10098 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10098"]) and arg_53_1.var_.actorSpriteComps10098 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10098 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(413061013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 10 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 10)

				if (10 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 10)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061013", "story_v_out_413061.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061013", "story_v_out_413061.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_413061", "413061013", "story_v_out_413061.awb")

						arg_53_1:RecordAudio("413061013", var_56_9)
						arg_53_1:RecordAudio("413061013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413061", "413061013", "story_v_out_413061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413061", "413061013", "story_v_out_413061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413061014
		arg_57_1.duration_ = 6.13

		local var_57_0 = {
			zh = 6.133,
			ja = 5.2
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
				arg_57_0:Play413061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(413061014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 32 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 32)

				if (32 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 32)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061014", "story_v_out_413061.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061014", "story_v_out_413061.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_413061", "413061014", "story_v_out_413061.awb")

						arg_57_1:RecordAudio("413061014", var_60_6)
						arg_57_1:RecordAudio("413061014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413061", "413061014", "story_v_out_413061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413061", "413061014", "story_v_out_413061.awb")
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
	Play413061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413061015
		arg_61_1.duration_ = 4.27

		local var_61_0 = {
			zh = 4.266,
			ja = 3.533
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
				arg_61_0:Play413061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.625

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(413061015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 25 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 25)

				if (25 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 25)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061015", "story_v_out_413061.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061015", "story_v_out_413061.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_413061", "413061015", "story_v_out_413061.awb")

						arg_61_1:RecordAudio("413061015", var_64_6)
						arg_61_1:RecordAudio("413061015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413061", "413061015", "story_v_out_413061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413061", "413061015", "story_v_out_413061.awb")
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
	Play413061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413061016
		arg_65_1.duration_ = 10.8

		local var_65_0 = {
			zh = 7.7,
			ja = 10.8
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play413061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10098"]) and arg_65_1.var_.actorSpriteComps10098 == nil then
				arg_65_1.var_.actorSpriteComps10098 = arg_65_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10098"]) then
				if arg_65_1.var_.actorSpriteComps10098 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10098"]) and arg_65_1.var_.actorSpriteComps10098 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10098 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.8

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(413061016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 32 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 32)

				if (32 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 32)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061016", "story_v_out_413061.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061016", "story_v_out_413061.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_413061", "413061016", "story_v_out_413061.awb")

						arg_65_1:RecordAudio("413061016", var_68_9)
						arg_65_1:RecordAudio("413061016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413061", "413061016", "story_v_out_413061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413061", "413061016", "story_v_out_413061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413061017
		arg_69_1.duration_ = 4.37

		local var_69_0 = {
			zh = 3.633,
			ja = 4.366
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
				arg_69_0:Play413061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10098 = arg_69_1.actors_["10098"].transform.localPosition
				arg_69_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10098", 0)

				for iter_72_0 = 0, arg_69_1.actors_["10098"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10098"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10098, Vector3.New(-1500, -350, -180), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10098"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_72_2 = "10094"

			if arg_69_1.actors_["10094"] == nil then
				local var_72_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_72_3) then
					local var_72_4 = Object.Instantiate(var_72_3, arg_69_1.canvasGo_.transform)

					var_72_4.transform:SetSiblingIndex(1)

					var_72_4.name = var_72_2
					var_72_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_[var_72_2] = var_72_4

					if arg_69_1.isInRecall_ then
						for iter_72_1, iter_72_2 in ipairs((var_72_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_72_2.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_5 = arg_69_1.actors_["10094"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10094 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10094", 3)

				for iter_72_3 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_3)

					if var_72_6.name == "" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_72_8 = arg_69_1.actors_["10098"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10098 == nil then
				arg_69_1.var_.actorSpriteComps10098 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.actorSpriteComps10098 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_9), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_9), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_9)))
							else
								local var_72_10 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_9)

								iter_72_5.color = Color.New(var_72_10, var_72_10, var_72_10)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10098 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10098 = nil
			end

			local var_72_11 = arg_69_1.actors_["10094"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10094 == nil then
				arg_69_1.var_.actorSpriteComps10094 = var_72_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_12 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_12 and not isNil(var_72_11) then
				if arg_69_1.var_.actorSpriteComps10094 then
					for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_72_9 then
							if arg_69_1.isInRecall_ then
								iter_72_9.color = Color.New(Mathf.Lerp(iter_72_9.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_12), Mathf.Lerp(iter_72_9.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_12), (Mathf.Lerp(iter_72_9.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_12)))
							else
								local var_72_13 = Mathf.Lerp(iter_72_9.color.r, 1, (arg_69_1.time_ - 0) / var_72_12)

								iter_72_9.color = Color.New(var_72_13, var_72_13, var_72_13)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_12 and arg_69_1.time_ < 0 + var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10094 then
				for iter_72_10, iter_72_11 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_72_11 then
						iter_72_11.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_14 = arg_69_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_14 then
					arg_69_1.var_.alphaOldValue10094 = var_72_14.alpha
					arg_69_1.var_.characterEffect10094 = var_72_14
				end

				arg_69_1.var_.alphaOldValue10094 = 0
			end

			local var_72_15 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_15 then
				if arg_69_1.var_.characterEffect10094 then
					arg_69_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue10094, 1, (arg_69_1.time_ - 0) / var_72_15)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_15 and arg_69_1.time_ < 0 + var_72_15 + arg_72_0 and arg_69_1.var_.characterEffect10094 then
				arg_69_1.var_.characterEffect10094.alpha = 1
			end

			local var_72_16 = 0
			local var_72_17 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(413061017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 16 <= 0 and var_72_17 or var_72_17 * (utf8.len(var_72_19) / 16)

				if (16 <= 0 and var_72_17 or var_72_17 * (utf8.len(var_72_19) / 16)) > 0 and var_72_17 < var_72_21 then
					arg_69_1.talkMaxDuration = var_72_21

					if var_72_21 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_16
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061017", "story_v_out_413061.awb") ~= 0 then
					local var_72_22 = manager.audio:GetVoiceLength("story_v_out_413061", "413061017", "story_v_out_413061.awb") / 1000

					if var_72_22 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_16
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_413061", "413061017", "story_v_out_413061.awb")

						arg_69_1:RecordAudio("413061017", var_72_23)
						arg_69_1:RecordAudio("413061017", var_72_23)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413061", "413061017", "story_v_out_413061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413061", "413061017", "story_v_out_413061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_24 = math.max(var_72_17, arg_69_1.talkMaxDuration)

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_24 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_16) / var_72_24

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_16 + var_72_24 and arg_69_1.time_ < var_72_16 + var_72_24 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413061018
		arg_73_1.duration_ = 10.27

		local var_73_0 = {
			zh = 5.466,
			ja = 10.266
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
				arg_73_0:Play413061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10094 = arg_73_1.actors_["10094"].transform.localPosition
				arg_73_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10094", 0)

				for iter_76_0 = 0, arg_73_1.actors_["10094"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10094"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_76_2 = arg_73_1.actors_["10098"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10098 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10098", 3)

				for iter_76_1 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_1)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -345, -300)
			end

			local var_76_5 = arg_73_1.actors_["10094"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10094 == nil then
				arg_73_1.var_.actorSpriteComps10094 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10094 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_3.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_3.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10094 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10094 = nil
			end

			local var_76_8 = arg_73_1.actors_["10098"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10098 == nil then
				arg_73_1.var_.actorSpriteComps10098 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 and not isNil(var_76_8) then
				if arg_73_1.var_.actorSpriteComps10098 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								iter_76_7.color = Color.New(Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_9), Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_9), (Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_9)))
							else
								local var_76_10 = Mathf.Lerp(iter_76_7.color.r, 1, (arg_73_1.time_ - 0) / var_76_9)

								iter_76_7.color = Color.New(var_76_10, var_76_10, var_76_10)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10098 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_76_9 then
						iter_76_9.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10098 = nil
			end

			local var_76_11 = 0
			local var_76_12 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(413061018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 20 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 20)

				if (20 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 20)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061018", "story_v_out_413061.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061018", "story_v_out_413061.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_413061", "413061018", "story_v_out_413061.awb")

						arg_73_1:RecordAudio("413061018", var_76_18)
						arg_73_1:RecordAudio("413061018", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413061", "413061018", "story_v_out_413061.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413061", "413061018", "story_v_out_413061.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_19 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_19

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_19 and arg_73_1.time_ < var_76_11 + var_76_19 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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
				actorName = "10098",
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
	Play413061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413061019
		arg_77_1.duration_ = 16.7

		local var_77_0 = {
			zh = 7.966,
			ja = 16.7
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
				arg_77_0:Play413061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.875

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(413061019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 35 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 35)

				if (35 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 35)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061019", "story_v_out_413061.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061019", "story_v_out_413061.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_413061", "413061019", "story_v_out_413061.awb")

						arg_77_1:RecordAudio("413061019", var_80_6)
						arg_77_1:RecordAudio("413061019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413061", "413061019", "story_v_out_413061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413061", "413061019", "story_v_out_413061.awb")
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
	Play413061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413061020
		arg_81_1.duration_ = 6.47

		local var_81_0 = {
			zh = 4.533,
			ja = 6.466
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
				arg_81_0:Play413061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10098"]) and arg_81_1.var_.actorSpriteComps10098 == nil then
				arg_81_1.var_.actorSpriteComps10098 = arg_81_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10098"]) then
				if arg_81_1.var_.actorSpriteComps10098 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10098"]) and arg_81_1.var_.actorSpriteComps10098 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10098 = nil
			end

			local var_84_2 = 0
			local var_84_3 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_4 = arg_81_1:GetWordFromCfg(413061020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 24)

				if (24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 24)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061020", "story_v_out_413061.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061020", "story_v_out_413061.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_413061", "413061020", "story_v_out_413061.awb")

						arg_81_1:RecordAudio("413061020", var_84_9)
						arg_81_1:RecordAudio("413061020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413061", "413061020", "story_v_out_413061.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413061", "413061020", "story_v_out_413061.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413061021
		arg_85_1.duration_ = 10.93

		local var_85_0 = {
			zh = 8.933,
			ja = 10.933
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
				arg_85_0:Play413061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10098 = arg_85_1.actors_["10098"].transform.localPosition
				arg_85_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10098", 3)

				for iter_88_0 = 0, arg_85_1.actors_["10098"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10098"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_4" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_88_2 = arg_85_1.actors_["10098"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10098 == nil then
				arg_85_1.var_.actorSpriteComps10098 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10098 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10098 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10098 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(413061021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 32 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 32)

				if (32 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 32)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061021", "story_v_out_413061.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061021", "story_v_out_413061.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_413061", "413061021", "story_v_out_413061.awb")

						arg_85_1:RecordAudio("413061021", var_88_12)
						arg_85_1:RecordAudio("413061021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413061", "413061021", "story_v_out_413061.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413061", "413061021", "story_v_out_413061.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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
	Play413061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413061022
		arg_89_1.duration_ = 8.43

		local var_89_0 = {
			zh = 6.833,
			ja = 8.433
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
				arg_89_0:Play413061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.825

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413061022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 33 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 33)

				if (33 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 33)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061022", "story_v_out_413061.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061022", "story_v_out_413061.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413061", "413061022", "story_v_out_413061.awb")

						arg_89_1:RecordAudio("413061022", var_92_6)
						arg_89_1:RecordAudio("413061022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413061", "413061022", "story_v_out_413061.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413061", "413061022", "story_v_out_413061.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play413061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413061023
		arg_93_1.duration_ = 4.73

		local var_93_0 = {
			zh = 4.733,
			ja = 3.333
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
				arg_93_0:Play413061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10098 = arg_93_1.actors_["10098"].transform.localPosition
				arg_93_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10098", 0)

				for iter_96_0 = 0, arg_93_1.actors_["10098"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10098"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10098, Vector3.New(-1500, -350, -180), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10098"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_96_2 = arg_93_1.actors_["10094"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10094 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10094", 3)

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
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_96_5 = arg_93_1.actors_["10098"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10098 == nil then
				arg_93_1.var_.actorSpriteComps10098 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10098 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10098 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10098 = nil
			end

			local var_96_8 = arg_93_1.actors_["10094"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10094 == nil then
				arg_93_1.var_.actorSpriteComps10094 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10094 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 1, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10094 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10094 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(413061023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 19 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 19)

				if (19 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 19)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061023", "story_v_out_413061.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061023", "story_v_out_413061.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_413061", "413061023", "story_v_out_413061.awb")

						arg_93_1:RecordAudio("413061023", var_96_18)
						arg_93_1:RecordAudio("413061023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413061", "413061023", "story_v_out_413061.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413061", "413061023", "story_v_out_413061.awb")
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
				actorName = "10098",
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413061024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413061024
		arg_97_1.duration_ = 5.77

		local var_97_0 = {
			zh = 5.766,
			ja = 5.633
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
				arg_97_0:Play413061025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10094 = arg_97_1.actors_["10094"].transform.localPosition
				arg_97_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10094", 0)

				for iter_100_0 = 0, arg_97_1.actors_["10094"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10094"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_100_2 = arg_97_1.actors_["10098"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10098 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10098", 3)

				for iter_100_1 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_1)

					if var_100_3.name == "split_1" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -345, -300)
			end

			local var_100_5 = arg_97_1.actors_["10094"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10094 == nil then
				arg_97_1.var_.actorSpriteComps10094 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps10094 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								iter_100_3.color = Color.New(Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_3.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_3.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10094 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_100_5 then
						iter_100_5.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10094 = nil
			end

			local var_100_8 = arg_97_1.actors_["10098"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10098 == nil then
				arg_97_1.var_.actorSpriteComps10098 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.actorSpriteComps10098 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								iter_100_7.color = Color.New(Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_9), Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_9), (Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_9)))
							else
								local var_100_10 = Mathf.Lerp(iter_100_7.color.r, 1, (arg_97_1.time_ - 0) / var_100_9)

								iter_100_7.color = Color.New(var_100_10, var_100_10, var_100_10)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10098 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_100_9 then
						iter_100_9.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10098 = nil
			end

			local var_100_11 = 0
			local var_100_12 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(413061024)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 30 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 30)

				if (30 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 30)) > 0 and var_100_12 < var_100_16 then
					arg_97_1.talkMaxDuration = var_100_16

					if var_100_16 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061024", "story_v_out_413061.awb") ~= 0 then
					local var_100_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061024", "story_v_out_413061.awb") / 1000

					if var_100_17 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_11
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_413061", "413061024", "story_v_out_413061.awb")

						arg_97_1:RecordAudio("413061024", var_100_18)
						arg_97_1:RecordAudio("413061024", var_100_18)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413061", "413061024", "story_v_out_413061.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413061", "413061024", "story_v_out_413061.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_19 and arg_97_1.time_ < var_100_11 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play413061025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413061025
		arg_101_1.duration_ = 7.8

		local var_101_0 = {
			zh = 5.266,
			ja = 7.8
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
				arg_101_0:Play413061026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10098 = arg_101_1.actors_["10098"].transform.localPosition
				arg_101_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10098", 3)

				for iter_104_0 = 0, arg_101_1.actors_["10098"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10098"].transform:GetChild(iter_104_0)

					if var_104_0.name == "split_4" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_104_2 = 0
			local var_104_3 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(413061025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 16 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 16)

				if (16 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 16)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061025", "story_v_out_413061.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061025", "story_v_out_413061.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_413061", "413061025", "story_v_out_413061.awb")

						arg_101_1:RecordAudio("413061025", var_104_9)
						arg_101_1:RecordAudio("413061025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413061", "413061025", "story_v_out_413061.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413061", "413061025", "story_v_out_413061.awb")
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

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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
	Play413061026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413061026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play413061027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10098"]) and arg_105_1.var_.actorSpriteComps10098 == nil then
				arg_105_1.var_.actorSpriteComps10098 = arg_105_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10098"]) then
				if arg_105_1.var_.actorSpriteComps10098 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10098:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10098"]) and arg_105_1.var_.actorSpriteComps10098 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10098 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 1.575

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(413061026).content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 63 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 63)

				if (63 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 63)) > 0 and var_108_3 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_7 and arg_105_1.time_ < var_108_2 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play413061027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413061027
		arg_109_1.duration_ = 10.4

		local var_109_0 = {
			zh = 10.4,
			ja = 9.5
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
				arg_109_0:Play413061028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10098"]) and arg_109_1.var_.actorSpriteComps10098 == nil then
				arg_109_1.var_.actorSpriteComps10098 = arg_109_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10098"]) then
				if arg_109_1.var_.actorSpriteComps10098 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10098:ToTable()) do
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

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10098"]) and arg_109_1.var_.actorSpriteComps10098 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10098 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(413061027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 40 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 40)

				if (40 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 40)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061027", "story_v_out_413061.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061027", "story_v_out_413061.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_413061", "413061027", "story_v_out_413061.awb")

						arg_109_1:RecordAudio("413061027", var_112_9)
						arg_109_1:RecordAudio("413061027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413061", "413061027", "story_v_out_413061.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413061", "413061027", "story_v_out_413061.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413061028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413061028
		arg_113_1.duration_ = 2

		local var_113_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_113_0:Play413061029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10098 = arg_113_1.actors_["10098"].transform.localPosition
				arg_113_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10098", 0)

				for iter_116_0 = 0, arg_113_1.actors_["10098"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10098"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10098, Vector3.New(-1500, -350, -180), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10098"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_116_2 = arg_113_1.actors_["10094"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10094 = var_116_2.localPosition
				var_116_2.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10094", 3)

				for iter_116_1 = 0, var_116_2.childCount - 1 do
					local var_116_3 = var_116_2:GetChild(iter_116_1)

					if var_116_3.name == "split_2" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_113_1.time_ - 0) / var_116_4)
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_116_5 = arg_113_1.actors_["10098"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps10098 == nil then
				arg_113_1.var_.actorSpriteComps10098 = var_116_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_6 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.actorSpriteComps10098 then
					for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_116_3 then
							if arg_113_1.isInRecall_ then
								iter_116_3.color = Color.New(Mathf.Lerp(iter_116_3.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_6), Mathf.Lerp(iter_116_3.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_6), (Mathf.Lerp(iter_116_3.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_6)))
							else
								local var_116_7 = Mathf.Lerp(iter_116_3.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_6)

								iter_116_3.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps10098 then
				for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_116_5 then
						iter_116_5.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10098 = nil
			end

			local var_116_8 = arg_113_1.actors_["10094"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10094 == nil then
				arg_113_1.var_.actorSpriteComps10094 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_9 and not isNil(var_116_8) then
				if arg_113_1.var_.actorSpriteComps10094 then
					for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_116_7 then
							if arg_113_1.isInRecall_ then
								iter_116_7.color = Color.New(Mathf.Lerp(iter_116_7.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_9), Mathf.Lerp(iter_116_7.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_9), (Mathf.Lerp(iter_116_7.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_9)))
							else
								local var_116_10 = Mathf.Lerp(iter_116_7.color.r, 1, (arg_113_1.time_ - 0) / var_116_9)

								iter_116_7.color = Color.New(var_116_10, var_116_10, var_116_10)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_9 and arg_113_1.time_ < 0 + var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10094 then
				for iter_116_8, iter_116_9 in pairs(arg_113_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_116_9 then
						iter_116_9.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10094 = nil
			end

			local var_116_11 = 0
			local var_116_12 = 0.15

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_13 = arg_113_1:GetWordFromCfg(413061028)
				local var_116_14 = arg_113_1:FormatText(var_116_13.content)

				arg_113_1.text_.text = var_116_14

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 6 <= 0 and var_116_12 or var_116_12 * (utf8.len(var_116_14) / 6)

				if (6 <= 0 and var_116_12 or var_116_12 * (utf8.len(var_116_14) / 6)) > 0 and var_116_12 < var_116_16 then
					arg_113_1.talkMaxDuration = var_116_16

					if var_116_16 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_14
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061028", "story_v_out_413061.awb") ~= 0 then
					local var_116_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061028", "story_v_out_413061.awb") / 1000

					if var_116_17 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_11
					end

					if var_116_13.prefab_name ~= "" and arg_113_1.actors_[var_116_13.prefab_name] ~= nil then
						local var_116_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_13.prefab_name].transform, "story_v_out_413061", "413061028", "story_v_out_413061.awb")

						arg_113_1:RecordAudio("413061028", var_116_18)
						arg_113_1:RecordAudio("413061028", var_116_18)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413061", "413061028", "story_v_out_413061.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413061", "413061028", "story_v_out_413061.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_19 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_19 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_19

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_19 and arg_113_1.time_ < var_116_11 + var_116_19 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_113_1:InitPlayNodeList()
	end,
	Play413061029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413061029
		arg_117_1.duration_ = 9

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play413061030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.F10g

				arg_117_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "F10g" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 4

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_3 + 0.3 and arg_117_1.time_ < var_120_3 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_5 = 2

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_5 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_4) / var_120_5)
				arg_117_1.mask_.color = var_120_6
			end

			if arg_117_1.time_ >= var_120_4 + var_120_5 and arg_117_1.time_ < var_120_4 + var_120_5 + arg_120_0 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = 1
				arg_117_1.mask_.color = var_120_7
			end

			local var_120_8 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 then
				local var_120_10 = Color.New(0, 0, 0)

				var_120_10.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_8) / var_120_9)
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 then
				local var_120_11 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_11.a = 0
				arg_117_1.mask_.color = var_120_11
			end

			local var_120_12 = arg_117_1.actors_["10094"].transform

			if 1.966 < arg_117_1.time_ and arg_117_1.time_ <= 1.966 + arg_120_0 then
				arg_117_1.var_.moveOldPos10094 = var_120_12.localPosition
				var_120_12.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10094", 0)

				for iter_120_2 = 0, var_120_12.childCount - 1 do
					local var_120_13 = var_120_12:GetChild(iter_120_2)

					if var_120_13.name == "" or not string.find(var_120_13.name, "split") then
						var_120_13.gameObject:SetActive(true)
					else
						var_120_13.gameObject:SetActive(false)
					end
				end
			end

			local var_120_14 = 0.001

			if 1.966 <= arg_117_1.time_ and arg_117_1.time_ < 1.966 + var_120_14 then
				var_120_12.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_117_1.time_ - 1.966) / var_120_14)
			end

			if arg_117_1.time_ >= 1.966 + var_120_14 and arg_117_1.time_ < 1.966 + var_120_14 + arg_120_0 then
				var_120_12.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_120_15 = arg_117_1.actors_["10094"]

			if 1.966 < arg_117_1.time_ and arg_117_1.time_ <= 1.966 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10094 == nil then
				arg_117_1.var_.actorSpriteComps10094 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_16 = 0.034

			if 1.966 <= arg_117_1.time_ and arg_117_1.time_ < 1.966 + var_120_16 and not isNil(var_120_15) then
				if arg_117_1.var_.actorSpriteComps10094 then
					for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_120_4 then
							if arg_117_1.isInRecall_ then
								iter_120_4.color = Color.New(Mathf.Lerp(iter_120_4.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 1.966) / var_120_16), Mathf.Lerp(iter_120_4.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 1.966) / var_120_16), (Mathf.Lerp(iter_120_4.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 1.966) / var_120_16)))
							else
								local var_120_17 = Mathf.Lerp(iter_120_4.color.r, 0.5, (arg_117_1.time_ - 1.966) / var_120_16)

								iter_120_4.color = Color.New(var_120_17, var_120_17, var_120_17)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 1.966 + var_120_16 and arg_117_1.time_ < 1.966 + var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10094 then
				for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_120_6 then
						iter_120_6.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10094 = nil
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_18 = 4
			local var_120_19 = 1.2

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_18 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_20 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_20:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_21 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(413061029).content)

				arg_117_1.text_.text = var_120_21

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_23 = 48 <= 0 and var_120_19 or var_120_19 * (utf8.len(var_120_21) / 48)

				if (48 <= 0 and var_120_19 or var_120_19 * (utf8.len(var_120_21) / 48)) > 0 and var_120_19 < var_120_23 then
					arg_117_1.talkMaxDuration = var_120_23
					var_120_18 = var_120_18 + 0.3

					if var_120_23 + var_120_18 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_18
					end
				end

				arg_117_1.text_.text = var_120_21
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_24 = var_120_18 + 0.3
			local var_120_25 = math.max(var_120_19, arg_117_1.talkMaxDuration)

			if var_120_18 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_24 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_24) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_24 + var_120_25 and arg_117_1.time_ < var_120_24 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413061030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413061030
		arg_123_1.duration_ = 8.43

		local var_123_0 = {
			zh = 5.133,
			ja = 8.433
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
				arg_123_0:Play413061031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["10092"] == nil then
				local var_126_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_126_0) then
					local var_126_1 = Object.Instantiate(var_126_0, arg_123_1.canvasGo_.transform)

					var_126_1.transform:SetSiblingIndex(1)

					var_126_1.name = "10092"
					var_126_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_123_1.actors_["10092"] = var_126_1

					if arg_123_1.isInRecall_ then
						for iter_126_0, iter_126_1 in ipairs((var_126_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_126_1.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_126_2 = arg_123_1.actors_["10092"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092", 2)

				for iter_126_2 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_2)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_126_5 = arg_123_1.actors_["10092"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092 == nil then
				arg_123_1.var_.actorSpriteComps10092 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps10092 then
					for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_126_4 then
							if arg_123_1.isInRecall_ then
								iter_126_4.color = Color.New(Mathf.Lerp(iter_126_4.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_4.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_4.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_4.color.r, 1, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_4.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10092 then
				for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_126_6 then
						iter_126_6.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_8 = arg_123_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_8 then
					arg_123_1.var_.alphaOldValue10092 = var_126_8.alpha
					arg_123_1.var_.characterEffect10092 = var_126_8
				end

				arg_123_1.var_.alphaOldValue10092 = 0
			end

			local var_126_9 = 0.5

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 then
				if arg_123_1.var_.characterEffect10092 then
					arg_123_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue10092, 1, (arg_123_1.time_ - 0) / var_126_9)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and arg_123_1.var_.characterEffect10092 then
				arg_123_1.var_.characterEffect10092.alpha = 1
			end

			local var_126_10 = 0
			local var_126_11 = 0.675

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_12 = arg_123_1:GetWordFromCfg(413061030)
				local var_126_13 = arg_123_1:FormatText(var_126_12.content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 27 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 27)

				if (27 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 27)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061030", "story_v_out_413061.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_413061", "413061030", "story_v_out_413061.awb") / 1000

					if var_126_16 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_10
					end

					if var_126_12.prefab_name ~= "" and arg_123_1.actors_[var_126_12.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_12.prefab_name].transform, "story_v_out_413061", "413061030", "story_v_out_413061.awb")

						arg_123_1:RecordAudio("413061030", var_126_17)
						arg_123_1:RecordAudio("413061030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413061", "413061030", "story_v_out_413061.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413061", "413061030", "story_v_out_413061.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_18 and arg_123_1.time_ < var_126_10 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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
	Play413061031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413061031
		arg_127_1.duration_ = 3.63

		local var_127_0 = {
			zh = 3.633,
			ja = 3.233
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
				arg_127_0:Play413061032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["10093"] == nil then
				local var_130_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_130_0) then
					local var_130_1 = Object.Instantiate(var_130_0, arg_127_1.canvasGo_.transform)

					var_130_1.transform:SetSiblingIndex(1)

					var_130_1.name = "10093"
					var_130_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_127_1.actors_["10093"] = var_130_1

					if arg_127_1.isInRecall_ then
						for iter_130_0, iter_130_1 in ipairs((var_130_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_130_1.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_130_2 = arg_127_1.actors_["10093"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10093 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10093", 4)

				for iter_130_2 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_2)

					if var_130_3.name == "split_4" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_130_5 = arg_127_1.actors_["10092"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10092 == nil then
				arg_127_1.var_.actorSpriteComps10092 = var_130_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_6 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.actorSpriteComps10092 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								iter_130_4.color = Color.New(Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_6), Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_6), (Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_6)))
							else
								local var_130_7 = Mathf.Lerp(iter_130_4.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_6)

								iter_130_4.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10092 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_130_6 then
						iter_130_6.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
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
					for iter_130_7, iter_130_8 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_130_8 then
							if arg_127_1.isInRecall_ then
								iter_130_8.color = Color.New(Mathf.Lerp(iter_130_8.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_8.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_8.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_8.color.r, 1, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_8.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10093 then
				for iter_130_9, iter_130_10 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_130_10 then
						iter_130_10.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_11 = arg_127_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_11 then
					arg_127_1.var_.alphaOldValue10093 = var_130_11.alpha
					arg_127_1.var_.characterEffect10093 = var_130_11
				end

				arg_127_1.var_.alphaOldValue10093 = 0
			end

			local var_130_12 = 0.5

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_12 then
				if arg_127_1.var_.characterEffect10093 then
					arg_127_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_127_1.var_.alphaOldValue10093, 1, (arg_127_1.time_ - 0) / var_130_12)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_12 and arg_127_1.time_ < 0 + var_130_12 + arg_130_0 and arg_127_1.var_.characterEffect10093 then
				arg_127_1.var_.characterEffect10093.alpha = 1
			end

			local var_130_13 = 0
			local var_130_14 = 0.375

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(413061031)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_18 = 15 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 15)

				if (15 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 15)) > 0 and var_130_14 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18

					if var_130_18 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_13
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061031", "story_v_out_413061.awb") ~= 0 then
					local var_130_19 = manager.audio:GetVoiceLength("story_v_out_413061", "413061031", "story_v_out_413061.awb") / 1000

					if var_130_19 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_13
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_413061", "413061031", "story_v_out_413061.awb")

						arg_127_1:RecordAudio("413061031", var_130_20)
						arg_127_1:RecordAudio("413061031", var_130_20)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413061", "413061031", "story_v_out_413061.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413061", "413061031", "story_v_out_413061.awb")
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
	Play413061032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413061032
		arg_131_1.duration_ = 11.3

		local var_131_0 = {
			zh = 3.766,
			ja = 11.3
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
				arg_131_0:Play413061033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10092 = arg_131_1.actors_["10092"].transform.localPosition
				arg_131_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10092", 2)

				for iter_134_0 = 0, arg_131_1.actors_["10092"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10092"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_2" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_134_2 = arg_131_1.actors_["10093"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10093 == nil then
				arg_131_1.var_.actorSpriteComps10093 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10093 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10093 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10093 = nil
			end

			local var_134_5 = arg_131_1.actors_["10092"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10092 == nil then
				arg_131_1.var_.actorSpriteComps10092 = var_134_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_6 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.actorSpriteComps10092 then
					for iter_134_5, iter_134_6 in pairs(arg_131_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_134_6 then
							if arg_131_1.isInRecall_ then
								iter_134_6.color = Color.New(Mathf.Lerp(iter_134_6.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_6), Mathf.Lerp(iter_134_6.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_6), (Mathf.Lerp(iter_134_6.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_6)))
							else
								local var_134_7 = Mathf.Lerp(iter_134_6.color.r, 1, (arg_131_1.time_ - 0) / var_134_6)

								iter_134_6.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10092 then
				for iter_134_7, iter_134_8 in pairs(arg_131_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_134_8 then
						iter_134_8.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10092 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.55

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
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

				local var_134_10 = arg_131_1:GetWordFromCfg(413061032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 22 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 22)

				if (22 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 22)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061032", "story_v_out_413061.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061032", "story_v_out_413061.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_413061", "413061032", "story_v_out_413061.awb")

						arg_131_1:RecordAudio("413061032", var_134_15)
						arg_131_1:RecordAudio("413061032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413061", "413061032", "story_v_out_413061.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413061", "413061032", "story_v_out_413061.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play413061033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413061033
		arg_135_1.duration_ = 12.7

		local var_135_0 = {
			zh = 8.8,
			ja = 12.7
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
				arg_135_0:Play413061034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10093"]) and arg_135_1.var_.actorSpriteComps10093 == nil then
				arg_135_1.var_.actorSpriteComps10093 = arg_135_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10093"]) then
				if arg_135_1.var_.actorSpriteComps10093 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10093"]) and arg_135_1.var_.actorSpriteComps10093 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10093 = nil
			end

			local var_138_2 = arg_135_1.actors_["10092"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10092 == nil then
				arg_135_1.var_.actorSpriteComps10092 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10092 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_138_5 then
							if arg_135_1.isInRecall_ then
								iter_138_5.color = Color.New(Mathf.Lerp(iter_138_5.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_5.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_5.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_5.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_5.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10092 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10092 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 0.8

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(413061033)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 32 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 32)

				if (32 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 32)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061033", "story_v_out_413061.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061033", "story_v_out_413061.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_413061", "413061033", "story_v_out_413061.awb")

						arg_135_1:RecordAudio("413061033", var_138_12)
						arg_135_1:RecordAudio("413061033", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413061", "413061033", "story_v_out_413061.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413061", "413061033", "story_v_out_413061.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play413061034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413061034
		arg_139_1.duration_ = 7.47

		local var_139_0 = {
			zh = 7.466,
			ja = 7.333
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
				arg_139_0:Play413061035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.925

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(413061034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 37 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 37)

				if (37 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 37)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061034", "story_v_out_413061.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061034", "story_v_out_413061.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_413061", "413061034", "story_v_out_413061.awb")

						arg_139_1:RecordAudio("413061034", var_142_6)
						arg_139_1:RecordAudio("413061034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413061", "413061034", "story_v_out_413061.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413061", "413061034", "story_v_out_413061.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play413061035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413061035
		arg_143_1.duration_ = 10.73

		local var_143_0 = {
			zh = 7.2,
			ja = 10.733
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
				arg_143_0:Play413061036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10092 = arg_143_1.actors_["10092"].transform.localPosition
				arg_143_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10092", 2)

				for iter_146_0 = 0, arg_143_1.actors_["10092"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10092"].transform:GetChild(iter_146_0)

					if var_146_0.name == "" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_146_2 = arg_143_1.actors_["10093"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps10093 == nil then
				arg_143_1.var_.actorSpriteComps10093 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps10093 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								iter_146_2.color = Color.New(Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_2.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_2.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps10093 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10093 = nil
			end

			local var_146_5 = arg_143_1.actors_["10092"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10092 == nil then
				arg_143_1.var_.actorSpriteComps10092 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps10092 then
					for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_146_6 then
							if arg_143_1.isInRecall_ then
								iter_146_6.color = Color.New(Mathf.Lerp(iter_146_6.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_6.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_6.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_6.color.r, 1, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_6.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10092 then
				for iter_146_7, iter_146_8 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_146_8 then
						iter_146_8.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10092 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 0.85

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(413061035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 34 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 34)

				if (34 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 34)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061035", "story_v_out_413061.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061035", "story_v_out_413061.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_413061", "413061035", "story_v_out_413061.awb")

						arg_143_1:RecordAudio("413061035", var_146_15)
						arg_143_1:RecordAudio("413061035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413061", "413061035", "story_v_out_413061.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413061", "413061035", "story_v_out_413061.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play413061036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413061036
		arg_147_1.duration_ = 2

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play413061037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10093 = arg_147_1.actors_["10093"].transform.localPosition
				arg_147_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10093", 4)

				for iter_150_0 = 0, arg_147_1.actors_["10093"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10093"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_6" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_150_2 = arg_147_1.actors_["10093"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10093 == nil then
				arg_147_1.var_.actorSpriteComps10093 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps10093 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								iter_150_2.color = Color.New(Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_2.color.r, 1, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_2.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10093 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10093 = nil
			end

			local var_150_5 = arg_147_1.actors_["10092"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10092 == nil then
				arg_147_1.var_.actorSpriteComps10092 = var_150_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.actorSpriteComps10092 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_150_6 then
							if arg_147_1.isInRecall_ then
								iter_150_6.color = Color.New(Mathf.Lerp(iter_150_6.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_6), Mathf.Lerp(iter_150_6.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_6), (Mathf.Lerp(iter_150_6.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_6)))
							else
								local var_150_7 = Mathf.Lerp(iter_150_6.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_6)

								iter_150_6.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10092 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_150_8 then
						iter_150_8.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10092 = nil
			end

			local var_150_8 = 0
			local var_150_9 = 0.125

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(413061036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 5 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 5)

				if (5 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 5)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061036", "story_v_out_413061.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061036", "story_v_out_413061.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_413061", "413061036", "story_v_out_413061.awb")

						arg_147_1:RecordAudio("413061036", var_150_15)
						arg_147_1:RecordAudio("413061036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413061", "413061036", "story_v_out_413061.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413061", "413061036", "story_v_out_413061.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play413061037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413061037
		arg_151_1.duration_ = 7.07

		local var_151_0 = {
			zh = 4.666,
			ja = 7.066
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
				arg_151_0:Play413061038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10093"]) and arg_151_1.var_.actorSpriteComps10093 == nil then
				arg_151_1.var_.actorSpriteComps10093 = arg_151_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10093"]) then
				if arg_151_1.var_.actorSpriteComps10093 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10093"]) and arg_151_1.var_.actorSpriteComps10093 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10093 = nil
			end

			local var_154_2 = arg_151_1.actors_["10092"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10092 == nil then
				arg_151_1.var_.actorSpriteComps10092 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10092 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 1, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10092 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10092 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.575

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(413061037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 23 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 23)

				if (23 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 23)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061037", "story_v_out_413061.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061037", "story_v_out_413061.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_413061", "413061037", "story_v_out_413061.awb")

						arg_151_1:RecordAudio("413061037", var_154_12)
						arg_151_1:RecordAudio("413061037", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413061", "413061037", "story_v_out_413061.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413061", "413061037", "story_v_out_413061.awb")
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

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413061038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413061038
		arg_155_1.duration_ = 7.33

		local var_155_0 = {
			zh = 6.533,
			ja = 7.333
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
				arg_155_0:Play413061039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.75

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(413061038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 30 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 30)

				if (30 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 30)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061038", "story_v_out_413061.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061038", "story_v_out_413061.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_413061", "413061038", "story_v_out_413061.awb")

						arg_155_1:RecordAudio("413061038", var_158_6)
						arg_155_1:RecordAudio("413061038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413061", "413061038", "story_v_out_413061.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413061", "413061038", "story_v_out_413061.awb")
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
	Play413061039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413061039
		arg_159_1.duration_ = 3.1

		local var_159_0 = {
			zh = 2.1,
			ja = 3.1
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
				arg_159_0:Play413061040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10093 = arg_159_1.actors_["10093"].transform.localPosition
				arg_159_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10093", 4)

				for iter_162_0 = 0, arg_159_1.actors_["10093"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10093"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_4" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_162_2 = arg_159_1.actors_["10093"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10093 == nil then
				arg_159_1.var_.actorSpriteComps10093 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps10093 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								iter_162_2.color = Color.New(Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_2.color.r, 1, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_2.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10093 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10093 = nil
			end

			local var_162_5 = arg_159_1.actors_["10092"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10092 == nil then
				arg_159_1.var_.actorSpriteComps10092 = var_162_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_6 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.actorSpriteComps10092 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								iter_162_6.color = Color.New(Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_6), Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_6), (Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_6)))
							else
								local var_162_7 = Mathf.Lerp(iter_162_6.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_6)

								iter_162_6.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10092 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_162_8 then
						iter_162_8.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps10092 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.3

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(413061039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 12 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 12)

				if (12 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 12)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061039", "story_v_out_413061.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061039", "story_v_out_413061.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_413061", "413061039", "story_v_out_413061.awb")

						arg_159_1:RecordAudio("413061039", var_162_15)
						arg_159_1:RecordAudio("413061039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413061", "413061039", "story_v_out_413061.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413061", "413061039", "story_v_out_413061.awb")
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
				actorName = "10093",
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
	Play413061040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413061040
		arg_163_1.duration_ = 7.97

		local var_163_0 = {
			zh = 4.366,
			ja = 7.966
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
				arg_163_0:Play413061041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10093"]) and arg_163_1.var_.actorSpriteComps10093 == nil then
				arg_163_1.var_.actorSpriteComps10093 = arg_163_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10093"]) then
				if arg_163_1.var_.actorSpriteComps10093 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10093"]) and arg_163_1.var_.actorSpriteComps10093 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10093 = nil
			end

			local var_166_2 = arg_163_1.actors_["10092"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10092 == nil then
				arg_163_1.var_.actorSpriteComps10092 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10092 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								iter_166_5.color = Color.New(Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_5.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_5.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10092 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_166_7 then
						iter_166_7.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10092 = nil
			end

			local var_166_5 = arg_163_1.actors_["10092"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10092 = var_166_5.localPosition
				var_166_5.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10092", 2)

				for iter_166_8 = 0, var_166_5.childCount - 1 do
					local var_166_6 = var_166_5:GetChild(iter_166_8)

					if var_166_6.name == "split_4" or not string.find(var_166_6.name, "split") then
						var_166_6.gameObject:SetActive(true)
					else
						var_166_6.gameObject:SetActive(false)
					end
				end
			end

			local var_166_7 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_163_1.time_ - 0) / var_166_7)
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_166_8 = 0
			local var_166_9 = 0.625

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(413061040)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 25 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 25)

				if (25 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 25)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061040", "story_v_out_413061.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061040", "story_v_out_413061.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_413061", "413061040", "story_v_out_413061.awb")

						arg_163_1:RecordAudio("413061040", var_166_15)
						arg_163_1:RecordAudio("413061040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413061", "413061040", "story_v_out_413061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413061", "413061040", "story_v_out_413061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play413061041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413061041
		arg_167_1.duration_ = 3.93

		local var_167_0 = {
			zh = 3.933,
			ja = 1.999999999999
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
				arg_167_0:Play413061042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10093"]) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = arg_167_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10093"]) then
				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10093"]) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_2 = arg_167_1.actors_["10092"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								iter_170_5.color = Color.New(Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_5.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_5.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 0.325

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(413061041)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 13 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 13)

				if (13 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 13)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061041", "story_v_out_413061.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061041", "story_v_out_413061.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_413061", "413061041", "story_v_out_413061.awb")

						arg_167_1:RecordAudio("413061041", var_170_12)
						arg_167_1:RecordAudio("413061041", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413061", "413061041", "story_v_out_413061.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413061", "413061041", "story_v_out_413061.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play413061042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413061042
		arg_171_1.duration_ = 13.37

		local var_171_0 = {
			zh = 6.166,
			ja = 13.366
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
				arg_171_0:Play413061043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = arg_171_1.actors_["10092"].transform.localPosition
				arg_171_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 2)

				for iter_174_0 = 0, arg_171_1.actors_["10092"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10092"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_4" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_174_2 = arg_171_1.actors_["10093"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10093 == nil then
				arg_171_1.var_.actorSpriteComps10093 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10093 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								iter_174_2.color = Color.New(Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_2.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_2.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10093 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10093 = nil
			end

			local var_174_5 = arg_171_1.actors_["10092"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps10092 == nil then
				arg_171_1.var_.actorSpriteComps10092 = var_174_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_6 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.actorSpriteComps10092 then
					for iter_174_5, iter_174_6 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_174_6 then
							if arg_171_1.isInRecall_ then
								iter_174_6.color = Color.New(Mathf.Lerp(iter_174_6.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_6), Mathf.Lerp(iter_174_6.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_6), (Mathf.Lerp(iter_174_6.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_6)))
							else
								local var_174_7 = Mathf.Lerp(iter_174_6.color.r, 1, (arg_171_1.time_ - 0) / var_174_6)

								iter_174_6.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps10092 then
				for iter_174_7, iter_174_8 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_174_8 then
						iter_174_8.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10092 = nil
			end

			local var_174_8 = 0
			local var_174_9 = 0.7

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(413061042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 28 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 28)

				if (28 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 28)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061042", "story_v_out_413061.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061042", "story_v_out_413061.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_413061", "413061042", "story_v_out_413061.awb")

						arg_171_1:RecordAudio("413061042", var_174_15)
						arg_171_1:RecordAudio("413061042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413061", "413061042", "story_v_out_413061.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413061", "413061042", "story_v_out_413061.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play413061043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413061043
		arg_175_1.duration_ = 9.4

		local var_175_0 = {
			zh = 3.933,
			ja = 9.4
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413061044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(413061043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 20)

				if (20 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 20)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061043", "story_v_out_413061.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061043", "story_v_out_413061.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_413061", "413061043", "story_v_out_413061.awb")

						arg_175_1:RecordAudio("413061043", var_178_6)
						arg_175_1:RecordAudio("413061043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413061", "413061043", "story_v_out_413061.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413061", "413061043", "story_v_out_413061.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play413061044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413061044
		arg_179_1.duration_ = 3.53

		local var_179_0 = {
			zh = 3.533,
			ja = 3.1
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413061045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10093"]) and arg_179_1.var_.actorSpriteComps10093 == nil then
				arg_179_1.var_.actorSpriteComps10093 = arg_179_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10093"]) then
				if arg_179_1.var_.actorSpriteComps10093 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10093"]) and arg_179_1.var_.actorSpriteComps10093 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10093 = nil
			end

			local var_182_2 = arg_179_1.actors_["10092"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10092 == nil then
				arg_179_1.var_.actorSpriteComps10092 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps10092 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10092 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10092 = nil
			end

			local var_182_5 = 0
			local var_182_6 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(413061044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 13 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 13)

				if (13 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 13)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061044", "story_v_out_413061.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061044", "story_v_out_413061.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_413061", "413061044", "story_v_out_413061.awb")

						arg_179_1:RecordAudio("413061044", var_182_12)
						arg_179_1:RecordAudio("413061044", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_413061", "413061044", "story_v_out_413061.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_413061", "413061044", "story_v_out_413061.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play413061045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413061045
		arg_183_1.duration_ = 13.77

		local var_183_0 = {
			zh = 6.366,
			ja = 13.766
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413061046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10092 = arg_183_1.actors_["10092"].transform.localPosition
				arg_183_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10092", 2)

				for iter_186_0 = 0, arg_183_1.actors_["10092"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10092"].transform:GetChild(iter_186_0)

					if var_186_0.name == "split_8" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_186_2 = arg_183_1.actors_["10093"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10093 == nil then
				arg_183_1.var_.actorSpriteComps10093 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps10093 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								iter_186_2.color = Color.New(Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_2.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_2.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps10093 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_186_4 then
						iter_186_4.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10093 = nil
			end

			local var_186_5 = arg_183_1.actors_["10092"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10092 == nil then
				arg_183_1.var_.actorSpriteComps10092 = var_186_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_6 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.actorSpriteComps10092 then
					for iter_186_5, iter_186_6 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_186_6 then
							if arg_183_1.isInRecall_ then
								iter_186_6.color = Color.New(Mathf.Lerp(iter_186_6.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_6), Mathf.Lerp(iter_186_6.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_6), (Mathf.Lerp(iter_186_6.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_6)))
							else
								local var_186_7 = Mathf.Lerp(iter_186_6.color.r, 1, (arg_183_1.time_ - 0) / var_186_6)

								iter_186_6.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.actorSpriteComps10092 then
				for iter_186_7, iter_186_8 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_186_8 then
						iter_186_8.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10092 = nil
			end

			local var_186_8 = 0
			local var_186_9 = 0.8

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(413061045)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 32 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 32)

				if (32 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 32)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061045", "story_v_out_413061.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061045", "story_v_out_413061.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_413061", "413061045", "story_v_out_413061.awb")

						arg_183_1:RecordAudio("413061045", var_186_15)
						arg_183_1:RecordAudio("413061045", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_413061", "413061045", "story_v_out_413061.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_413061", "413061045", "story_v_out_413061.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play413061046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413061046
		arg_187_1.duration_ = 19.33

		local var_187_0 = {
			zh = 7,
			ja = 19.333
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413061047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(413061046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 35 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 35)

				if (35 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 35)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061046", "story_v_out_413061.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061046", "story_v_out_413061.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_413061", "413061046", "story_v_out_413061.awb")

						arg_187_1:RecordAudio("413061046", var_190_6)
						arg_187_1:RecordAudio("413061046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413061", "413061046", "story_v_out_413061.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413061", "413061046", "story_v_out_413061.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play413061047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413061047
		arg_191_1.duration_ = 13

		local var_191_0 = {
			zh = 7.266,
			ja = 13
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413061048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.8

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(413061047)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 32 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 32)

				if (32 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 32)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061047", "story_v_out_413061.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061047", "story_v_out_413061.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_413061", "413061047", "story_v_out_413061.awb")

						arg_191_1:RecordAudio("413061047", var_194_6)
						arg_191_1:RecordAudio("413061047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_413061", "413061047", "story_v_out_413061.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_413061", "413061047", "story_v_out_413061.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play413061048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413061048
		arg_195_1.duration_ = 7.63

		local var_195_0 = {
			zh = 7.633,
			ja = 6.8
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play413061049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(413061048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 16 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 16)

				if (16 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 16)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061048", "story_v_out_413061.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061048", "story_v_out_413061.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_413061", "413061048", "story_v_out_413061.awb")

						arg_195_1:RecordAudio("413061048", var_198_6)
						arg_195_1:RecordAudio("413061048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413061", "413061048", "story_v_out_413061.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413061", "413061048", "story_v_out_413061.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play413061049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413061049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play413061050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10093 = arg_199_1.actors_["10093"].transform.localPosition
				arg_199_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10093", 7)

				for iter_202_0 = 0, arg_199_1.actors_["10093"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10093"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_202_2 = arg_199_1.actors_["10092"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10092 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10092", 7)

				for iter_202_1 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_1)

					if var_202_3.name == "" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_199_1.time_ - 0) / var_202_4)
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_202_5 = arg_199_1.actors_["10093"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps10093 == nil then
				arg_199_1.var_.actorSpriteComps10093 = var_202_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_6 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.actorSpriteComps10093 then
					for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_202_3 then
							if arg_199_1.isInRecall_ then
								iter_202_3.color = Color.New(Mathf.Lerp(iter_202_3.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_6), Mathf.Lerp(iter_202_3.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_6), (Mathf.Lerp(iter_202_3.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_6)))
							else
								local var_202_7 = Mathf.Lerp(iter_202_3.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_6)

								iter_202_3.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps10093 then
				for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_202_5 then
						iter_202_5.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10093 = nil
			end

			local var_202_8 = arg_199_1.actors_["10092"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps10092 == nil then
				arg_199_1.var_.actorSpriteComps10092 = var_202_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_9 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_9 and not isNil(var_202_8) then
				if arg_199_1.var_.actorSpriteComps10092 then
					for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_202_7 then
							if arg_199_1.isInRecall_ then
								iter_202_7.color = Color.New(Mathf.Lerp(iter_202_7.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_9), Mathf.Lerp(iter_202_7.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_9), (Mathf.Lerp(iter_202_7.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_9)))
							else
								local var_202_10 = Mathf.Lerp(iter_202_7.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_9)

								iter_202_7.color = Color.New(var_202_10, var_202_10, var_202_10)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_9 and arg_199_1.time_ < 0 + var_202_9 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps10092 then
				for iter_202_8, iter_202_9 in pairs(arg_199_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_202_9 then
						iter_202_9.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10092 = nil
			end

			local var_202_11 = 0
			local var_202_12 = 0.925

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(413061049).content)

				arg_199_1.text_.text = var_202_13

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 37 <= 0 and var_202_12 or var_202_12 * (utf8.len(var_202_13) / 37)

				if (37 <= 0 and var_202_12 or var_202_12 * (utf8.len(var_202_13) / 37)) > 0 and var_202_12 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_11 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_11
					end
				end

				arg_199_1.text_.text = var_202_13
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_12, arg_199_1.talkMaxDuration)

			if var_202_11 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_11) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_11 + var_202_16 and arg_199_1.time_ < var_202_11 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play413061050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413061050
		arg_203_1.duration_ = 9.33

		local var_203_0 = {
			zh = 8.399999999999,
			ja = 9.332999999999
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
				arg_203_0:Play413061051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.F08f == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08f")
				var_206_0.name = "F08f"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.F08f = var_206_0
			end

			if 1.999999999999 < arg_203_1.time_ and arg_203_1.time_ <= 1.999999999999 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.F08f

				arg_203_1.bgs_.F08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "F08f" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 3.999999999999

			if 3.999999999999 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_4 + 0.3 and arg_203_1.time_ < var_206_4 + 0.3 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_5 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_6 = 2

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 then
				local var_206_7 = Color.New(0, 0, 0)

				var_206_7.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_5) / var_206_6)
				arg_203_1.mask_.color = var_206_7
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 then
				local var_206_8 = Color.New(0, 0, 0)

				var_206_8.a = 1
				arg_203_1.mask_.color = var_206_8
			end

			local var_206_9 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_10 = 2

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 then
				local var_206_11 = Color.New(0, 0, 0)

				var_206_11.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_9) / var_206_10)
				arg_203_1.mask_.color = var_206_11
			end

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 then
				local var_206_12 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_12.a = 0
				arg_203_1.mask_.color = var_206_12
			end

			local var_206_13 = 2

			arg_203_1.isInRecall_ = true

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(true)

				arg_203_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_203_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_203_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_206_2, iter_206_3 in pairs(arg_203_1.actors_) do
					for iter_206_4, iter_206_5 in ipairs((iter_206_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_206_5.color = iter_206_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_206_14 = 0.1

			if var_206_13 <= arg_203_1.time_ and arg_203_1.time_ < var_206_13 + var_206_14 then
				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_13) / var_206_14)
			end

			if arg_203_1.time_ >= var_206_13 + var_206_14 and arg_203_1.time_ < var_206_13 + var_206_14 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 1
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_15 = 3.999999999999
			local var_206_16 = 0.575

			if 3.999999999999 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_17 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_17:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_203_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_206_18 = arg_203_1:GetWordFromCfg(413061050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_21 = 23 <= 0 and var_206_16 or var_206_16 * (utf8.len(var_206_19) / 23)

				if (23 <= 0 and var_206_16 or var_206_16 * (utf8.len(var_206_19) / 23)) > 0 and var_206_16 < var_206_21 then
					arg_203_1.talkMaxDuration = var_206_21
					var_206_15 = var_206_15 + 0.3

					if var_206_21 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_21 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061050", "story_v_out_413061.awb") ~= 0 then
					local var_206_22 = manager.audio:GetVoiceLength("story_v_out_413061", "413061050", "story_v_out_413061.awb") / 1000

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_413061", "413061050", "story_v_out_413061.awb")

						arg_203_1:RecordAudio("413061050", var_206_23)
						arg_203_1:RecordAudio("413061050", var_206_23)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_413061", "413061050", "story_v_out_413061.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_413061", "413061050", "story_v_out_413061.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_24 = var_206_15 + 0.3
			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_24 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_24) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_24 + var_206_25 and arg_203_1.time_ < var_206_24 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play413061051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413061051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play413061052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.225

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(413061051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 49 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 49)

				if (49 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 49)) > 0 and var_212_0 < var_212_3 then
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
	Play413061052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413061052
		arg_213_1.duration_ = 5

		local var_213_0 = {
			zh = 5,
			ja = 4.366
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
				arg_213_0:Play413061053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10092 = arg_213_1.actors_["10092"].transform.localPosition
				arg_213_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10092", 3)

				for iter_216_0 = 0, arg_213_1.actors_["10092"].transform.childCount - 1 do
					local var_216_0 = arg_213_1.actors_["10092"].transform:GetChild(iter_216_0)

					if var_216_0.name == "split_1_1" or not string.find(var_216_0.name, "split") then
						var_216_0.gameObject:SetActive(true)
					else
						var_216_0.gameObject:SetActive(false)
					end
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_216_2 = arg_213_1.actors_["10092"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10092 == nil then
				arg_213_1.var_.actorSpriteComps10092 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10092 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								iter_216_2.color = Color.New(Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_2.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_2.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10092 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				local var_216_5 = arg_213_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_216_5 then
					arg_213_1.var_.alphaOldValue10092 = var_216_5.alpha
					arg_213_1.var_.characterEffect10092 = var_216_5
				end

				arg_213_1.var_.alphaOldValue10092 = 0
			end

			local var_216_6 = 0.5

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 then
				if arg_213_1.var_.characterEffect10092 then
					arg_213_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_213_1.var_.alphaOldValue10092, 1, (arg_213_1.time_ - 0) / var_216_6)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and arg_213_1.var_.characterEffect10092 then
				arg_213_1.var_.characterEffect10092.alpha = 1
			end

			local var_216_7 = 0
			local var_216_8 = 0.75

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_9 = arg_213_1:GetWordFromCfg(413061052)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_12 = 30 <= 0 and var_216_8 or var_216_8 * (utf8.len(var_216_10) / 30)

				if (30 <= 0 and var_216_8 or var_216_8 * (utf8.len(var_216_10) / 30)) > 0 and var_216_8 < var_216_12 then
					arg_213_1.talkMaxDuration = var_216_12

					if var_216_12 + var_216_7 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_7
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061052", "story_v_out_413061.awb") ~= 0 then
					local var_216_13 = manager.audio:GetVoiceLength("story_v_out_413061", "413061052", "story_v_out_413061.awb") / 1000

					if var_216_13 + var_216_7 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_7
					end

					if var_216_9.prefab_name ~= "" and arg_213_1.actors_[var_216_9.prefab_name] ~= nil then
						local var_216_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_9.prefab_name].transform, "story_v_out_413061", "413061052", "story_v_out_413061.awb")

						arg_213_1:RecordAudio("413061052", var_216_14)
						arg_213_1:RecordAudio("413061052", var_216_14)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413061", "413061052", "story_v_out_413061.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413061", "413061052", "story_v_out_413061.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_15 = math.max(var_216_8, arg_213_1.talkMaxDuration)

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_15 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_7) / var_216_15

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_7 + var_216_15 and arg_213_1.time_ < var_216_7 + var_216_15 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play413061053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413061053
		arg_217_1.duration_ = 6.1

		local var_217_0 = {
			zh = 4.2,
			ja = 6.1
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
				arg_217_0:Play413061054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(413061053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061053", "story_v_out_413061.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061053", "story_v_out_413061.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_413061", "413061053", "story_v_out_413061.awb")

						arg_217_1:RecordAudio("413061053", var_220_6)
						arg_217_1:RecordAudio("413061053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413061", "413061053", "story_v_out_413061.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413061", "413061053", "story_v_out_413061.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413061054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413061054
		arg_221_1.duration_ = 7.1

		local var_221_0 = {
			zh = 7.1,
			ja = 6.6
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
				arg_221_0:Play413061055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10092"]) and arg_221_1.var_.actorSpriteComps10092 == nil then
				arg_221_1.var_.actorSpriteComps10092 = arg_221_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10092"]) then
				if arg_221_1.var_.actorSpriteComps10092 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10092"]) and arg_221_1.var_.actorSpriteComps10092 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10092 = nil
			end

			local var_224_2 = 0
			local var_224_3 = 0.9

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_221_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_224_4 = arg_221_1:GetWordFromCfg(413061054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 36 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 36)

				if (36 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 36)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061054", "story_v_out_413061.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061054", "story_v_out_413061.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_out_413061", "413061054", "story_v_out_413061.awb")

						arg_221_1:RecordAudio("413061054", var_224_9)
						arg_221_1:RecordAudio("413061054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413061", "413061054", "story_v_out_413061.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413061", "413061054", "story_v_out_413061.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play413061055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413061055
		arg_225_1.duration_ = 7.07

		local var_225_0 = {
			zh = 7.066,
			ja = 6.933
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
				arg_225_0:Play413061056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.925

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_225_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_228_1 = arg_225_1:GetWordFromCfg(413061055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 37 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 37)

				if (37 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 37)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061055", "story_v_out_413061.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061055", "story_v_out_413061.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_413061", "413061055", "story_v_out_413061.awb")

						arg_225_1:RecordAudio("413061055", var_228_6)
						arg_225_1:RecordAudio("413061055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413061", "413061055", "story_v_out_413061.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413061", "413061055", "story_v_out_413061.awb")
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

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413061056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413061056
		arg_229_1.duration_ = 6.73

		local var_229_0 = {
			zh = 4.466,
			ja = 6.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play413061057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.6

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_229_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_232_1 = arg_229_1:GetWordFromCfg(413061056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 24 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 24)

				if (24 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 24)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061056", "story_v_out_413061.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061056", "story_v_out_413061.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_413061", "413061056", "story_v_out_413061.awb")

						arg_229_1:RecordAudio("413061056", var_232_6)
						arg_229_1:RecordAudio("413061056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413061", "413061056", "story_v_out_413061.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413061", "413061056", "story_v_out_413061.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413061057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413061057
		arg_233_1.duration_ = 4.03

		local var_233_0 = {
			zh = 1.999999999999,
			ja = 4.033
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play413061058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10092 = arg_233_1.actors_["10092"].transform.localPosition
				arg_233_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10092", 0)

				for iter_236_0 = 0, arg_233_1.actors_["10092"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["10092"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_236_2 = "10097"

			if arg_233_1.actors_["10097"] == nil then
				local var_236_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_236_3) then
					local var_236_4 = Object.Instantiate(var_236_3, arg_233_1.canvasGo_.transform)

					var_236_4.transform:SetSiblingIndex(1)

					var_236_4.name = var_236_2
					var_236_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_233_1.actors_[var_236_2] = var_236_4

					if arg_233_1.isInRecall_ then
						for iter_236_1, iter_236_2 in ipairs((var_236_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_236_2.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_236_5 = arg_233_1.actors_["10097"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10097 = var_236_5.localPosition
				var_236_5.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10097", 3)

				for iter_236_3 = 0, var_236_5.childCount - 1 do
					local var_236_6 = var_236_5:GetChild(iter_236_3)

					if var_236_6.name == "" or not string.find(var_236_6.name, "split") then
						var_236_6.gameObject:SetActive(true)
					else
						var_236_6.gameObject:SetActive(false)
					end
				end
			end

			local var_236_7 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				var_236_5.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_233_1.time_ - 0) / var_236_7)
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				var_236_5.localPosition = Vector3.New(0, -350, -180)
			end

			local var_236_8 = arg_233_1.actors_["10092"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10092 == nil then
				arg_233_1.var_.actorSpriteComps10092 = var_236_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_9 and not isNil(var_236_8) then
				if arg_233_1.var_.actorSpriteComps10092 then
					for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_236_5 then
							if arg_233_1.isInRecall_ then
								iter_236_5.color = Color.New(Mathf.Lerp(iter_236_5.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_9), Mathf.Lerp(iter_236_5.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_9), (Mathf.Lerp(iter_236_5.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_9)))
							else
								local var_236_10 = Mathf.Lerp(iter_236_5.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_9)

								iter_236_5.color = Color.New(var_236_10, var_236_10, var_236_10)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_9 and arg_233_1.time_ < 0 + var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10092 then
				for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_236_7 then
						iter_236_7.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps10092 = nil
			end

			local var_236_11 = arg_233_1.actors_["10097"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_11) and arg_233_1.var_.actorSpriteComps10097 == nil then
				arg_233_1.var_.actorSpriteComps10097 = var_236_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_12 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_12 and not isNil(var_236_11) then
				if arg_233_1.var_.actorSpriteComps10097 then
					for iter_236_8, iter_236_9 in pairs(arg_233_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_236_9 then
							if arg_233_1.isInRecall_ then
								iter_236_9.color = Color.New(Mathf.Lerp(iter_236_9.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_12), Mathf.Lerp(iter_236_9.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_12), (Mathf.Lerp(iter_236_9.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_12)))
							else
								local var_236_13 = Mathf.Lerp(iter_236_9.color.r, 1, (arg_233_1.time_ - 0) / var_236_12)

								iter_236_9.color = Color.New(var_236_13, var_236_13, var_236_13)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_12 and arg_233_1.time_ < 0 + var_236_12 + arg_236_0 and not isNil(var_236_11) and arg_233_1.var_.actorSpriteComps10097 then
				for iter_236_10, iter_236_11 in pairs(arg_233_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_236_11 then
						iter_236_11.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				local var_236_14 = arg_233_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_236_14 then
					arg_233_1.var_.alphaOldValue10097 = var_236_14.alpha
					arg_233_1.var_.characterEffect10097 = var_236_14
				end

				arg_233_1.var_.alphaOldValue10097 = 0
			end

			local var_236_15 = 0.5

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_15 then
				if arg_233_1.var_.characterEffect10097 then
					arg_233_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_233_1.var_.alphaOldValue10097, 1, (arg_233_1.time_ - 0) / var_236_15)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_15 and arg_233_1.time_ < 0 + var_236_15 + arg_236_0 and arg_233_1.var_.characterEffect10097 then
				arg_233_1.var_.characterEffect10097.alpha = 1
			end

			local var_236_16 = 0
			local var_236_17 = 0.125

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(413061057)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 5 <= 0 and var_236_17 or var_236_17 * (utf8.len(var_236_19) / 5)

				if (5 <= 0 and var_236_17 or var_236_17 * (utf8.len(var_236_19) / 5)) > 0 and var_236_17 < var_236_21 then
					arg_233_1.talkMaxDuration = var_236_21

					if var_236_21 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_21 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061057", "story_v_out_413061.awb") ~= 0 then
					local var_236_22 = manager.audio:GetVoiceLength("story_v_out_413061", "413061057", "story_v_out_413061.awb") / 1000

					if var_236_22 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_16
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_out_413061", "413061057", "story_v_out_413061.awb")

						arg_233_1:RecordAudio("413061057", var_236_23)
						arg_233_1:RecordAudio("413061057", var_236_23)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413061", "413061057", "story_v_out_413061.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413061", "413061057", "story_v_out_413061.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_24 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_24 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_16) / var_236_24

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_16 + var_236_24 and arg_233_1.time_ < var_236_16 + var_236_24 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play413061058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413061058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play413061059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10097 = arg_237_1.actors_["10097"].transform.localPosition
				arg_237_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10097", 3)

				for iter_240_0 = 0, arg_237_1.actors_["10097"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10097"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_240_2 = arg_237_1.actors_["10097"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10097 == nil then
				arg_237_1.var_.actorSpriteComps10097 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps10097 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10097 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10097 = nil
			end

			local var_240_5 = 0
			local var_240_6 = 1.05

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(413061058).content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 42 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_7) / 42)

				if (42 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_7) / 42)) > 0 and var_240_6 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_6, arg_237_1.talkMaxDuration)

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_5) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_5 + var_240_10 and arg_237_1.time_ < var_240_5 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play413061059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413061059
		arg_241_1.duration_ = 5.97

		local var_241_0 = {
			zh = 5.3,
			ja = 5.966
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
				arg_241_0:Play413061060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10097 = arg_241_1.actors_["10097"].transform.localPosition
				arg_241_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10097", 3)

				for iter_244_0 = 0, arg_241_1.actors_["10097"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["10097"].transform:GetChild(iter_244_0)

					if var_244_0.name == "split_2" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_244_2 = arg_241_1.actors_["10097"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10097 == nil then
				arg_241_1.var_.actorSpriteComps10097 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps10097 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10097 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps10097 = nil
			end

			local var_244_5 = 0
			local var_244_6 = 0.675

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(413061059)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 27 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 27)

				if (27 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 27)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061059", "story_v_out_413061.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061059", "story_v_out_413061.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_413061", "413061059", "story_v_out_413061.awb")

						arg_241_1:RecordAudio("413061059", var_244_12)
						arg_241_1:RecordAudio("413061059", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413061", "413061059", "story_v_out_413061.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413061", "413061059", "story_v_out_413061.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_13 and arg_241_1.time_ < var_244_5 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413061060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413061060
		arg_245_1.duration_ = 7.57

		local var_245_0 = {
			zh = 5,
			ja = 7.566
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play413061061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.525

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(413061060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 21 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 21)

				if (21 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 21)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061060", "story_v_out_413061.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061060", "story_v_out_413061.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_413061", "413061060", "story_v_out_413061.awb")

						arg_245_1:RecordAudio("413061060", var_248_6)
						arg_245_1:RecordAudio("413061060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413061", "413061060", "story_v_out_413061.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413061", "413061060", "story_v_out_413061.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play413061061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413061061
		arg_249_1.duration_ = 11.57

		local var_249_0 = {
			zh = 5.033,
			ja = 11.566
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413061062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10092 = arg_249_1.actors_["10092"].transform.localPosition
				arg_249_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10092", 2)

				for iter_252_0 = 0, arg_249_1.actors_["10092"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["10092"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_252_2 = arg_249_1.actors_["10097"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10097 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10097", 4)

				for iter_252_1 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_1)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_252_5 = arg_249_1.actors_["10092"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10092 == nil then
				arg_249_1.var_.actorSpriteComps10092 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps10092 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								iter_252_3.color = Color.New(Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_3.color.r, 1, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_3.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10092 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps10092 = nil
			end

			local var_252_8 = arg_249_1.actors_["10097"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10097 == nil then
				arg_249_1.var_.actorSpriteComps10097 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.actorSpriteComps10097 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								iter_252_7.color = Color.New(Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_9), Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_9), (Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_9)))
							else
								local var_252_10 = Mathf.Lerp(iter_252_7.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_9)

								iter_252_7.color = Color.New(var_252_10, var_252_10, var_252_10)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10097 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_252_9 then
						iter_252_9.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10097 = nil
			end

			local var_252_11 = 0
			local var_252_12 = 0.65

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_13 = arg_249_1:GetWordFromCfg(413061061)
				local var_252_14 = arg_249_1:FormatText(var_252_13.content)

				arg_249_1.text_.text = var_252_14

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 26 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 26)

				if (26 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 26)) > 0 and var_252_12 < var_252_16 then
					arg_249_1.talkMaxDuration = var_252_16

					if var_252_16 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_14
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061061", "story_v_out_413061.awb") ~= 0 then
					local var_252_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061061", "story_v_out_413061.awb") / 1000

					if var_252_17 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_11
					end

					if var_252_13.prefab_name ~= "" and arg_249_1.actors_[var_252_13.prefab_name] ~= nil then
						local var_252_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_13.prefab_name].transform, "story_v_out_413061", "413061061", "story_v_out_413061.awb")

						arg_249_1:RecordAudio("413061061", var_252_18)
						arg_249_1:RecordAudio("413061061", var_252_18)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413061", "413061061", "story_v_out_413061.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413061", "413061061", "story_v_out_413061.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_19 = math.max(var_252_12, arg_249_1.talkMaxDuration)

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_19 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_11) / var_252_19

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_11 + var_252_19 and arg_249_1.time_ < var_252_11 + var_252_19 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play413061062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413061062
		arg_253_1.duration_ = 10.97

		local var_253_0 = {
			zh = 5.4,
			ja = 10.966
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
				arg_253_0:Play413061063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.7

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(413061062)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 28 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 28)

				if (28 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 28)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061062", "story_v_out_413061.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061062", "story_v_out_413061.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_413061", "413061062", "story_v_out_413061.awb")

						arg_253_1:RecordAudio("413061062", var_256_6)
						arg_253_1:RecordAudio("413061062", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413061", "413061062", "story_v_out_413061.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413061", "413061062", "story_v_out_413061.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play413061063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413061063
		arg_257_1.duration_ = 9.8

		local var_257_0 = {
			zh = 5.266,
			ja = 9.8
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
				arg_257_0:Play413061064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10092 = arg_257_1.actors_["10092"].transform.localPosition
				arg_257_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10092", 2)

				for iter_260_0 = 0, arg_257_1.actors_["10092"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["10092"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_1_1" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_260_2 = arg_257_1.actors_["10092"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10092 == nil then
				arg_257_1.var_.actorSpriteComps10092 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps10092 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10092 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10092 = nil
			end

			local var_260_5 = arg_257_1.actors_["10097"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10097 == nil then
				arg_257_1.var_.actorSpriteComps10097 = var_260_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_6 = 2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.actorSpriteComps10097 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10097 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_260_8 then
						iter_260_8.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps10097 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(413061063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 24 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 24)

				if (24 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 24)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061063", "story_v_out_413061.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061063", "story_v_out_413061.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_413061", "413061063", "story_v_out_413061.awb")

						arg_257_1:RecordAudio("413061063", var_260_15)
						arg_257_1:RecordAudio("413061063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413061", "413061063", "story_v_out_413061.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413061", "413061063", "story_v_out_413061.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play413061064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413061064
		arg_261_1.duration_ = 14.27

		local var_261_0 = {
			zh = 10.233,
			ja = 14.266
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
				arg_261_0:Play413061065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(413061064)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 46 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 46)

				if (46 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 46)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061064", "story_v_out_413061.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061064", "story_v_out_413061.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_413061", "413061064", "story_v_out_413061.awb")

						arg_261_1:RecordAudio("413061064", var_264_6)
						arg_261_1:RecordAudio("413061064", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413061", "413061064", "story_v_out_413061.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413061", "413061064", "story_v_out_413061.awb")
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
	Play413061065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413061065
		arg_265_1.duration_ = 5.77

		local var_265_0 = {
			zh = 5.333,
			ja = 5.766
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
				arg_265_0:Play413061066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10097"]) and arg_265_1.var_.actorSpriteComps10097 == nil then
				arg_265_1.var_.actorSpriteComps10097 = arg_265_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10097"]) then
				if arg_265_1.var_.actorSpriteComps10097 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10097"]) and arg_265_1.var_.actorSpriteComps10097 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10097 = nil
			end

			local var_268_2 = 0
			local var_268_3 = 0.65

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_265_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_268_4 = arg_265_1:GetWordFromCfg(413061065)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 26 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 26)

				if (26 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 26)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061065", "story_v_out_413061.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061065", "story_v_out_413061.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_413061", "413061065", "story_v_out_413061.awb")

						arg_265_1:RecordAudio("413061065", var_268_9)
						arg_265_1:RecordAudio("413061065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_413061", "413061065", "story_v_out_413061.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_413061", "413061065", "story_v_out_413061.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play413061066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413061066
		arg_269_1.duration_ = 7.6

		local var_269_0 = {
			zh = 6.966,
			ja = 7.6
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
				arg_269_0:Play413061067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10097 = arg_269_1.actors_["10097"].transform.localPosition
				arg_269_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10097", 4)

				for iter_272_0 = 0, arg_269_1.actors_["10097"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["10097"].transform:GetChild(iter_272_0)

					if var_272_0.name == "" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_272_2 = arg_269_1.actors_["10097"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10097 == nil then
				arg_269_1.var_.actorSpriteComps10097 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10097 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10097 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10097 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.7

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(413061066)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 28 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 28)

				if (28 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 28)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061066", "story_v_out_413061.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061066", "story_v_out_413061.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_413061", "413061066", "story_v_out_413061.awb")

						arg_269_1:RecordAudio("413061066", var_272_12)
						arg_269_1:RecordAudio("413061066", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413061", "413061066", "story_v_out_413061.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413061", "413061066", "story_v_out_413061.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_13 and arg_269_1.time_ < var_272_5 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play413061067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413061067
		arg_273_1.duration_ = 11.67

		local var_273_0 = {
			zh = 8.166,
			ja = 11.666
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
				arg_273_0:Play413061068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10097 = arg_273_1.actors_["10097"].transform.localPosition
				arg_273_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10097", 4)

				for iter_276_0 = 0, arg_273_1.actors_["10097"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["10097"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_276_2 = arg_273_1.actors_["10097"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10097 == nil then
				arg_273_1.var_.actorSpriteComps10097 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps10097 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10097 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10097 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.925

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_273_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_276_7 = arg_273_1:GetWordFromCfg(413061067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 37 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 37)

				if (37 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 37)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061067", "story_v_out_413061.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061067", "story_v_out_413061.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_413061", "413061067", "story_v_out_413061.awb")

						arg_273_1:RecordAudio("413061067", var_276_12)
						arg_273_1:RecordAudio("413061067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413061", "413061067", "story_v_out_413061.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413061", "413061067", "story_v_out_413061.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_13 and arg_273_1.time_ < var_276_5 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413061068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413061068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play413061069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.025

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(413061068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 41 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 41)

				if (41 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 41)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play413061069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413061069
		arg_281_1.duration_ = 12.7

		local var_281_0 = {
			zh = 5.466,
			ja = 12.7
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413061070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10092 = arg_281_1.actors_["10092"].transform.localPosition
				arg_281_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10092", 2)

				for iter_284_0 = 0, arg_281_1.actors_["10092"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["10092"].transform:GetChild(iter_284_0)

					if var_284_0.name == "split_2" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_284_2 = arg_281_1.actors_["10092"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10092 == nil then
				arg_281_1.var_.actorSpriteComps10092 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps10092 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10092 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps10092 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.675

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(413061069)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 27 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 27)

				if (27 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 27)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061069", "story_v_out_413061.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061069", "story_v_out_413061.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_413061", "413061069", "story_v_out_413061.awb")

						arg_281_1:RecordAudio("413061069", var_284_12)
						arg_281_1:RecordAudio("413061069", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413061", "413061069", "story_v_out_413061.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413061", "413061069", "story_v_out_413061.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play413061070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413061070
		arg_285_1.duration_ = 12.6

		local var_285_0 = {
			zh = 7.533,
			ja = 12.6
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
				arg_285_0:Play413061071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10092 = arg_285_1.actors_["10092"].transform.localPosition
				arg_285_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10092", 2)

				for iter_288_0 = 0, arg_285_1.actors_["10092"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["10092"].transform:GetChild(iter_288_0)

					if var_288_0.name == "split_1_1" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_288_2 = 0
			local var_288_3 = 0.95

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(413061070)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 38 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 38)

				if (38 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 38)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061070", "story_v_out_413061.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061070", "story_v_out_413061.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_413061", "413061070", "story_v_out_413061.awb")

						arg_285_1:RecordAudio("413061070", var_288_9)
						arg_285_1:RecordAudio("413061070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413061", "413061070", "story_v_out_413061.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413061", "413061070", "story_v_out_413061.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play413061071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413061071
		arg_289_1.duration_ = 3.83

		local var_289_0 = {
			zh = 2.5,
			ja = 3.833
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
				arg_289_0:Play413061072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10092"]) and arg_289_1.var_.actorSpriteComps10092 == nil then
				arg_289_1.var_.actorSpriteComps10092 = arg_289_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10092"]) then
				if arg_289_1.var_.actorSpriteComps10092 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10092"]) and arg_289_1.var_.actorSpriteComps10092 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10092 = nil
			end

			local var_292_2 = 0
			local var_292_3 = 0.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_289_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_292_4 = arg_289_1:GetWordFromCfg(413061071)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 9 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 9)

				if (9 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 9)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061071", "story_v_out_413061.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061071", "story_v_out_413061.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_413061", "413061071", "story_v_out_413061.awb")

						arg_289_1:RecordAudio("413061071", var_292_9)
						arg_289_1:RecordAudio("413061071", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_413061", "413061071", "story_v_out_413061.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_413061", "413061071", "story_v_out_413061.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play413061072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 413061072
		arg_293_1.duration_ = 11.13

		local var_293_0 = {
			zh = 7.533,
			ja = 11.133
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
				arg_293_0:Play413061073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10097 = arg_293_1.actors_["10097"].transform.localPosition
				arg_293_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10097", 4)

				for iter_296_0 = 0, arg_293_1.actors_["10097"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["10097"].transform:GetChild(iter_296_0)

					if var_296_0.name == "split_3" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_296_2 = arg_293_1.actors_["10097"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10097 == nil then
				arg_293_1.var_.actorSpriteComps10097 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps10097 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								iter_296_2.color = Color.New(Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_2.color.r, 1, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_2.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10097 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps10097 = nil
			end

			local var_296_5 = 0
			local var_296_6 = 0.65

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(413061072)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 26 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 26)

				if (26 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 26)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061072", "story_v_out_413061.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061072", "story_v_out_413061.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_413061", "413061072", "story_v_out_413061.awb")

						arg_293_1:RecordAudio("413061072", var_296_12)
						arg_293_1:RecordAudio("413061072", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_413061", "413061072", "story_v_out_413061.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_413061", "413061072", "story_v_out_413061.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play413061073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 413061073
		arg_297_1.duration_ = 3.77

		local var_297_0 = {
			zh = 3.766,
			ja = 3.033
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play413061074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10097"]) and arg_297_1.var_.actorSpriteComps10097 == nil then
				arg_297_1.var_.actorSpriteComps10097 = arg_297_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10097"]) then
				if arg_297_1.var_.actorSpriteComps10097 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10097"]) and arg_297_1.var_.actorSpriteComps10097 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps10097 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.35

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_297_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_300_4 = arg_297_1:GetWordFromCfg(413061073)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 14 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 14)

				if (14 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 14)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061073", "story_v_out_413061.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061073", "story_v_out_413061.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_413061", "413061073", "story_v_out_413061.awb")

						arg_297_1:RecordAudio("413061073", var_300_9)
						arg_297_1:RecordAudio("413061073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_413061", "413061073", "story_v_out_413061.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_413061", "413061073", "story_v_out_413061.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play413061074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 413061074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play413061075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10097 = arg_301_1.actors_["10097"].transform.localPosition
				arg_301_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10097", 0)

				for iter_304_0 = 0, arg_301_1.actors_["10097"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10097"].transform:GetChild(iter_304_0)

					if var_304_0.name == "" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_304_2 = arg_301_1.actors_["10092"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10092 = var_304_2.localPosition
				var_304_2.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10092", 0)

				for iter_304_1 = 0, var_304_2.childCount - 1 do
					local var_304_3 = var_304_2:GetChild(iter_304_1)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_301_1.time_ - 0) / var_304_4)
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_304_5 = arg_301_1.actors_["10097"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps10097 == nil then
				arg_301_1.var_.actorSpriteComps10097 = var_304_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_6 = 2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_6 and not isNil(var_304_5) then
				if arg_301_1.var_.actorSpriteComps10097 then
					for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_304_3 then
							if arg_301_1.isInRecall_ then
								iter_304_3.color = Color.New(Mathf.Lerp(iter_304_3.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_6), Mathf.Lerp(iter_304_3.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_6), (Mathf.Lerp(iter_304_3.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_6)))
							else
								local var_304_7 = Mathf.Lerp(iter_304_3.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_6)

								iter_304_3.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_6 and arg_301_1.time_ < 0 + var_304_6 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps10097 then
				for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_304_5 then
						iter_304_5.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10097 = nil
			end

			local var_304_8 = arg_301_1.actors_["10092"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps10092 == nil then
				arg_301_1.var_.actorSpriteComps10092 = var_304_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_9 and not isNil(var_304_8) then
				if arg_301_1.var_.actorSpriteComps10092 then
					for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_304_7 then
							if arg_301_1.isInRecall_ then
								iter_304_7.color = Color.New(Mathf.Lerp(iter_304_7.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_9), Mathf.Lerp(iter_304_7.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_9), (Mathf.Lerp(iter_304_7.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_9)))
							else
								local var_304_10 = Mathf.Lerp(iter_304_7.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_9)

								iter_304_7.color = Color.New(var_304_10, var_304_10, var_304_10)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_9 and arg_301_1.time_ < 0 + var_304_9 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps10092 then
				for iter_304_8, iter_304_9 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_304_9 then
						iter_304_9.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10092 = nil
			end

			local var_304_11 = 0
			local var_304_12 = 1.225

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_13 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(413061074).content)

				arg_301_1.text_.text = var_304_13

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_15 = 49 <= 0 and var_304_12 or var_304_12 * (utf8.len(var_304_13) / 49)

				if (49 <= 0 and var_304_12 or var_304_12 * (utf8.len(var_304_13) / 49)) > 0 and var_304_12 < var_304_15 then
					arg_301_1.talkMaxDuration = var_304_15

					if var_304_15 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_11
					end
				end

				arg_301_1.text_.text = var_304_13
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_12, arg_301_1.talkMaxDuration)

			if var_304_11 <= arg_301_1.time_ and arg_301_1.time_ < var_304_11 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_11) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_11 + var_304_16 and arg_301_1.time_ < var_304_11 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_301_1:InitPlayNodeList()
	end,
	Play413061075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413061075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play413061076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.5

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(413061075).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 60 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 60)

				if (60 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 60)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play413061076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413061076
		arg_309_1.duration_ = 9

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play413061077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if arg_309_1.bgs_.F08g == nil then
				local var_312_0 = Object.Instantiate(arg_309_1.paintGo_)

				var_312_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08g")
				var_312_0.name = "F08g"
				var_312_0.transform.parent = arg_309_1.stage_.transform
				var_312_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.bgs_.F08g = var_312_0
			end

			if 2 < arg_309_1.time_ and arg_309_1.time_ <= 2 + arg_312_0 then
				local var_312_1 = arg_309_1.bgs_.F08g

				arg_309_1.bgs_.F08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_312_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_312_2 = var_312_1:GetComponent("SpriteRenderer")

				if var_312_2 and var_312_2.sprite then
					local var_312_3 = 2 * (var_312_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_312_1.transform.localScale = Vector3.New(var_312_3 / var_312_2.sprite.bounds.size.y < var_312_3 * manager.ui.mainCameraCom_.aspect / var_312_2.sprite.bounds.size.x and var_312_3 * manager.ui.mainCameraCom_.aspect / var_312_2.sprite.bounds.size.x or var_312_3 / var_312_2.sprite.bounds.size.y, var_312_3 / var_312_2.sprite.bounds.size.y < var_312_3 * manager.ui.mainCameraCom_.aspect / var_312_2.sprite.bounds.size.x and var_312_3 * manager.ui.mainCameraCom_.aspect / var_312_2.sprite.bounds.size.x or var_312_3 / var_312_2.sprite.bounds.size.y, 0)
				end

				for iter_312_0, iter_312_1 in pairs(arg_309_1.bgs_) do
					if iter_312_0 ~= "F08g" then
						iter_312_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_312_4 = 4

			if 4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			if arg_309_1.time_ >= var_312_4 + 0.3 and arg_309_1.time_ < var_312_4 + 0.3 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end

			local var_312_5 = 0

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_6 = 2

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_6 then
				local var_312_7 = Color.New(0, 0, 0)

				var_312_7.a = Mathf.Lerp(0, 1, (arg_309_1.time_ - var_312_5) / var_312_6)
				arg_309_1.mask_.color = var_312_7
			end

			if arg_309_1.time_ >= var_312_5 + var_312_6 and arg_309_1.time_ < var_312_5 + var_312_6 + arg_312_0 then
				local var_312_8 = Color.New(0, 0, 0)

				var_312_8.a = 1
				arg_309_1.mask_.color = var_312_8
			end

			local var_312_9 = 2

			if 2 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_10 = 2

			if var_312_9 <= arg_309_1.time_ and arg_309_1.time_ < var_312_9 + var_312_10 then
				local var_312_11 = Color.New(0, 0, 0)

				var_312_11.a = Mathf.Lerp(1, 0, (arg_309_1.time_ - var_312_9) / var_312_10)
				arg_309_1.mask_.color = var_312_11
			end

			if arg_309_1.time_ >= var_312_9 + var_312_10 and arg_309_1.time_ < var_312_9 + var_312_10 + arg_312_0 then
				local var_312_12 = Color.New(0, 0, 0)

				arg_309_1.mask_.enabled = false
				var_312_12.a = 0
				arg_309_1.mask_.color = var_312_12
			end

			local var_312_13 = 2

			arg_309_1.isInRecall_ = false

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1.screenFilterGo_:SetActive(false)

				for iter_312_2, iter_312_3 in pairs(arg_309_1.actors_) do
					for iter_312_4, iter_312_5 in ipairs((iter_312_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_312_5.color = iter_312_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_312_14 = 0.0333333333333332

			if var_312_13 <= arg_309_1.time_ and arg_309_1.time_ < var_312_13 + var_312_14 then
				arg_309_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_309_1.time_ - var_312_13) / var_312_14)
			end

			if arg_309_1.time_ >= var_312_13 + var_312_14 and arg_309_1.time_ < var_312_13 + var_312_14 + arg_312_0 then
				arg_309_1.screenFilterEffect_.weight = 0
			end

			if arg_309_1.frameCnt_ <= 1 then
				arg_309_1.dialog_:SetActive(false)
			end

			local var_312_15 = 4
			local var_312_16 = 1.125

			if 4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				arg_309_1.dialog_:SetActive(true)

				arg_309_1.dialogCg_.alpha = 0

				local var_312_17 = LeanTween.value(arg_309_1.dialog_, 0, 1, 0.3)

				var_312_17:setOnUpdate(LuaHelper.FloatAction(function(arg_313_0)
					arg_309_1.dialogCg_.alpha = arg_313_0
				end))
				var_312_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_309_1.dialog_)
					var_312_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_309_1.duration_ = arg_309_1.duration_ + 0.3

				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(413061076).content)

				arg_309_1.text_.text = var_312_18

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 45 <= 0 and var_312_16 or var_312_16 * (utf8.len(var_312_18) / 45)

				if (45 <= 0 and var_312_16 or var_312_16 * (utf8.len(var_312_18) / 45)) > 0 and var_312_16 < var_312_20 then
					arg_309_1.talkMaxDuration = var_312_20
					var_312_15 = var_312_15 + 0.3

					if var_312_20 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_18
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_21 = var_312_15 + 0.3
			local var_312_22 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 + 0.3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_21 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_21) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_21 + var_312_22 and arg_309_1.time_ < var_312_21 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play413061077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413061077
		arg_315_1.duration_ = 4.7

		local var_315_0 = {
			zh = 4.7,
			ja = 3.7
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
				arg_315_0:Play413061078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.5

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:GetWordFromCfg(413061077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 20 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 20)

				if (20 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 20)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061077", "story_v_out_413061.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061077", "story_v_out_413061.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_413061", "413061077", "story_v_out_413061.awb")

						arg_315_1:RecordAudio("413061077", var_318_6)
						arg_315_1:RecordAudio("413061077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413061", "413061077", "story_v_out_413061.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413061", "413061077", "story_v_out_413061.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play413061078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413061078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play413061079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(413061078).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 40 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 40)

				if (40 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 40)) > 0 and var_322_0 < var_322_3 then
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
	Play413061079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413061079
		arg_323_1.duration_ = 7.4

		local var_323_0 = {
			zh = 6.1,
			ja = 7.4
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
				arg_323_0:Play413061080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10097 = arg_323_1.actors_["10097"].transform.localPosition
				arg_323_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10097", 3)

				for iter_326_0 = 0, arg_323_1.actors_["10097"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10097"].transform:GetChild(iter_326_0)

					if var_326_0.name == "" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_326_2 = arg_323_1.actors_["10097"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10097 == nil then
				arg_323_1.var_.actorSpriteComps10097 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10097 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10097 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10097 = nil
			end

			local var_326_5 = 0
			local var_326_6 = 0.575

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_7 = arg_323_1:GetWordFromCfg(413061079)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 23 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 23)

				if (23 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 23)) > 0 and var_326_6 < var_326_10 then
					arg_323_1.talkMaxDuration = var_326_10

					if var_326_10 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061079", "story_v_out_413061.awb") ~= 0 then
					local var_326_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061079", "story_v_out_413061.awb") / 1000

					if var_326_11 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_5
					end

					if var_326_7.prefab_name ~= "" and arg_323_1.actors_[var_326_7.prefab_name] ~= nil then
						local var_326_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_7.prefab_name].transform, "story_v_out_413061", "413061079", "story_v_out_413061.awb")

						arg_323_1:RecordAudio("413061079", var_326_12)
						arg_323_1:RecordAudio("413061079", var_326_12)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413061", "413061079", "story_v_out_413061.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413061", "413061079", "story_v_out_413061.awb")
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
				actorName = "10097",
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
	Play413061080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413061080
		arg_327_1.duration_ = 7.63

		local var_327_0 = {
			zh = 5.566,
			ja = 7.633
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play413061081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.4

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(413061080)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 16 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 16)

				if (16 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 16)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061080", "story_v_out_413061.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061080", "story_v_out_413061.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_413061", "413061080", "story_v_out_413061.awb")

						arg_327_1:RecordAudio("413061080", var_330_6)
						arg_327_1:RecordAudio("413061080", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413061", "413061080", "story_v_out_413061.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413061", "413061080", "story_v_out_413061.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play413061081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413061081
		arg_331_1.duration_ = 6.57

		local var_331_0 = {
			zh = 4.066,
			ja = 6.566
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
				arg_331_0:Play413061082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.3

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(413061081)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 12 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 12)

				if (12 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 12)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061081", "story_v_out_413061.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061081", "story_v_out_413061.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_413061", "413061081", "story_v_out_413061.awb")

						arg_331_1:RecordAudio("413061081", var_334_6)
						arg_331_1:RecordAudio("413061081", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413061", "413061081", "story_v_out_413061.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413061", "413061081", "story_v_out_413061.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play413061082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413061082
		arg_335_1.duration_ = 8.57

		local var_335_0 = {
			zh = 7.6,
			ja = 8.566
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
				arg_335_0:Play413061083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10097 = arg_335_1.actors_["10097"].transform.localPosition
				arg_335_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10097", 3)

				for iter_338_0 = 0, arg_335_1.actors_["10097"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["10097"].transform:GetChild(iter_338_0)

					if var_338_0.name == "" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_338_2 = arg_335_1.actors_["10097"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10097 == nil then
				arg_335_1.var_.actorSpriteComps10097 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10097 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								iter_338_2.color = Color.New(Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_2.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_2.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10097 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_338_4 then
						iter_338_4.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps10097 = nil
			end

			local var_338_5 = 0
			local var_338_6 = 0.7

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_7 = arg_335_1:GetWordFromCfg(413061082)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 28 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 28)

				if (28 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 28)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061082", "story_v_out_413061.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061082", "story_v_out_413061.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_413061", "413061082", "story_v_out_413061.awb")

						arg_335_1:RecordAudio("413061082", var_338_12)
						arg_335_1:RecordAudio("413061082", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_413061", "413061082", "story_v_out_413061.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_413061", "413061082", "story_v_out_413061.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play413061083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413061083
		arg_339_1.duration_ = 12.23

		local var_339_0 = {
			zh = 6.166,
			ja = 12.233
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play413061084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10097"]) and arg_339_1.var_.actorSpriteComps10097 == nil then
				arg_339_1.var_.actorSpriteComps10097 = arg_339_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10097"]) then
				if arg_339_1.var_.actorSpriteComps10097 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 1, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10097"]) and arg_339_1.var_.actorSpriteComps10097 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10097 = nil
			end

			local var_342_2 = 0
			local var_342_3 = 0.4

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_4 = arg_339_1:GetWordFromCfg(413061083)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 16 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 16)

				if (16 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 16)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061083", "story_v_out_413061.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_413061", "413061083", "story_v_out_413061.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_out_413061", "413061083", "story_v_out_413061.awb")

						arg_339_1:RecordAudio("413061083", var_342_9)
						arg_339_1:RecordAudio("413061083", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413061", "413061083", "story_v_out_413061.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413061", "413061083", "story_v_out_413061.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play413061084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413061084
		arg_343_1.duration_ = 4.87

		local var_343_0 = {
			zh = 2.733,
			ja = 4.866
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
				arg_343_0:Play413061085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10097 = arg_343_1.actors_["10097"].transform.localPosition
				arg_343_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10097", 3)

				for iter_346_0 = 0, arg_343_1.actors_["10097"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10097"].transform:GetChild(iter_346_0)

					if var_346_0.name == "" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_346_2 = arg_343_1.actors_["10097"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10097 == nil then
				arg_343_1.var_.actorSpriteComps10097 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps10097 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								iter_346_2.color = Color.New(Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_2.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_2.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10097 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_346_4 then
						iter_346_4.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10097 = nil
			end

			local var_346_5 = 0
			local var_346_6 = 0.275

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_7 = arg_343_1:GetWordFromCfg(413061084)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 11 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 11)

				if (11 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 11)) > 0 and var_346_6 < var_346_10 then
					arg_343_1.talkMaxDuration = var_346_10

					if var_346_10 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061084", "story_v_out_413061.awb") ~= 0 then
					local var_346_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061084", "story_v_out_413061.awb") / 1000

					if var_346_11 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_5
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_out_413061", "413061084", "story_v_out_413061.awb")

						arg_343_1:RecordAudio("413061084", var_346_12)
						arg_343_1:RecordAudio("413061084", var_346_12)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413061", "413061084", "story_v_out_413061.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413061", "413061084", "story_v_out_413061.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_13 and arg_343_1.time_ < var_346_5 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413061085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413061085
		arg_347_1.duration_ = 8.23

		local var_347_0 = {
			zh = 8.233,
			ja = 7.9
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
				arg_347_0:Play413061086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.625

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(413061085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 25 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 25)

				if (25 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 25)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061085", "story_v_out_413061.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061085", "story_v_out_413061.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_413061", "413061085", "story_v_out_413061.awb")

						arg_347_1:RecordAudio("413061085", var_350_6)
						arg_347_1:RecordAudio("413061085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413061", "413061085", "story_v_out_413061.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413061", "413061085", "story_v_out_413061.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play413061086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413061086
		arg_351_1.duration_ = 10.3

		local var_351_0 = {
			zh = 6.233,
			ja = 10.3
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
				arg_351_0:Play413061087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10097 = arg_351_1.actors_["10097"].transform.localPosition
				arg_351_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10097", 3)

				for iter_354_0 = 0, arg_351_1.actors_["10097"].transform.childCount - 1 do
					local var_354_0 = arg_351_1.actors_["10097"].transform:GetChild(iter_354_0)

					if var_354_0.name == "" or not string.find(var_354_0.name, "split") then
						var_354_0.gameObject:SetActive(true)
					else
						var_354_0.gameObject:SetActive(false)
					end
				end
			end

			local var_354_1 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				arg_351_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_351_1.time_ - 0) / var_354_1)
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 then
				arg_351_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_354_2 = arg_351_1.actors_["10097"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10097 == nil then
				arg_351_1.var_.actorSpriteComps10097 = var_354_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_3 = 2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.actorSpriteComps10097 then
					for iter_354_1, iter_354_2 in pairs(arg_351_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_354_2 then
							if arg_351_1.isInRecall_ then
								iter_354_2.color = Color.New(Mathf.Lerp(iter_354_2.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_3), Mathf.Lerp(iter_354_2.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_3), (Mathf.Lerp(iter_354_2.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_3)))
							else
								local var_354_4 = Mathf.Lerp(iter_354_2.color.r, 1, (arg_351_1.time_ - 0) / var_354_3)

								iter_354_2.color = Color.New(var_354_4, var_354_4, var_354_4)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10097 then
				for iter_354_3, iter_354_4 in pairs(arg_351_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_354_4 then
						iter_354_4.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps10097 = nil
			end

			local var_354_5 = 0
			local var_354_6 = 0.5

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(413061086)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 20 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 20)

				if (20 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 20)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061086", "story_v_out_413061.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061086", "story_v_out_413061.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_413061", "413061086", "story_v_out_413061.awb")

						arg_351_1:RecordAudio("413061086", var_354_12)
						arg_351_1:RecordAudio("413061086", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413061", "413061086", "story_v_out_413061.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413061", "413061086", "story_v_out_413061.awb")
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play413061087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413061087
		arg_355_1.duration_ = 6.03

		local var_355_0 = {
			zh = 6.033,
			ja = 4.566
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
				arg_355_0:Play413061088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.325

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(413061087)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 13)

				if (13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 13)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061087", "story_v_out_413061.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061087", "story_v_out_413061.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_413061", "413061087", "story_v_out_413061.awb")

						arg_355_1:RecordAudio("413061087", var_358_6)
						arg_355_1:RecordAudio("413061087", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413061", "413061087", "story_v_out_413061.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413061", "413061087", "story_v_out_413061.awb")
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
	Play413061088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413061088
		arg_359_1.duration_ = 9.27

		local var_359_0 = {
			zh = 9.266,
			ja = 8.1
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
				arg_359_0:Play413061089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10097 = arg_359_1.actors_["10097"].transform.localPosition
				arg_359_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10097", 7)

				for iter_362_0 = 0, arg_359_1.actors_["10097"].transform.childCount - 1 do
					local var_362_0 = arg_359_1.actors_["10097"].transform:GetChild(iter_362_0)

					if var_362_0.name == "" or not string.find(var_362_0.name, "split") then
						var_362_0.gameObject:SetActive(true)
					else
						var_362_0.gameObject:SetActive(false)
					end
				end
			end

			local var_362_1 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 then
				arg_359_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_359_1.time_ - 0) / var_362_1)
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 then
				arg_359_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_362_2 = arg_359_1.actors_["10097"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10097 == nil then
				arg_359_1.var_.actorSpriteComps10097 = var_362_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_3 = 2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.actorSpriteComps10097 then
					for iter_362_1, iter_362_2 in pairs(arg_359_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_362_2 then
							if arg_359_1.isInRecall_ then
								iter_362_2.color = Color.New(Mathf.Lerp(iter_362_2.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 0) / var_362_3), Mathf.Lerp(iter_362_2.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 0) / var_362_3), (Mathf.Lerp(iter_362_2.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 0) / var_362_3)))
							else
								local var_362_4 = Mathf.Lerp(iter_362_2.color.r, 0.5, (arg_359_1.time_ - 0) / var_362_3)

								iter_362_2.color = Color.New(var_362_4, var_362_4, var_362_4)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10097 then
				for iter_362_3, iter_362_4 in pairs(arg_359_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_362_4 then
						iter_362_4.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps10097 = nil
			end

			local var_362_5 = manager.ui.mainCamera.transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.shakeOldPos = var_362_5.localPosition
			end

			local var_362_6 = 0.6

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_6 then
				local var_362_7, var_362_8 = math.modf((arg_359_1.time_ - 0) / 0.066)

				var_362_5.localPosition = Vector3.New(var_362_8 * 0.13, var_362_8 * 0.13, var_362_8 * 0.13) + arg_359_1.var_.shakeOldPos
			end

			if arg_359_1.time_ >= 0 + var_362_6 and arg_359_1.time_ < 0 + var_362_6 + arg_362_0 then
				var_362_5.localPosition = arg_359_1.var_.shakeOldPos
			end

			local var_362_9 = 0

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			if arg_359_1.time_ >= var_362_9 + 0.6 and arg_359_1.time_ < var_362_9 + 0.6 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_10 = 0

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			if arg_359_1.time_ >= var_362_10 + 0.633333333333333 and arg_359_1.time_ < var_362_10 + 0.633333333333333 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_362_13 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if "" ~= "" then
					if arg_359_1.bgmTxt_.text ~= var_362_13 and arg_359_1.bgmTxt_.text ~= "" then
						if arg_359_1.bgmTxt2_.text ~= "" then
							arg_359_1.bgmTxt_.text = arg_359_1.bgmTxt2_.text
						end

						arg_359_1.bgmTxt2_.text = var_362_13

						arg_359_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_359_1.bgmTxt_.text = var_362_13
						arg_359_1.bgmTxt2_.text = var_362_13
					end

					if arg_359_1.bgmTimer then
						arg_359_1.bgmTimer:Stop()

						arg_359_1.bgmTimer = nil
					end

					if arg_359_1.settingData.show_music_name == 1 then
						arg_359_1.musicController:SetSelectedState("show")
						arg_359_1.musicAnimator_:Play("open", 0, 0)

						if arg_359_1.settingData.music_time ~= 0 then
							arg_359_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_359_1.settingData.music_time), function()
								if arg_359_1 == nil or isNil(arg_359_1.bgmTxt_) then
									return
								end

								arg_359_1.musicController:SetSelectedState("hide")
								arg_359_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_14 = 0.6
			local var_362_15 = 0.6

			if 0.6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_14 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_16 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_16:setOnUpdate(LuaHelper.FloatAction(function(arg_364_0)
					arg_359_1.dialogCg_.alpha = arg_364_0
				end))
				var_362_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_17 = arg_359_1:GetWordFromCfg(413061088)
				local var_362_18 = arg_359_1:FormatText(var_362_17.content)

				arg_359_1.text_.text = var_362_18

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 24 <= 0 and var_362_15 or var_362_15 * (utf8.len(var_362_18) / 24)

				if (24 <= 0 and var_362_15 or var_362_15 * (utf8.len(var_362_18) / 24)) > 0 and var_362_15 < var_362_20 then
					arg_359_1.talkMaxDuration = var_362_20
					var_362_14 = var_362_14 + 0.3

					if var_362_20 + var_362_14 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_20 + var_362_14
					end
				end

				arg_359_1.text_.text = var_362_18
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061088", "story_v_out_413061.awb") ~= 0 then
					local var_362_21 = manager.audio:GetVoiceLength("story_v_out_413061", "413061088", "story_v_out_413061.awb") / 1000

					if var_362_21 + var_362_14 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_21 + var_362_14
					end

					if var_362_17.prefab_name ~= "" and arg_359_1.actors_[var_362_17.prefab_name] ~= nil then
						local var_362_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_17.prefab_name].transform, "story_v_out_413061", "413061088", "story_v_out_413061.awb")

						arg_359_1:RecordAudio("413061088", var_362_22)
						arg_359_1:RecordAudio("413061088", var_362_22)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_413061", "413061088", "story_v_out_413061.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_413061", "413061088", "story_v_out_413061.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_23 = var_362_14 + 0.3
			local var_362_24 = math.max(var_362_15, arg_359_1.talkMaxDuration)

			if var_362_14 + 0.3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_23 + var_362_24 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_23) / var_362_24

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_23 + var_362_24 and arg_359_1.time_ < var_362_23 + var_362_24 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play413061089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 413061089
		arg_366_1.duration_ = 4.3

		local var_366_0 = {
			zh = 4.3,
			ja = 2.9
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play413061090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.15

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1000].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:GetWordFromCfg(413061089)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 6 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 6)

				if (6 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 6)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061089", "story_v_out_413061.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061089", "story_v_out_413061.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_out_413061", "413061089", "story_v_out_413061.awb")

						arg_366_1:RecordAudio("413061089", var_369_6)
						arg_366_1:RecordAudio("413061089", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_413061", "413061089", "story_v_out_413061.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_413061", "413061089", "story_v_out_413061.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play413061090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 413061090
		arg_370_1.duration_ = 7.77

		local var_370_0 = {
			zh = 7.766,
			ja = 3.033
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play413061091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 1 < arg_370_1.time_ and arg_370_1.time_ <= 1 + arg_373_0 then
				arg_370_1.allBtn_.enabled = false
			end

			if arg_370_1.time_ >= 1 + 0.6 and arg_370_1.time_ < 1 + 0.6 + arg_373_0 then
				arg_370_1.allBtn_.enabled = true
			end

			local var_373_0 = manager.ui.mainCamera.transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.shakeOldPos = var_373_0.localPosition
			end

			local var_373_1 = 1.6

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_1 then
				local var_373_2, var_373_3 = math.modf((arg_370_1.time_ - 0) / 0.066)

				var_373_0.localPosition = Vector3.New(var_373_3 * 0.13, var_373_3 * 0.13, var_373_3 * 0.13) + arg_370_1.var_.shakeOldPos
			end

			if arg_370_1.time_ >= 0 + var_373_1 and arg_370_1.time_ < 0 + var_373_1 + arg_373_0 then
				var_373_0.localPosition = arg_370_1.var_.shakeOldPos
			end

			local var_373_4 = 0
			local var_373_5 = 0.375

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_6 = arg_370_1:GetWordFromCfg(413061090)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 15 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 15)

				if (15 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 15)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061090", "story_v_out_413061.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_out_413061", "413061090", "story_v_out_413061.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_out_413061", "413061090", "story_v_out_413061.awb")

						arg_370_1:RecordAudio("413061090", var_373_11)
						arg_370_1:RecordAudio("413061090", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_413061", "413061090", "story_v_out_413061.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_413061", "413061090", "story_v_out_413061.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play413061091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 413061091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play413061092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 1.425

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(413061091).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 57 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 57)

				if (57 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 57)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play413061092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 413061092
		arg_378_1.duration_ = 6.03

		local var_378_0 = {
			zh = 6.033,
			ja = 2.7
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play413061093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.225

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_1 = arg_378_1:GetWordFromCfg(413061092)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 9 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 9)

				if (9 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 9)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061092", "story_v_out_413061.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061092", "story_v_out_413061.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_413061", "413061092", "story_v_out_413061.awb")

						arg_378_1:RecordAudio("413061092", var_381_6)
						arg_378_1:RecordAudio("413061092", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_413061", "413061092", "story_v_out_413061.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_413061", "413061092", "story_v_out_413061.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play413061093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 413061093
		arg_382_1.duration_ = 11.8

		local var_382_0 = {
			zh = 11.8,
			ja = 5.366
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play413061094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.35

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:GetWordFromCfg(413061093)
				local var_385_2 = arg_382_1:FormatText(var_385_1.content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 14 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 14)

				if (14 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 14)) > 0 and var_385_0 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + 0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061093", "story_v_out_413061.awb") ~= 0 then
					local var_385_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061093", "story_v_out_413061.awb") / 1000

					if var_385_5 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + 0
					end

					if var_385_1.prefab_name ~= "" and arg_382_1.actors_[var_385_1.prefab_name] ~= nil then
						local var_385_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_1.prefab_name].transform, "story_v_out_413061", "413061093", "story_v_out_413061.awb")

						arg_382_1:RecordAudio("413061093", var_385_6)
						arg_382_1:RecordAudio("413061093", var_385_6)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_413061", "413061093", "story_v_out_413061.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_413061", "413061093", "story_v_out_413061.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play413061094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 413061094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play413061095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 1.525

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(413061094).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 61 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 61)

				if (61 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 61)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play413061095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 413061095
		arg_390_1.duration_ = 6.47

		local var_390_0 = {
			zh = 6.2,
			ja = 6.466
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play413061096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos10097 = arg_390_1.actors_["10097"].transform.localPosition
				arg_390_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10097", 3)

				for iter_393_0 = 0, arg_390_1.actors_["10097"].transform.childCount - 1 do
					local var_393_0 = arg_390_1.actors_["10097"].transform:GetChild(iter_393_0)

					if var_393_0.name == "split_2" or not string.find(var_393_0.name, "split") then
						var_393_0.gameObject:SetActive(true)
					else
						var_393_0.gameObject:SetActive(false)
					end
				end
			end

			local var_393_1 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_1 then
				arg_390_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_390_1.time_ - 0) / var_393_1)
			end

			if arg_390_1.time_ >= 0 + var_393_1 and arg_390_1.time_ < 0 + var_393_1 + arg_393_0 then
				arg_390_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_393_2 = arg_390_1.actors_["10097"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps10097 == nil then
				arg_390_1.var_.actorSpriteComps10097 = var_393_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_3 = 2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.actorSpriteComps10097 then
					for iter_393_1, iter_393_2 in pairs(arg_390_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_393_2 then
							if arg_390_1.isInRecall_ then
								iter_393_2.color = Color.New(Mathf.Lerp(iter_393_2.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_3), Mathf.Lerp(iter_393_2.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_3), (Mathf.Lerp(iter_393_2.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_3)))
							else
								local var_393_4 = Mathf.Lerp(iter_393_2.color.r, 1, (arg_390_1.time_ - 0) / var_393_3)

								iter_393_2.color = Color.New(var_393_4, var_393_4, var_393_4)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps10097 then
				for iter_393_3, iter_393_4 in pairs(arg_390_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_393_4 then
						iter_393_4.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps10097 = nil
			end

			local var_393_5 = 0
			local var_393_6 = 0.425

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:GetWordFromCfg(413061095)
				local var_393_8 = arg_390_1:FormatText(var_393_7.content)

				arg_390_1.text_.text = var_393_8

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_10 = 17 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 17)

				if (17 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 17)) > 0 and var_393_6 < var_393_10 then
					arg_390_1.talkMaxDuration = var_393_10

					if var_393_10 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_8
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061095", "story_v_out_413061.awb") ~= 0 then
					local var_393_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061095", "story_v_out_413061.awb") / 1000

					if var_393_11 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_5
					end

					if var_393_7.prefab_name ~= "" and arg_390_1.actors_[var_393_7.prefab_name] ~= nil then
						local var_393_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_7.prefab_name].transform, "story_v_out_413061", "413061095", "story_v_out_413061.awb")

						arg_390_1:RecordAudio("413061095", var_393_12)
						arg_390_1:RecordAudio("413061095", var_393_12)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_413061", "413061095", "story_v_out_413061.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_413061", "413061095", "story_v_out_413061.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_13 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_13 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_13

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_13 and arg_390_1.time_ < var_393_5 + var_393_13 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413061096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 413061096
		arg_394_1.duration_ = 8.43

		local var_394_0 = {
			zh = 8.433,
			ja = 7.4
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play413061097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.575

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:GetWordFromCfg(413061096)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 23 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 23)

				if (23 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 23)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061096", "story_v_out_413061.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061096", "story_v_out_413061.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_413061", "413061096", "story_v_out_413061.awb")

						arg_394_1:RecordAudio("413061096", var_397_6)
						arg_394_1:RecordAudio("413061096", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_413061", "413061096", "story_v_out_413061.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_413061", "413061096", "story_v_out_413061.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play413061097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 413061097
		arg_398_1.duration_ = 7.7

		local var_398_0 = {
			zh = 5.333,
			ja = 7.7
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play413061098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.3

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(413061097)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 12 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 12)

				if (12 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 12)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061097", "story_v_out_413061.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061097", "story_v_out_413061.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_413061", "413061097", "story_v_out_413061.awb")

						arg_398_1:RecordAudio("413061097", var_401_6)
						arg_398_1:RecordAudio("413061097", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_413061", "413061097", "story_v_out_413061.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_413061", "413061097", "story_v_out_413061.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play413061098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 413061098
		arg_402_1.duration_ = 10.47

		local var_402_0 = {
			zh = 8,
			ja = 10.466
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play413061099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 2 < arg_402_1.time_ and arg_402_1.time_ <= 2 + arg_405_0 then
				local var_405_0 = arg_402_1.bgs_.F10g

				arg_402_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_405_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_405_1 = var_405_0:GetComponent("SpriteRenderer")

				if var_405_1 and var_405_1.sprite then
					local var_405_2 = 2 * (var_405_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_405_0.transform.localScale = Vector3.New(var_405_2 / var_405_1.sprite.bounds.size.y < var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x and var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x or var_405_2 / var_405_1.sprite.bounds.size.y, var_405_2 / var_405_1.sprite.bounds.size.y < var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x and var_405_2 * manager.ui.mainCameraCom_.aspect / var_405_1.sprite.bounds.size.x or var_405_2 / var_405_1.sprite.bounds.size.y, 0)
				end

				for iter_405_0, iter_405_1 in pairs(arg_402_1.bgs_) do
					if iter_405_0 ~= "F10g" then
						iter_405_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_405_3 = 3.999999999999

			if 3.999999999999 < arg_402_1.time_ and arg_402_1.time_ <= var_405_3 + arg_405_0 then
				arg_402_1.allBtn_.enabled = false
			end

			if arg_402_1.time_ >= var_405_3 + 0.3 and arg_402_1.time_ < var_405_3 + 0.3 + arg_405_0 then
				arg_402_1.allBtn_.enabled = true
			end

			local var_405_4 = 0

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_4 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_5 = 2

			if var_405_4 <= arg_402_1.time_ and arg_402_1.time_ < var_405_4 + var_405_5 then
				local var_405_6 = Color.New(0, 0, 0)

				var_405_6.a = Mathf.Lerp(0, 1, (arg_402_1.time_ - var_405_4) / var_405_5)
				arg_402_1.mask_.color = var_405_6
			end

			if arg_402_1.time_ >= var_405_4 + var_405_5 and arg_402_1.time_ < var_405_4 + var_405_5 + arg_405_0 then
				local var_405_7 = Color.New(0, 0, 0)

				var_405_7.a = 1
				arg_402_1.mask_.color = var_405_7
			end

			local var_405_8 = 2

			if 2 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_9 = 2

			if var_405_8 <= arg_402_1.time_ and arg_402_1.time_ < var_405_8 + var_405_9 then
				local var_405_10 = Color.New(0, 0, 0)

				var_405_10.a = Mathf.Lerp(1, 0, (arg_402_1.time_ - var_405_8) / var_405_9)
				arg_402_1.mask_.color = var_405_10
			end

			if arg_402_1.time_ >= var_405_8 + var_405_9 and arg_402_1.time_ < var_405_8 + var_405_9 + arg_405_0 then
				local var_405_11 = Color.New(0, 0, 0)

				arg_402_1.mask_.enabled = false
				var_405_11.a = 0
				arg_402_1.mask_.color = var_405_11
			end

			local var_405_12 = arg_402_1.actors_["10097"].transform

			if 1.966 < arg_402_1.time_ and arg_402_1.time_ <= 1.966 + arg_405_0 then
				arg_402_1.var_.moveOldPos10097 = var_405_12.localPosition
				var_405_12.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10097", 0)

				for iter_405_2 = 0, var_405_12.childCount - 1 do
					local var_405_13 = var_405_12:GetChild(iter_405_2)

					if var_405_13.name == "" or not string.find(var_405_13.name, "split") then
						var_405_13.gameObject:SetActive(true)
					else
						var_405_13.gameObject:SetActive(false)
					end
				end
			end

			local var_405_14 = 0.001

			if 1.966 <= arg_402_1.time_ and arg_402_1.time_ < 1.966 + var_405_14 then
				var_405_12.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_402_1.time_ - 1.966) / var_405_14)
			end

			if arg_402_1.time_ >= 1.966 + var_405_14 and arg_402_1.time_ < 1.966 + var_405_14 + arg_405_0 then
				var_405_12.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_405_15 = arg_402_1.actors_["10092"].transform

			if 3.8 < arg_402_1.time_ and arg_402_1.time_ <= 3.8 + arg_405_0 then
				arg_402_1.var_.moveOldPos10092 = var_405_15.localPosition
				var_405_15.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10092", 4)

				for iter_405_3 = 0, var_405_15.childCount - 1 do
					local var_405_16 = var_405_15:GetChild(iter_405_3)

					if var_405_16.name == "split_4" or not string.find(var_405_16.name, "split") then
						var_405_16.gameObject:SetActive(true)
					else
						var_405_16.gameObject:SetActive(false)
					end
				end
			end

			local var_405_17 = 0.001

			if 3.8 <= arg_402_1.time_ and arg_402_1.time_ < 3.8 + var_405_17 then
				var_405_15.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_402_1.time_ - 3.8) / var_405_17)
			end

			if arg_402_1.time_ >= 3.8 + var_405_17 and arg_402_1.time_ < 3.8 + var_405_17 + arg_405_0 then
				var_405_15.localPosition = Vector3.New(390, -300, -295)
			end

			local var_405_18 = arg_402_1.actors_["10097"]

			if 1.966 < arg_402_1.time_ and arg_402_1.time_ <= 1.966 + arg_405_0 and not isNil(var_405_18) and arg_402_1.var_.actorSpriteComps10097 == nil then
				arg_402_1.var_.actorSpriteComps10097 = var_405_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_19 = 0.034

			if 1.966 <= arg_402_1.time_ and arg_402_1.time_ < 1.966 + var_405_19 and not isNil(var_405_18) then
				if arg_402_1.var_.actorSpriteComps10097 then
					for iter_405_4, iter_405_5 in pairs(arg_402_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_405_5 then
							if arg_402_1.isInRecall_ then
								iter_405_5.color = Color.New(Mathf.Lerp(iter_405_5.color.r, arg_402_1.hightColor2.r, (arg_402_1.time_ - 1.966) / var_405_19), Mathf.Lerp(iter_405_5.color.g, arg_402_1.hightColor2.g, (arg_402_1.time_ - 1.966) / var_405_19), (Mathf.Lerp(iter_405_5.color.b, arg_402_1.hightColor2.b, (arg_402_1.time_ - 1.966) / var_405_19)))
							else
								local var_405_20 = Mathf.Lerp(iter_405_5.color.r, 0.5, (arg_402_1.time_ - 1.966) / var_405_19)

								iter_405_5.color = Color.New(var_405_20, var_405_20, var_405_20)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 1.966 + var_405_19 and arg_402_1.time_ < 1.966 + var_405_19 + arg_405_0 and not isNil(var_405_18) and arg_402_1.var_.actorSpriteComps10097 then
				for iter_405_6, iter_405_7 in pairs(arg_402_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_405_7 then
						iter_405_7.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_402_1.var_.actorSpriteComps10097 = nil
			end

			local var_405_21 = arg_402_1.actors_["10092"]

			if 3.8 < arg_402_1.time_ and arg_402_1.time_ <= 3.8 + arg_405_0 and not isNil(var_405_21) and arg_402_1.var_.actorSpriteComps10092 == nil then
				arg_402_1.var_.actorSpriteComps10092 = var_405_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_22 = 0.2

			if 3.8 <= arg_402_1.time_ and arg_402_1.time_ < 3.8 + var_405_22 and not isNil(var_405_21) then
				if arg_402_1.var_.actorSpriteComps10092 then
					for iter_405_8, iter_405_9 in pairs(arg_402_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_405_9 then
							if arg_402_1.isInRecall_ then
								iter_405_9.color = Color.New(Mathf.Lerp(iter_405_9.color.r, arg_402_1.hightColor1.r, (arg_402_1.time_ - 3.8) / var_405_22), Mathf.Lerp(iter_405_9.color.g, arg_402_1.hightColor1.g, (arg_402_1.time_ - 3.8) / var_405_22), (Mathf.Lerp(iter_405_9.color.b, arg_402_1.hightColor1.b, (arg_402_1.time_ - 3.8) / var_405_22)))
							else
								local var_405_23 = Mathf.Lerp(iter_405_9.color.r, 1, (arg_402_1.time_ - 3.8) / var_405_22)

								iter_405_9.color = Color.New(var_405_23, var_405_23, var_405_23)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 3.8 + var_405_22 and arg_402_1.time_ < 3.8 + var_405_22 + arg_405_0 and not isNil(var_405_21) and arg_402_1.var_.actorSpriteComps10092 then
				for iter_405_10, iter_405_11 in pairs(arg_402_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_405_11 then
						iter_405_11.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_402_1.var_.actorSpriteComps10092 = nil
			end

			if 3.799999999999 < arg_402_1.time_ and arg_402_1.time_ <= 3.799999999999 + arg_405_0 then
				local var_405_24 = arg_402_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_405_24 then
					arg_402_1.var_.alphaOldValue10092 = var_405_24.alpha
					arg_402_1.var_.characterEffect10092 = var_405_24
				end

				arg_402_1.var_.alphaOldValue10092 = 0
			end

			local var_405_25 = 0.5

			if 3.799999999999 <= arg_402_1.time_ and arg_402_1.time_ < 3.799999999999 + var_405_25 then
				if arg_402_1.var_.characterEffect10092 then
					arg_402_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_402_1.var_.alphaOldValue10092, 1, (arg_402_1.time_ - 3.799999999999) / var_405_25)
				end
			end

			if arg_402_1.time_ >= 3.799999999999 + var_405_25 and arg_402_1.time_ < 3.799999999999 + var_405_25 + arg_405_0 and arg_402_1.var_.characterEffect10092 then
				arg_402_1.var_.characterEffect10092.alpha = 1
			end

			if 1.966 < arg_402_1.time_ and arg_402_1.time_ <= 1.966 + arg_405_0 then
				arg_402_1:AudioAction("play", "music", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_405_28 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

				if "" ~= "" then
					if arg_402_1.bgmTxt_.text ~= var_405_28 and arg_402_1.bgmTxt_.text ~= "" then
						if arg_402_1.bgmTxt2_.text ~= "" then
							arg_402_1.bgmTxt_.text = arg_402_1.bgmTxt2_.text
						end

						arg_402_1.bgmTxt2_.text = var_405_28

						arg_402_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_402_1.bgmTxt_.text = var_405_28
						arg_402_1.bgmTxt2_.text = var_405_28
					end

					if arg_402_1.bgmTimer then
						arg_402_1.bgmTimer:Stop()

						arg_402_1.bgmTimer = nil
					end

					if arg_402_1.settingData.show_music_name == 1 then
						arg_402_1.musicController:SetSelectedState("show")
						arg_402_1.musicAnimator_:Play("open", 0, 0)

						if arg_402_1.settingData.music_time ~= 0 then
							arg_402_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_402_1.settingData.music_time), function()
								if arg_402_1 == nil or isNil(arg_402_1.bgmTxt_) then
									return
								end

								arg_402_1.musicController:SetSelectedState("hide")
								arg_402_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_402_1.frameCnt_ <= 1 then
				arg_402_1.dialog_:SetActive(false)
			end

			local var_405_29 = 4
			local var_405_30 = 0.475

			if 4 < arg_402_1.time_ and arg_402_1.time_ <= var_405_29 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0

				arg_402_1.dialog_:SetActive(true)

				arg_402_1.dialogCg_.alpha = 0

				local var_405_31 = LeanTween.value(arg_402_1.dialog_, 0, 1, 0.3)

				var_405_31:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_402_1.dialogCg_.alpha = arg_407_0
				end))
				var_405_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_402_1.dialog_)
					var_405_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_402_1.duration_ = arg_402_1.duration_ + 0.3

				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_32 = arg_402_1:GetWordFromCfg(413061098)
				local var_405_33 = arg_402_1:FormatText(var_405_32.content)

				arg_402_1.text_.text = var_405_33

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_35 = 19 <= 0 and var_405_30 or var_405_30 * (utf8.len(var_405_33) / 19)

				if (19 <= 0 and var_405_30 or var_405_30 * (utf8.len(var_405_33) / 19)) > 0 and var_405_30 < var_405_35 then
					arg_402_1.talkMaxDuration = var_405_35
					var_405_29 = var_405_29 + 0.3

					if var_405_35 + var_405_29 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_35 + var_405_29
					end
				end

				arg_402_1.text_.text = var_405_33
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061098", "story_v_out_413061.awb") ~= 0 then
					local var_405_36 = manager.audio:GetVoiceLength("story_v_out_413061", "413061098", "story_v_out_413061.awb") / 1000

					if var_405_36 + var_405_29 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_36 + var_405_29
					end

					if var_405_32.prefab_name ~= "" and arg_402_1.actors_[var_405_32.prefab_name] ~= nil then
						local var_405_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_32.prefab_name].transform, "story_v_out_413061", "413061098", "story_v_out_413061.awb")

						arg_402_1:RecordAudio("413061098", var_405_37)
						arg_402_1:RecordAudio("413061098", var_405_37)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_413061", "413061098", "story_v_out_413061.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_413061", "413061098", "story_v_out_413061.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_38 = var_405_29 + 0.3
			local var_405_39 = math.max(var_405_30, arg_402_1.talkMaxDuration)

			if var_405_29 + 0.3 <= arg_402_1.time_ and arg_402_1.time_ < var_405_38 + var_405_39 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_38) / var_405_39

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_38 + var_405_39 and arg_402_1.time_ < var_405_38 + var_405_39 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play413061099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 413061099
		arg_409_1.duration_ = 3.7

		local var_409_0 = {
			zh = 3.4,
			ja = 3.7
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
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play413061100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10093 = arg_409_1.actors_["10093"].transform.localPosition
				arg_409_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10093", 2)

				for iter_412_0 = 0, arg_409_1.actors_["10093"].transform.childCount - 1 do
					local var_412_0 = arg_409_1.actors_["10093"].transform:GetChild(iter_412_0)

					if var_412_0.name == "split_4" or not string.find(var_412_0.name, "split") then
						var_412_0.gameObject:SetActive(true)
					else
						var_412_0.gameObject:SetActive(false)
					end
				end
			end

			local var_412_1 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				arg_409_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_409_1.time_ - 0) / var_412_1)
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 then
				arg_409_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_412_2 = arg_409_1.actors_["10093"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps10093 == nil then
				arg_409_1.var_.actorSpriteComps10093 = var_412_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_3 = 2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.actorSpriteComps10093 then
					for iter_412_1, iter_412_2 in pairs(arg_409_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps10093 then
				for iter_412_3, iter_412_4 in pairs(arg_409_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_412_4 then
						iter_412_4.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps10093 = nil
			end

			local var_412_5 = arg_409_1.actors_["10092"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps10092 == nil then
				arg_409_1.var_.actorSpriteComps10092 = var_412_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_6 = 2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_6 and not isNil(var_412_5) then
				if arg_409_1.var_.actorSpriteComps10092 then
					for iter_412_5, iter_412_6 in pairs(arg_409_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_412_6 then
							if arg_409_1.isInRecall_ then
								iter_412_6.color = Color.New(Mathf.Lerp(iter_412_6.color.r, arg_409_1.hightColor2.r, (arg_409_1.time_ - 0) / var_412_6), Mathf.Lerp(iter_412_6.color.g, arg_409_1.hightColor2.g, (arg_409_1.time_ - 0) / var_412_6), (Mathf.Lerp(iter_412_6.color.b, arg_409_1.hightColor2.b, (arg_409_1.time_ - 0) / var_412_6)))
							else
								local var_412_7 = Mathf.Lerp(iter_412_6.color.r, 0.5, (arg_409_1.time_ - 0) / var_412_6)

								iter_412_6.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_6 and arg_409_1.time_ < 0 + var_412_6 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps10092 then
				for iter_412_7, iter_412_8 in pairs(arg_409_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_412_8 then
						iter_412_8.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_409_1.var_.actorSpriteComps10092 = nil
			end

			local var_412_8 = 0
			local var_412_9 = 0.325

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_10 = arg_409_1:GetWordFromCfg(413061099)
				local var_412_11 = arg_409_1:FormatText(var_412_10.content)

				arg_409_1.text_.text = var_412_11

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 13 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 13)

				if (13 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 13)) > 0 and var_412_9 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_8
					end
				end

				arg_409_1.text_.text = var_412_11
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061099", "story_v_out_413061.awb") ~= 0 then
					local var_412_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061099", "story_v_out_413061.awb") / 1000

					if var_412_14 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_8
					end

					if var_412_10.prefab_name ~= "" and arg_409_1.actors_[var_412_10.prefab_name] ~= nil then
						local var_412_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_10.prefab_name].transform, "story_v_out_413061", "413061099", "story_v_out_413061.awb")

						arg_409_1:RecordAudio("413061099", var_412_15)
						arg_409_1:RecordAudio("413061099", var_412_15)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_413061", "413061099", "story_v_out_413061.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_413061", "413061099", "story_v_out_413061.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_9, arg_409_1.talkMaxDuration)

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_8) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_8 + var_412_16 and arg_409_1.time_ < var_412_8 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play413061100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 413061100
		arg_413_1.duration_ = 3.07

		local var_413_0 = {
			zh = 3.066,
			ja = 2.866
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play413061101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10093"]) and arg_413_1.var_.actorSpriteComps10093 == nil then
				arg_413_1.var_.actorSpriteComps10093 = arg_413_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10093"]) then
				if arg_413_1.var_.actorSpriteComps10093 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								iter_416_1.color = Color.New(Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_0), Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_0), (Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_0)))
							else
								local var_416_1 = Mathf.Lerp(iter_416_1.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_0)

								iter_416_1.color = Color.New(var_416_1, var_416_1, var_416_1)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10093"]) and arg_413_1.var_.actorSpriteComps10093 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps10093 = nil
			end

			local var_416_2 = arg_413_1.actors_["10092"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps10092 == nil then
				arg_413_1.var_.actorSpriteComps10092 = var_416_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_3 = 2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_2) then
				if arg_413_1.var_.actorSpriteComps10092 then
					for iter_416_4, iter_416_5 in pairs(arg_413_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_416_5 then
							if arg_413_1.isInRecall_ then
								iter_416_5.color = Color.New(Mathf.Lerp(iter_416_5.color.r, arg_413_1.hightColor1.r, (arg_413_1.time_ - 0) / var_416_3), Mathf.Lerp(iter_416_5.color.g, arg_413_1.hightColor1.g, (arg_413_1.time_ - 0) / var_416_3), (Mathf.Lerp(iter_416_5.color.b, arg_413_1.hightColor1.b, (arg_413_1.time_ - 0) / var_416_3)))
							else
								local var_416_4 = Mathf.Lerp(iter_416_5.color.r, 1, (arg_413_1.time_ - 0) / var_416_3)

								iter_416_5.color = Color.New(var_416_4, var_416_4, var_416_4)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps10092 then
				for iter_416_6, iter_416_7 in pairs(arg_413_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_416_7 then
						iter_416_7.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_413_1.var_.actorSpriteComps10092 = nil
			end

			local var_416_5 = 0
			local var_416_6 = 0.1

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_7 = arg_413_1:GetWordFromCfg(413061100)
				local var_416_8 = arg_413_1:FormatText(var_416_7.content)

				arg_413_1.text_.text = var_416_8

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 4 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 4)

				if (4 <= 0 and var_416_6 or var_416_6 * (utf8.len(var_416_8) / 4)) > 0 and var_416_6 < var_416_10 then
					arg_413_1.talkMaxDuration = var_416_10

					if var_416_10 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_5
					end
				end

				arg_413_1.text_.text = var_416_8
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061100", "story_v_out_413061.awb") ~= 0 then
					local var_416_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061100", "story_v_out_413061.awb") / 1000

					if var_416_11 + var_416_5 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_11 + var_416_5
					end

					if var_416_7.prefab_name ~= "" and arg_413_1.actors_[var_416_7.prefab_name] ~= nil then
						local var_416_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_7.prefab_name].transform, "story_v_out_413061", "413061100", "story_v_out_413061.awb")

						arg_413_1:RecordAudio("413061100", var_416_12)
						arg_413_1:RecordAudio("413061100", var_416_12)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_413061", "413061100", "story_v_out_413061.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_413061", "413061100", "story_v_out_413061.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_13 = math.max(var_416_6, arg_413_1.talkMaxDuration)

			if var_416_5 <= arg_413_1.time_ and arg_413_1.time_ < var_416_5 + var_416_13 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_5) / var_416_13

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_5 + var_416_13 and arg_413_1.time_ < var_416_5 + var_416_13 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play413061101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 413061101
		arg_417_1.duration_ = 4.73

		local var_417_0 = {
			zh = 3.36633333333333,
			ja = 4.73333333333333
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play413061102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10092"]) and arg_417_1.var_.actorSpriteComps10092 == nil then
				arg_417_1.var_.actorSpriteComps10092 = arg_417_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10092"]) then
				if arg_417_1.var_.actorSpriteComps10092 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor2.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor2.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor2.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 0.5, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10092"]) and arg_417_1.var_.actorSpriteComps10092 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_417_1.var_.actorSpriteComps10092 = nil
			end

			if 0.366666666666667 < arg_417_1.time_ and arg_417_1.time_ <= 0.366666666666667 + arg_420_0 then
				arg_417_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_420_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_417_1.bgmTxt_.text ~= var_420_5 and arg_417_1.bgmTxt_.text ~= "" then
						if arg_417_1.bgmTxt2_.text ~= "" then
							arg_417_1.bgmTxt_.text = arg_417_1.bgmTxt2_.text
						end

						arg_417_1.bgmTxt2_.text = var_420_5

						arg_417_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_417_1.bgmTxt_.text = var_420_5
						arg_417_1.bgmTxt2_.text = var_420_5
					end

					if arg_417_1.bgmTimer then
						arg_417_1.bgmTimer:Stop()

						arg_417_1.bgmTimer = nil
					end

					if arg_417_1.settingData.show_music_name == 1 then
						arg_417_1.musicController:SetSelectedState("show")
						arg_417_1.musicAnimator_:Play("open", 0, 0)

						if arg_417_1.settingData.music_time ~= 0 then
							arg_417_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_417_1.settingData.music_time), function()
								if arg_417_1 == nil or isNil(arg_417_1.bgmTxt_) then
									return
								end

								arg_417_1.musicController:SetSelectedState("hide")
								arg_417_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_420_6 = arg_417_1.actors_["10092"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10092 = var_420_6.localPosition
				var_420_6.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("10092", 7)

				for iter_420_4 = 0, var_420_6.childCount - 1 do
					local var_420_7 = var_420_6:GetChild(iter_420_4)

					if var_420_7.name == "split_8" or not string.find(var_420_7.name, "split") then
						var_420_7.gameObject:SetActive(true)
					else
						var_420_7.gameObject:SetActive(false)
					end
				end
			end

			local var_420_8 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_8 then
				var_420_6.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_417_1.time_ - 0) / var_420_8)
			end

			if arg_417_1.time_ >= 0 + var_420_8 and arg_417_1.time_ < 0 + var_420_8 + arg_420_0 then
				var_420_6.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_420_9 = arg_417_1.actors_["10093"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10093 = var_420_9.localPosition
				var_420_9.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("10093", 7)

				for iter_420_5 = 0, var_420_9.childCount - 1 do
					local var_420_10 = var_420_9:GetChild(iter_420_5)

					if var_420_10.name == "split_4" or not string.find(var_420_10.name, "split") then
						var_420_10.gameObject:SetActive(true)
					else
						var_420_10.gameObject:SetActive(false)
					end
				end
			end

			local var_420_11 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_11 then
				var_420_9.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_417_1.time_ - 0) / var_420_11)
			end

			if arg_417_1.time_ >= 0 + var_420_11 and arg_417_1.time_ < 0 + var_420_11 + arg_420_0 then
				var_420_9.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_417_1.frameCnt_ <= 1 then
				arg_417_1.dialog_:SetActive(false)
			end

			local var_420_12 = 0.533333333333333
			local var_420_13 = 0.35

			if 0.533333333333333 < arg_417_1.time_ and arg_417_1.time_ <= var_420_12 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0

				arg_417_1.dialog_:SetActive(true)

				arg_417_1.dialogCg_.alpha = 0

				local var_420_14 = LeanTween.value(arg_417_1.dialog_, 0, 1, 0.3)

				var_420_14:setOnUpdate(LuaHelper.FloatAction(function(arg_422_0)
					arg_417_1.dialogCg_.alpha = arg_422_0
				end))
				var_420_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_417_1.dialog_)
					var_420_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_417_1.duration_ = arg_417_1.duration_ + 0.3

				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_15 = arg_417_1:GetWordFromCfg(413061101)
				local var_420_16 = arg_417_1:FormatText(var_420_15.content)

				arg_417_1.text_.text = var_420_16

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_18 = 14 <= 0 and var_420_13 or var_420_13 * (utf8.len(var_420_16) / 14)

				if (14 <= 0 and var_420_13 or var_420_13 * (utf8.len(var_420_16) / 14)) > 0 and var_420_13 < var_420_18 then
					arg_417_1.talkMaxDuration = var_420_18
					var_420_12 = var_420_12 + 0.3

					if var_420_18 + var_420_12 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_18 + var_420_12
					end
				end

				arg_417_1.text_.text = var_420_16
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061101", "story_v_out_413061.awb") ~= 0 then
					local var_420_19 = manager.audio:GetVoiceLength("story_v_out_413061", "413061101", "story_v_out_413061.awb") / 1000

					if var_420_19 + var_420_12 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_19 + var_420_12
					end

					if var_420_15.prefab_name ~= "" and arg_417_1.actors_[var_420_15.prefab_name] ~= nil then
						local var_420_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_15.prefab_name].transform, "story_v_out_413061", "413061101", "story_v_out_413061.awb")

						arg_417_1:RecordAudio("413061101", var_420_20)
						arg_417_1:RecordAudio("413061101", var_420_20)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_413061", "413061101", "story_v_out_413061.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_413061", "413061101", "story_v_out_413061.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_21 = var_420_12 + 0.3
			local var_420_22 = math.max(var_420_13, arg_417_1.talkMaxDuration)

			if var_420_12 + 0.3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_21 + var_420_22 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_21) / var_420_22

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_21 + var_420_22 and arg_417_1.time_ < var_420_21 + var_420_22 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
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

		arg_417_1:InitPlayNodeList()
	end,
	Play413061102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413061102
		arg_424_1.duration_ = 7.7

		local var_424_0 = {
			zh = 5.1,
			ja = 7.7
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play413061103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10092 = arg_424_1.actors_["10092"].transform.localPosition
				arg_424_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10092", 3)

				for iter_427_0 = 0, arg_424_1.actors_["10092"].transform.childCount - 1 do
					local var_427_0 = arg_424_1.actors_["10092"].transform:GetChild(iter_427_0)

					if var_427_0.name == "split_8" or not string.find(var_427_0.name, "split") then
						var_427_0.gameObject:SetActive(true)
					else
						var_427_0.gameObject:SetActive(false)
					end
				end
			end

			local var_427_1 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_1 then
				arg_424_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_424_1.time_ - 0) / var_427_1)
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 then
				arg_424_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_427_2 = arg_424_1.actors_["10092"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps10092 == nil then
				arg_424_1.var_.actorSpriteComps10092 = var_427_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_3 = 2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_3 and not isNil(var_427_2) then
				if arg_424_1.var_.actorSpriteComps10092 then
					for iter_427_1, iter_427_2 in pairs(arg_424_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_427_2 then
							if arg_424_1.isInRecall_ then
								iter_427_2.color = Color.New(Mathf.Lerp(iter_427_2.color.r, arg_424_1.hightColor1.r, (arg_424_1.time_ - 0) / var_427_3), Mathf.Lerp(iter_427_2.color.g, arg_424_1.hightColor1.g, (arg_424_1.time_ - 0) / var_427_3), (Mathf.Lerp(iter_427_2.color.b, arg_424_1.hightColor1.b, (arg_424_1.time_ - 0) / var_427_3)))
							else
								local var_427_4 = Mathf.Lerp(iter_427_2.color.r, 1, (arg_424_1.time_ - 0) / var_427_3)

								iter_427_2.color = Color.New(var_427_4, var_427_4, var_427_4)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_3 and arg_424_1.time_ < 0 + var_427_3 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps10092 then
				for iter_427_3, iter_427_4 in pairs(arg_424_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_427_4 then
						iter_427_4.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_424_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_427_7 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_424_1.bgmTxt_.text ~= var_427_7 and arg_424_1.bgmTxt_.text ~= "" then
						if arg_424_1.bgmTxt2_.text ~= "" then
							arg_424_1.bgmTxt_.text = arg_424_1.bgmTxt2_.text
						end

						arg_424_1.bgmTxt2_.text = var_427_7

						arg_424_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_424_1.bgmTxt_.text = var_427_7
						arg_424_1.bgmTxt2_.text = var_427_7
					end

					if arg_424_1.bgmTimer then
						arg_424_1.bgmTimer:Stop()

						arg_424_1.bgmTimer = nil
					end

					if arg_424_1.settingData.show_music_name == 1 then
						arg_424_1.musicController:SetSelectedState("show")
						arg_424_1.musicAnimator_:Play("open", 0, 0)

						if arg_424_1.settingData.music_time ~= 0 then
							arg_424_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_424_1.settingData.music_time), function()
								if arg_424_1 == nil or isNil(arg_424_1.bgmTxt_) then
									return
								end

								arg_424_1.musicController:SetSelectedState("hide")
								arg_424_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_427_8 = 0
			local var_427_9 = 0.7

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:GetWordFromCfg(413061102)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 28 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 28)

				if (28 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 28)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061102", "story_v_out_413061.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_413061", "413061102", "story_v_out_413061.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_413061", "413061102", "story_v_out_413061.awb")

						arg_424_1:RecordAudio("413061102", var_427_15)
						arg_424_1:RecordAudio("413061102", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413061", "413061102", "story_v_out_413061.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413061", "413061102", "story_v_out_413061.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play413061103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 413061103
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play413061104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10092 = arg_429_1.actors_["10092"].transform.localPosition
				arg_429_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("10092", 0)

				for iter_432_0 = 0, arg_429_1.actors_["10092"].transform.childCount - 1 do
					local var_432_0 = arg_429_1.actors_["10092"].transform:GetChild(iter_432_0)

					if var_432_0.name == "" or not string.find(var_432_0.name, "split") then
						var_432_0.gameObject:SetActive(true)
					else
						var_432_0.gameObject:SetActive(false)
					end
				end
			end

			local var_432_1 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_1 then
				arg_429_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_429_1.time_ - 0) / var_432_1)
			end

			if arg_429_1.time_ >= 0 + var_432_1 and arg_429_1.time_ < 0 + var_432_1 + arg_432_0 then
				arg_429_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_432_2 = arg_429_1.actors_["10093"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10093 = var_432_2.localPosition
				var_432_2.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("10093", 0)

				for iter_432_1 = 0, var_432_2.childCount - 1 do
					local var_432_3 = var_432_2:GetChild(iter_432_1)

					if var_432_3.name == "" or not string.find(var_432_3.name, "split") then
						var_432_3.gameObject:SetActive(true)
					else
						var_432_3.gameObject:SetActive(false)
					end
				end
			end

			local var_432_4 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				var_432_2.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_429_1.time_ - 0) / var_432_4)
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				var_432_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_432_5 = arg_429_1.actors_["10092"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_5) and arg_429_1.var_.actorSpriteComps10092 == nil then
				arg_429_1.var_.actorSpriteComps10092 = var_432_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_6 = 2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_6 and not isNil(var_432_5) then
				if arg_429_1.var_.actorSpriteComps10092 then
					for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_432_3 then
							if arg_429_1.isInRecall_ then
								iter_432_3.color = Color.New(Mathf.Lerp(iter_432_3.color.r, arg_429_1.hightColor2.r, (arg_429_1.time_ - 0) / var_432_6), Mathf.Lerp(iter_432_3.color.g, arg_429_1.hightColor2.g, (arg_429_1.time_ - 0) / var_432_6), (Mathf.Lerp(iter_432_3.color.b, arg_429_1.hightColor2.b, (arg_429_1.time_ - 0) / var_432_6)))
							else
								local var_432_7 = Mathf.Lerp(iter_432_3.color.r, 0.5, (arg_429_1.time_ - 0) / var_432_6)

								iter_432_3.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_6 and arg_429_1.time_ < 0 + var_432_6 + arg_432_0 and not isNil(var_432_5) and arg_429_1.var_.actorSpriteComps10092 then
				for iter_432_4, iter_432_5 in pairs(arg_429_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_432_5 then
						iter_432_5.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps10092 = nil
			end

			local var_432_8 = arg_429_1.actors_["10093"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_8) and arg_429_1.var_.actorSpriteComps10093 == nil then
				arg_429_1.var_.actorSpriteComps10093 = var_432_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_9 = 2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_9 and not isNil(var_432_8) then
				if arg_429_1.var_.actorSpriteComps10093 then
					for iter_432_6, iter_432_7 in pairs(arg_429_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_432_7 then
							if arg_429_1.isInRecall_ then
								iter_432_7.color = Color.New(Mathf.Lerp(iter_432_7.color.r, arg_429_1.hightColor2.r, (arg_429_1.time_ - 0) / var_432_9), Mathf.Lerp(iter_432_7.color.g, arg_429_1.hightColor2.g, (arg_429_1.time_ - 0) / var_432_9), (Mathf.Lerp(iter_432_7.color.b, arg_429_1.hightColor2.b, (arg_429_1.time_ - 0) / var_432_9)))
							else
								local var_432_10 = Mathf.Lerp(iter_432_7.color.r, 0.5, (arg_429_1.time_ - 0) / var_432_9)

								iter_432_7.color = Color.New(var_432_10, var_432_10, var_432_10)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_9 and arg_429_1.time_ < 0 + var_432_9 + arg_432_0 and not isNil(var_432_8) and arg_429_1.var_.actorSpriteComps10093 then
				for iter_432_8, iter_432_9 in pairs(arg_429_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_432_9 then
						iter_432_9.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps10093 = nil
			end

			local var_432_11 = 0
			local var_432_12 = 1.625

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_11 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_13 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(413061103).content)

				arg_429_1.text_.text = var_432_13

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_15 = 65 <= 0 and var_432_12 or var_432_12 * (utf8.len(var_432_13) / 65)

				if (65 <= 0 and var_432_12 or var_432_12 * (utf8.len(var_432_13) / 65)) > 0 and var_432_12 < var_432_15 then
					arg_429_1.talkMaxDuration = var_432_15

					if var_432_15 + var_432_11 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_15 + var_432_11
					end
				end

				arg_429_1.text_.text = var_432_13
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_12, arg_429_1.talkMaxDuration)

			if var_432_11 <= arg_429_1.time_ and arg_429_1.time_ < var_432_11 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_11) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_11 + var_432_16 and arg_429_1.time_ < var_432_11 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
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

		arg_429_1:InitPlayNodeList()
	end,
	Play413061104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 413061104
		arg_433_1.duration_ = 4.63

		local var_433_0 = {
			zh = 3.9,
			ja = 4.633
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play413061105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10098 = arg_433_1.actors_["10098"].transform.localPosition
				arg_433_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10098", 3)

				for iter_436_0 = 0, arg_433_1.actors_["10098"].transform.childCount - 1 do
					local var_436_0 = arg_433_1.actors_["10098"].transform:GetChild(iter_436_0)

					if var_436_0.name == "split_2" or not string.find(var_436_0.name, "split") then
						var_436_0.gameObject:SetActive(true)
					else
						var_436_0.gameObject:SetActive(false)
					end
				end
			end

			local var_436_1 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_1 then
				arg_433_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_433_1.time_ - 0) / var_436_1)
			end

			if arg_433_1.time_ >= 0 + var_436_1 and arg_433_1.time_ < 0 + var_436_1 + arg_436_0 then
				arg_433_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_436_2 = arg_433_1.actors_["10098"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps10098 == nil then
				arg_433_1.var_.actorSpriteComps10098 = var_436_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_3 = 2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_3 and not isNil(var_436_2) then
				if arg_433_1.var_.actorSpriteComps10098 then
					for iter_436_1, iter_436_2 in pairs(arg_433_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_436_2 then
							if arg_433_1.isInRecall_ then
								iter_436_2.color = Color.New(Mathf.Lerp(iter_436_2.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_3), Mathf.Lerp(iter_436_2.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_3), (Mathf.Lerp(iter_436_2.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_3)))
							else
								local var_436_4 = Mathf.Lerp(iter_436_2.color.r, 1, (arg_433_1.time_ - 0) / var_436_3)

								iter_436_2.color = Color.New(var_436_4, var_436_4, var_436_4)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_3 and arg_433_1.time_ < 0 + var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps10098 then
				for iter_436_3, iter_436_4 in pairs(arg_433_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_436_4 then
						iter_436_4.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps10098 = nil
			end

			local var_436_5 = 0
			local var_436_6 = 0.425

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_7 = arg_433_1:GetWordFromCfg(413061104)
				local var_436_8 = arg_433_1:FormatText(var_436_7.content)

				arg_433_1.text_.text = var_436_8

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_10 = 17 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 17)

				if (17 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 17)) > 0 and var_436_6 < var_436_10 then
					arg_433_1.talkMaxDuration = var_436_10

					if var_436_10 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_5
					end
				end

				arg_433_1.text_.text = var_436_8
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061104", "story_v_out_413061.awb") ~= 0 then
					local var_436_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061104", "story_v_out_413061.awb") / 1000

					if var_436_11 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_5
					end

					if var_436_7.prefab_name ~= "" and arg_433_1.actors_[var_436_7.prefab_name] ~= nil then
						local var_436_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_7.prefab_name].transform, "story_v_out_413061", "413061104", "story_v_out_413061.awb")

						arg_433_1:RecordAudio("413061104", var_436_12)
						arg_433_1:RecordAudio("413061104", var_436_12)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_413061", "413061104", "story_v_out_413061.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_413061", "413061104", "story_v_out_413061.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_13 = math.max(var_436_6, arg_433_1.talkMaxDuration)

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_13 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_5) / var_436_13

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_5 + var_436_13 and arg_433_1.time_ < var_436_5 + var_436_13 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play413061105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 413061105
		arg_437_1.duration_ = 7.23

		local var_437_0 = {
			zh = 5.1,
			ja = 7.233
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play413061106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.6

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:GetWordFromCfg(413061105)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 24 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 24)

				if (24 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 24)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061105", "story_v_out_413061.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061105", "story_v_out_413061.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_413061", "413061105", "story_v_out_413061.awb")

						arg_437_1:RecordAudio("413061105", var_440_6)
						arg_437_1:RecordAudio("413061105", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_413061", "413061105", "story_v_out_413061.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_413061", "413061105", "story_v_out_413061.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play413061106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 413061106
		arg_441_1.duration_ = 5.4

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play413061107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos10098 = arg_441_1.actors_["10098"].transform.localPosition
				arg_441_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10098", 7)

				for iter_444_0 = 0, arg_441_1.actors_["10098"].transform.childCount - 1 do
					local var_444_0 = arg_441_1.actors_["10098"].transform:GetChild(iter_444_0)

					if var_444_0.name == "split_7" or not string.find(var_444_0.name, "split") then
						var_444_0.gameObject:SetActive(true)
					else
						var_444_0.gameObject:SetActive(false)
					end
				end
			end

			local var_444_1 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_1 then
				arg_441_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10098, Vector3.New(0, -2000, -180), (arg_441_1.time_ - 0) / var_444_1)
			end

			if arg_441_1.time_ >= 0 + var_444_1 and arg_441_1.time_ < 0 + var_444_1 + arg_444_0 then
				arg_441_1.actors_["10098"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_444_2 = arg_441_1.actors_["10098"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps10098 == nil then
				arg_441_1.var_.actorSpriteComps10098 = var_444_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_3 = 2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_3 and not isNil(var_444_2) then
				if arg_441_1.var_.actorSpriteComps10098 then
					for iter_444_1, iter_444_2 in pairs(arg_441_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_444_2 then
							if arg_441_1.isInRecall_ then
								iter_444_2.color = Color.New(Mathf.Lerp(iter_444_2.color.r, arg_441_1.hightColor2.r, (arg_441_1.time_ - 0) / var_444_3), Mathf.Lerp(iter_444_2.color.g, arg_441_1.hightColor2.g, (arg_441_1.time_ - 0) / var_444_3), (Mathf.Lerp(iter_444_2.color.b, arg_441_1.hightColor2.b, (arg_441_1.time_ - 0) / var_444_3)))
							else
								local var_444_4 = Mathf.Lerp(iter_444_2.color.r, 0.5, (arg_441_1.time_ - 0) / var_444_3)

								iter_444_2.color = Color.New(var_444_4, var_444_4, var_444_4)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_3 and arg_441_1.time_ < 0 + var_444_3 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps10098 then
				for iter_444_3, iter_444_4 in pairs(arg_441_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_444_4 then
						iter_444_4.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_441_1.var_.actorSpriteComps10098 = nil
			end

			local var_444_5 = manager.ui.mainCamera.transform

			if 0.4 < arg_441_1.time_ and arg_441_1.time_ <= 0.4 + arg_444_0 then
				arg_441_1.var_.shakeOldPos = var_444_5.localPosition
			end

			local var_444_6 = 1

			if 0.4 <= arg_441_1.time_ and arg_441_1.time_ < 0.4 + var_444_6 then
				local var_444_7, var_444_8 = math.modf((arg_441_1.time_ - 0.4) / 0.066)

				var_444_5.localPosition = Vector3.New(var_444_8 * 0.13, var_444_8 * 0.13, var_444_8 * 0.13) + arg_441_1.var_.shakeOldPos
			end

			if arg_441_1.time_ >= 0.4 + var_444_6 and arg_441_1.time_ < 0.4 + var_444_6 + arg_444_0 then
				var_444_5.localPosition = arg_441_1.var_.shakeOldPos
			end

			local var_444_9 = 0

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_9 + arg_444_0 then
				arg_441_1.allBtn_.enabled = false
			end

			if arg_441_1.time_ >= var_444_9 + 1.4 and arg_441_1.time_ < var_444_9 + 1.4 + arg_444_0 then
				arg_441_1.allBtn_.enabled = true
			end

			if arg_441_1.frameCnt_ <= 1 then
				arg_441_1.dialog_:SetActive(false)
			end

			local var_444_10 = 0.4
			local var_444_11 = 1.525

			if 0.4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_10 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0

				arg_441_1.dialog_:SetActive(true)

				arg_441_1.dialogCg_.alpha = 0

				local var_444_12 = LeanTween.value(arg_441_1.dialog_, 0, 1, 0.3)

				var_444_12:setOnUpdate(LuaHelper.FloatAction(function(arg_445_0)
					arg_441_1.dialogCg_.alpha = arg_445_0
				end))
				var_444_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_441_1.dialog_)
					var_444_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_441_1.duration_ = arg_441_1.duration_ + 0.3

				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_13 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(413061106).content)

				arg_441_1.text_.text = var_444_13

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_15 = 61 <= 0 and var_444_11 or var_444_11 * (utf8.len(var_444_13) / 61)

				if (61 <= 0 and var_444_11 or var_444_11 * (utf8.len(var_444_13) / 61)) > 0 and var_444_11 < var_444_15 then
					arg_441_1.talkMaxDuration = var_444_15
					var_444_10 = var_444_10 + 0.3

					if var_444_15 + var_444_10 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_15 + var_444_10
					end
				end

				arg_441_1.text_.text = var_444_13
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = var_444_10 + 0.3
			local var_444_17 = math.max(var_444_11, arg_441_1.talkMaxDuration)

			if var_444_10 + 0.3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_16 + var_444_17 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_16) / var_444_17

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_16 + var_444_17 and arg_441_1.time_ < var_444_16 + var_444_17 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play413061107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 413061107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play413061108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 1.2

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(413061107).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 48 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 48)

				if (48 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 48)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play413061108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 413061108
		arg_451_1.duration_ = 6.13

		local var_451_0 = {
			zh = 3.833,
			ja = 6.133
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play413061109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.5

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_1 = arg_451_1:GetWordFromCfg(413061108)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 20 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 20)

				if (20 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 20)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061108", "story_v_out_413061.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061108", "story_v_out_413061.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_out_413061", "413061108", "story_v_out_413061.awb")

						arg_451_1:RecordAudio("413061108", var_454_6)
						arg_451_1:RecordAudio("413061108", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_413061", "413061108", "story_v_out_413061.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_413061", "413061108", "story_v_out_413061.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play413061109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 413061109
		arg_455_1.duration_ = 4.4

		local var_455_0 = {
			zh = 4.4,
			ja = 3.233
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play413061110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10098 = arg_455_1.actors_["10098"].transform.localPosition
				arg_455_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10098", 3)

				for iter_458_0 = 0, arg_455_1.actors_["10098"].transform.childCount - 1 do
					local var_458_0 = arg_455_1.actors_["10098"].transform:GetChild(iter_458_0)

					if var_458_0.name == "split_2" or not string.find(var_458_0.name, "split") then
						var_458_0.gameObject:SetActive(true)
					else
						var_458_0.gameObject:SetActive(false)
					end
				end
			end

			local var_458_1 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_1 then
				arg_455_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_455_1.time_ - 0) / var_458_1)
			end

			if arg_455_1.time_ >= 0 + var_458_1 and arg_455_1.time_ < 0 + var_458_1 + arg_458_0 then
				arg_455_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_458_2 = arg_455_1.actors_["10098"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.actorSpriteComps10098 == nil then
				arg_455_1.var_.actorSpriteComps10098 = var_458_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_3 = 2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_3 and not isNil(var_458_2) then
				if arg_455_1.var_.actorSpriteComps10098 then
					for iter_458_1, iter_458_2 in pairs(arg_455_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_458_2 then
							if arg_455_1.isInRecall_ then
								iter_458_2.color = Color.New(Mathf.Lerp(iter_458_2.color.r, arg_455_1.hightColor1.r, (arg_455_1.time_ - 0) / var_458_3), Mathf.Lerp(iter_458_2.color.g, arg_455_1.hightColor1.g, (arg_455_1.time_ - 0) / var_458_3), (Mathf.Lerp(iter_458_2.color.b, arg_455_1.hightColor1.b, (arg_455_1.time_ - 0) / var_458_3)))
							else
								local var_458_4 = Mathf.Lerp(iter_458_2.color.r, 1, (arg_455_1.time_ - 0) / var_458_3)

								iter_458_2.color = Color.New(var_458_4, var_458_4, var_458_4)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_3 and arg_455_1.time_ < 0 + var_458_3 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.actorSpriteComps10098 then
				for iter_458_3, iter_458_4 in pairs(arg_455_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_458_4 then
						iter_458_4.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_455_1.var_.actorSpriteComps10098 = nil
			end

			local var_458_5 = 0
			local var_458_6 = 0.5

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_7 = arg_455_1:GetWordFromCfg(413061109)
				local var_458_8 = arg_455_1:FormatText(var_458_7.content)

				arg_455_1.text_.text = var_458_8

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_10 = 20 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_8) / 20)

				if (20 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_8) / 20)) > 0 and var_458_6 < var_458_10 then
					arg_455_1.talkMaxDuration = var_458_10

					if var_458_10 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_10 + var_458_5
					end
				end

				arg_455_1.text_.text = var_458_8
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061109", "story_v_out_413061.awb") ~= 0 then
					local var_458_11 = manager.audio:GetVoiceLength("story_v_out_413061", "413061109", "story_v_out_413061.awb") / 1000

					if var_458_11 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_11 + var_458_5
					end

					if var_458_7.prefab_name ~= "" and arg_455_1.actors_[var_458_7.prefab_name] ~= nil then
						local var_458_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_7.prefab_name].transform, "story_v_out_413061", "413061109", "story_v_out_413061.awb")

						arg_455_1:RecordAudio("413061109", var_458_12)
						arg_455_1:RecordAudio("413061109", var_458_12)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_413061", "413061109", "story_v_out_413061.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_413061", "413061109", "story_v_out_413061.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_13 = math.max(var_458_6, arg_455_1.talkMaxDuration)

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_13 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_5) / var_458_13

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_5 + var_458_13 and arg_455_1.time_ < var_458_5 + var_458_13 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play413061110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 413061110
		arg_459_1.duration_ = 5.77

		local var_459_0 = {
			zh = 5.766,
			ja = 3.766
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play413061111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.6

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:GetWordFromCfg(413061110)
				local var_462_2 = arg_459_1:FormatText(var_462_1.content)

				arg_459_1.text_.text = var_462_2

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 24 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 24)

				if (24 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 24)) > 0 and var_462_0 < var_462_4 then
					arg_459_1.talkMaxDuration = var_462_4

					if var_462_4 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_4 + 0
					end
				end

				arg_459_1.text_.text = var_462_2
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061110", "story_v_out_413061.awb") ~= 0 then
					local var_462_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061110", "story_v_out_413061.awb") / 1000

					if var_462_5 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + 0
					end

					if var_462_1.prefab_name ~= "" and arg_459_1.actors_[var_462_1.prefab_name] ~= nil then
						local var_462_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_1.prefab_name].transform, "story_v_out_413061", "413061110", "story_v_out_413061.awb")

						arg_459_1:RecordAudio("413061110", var_462_6)
						arg_459_1:RecordAudio("413061110", var_462_6)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_413061", "413061110", "story_v_out_413061.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_413061", "413061110", "story_v_out_413061.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_7 and arg_459_1.time_ < 0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play413061111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 413061111
		arg_463_1.duration_ = 2

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play413061112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10098 = arg_463_1.actors_["10098"].transform.localPosition
				arg_463_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10098", 0)

				for iter_466_0 = 0, arg_463_1.actors_["10098"].transform.childCount - 1 do
					local var_466_0 = arg_463_1.actors_["10098"].transform:GetChild(iter_466_0)

					if var_466_0.name == "" or not string.find(var_466_0.name, "split") then
						var_466_0.gameObject:SetActive(true)
					else
						var_466_0.gameObject:SetActive(false)
					end
				end
			end

			local var_466_1 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_1 then
				arg_463_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10098, Vector3.New(-1500, -350, -180), (arg_463_1.time_ - 0) / var_466_1)
			end

			if arg_463_1.time_ >= 0 + var_466_1 and arg_463_1.time_ < 0 + var_466_1 + arg_466_0 then
				arg_463_1.actors_["10098"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_466_2 = arg_463_1.actors_["10094"].transform

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10094 = var_466_2.localPosition
				var_466_2.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10094", 3)

				for iter_466_1 = 0, var_466_2.childCount - 1 do
					local var_466_3 = var_466_2:GetChild(iter_466_1)

					if var_466_3.name == "split_2" or not string.find(var_466_3.name, "split") then
						var_466_3.gameObject:SetActive(true)
					else
						var_466_3.gameObject:SetActive(false)
					end
				end
			end

			local var_466_4 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				var_466_2.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_463_1.time_ - 0) / var_466_4)
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				var_466_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_466_5 = arg_463_1.actors_["10098"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_5) and arg_463_1.var_.actorSpriteComps10098 == nil then
				arg_463_1.var_.actorSpriteComps10098 = var_466_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_6 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_6 and not isNil(var_466_5) then
				if arg_463_1.var_.actorSpriteComps10098 then
					for iter_466_2, iter_466_3 in pairs(arg_463_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_466_3 then
							if arg_463_1.isInRecall_ then
								iter_466_3.color = Color.New(Mathf.Lerp(iter_466_3.color.r, arg_463_1.hightColor2.r, (arg_463_1.time_ - 0) / var_466_6), Mathf.Lerp(iter_466_3.color.g, arg_463_1.hightColor2.g, (arg_463_1.time_ - 0) / var_466_6), (Mathf.Lerp(iter_466_3.color.b, arg_463_1.hightColor2.b, (arg_463_1.time_ - 0) / var_466_6)))
							else
								local var_466_7 = Mathf.Lerp(iter_466_3.color.r, 0.5, (arg_463_1.time_ - 0) / var_466_6)

								iter_466_3.color = Color.New(var_466_7, var_466_7, var_466_7)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_6 and arg_463_1.time_ < 0 + var_466_6 + arg_466_0 and not isNil(var_466_5) and arg_463_1.var_.actorSpriteComps10098 then
				for iter_466_4, iter_466_5 in pairs(arg_463_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_466_5 then
						iter_466_5.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_463_1.var_.actorSpriteComps10098 = nil
			end

			local var_466_8 = arg_463_1.actors_["10094"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_8) and arg_463_1.var_.actorSpriteComps10094 == nil then
				arg_463_1.var_.actorSpriteComps10094 = var_466_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_9 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_9 and not isNil(var_466_8) then
				if arg_463_1.var_.actorSpriteComps10094 then
					for iter_466_6, iter_466_7 in pairs(arg_463_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_466_7 then
							if arg_463_1.isInRecall_ then
								iter_466_7.color = Color.New(Mathf.Lerp(iter_466_7.color.r, arg_463_1.hightColor1.r, (arg_463_1.time_ - 0) / var_466_9), Mathf.Lerp(iter_466_7.color.g, arg_463_1.hightColor1.g, (arg_463_1.time_ - 0) / var_466_9), (Mathf.Lerp(iter_466_7.color.b, arg_463_1.hightColor1.b, (arg_463_1.time_ - 0) / var_466_9)))
							else
								local var_466_10 = Mathf.Lerp(iter_466_7.color.r, 1, (arg_463_1.time_ - 0) / var_466_9)

								iter_466_7.color = Color.New(var_466_10, var_466_10, var_466_10)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_9 and arg_463_1.time_ < 0 + var_466_9 + arg_466_0 and not isNil(var_466_8) and arg_463_1.var_.actorSpriteComps10094 then
				for iter_466_8, iter_466_9 in pairs(arg_463_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_466_9 then
						iter_466_9.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_463_1.var_.actorSpriteComps10094 = nil
			end

			local var_466_11 = 0
			local var_466_12 = 0.175

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_11 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_13 = arg_463_1:GetWordFromCfg(413061111)
				local var_466_14 = arg_463_1:FormatText(var_466_13.content)

				arg_463_1.text_.text = var_466_14

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_16 = 7 <= 0 and var_466_12 or var_466_12 * (utf8.len(var_466_14) / 7)

				if (7 <= 0 and var_466_12 or var_466_12 * (utf8.len(var_466_14) / 7)) > 0 and var_466_12 < var_466_16 then
					arg_463_1.talkMaxDuration = var_466_16

					if var_466_16 + var_466_11 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_16 + var_466_11
					end
				end

				arg_463_1.text_.text = var_466_14
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061111", "story_v_out_413061.awb") ~= 0 then
					local var_466_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061111", "story_v_out_413061.awb") / 1000

					if var_466_17 + var_466_11 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_17 + var_466_11
					end

					if var_466_13.prefab_name ~= "" and arg_463_1.actors_[var_466_13.prefab_name] ~= nil then
						local var_466_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_13.prefab_name].transform, "story_v_out_413061", "413061111", "story_v_out_413061.awb")

						arg_463_1:RecordAudio("413061111", var_466_18)
						arg_463_1:RecordAudio("413061111", var_466_18)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_413061", "413061111", "story_v_out_413061.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_413061", "413061111", "story_v_out_413061.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_19 = math.max(var_466_12, arg_463_1.talkMaxDuration)

			if var_466_11 <= arg_463_1.time_ and arg_463_1.time_ < var_466_11 + var_466_19 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_11) / var_466_19

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_11 + var_466_19 and arg_463_1.time_ < var_466_11 + var_466_19 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_463_1:InitPlayNodeList()
	end,
	Play413061112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 413061112
		arg_467_1.duration_ = 6.5

		local var_467_0 = {
			zh = 4.566,
			ja = 6.5
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play413061113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos10098 = arg_467_1.actors_["10098"].transform.localPosition
				arg_467_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10098", 3)

				for iter_470_0 = 0, arg_467_1.actors_["10098"].transform.childCount - 1 do
					local var_470_0 = arg_467_1.actors_["10098"].transform:GetChild(iter_470_0)

					if var_470_0.name == "split_2" or not string.find(var_470_0.name, "split") then
						var_470_0.gameObject:SetActive(true)
					else
						var_470_0.gameObject:SetActive(false)
					end
				end
			end

			local var_470_1 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_1 then
				arg_467_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10098, Vector3.New(0, -350, -180), (arg_467_1.time_ - 0) / var_470_1)
			end

			if arg_467_1.time_ >= 0 + var_470_1 and arg_467_1.time_ < 0 + var_470_1 + arg_470_0 then
				arg_467_1.actors_["10098"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_470_2 = arg_467_1.actors_["10094"].transform

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos10094 = var_470_2.localPosition
				var_470_2.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10094", 0)

				for iter_470_1 = 0, var_470_2.childCount - 1 do
					local var_470_3 = var_470_2:GetChild(iter_470_1)

					if var_470_3.name == "" or not string.find(var_470_3.name, "split") then
						var_470_3.gameObject:SetActive(true)
					else
						var_470_3.gameObject:SetActive(false)
					end
				end
			end

			local var_470_4 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				var_470_2.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10094, Vector3.New(-5000, -345, -300), (arg_467_1.time_ - 0) / var_470_4)
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				var_470_2.localPosition = Vector3.New(-5000, -345, -300)
			end

			local var_470_5 = arg_467_1.actors_["10098"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_5) and arg_467_1.var_.actorSpriteComps10098 == nil then
				arg_467_1.var_.actorSpriteComps10098 = var_470_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_6 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_6 and not isNil(var_470_5) then
				if arg_467_1.var_.actorSpriteComps10098 then
					for iter_470_2, iter_470_3 in pairs(arg_467_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_470_3 then
							if arg_467_1.isInRecall_ then
								iter_470_3.color = Color.New(Mathf.Lerp(iter_470_3.color.r, arg_467_1.hightColor1.r, (arg_467_1.time_ - 0) / var_470_6), Mathf.Lerp(iter_470_3.color.g, arg_467_1.hightColor1.g, (arg_467_1.time_ - 0) / var_470_6), (Mathf.Lerp(iter_470_3.color.b, arg_467_1.hightColor1.b, (arg_467_1.time_ - 0) / var_470_6)))
							else
								local var_470_7 = Mathf.Lerp(iter_470_3.color.r, 1, (arg_467_1.time_ - 0) / var_470_6)

								iter_470_3.color = Color.New(var_470_7, var_470_7, var_470_7)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_6 and arg_467_1.time_ < 0 + var_470_6 + arg_470_0 and not isNil(var_470_5) and arg_467_1.var_.actorSpriteComps10098 then
				for iter_470_4, iter_470_5 in pairs(arg_467_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_470_5 then
						iter_470_5.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_467_1.var_.actorSpriteComps10098 = nil
			end

			local var_470_8 = arg_467_1.actors_["10094"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_8) and arg_467_1.var_.actorSpriteComps10094 == nil then
				arg_467_1.var_.actorSpriteComps10094 = var_470_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_9 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_9 and not isNil(var_470_8) then
				if arg_467_1.var_.actorSpriteComps10094 then
					for iter_470_6, iter_470_7 in pairs(arg_467_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_470_7 then
							if arg_467_1.isInRecall_ then
								iter_470_7.color = Color.New(Mathf.Lerp(iter_470_7.color.r, arg_467_1.hightColor2.r, (arg_467_1.time_ - 0) / var_470_9), Mathf.Lerp(iter_470_7.color.g, arg_467_1.hightColor2.g, (arg_467_1.time_ - 0) / var_470_9), (Mathf.Lerp(iter_470_7.color.b, arg_467_1.hightColor2.b, (arg_467_1.time_ - 0) / var_470_9)))
							else
								local var_470_10 = Mathf.Lerp(iter_470_7.color.r, 0.5, (arg_467_1.time_ - 0) / var_470_9)

								iter_470_7.color = Color.New(var_470_10, var_470_10, var_470_10)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_9 and arg_467_1.time_ < 0 + var_470_9 + arg_470_0 and not isNil(var_470_8) and arg_467_1.var_.actorSpriteComps10094 then
				for iter_470_8, iter_470_9 in pairs(arg_467_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_470_9 then
						iter_470_9.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_467_1.var_.actorSpriteComps10094 = nil
			end

			local var_470_11 = 0
			local var_470_12 = 0.525

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_11 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_13 = arg_467_1:GetWordFromCfg(413061112)
				local var_470_14 = arg_467_1:FormatText(var_470_13.content)

				arg_467_1.text_.text = var_470_14

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_16 = 21 <= 0 and var_470_12 or var_470_12 * (utf8.len(var_470_14) / 21)

				if (21 <= 0 and var_470_12 or var_470_12 * (utf8.len(var_470_14) / 21)) > 0 and var_470_12 < var_470_16 then
					arg_467_1.talkMaxDuration = var_470_16

					if var_470_16 + var_470_11 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_16 + var_470_11
					end
				end

				arg_467_1.text_.text = var_470_14
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061112", "story_v_out_413061.awb") ~= 0 then
					local var_470_17 = manager.audio:GetVoiceLength("story_v_out_413061", "413061112", "story_v_out_413061.awb") / 1000

					if var_470_17 + var_470_11 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_17 + var_470_11
					end

					if var_470_13.prefab_name ~= "" and arg_467_1.actors_[var_470_13.prefab_name] ~= nil then
						local var_470_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_13.prefab_name].transform, "story_v_out_413061", "413061112", "story_v_out_413061.awb")

						arg_467_1:RecordAudio("413061112", var_470_18)
						arg_467_1:RecordAudio("413061112", var_470_18)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_413061", "413061112", "story_v_out_413061.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_413061", "413061112", "story_v_out_413061.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_19 = math.max(var_470_12, arg_467_1.talkMaxDuration)

			if var_470_11 <= arg_467_1.time_ and arg_467_1.time_ < var_470_11 + var_470_19 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_11) / var_470_19

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_11 + var_470_19 and arg_467_1.time_ < var_470_11 + var_470_19 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_467_1:InitPlayNodeList()
	end,
	Play413061113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 413061113
		arg_471_1.duration_ = 8.9

		local var_471_0 = {
			zh = 6.2,
			ja = 8.9
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play413061114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.8

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:GetWordFromCfg(413061113)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 32 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 32)

				if (32 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 32)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061113", "story_v_out_413061.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061113", "story_v_out_413061.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_413061", "413061113", "story_v_out_413061.awb")

						arg_471_1:RecordAudio("413061113", var_474_6)
						arg_471_1:RecordAudio("413061113", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_413061", "413061113", "story_v_out_413061.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_413061", "413061113", "story_v_out_413061.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play413061114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 413061114
		arg_475_1.duration_ = 5.6

		local var_475_0 = {
			zh = 1.999999999999,
			ja = 5.6
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play413061115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10098 = arg_475_1.actors_["10098"].transform.localPosition
				arg_475_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10098", 0)

				for iter_478_0 = 0, arg_475_1.actors_["10098"].transform.childCount - 1 do
					local var_478_0 = arg_475_1.actors_["10098"].transform:GetChild(iter_478_0)

					if var_478_0.name == "" or not string.find(var_478_0.name, "split") then
						var_478_0.gameObject:SetActive(true)
					else
						var_478_0.gameObject:SetActive(false)
					end
				end
			end

			local var_478_1 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_1 then
				arg_475_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10098, Vector3.New(-1500, -350, -180), (arg_475_1.time_ - 0) / var_478_1)
			end

			if arg_475_1.time_ >= 0 + var_478_1 and arg_475_1.time_ < 0 + var_478_1 + arg_478_0 then
				arg_475_1.actors_["10098"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_478_2 = arg_475_1.actors_["10092"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10092 = var_478_2.localPosition
				var_478_2.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10092", 3)

				for iter_478_1 = 0, var_478_2.childCount - 1 do
					local var_478_3 = var_478_2:GetChild(iter_478_1)

					if var_478_3.name == "split_8" or not string.find(var_478_3.name, "split") then
						var_478_3.gameObject:SetActive(true)
					else
						var_478_3.gameObject:SetActive(false)
					end
				end
			end

			local var_478_4 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				var_478_2.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_475_1.time_ - 0) / var_478_4)
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				var_478_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_478_5 = arg_475_1.actors_["10098"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.actorSpriteComps10098 == nil then
				arg_475_1.var_.actorSpriteComps10098 = var_478_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_6 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_6 and not isNil(var_478_5) then
				if arg_475_1.var_.actorSpriteComps10098 then
					for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_478_3 then
							if arg_475_1.isInRecall_ then
								iter_478_3.color = Color.New(Mathf.Lerp(iter_478_3.color.r, arg_475_1.hightColor2.r, (arg_475_1.time_ - 0) / var_478_6), Mathf.Lerp(iter_478_3.color.g, arg_475_1.hightColor2.g, (arg_475_1.time_ - 0) / var_478_6), (Mathf.Lerp(iter_478_3.color.b, arg_475_1.hightColor2.b, (arg_475_1.time_ - 0) / var_478_6)))
							else
								local var_478_7 = Mathf.Lerp(iter_478_3.color.r, 0.5, (arg_475_1.time_ - 0) / var_478_6)

								iter_478_3.color = Color.New(var_478_7, var_478_7, var_478_7)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_6 and arg_475_1.time_ < 0 + var_478_6 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.actorSpriteComps10098 then
				for iter_478_4, iter_478_5 in pairs(arg_475_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_478_5 then
						iter_478_5.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_475_1.var_.actorSpriteComps10098 = nil
			end

			local var_478_8 = arg_475_1.actors_["10092"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10092 == nil then
				arg_475_1.var_.actorSpriteComps10092 = var_478_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_9 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_9 and not isNil(var_478_8) then
				if arg_475_1.var_.actorSpriteComps10092 then
					for iter_478_6, iter_478_7 in pairs(arg_475_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_478_7 then
							if arg_475_1.isInRecall_ then
								iter_478_7.color = Color.New(Mathf.Lerp(iter_478_7.color.r, arg_475_1.hightColor1.r, (arg_475_1.time_ - 0) / var_478_9), Mathf.Lerp(iter_478_7.color.g, arg_475_1.hightColor1.g, (arg_475_1.time_ - 0) / var_478_9), (Mathf.Lerp(iter_478_7.color.b, arg_475_1.hightColor1.b, (arg_475_1.time_ - 0) / var_478_9)))
							else
								local var_478_10 = Mathf.Lerp(iter_478_7.color.r, 1, (arg_475_1.time_ - 0) / var_478_9)

								iter_478_7.color = Color.New(var_478_10, var_478_10, var_478_10)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_9 and arg_475_1.time_ < 0 + var_478_9 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10092 then
				for iter_478_8, iter_478_9 in pairs(arg_475_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_478_9 then
						iter_478_9.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps10092 = nil
			end

			local var_478_11 = manager.ui.mainCamera.transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.shakeOldPos = var_478_11.localPosition
			end

			local var_478_12 = 0.6

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_12 then
				local var_478_13, var_478_14 = math.modf((arg_475_1.time_ - 0) / 0.066)

				var_478_11.localPosition = Vector3.New(var_478_14 * 0.13, var_478_14 * 0.13, var_478_14 * 0.13) + arg_475_1.var_.shakeOldPos
			end

			if arg_475_1.time_ >= 0 + var_478_12 and arg_475_1.time_ < 0 + var_478_12 + arg_478_0 then
				var_478_11.localPosition = arg_475_1.var_.shakeOldPos
			end

			local var_478_15 = 0

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_15 + arg_478_0 then
				arg_475_1.allBtn_.enabled = false
			end

			if arg_475_1.time_ >= var_478_15 + 0.6 and arg_475_1.time_ < var_478_15 + 0.6 + arg_478_0 then
				arg_475_1.allBtn_.enabled = true
			end

			local var_478_16 = 0
			local var_478_17 = 0.225

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_16 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_18 = arg_475_1:GetWordFromCfg(413061114)
				local var_478_19 = arg_475_1:FormatText(var_478_18.content)

				arg_475_1.text_.text = var_478_19

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_21 = 9 <= 0 and var_478_17 or var_478_17 * (utf8.len(var_478_19) / 9)

				if (9 <= 0 and var_478_17 or var_478_17 * (utf8.len(var_478_19) / 9)) > 0 and var_478_17 < var_478_21 then
					arg_475_1.talkMaxDuration = var_478_21

					if var_478_21 + var_478_16 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_21 + var_478_16
					end
				end

				arg_475_1.text_.text = var_478_19
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061114", "story_v_out_413061.awb") ~= 0 then
					local var_478_22 = manager.audio:GetVoiceLength("story_v_out_413061", "413061114", "story_v_out_413061.awb") / 1000

					if var_478_22 + var_478_16 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_22 + var_478_16
					end

					if var_478_18.prefab_name ~= "" and arg_475_1.actors_[var_478_18.prefab_name] ~= nil then
						local var_478_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_18.prefab_name].transform, "story_v_out_413061", "413061114", "story_v_out_413061.awb")

						arg_475_1:RecordAudio("413061114", var_478_23)
						arg_475_1:RecordAudio("413061114", var_478_23)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_413061", "413061114", "story_v_out_413061.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_413061", "413061114", "story_v_out_413061.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_24 = math.max(var_478_17, arg_475_1.talkMaxDuration)

			if var_478_16 <= arg_475_1.time_ and arg_475_1.time_ < var_478_16 + var_478_24 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_16) / var_478_24

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_16 + var_478_24 and arg_475_1.time_ < var_478_16 + var_478_24 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_475_1:InitPlayNodeList()
	end,
	Play413061115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 413061115
		arg_479_1.duration_ = 8.73

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play413061116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_482_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_479_1.bgmTxt_.text ~= var_482_2 and arg_479_1.bgmTxt_.text ~= "" then
						if arg_479_1.bgmTxt2_.text ~= "" then
							arg_479_1.bgmTxt_.text = arg_479_1.bgmTxt2_.text
						end

						arg_479_1.bgmTxt2_.text = var_482_2

						arg_479_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_479_1.bgmTxt_.text = var_482_2
						arg_479_1.bgmTxt2_.text = var_482_2
					end

					if arg_479_1.bgmTimer then
						arg_479_1.bgmTimer:Stop()

						arg_479_1.bgmTimer = nil
					end

					if arg_479_1.settingData.show_music_name == 1 then
						arg_479_1.musicController:SetSelectedState("show")
						arg_479_1.musicAnimator_:Play("open", 0, 0)

						if arg_479_1.settingData.music_time ~= 0 then
							arg_479_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_479_1.settingData.music_time), function()
								if arg_479_1 == nil or isNil(arg_479_1.bgmTxt_) then
									return
								end

								arg_479_1.musicController:SetSelectedState("hide")
								arg_479_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_479_1.time_ and arg_479_1.time_ <= 0.366666666666667 + arg_482_0 then
				arg_479_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_482_5 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if "" ~= "" then
					if arg_479_1.bgmTxt_.text ~= var_482_5 and arg_479_1.bgmTxt_.text ~= "" then
						if arg_479_1.bgmTxt2_.text ~= "" then
							arg_479_1.bgmTxt_.text = arg_479_1.bgmTxt2_.text
						end

						arg_479_1.bgmTxt2_.text = var_482_5

						arg_479_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_479_1.bgmTxt_.text = var_482_5
						arg_479_1.bgmTxt2_.text = var_482_5
					end

					if arg_479_1.bgmTimer then
						arg_479_1.bgmTimer:Stop()

						arg_479_1.bgmTimer = nil
					end

					if arg_479_1.settingData.show_music_name == 1 then
						arg_479_1.musicController:SetSelectedState("show")
						arg_479_1.musicAnimator_:Play("open", 0, 0)

						if arg_479_1.settingData.music_time ~= 0 then
							arg_479_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_479_1.settingData.music_time), function()
								if arg_479_1 == nil or isNil(arg_479_1.bgmTxt_) then
									return
								end

								arg_479_1.musicController:SetSelectedState("hide")
								arg_479_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_479_1.time_ and arg_479_1.time_ <= 0.2 + arg_482_0 then
				arg_479_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sizzle", "")
			end

			if 0.333333333333333 < arg_479_1.time_ and arg_479_1.time_ <= 0.333333333333333 + arg_482_0 then
				arg_479_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_enermy", "")
			end

			local var_482_8 = 0

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_8 + arg_482_0 then
				arg_479_1.mask_.enabled = true
				arg_479_1.mask_.raycastTarget = true

				arg_479_1:SetGaussion(false)
			end

			local var_482_9 = 2

			if var_482_8 <= arg_479_1.time_ and arg_479_1.time_ < var_482_8 + var_482_9 then
				local var_482_10 = Color.New(0, 0, 0)

				var_482_10.a = Mathf.Lerp(0, 1, (arg_479_1.time_ - var_482_8) / var_482_9)
				arg_479_1.mask_.color = var_482_10
			end

			if arg_479_1.time_ >= var_482_8 + var_482_9 and arg_479_1.time_ < var_482_8 + var_482_9 + arg_482_0 then
				local var_482_11 = Color.New(0, 0, 0)

				var_482_11.a = 1
				arg_479_1.mask_.color = var_482_11
			end

			local var_482_12 = 2

			if 2 < arg_479_1.time_ and arg_479_1.time_ <= var_482_12 + arg_482_0 then
				arg_479_1.mask_.enabled = true
				arg_479_1.mask_.raycastTarget = true

				arg_479_1:SetGaussion(false)
			end

			local var_482_13 = 2

			if var_482_12 <= arg_479_1.time_ and arg_479_1.time_ < var_482_12 + var_482_13 then
				local var_482_14 = Color.New(0, 0, 0)

				var_482_14.a = Mathf.Lerp(1, 0, (arg_479_1.time_ - var_482_12) / var_482_13)
				arg_479_1.mask_.color = var_482_14
			end

			if arg_479_1.time_ >= var_482_12 + var_482_13 and arg_479_1.time_ < var_482_12 + var_482_13 + arg_482_0 then
				local var_482_15 = Color.New(0, 0, 0)

				arg_479_1.mask_.enabled = false
				var_482_15.a = 0
				arg_479_1.mask_.color = var_482_15
			end

			local var_482_16 = "SS1304"

			if arg_479_1.bgs_.SS1304 == nil then
				local var_482_17 = Object.Instantiate(arg_479_1.paintGo_)

				var_482_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_482_16)
				var_482_17.name = var_482_16
				var_482_17.transform.parent = arg_479_1.stage_.transform
				var_482_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_479_1.bgs_[var_482_16] = var_482_17
			end

			if 1.98333333333333 < arg_479_1.time_ and arg_479_1.time_ <= 1.98333333333333 + arg_482_0 then
				local var_482_18 = arg_479_1.bgs_.SS1304

				arg_479_1.bgs_.SS1304.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_482_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_482_19 = var_482_18:GetComponent("SpriteRenderer")

				if var_482_19 and var_482_19.sprite then
					local var_482_20 = 2 * (var_482_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_482_18.transform.localScale = Vector3.New(var_482_20 / var_482_19.sprite.bounds.size.y < var_482_20 * manager.ui.mainCameraCom_.aspect / var_482_19.sprite.bounds.size.x and var_482_20 * manager.ui.mainCameraCom_.aspect / var_482_19.sprite.bounds.size.x or var_482_20 / var_482_19.sprite.bounds.size.y, var_482_20 / var_482_19.sprite.bounds.size.y < var_482_20 * manager.ui.mainCameraCom_.aspect / var_482_19.sprite.bounds.size.x and var_482_20 * manager.ui.mainCameraCom_.aspect / var_482_19.sprite.bounds.size.x or var_482_20 / var_482_19.sprite.bounds.size.y, 0)
				end

				for iter_482_0, iter_482_1 in pairs(arg_479_1.bgs_) do
					if iter_482_0 ~= "SS1304" then
						iter_482_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_482_21 = arg_479_1.actors_["10092"].transform

			if 1.966 < arg_479_1.time_ and arg_479_1.time_ <= 1.966 + arg_482_0 then
				arg_479_1.var_.moveOldPos10092 = var_482_21.localPosition
				var_482_21.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10092", 7)

				for iter_482_2 = 0, var_482_21.childCount - 1 do
					local var_482_22 = var_482_21:GetChild(iter_482_2)

					if var_482_22.name == "split_8" or not string.find(var_482_22.name, "split") then
						var_482_22.gameObject:SetActive(true)
					else
						var_482_22.gameObject:SetActive(false)
					end
				end
			end

			local var_482_23 = 0.001

			if 1.966 <= arg_479_1.time_ and arg_479_1.time_ < 1.966 + var_482_23 then
				var_482_21.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_479_1.time_ - 1.966) / var_482_23)
			end

			if arg_479_1.time_ >= 1.966 + var_482_23 and arg_479_1.time_ < 1.966 + var_482_23 + arg_482_0 then
				var_482_21.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_482_24 = arg_479_1.bgs_.SS1304.transform

			if 2 < arg_479_1.time_ and arg_479_1.time_ <= 2 + arg_482_0 then
				arg_479_1.var_.moveOldPosSS1304 = var_482_24.localPosition
			end

			local var_482_25 = 0.001

			if 2 <= arg_479_1.time_ and arg_479_1.time_ < 2 + var_482_25 then
				var_482_24.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPosSS1304, Vector3.New(0, 1, 10), (arg_479_1.time_ - 2) / var_482_25)
			end

			if arg_479_1.time_ >= 2 + var_482_25 and arg_479_1.time_ < 2 + var_482_25 + arg_482_0 then
				var_482_24.localPosition = Vector3.New(0, 1, 10)
			end

			local var_482_26 = arg_479_1.bgs_.SS1304.transform

			if 2.034 < arg_479_1.time_ and arg_479_1.time_ <= 2.034 + arg_482_0 then
				arg_479_1.var_.moveOldPosSS1304 = var_482_26.localPosition
			end

			local var_482_27 = 1.966

			if 2.034 <= arg_479_1.time_ and arg_479_1.time_ < 2.034 + var_482_27 then
				var_482_26.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPosSS1304, Vector3.New(0, 1, 9.55), (arg_479_1.time_ - 2.034) / var_482_27)
			end

			if arg_479_1.time_ >= 2.034 + var_482_27 and arg_479_1.time_ < 2.034 + var_482_27 + arg_482_0 then
				var_482_26.localPosition = Vector3.New(0, 1, 9.55)
			end

			if arg_479_1.frameCnt_ <= 1 then
				arg_479_1.dialog_:SetActive(false)
			end

			local var_482_28 = 3.73333333333333
			local var_482_29 = 1.725

			if 3.73333333333333 < arg_479_1.time_ and arg_479_1.time_ <= var_482_28 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0

				arg_479_1.dialog_:SetActive(true)

				arg_479_1.dialogCg_.alpha = 0

				local var_482_30 = LeanTween.value(arg_479_1.dialog_, 0, 1, 0.3)

				var_482_30:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_479_1.dialogCg_.alpha = arg_485_0
				end))
				var_482_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_479_1.dialog_)
					var_482_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_479_1.duration_ = arg_479_1.duration_ + 0.3

				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_31 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(413061115).content)

				arg_479_1.text_.text = var_482_31

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_33 = 69 <= 0 and var_482_29 or var_482_29 * (utf8.len(var_482_31) / 69)

				if (69 <= 0 and var_482_29 or var_482_29 * (utf8.len(var_482_31) / 69)) > 0 and var_482_29 < var_482_33 then
					arg_479_1.talkMaxDuration = var_482_33
					var_482_28 = var_482_28 + 0.3

					if var_482_33 + var_482_28 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_33 + var_482_28
					end
				end

				arg_479_1.text_.text = var_482_31
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_34 = var_482_28 + 0.3
			local var_482_35 = math.max(var_482_29, arg_479_1.talkMaxDuration)

			if var_482_28 + 0.3 <= arg_479_1.time_ and arg_479_1.time_ < var_482_34 + var_482_35 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_34) / var_482_35

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_34 + var_482_35 and arg_479_1.time_ < var_482_34 + var_482_35 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
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
				actorName = "SS1304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play413061116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 413061116
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play413061117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 1.475

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(413061116).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 59 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 59)

				if (59 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 59)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play413061117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 413061117
		arg_491_1.duration_ = 3.37

		local var_491_0 = {
			zh = 3.366,
			ja = 2.533
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play413061118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.325

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:GetWordFromCfg(413061117)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 13 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 13)

				if (13 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 13)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061117", "story_v_out_413061.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061117", "story_v_out_413061.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_413061", "413061117", "story_v_out_413061.awb")

						arg_491_1:RecordAudio("413061117", var_494_6)
						arg_491_1:RecordAudio("413061117", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_413061", "413061117", "story_v_out_413061.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_413061", "413061117", "story_v_out_413061.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play413061118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 413061118
		arg_495_1.duration_ = 6.5

		local var_495_0 = {
			zh = 6.5,
			ja = 5.733
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play413061119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.525

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(413061118)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 21 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 21)

				if (21 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 21)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061118", "story_v_out_413061.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061118", "story_v_out_413061.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_413061", "413061118", "story_v_out_413061.awb")

						arg_495_1:RecordAudio("413061118", var_498_6)
						arg_495_1:RecordAudio("413061118", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_413061", "413061118", "story_v_out_413061.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_413061", "413061118", "story_v_out_413061.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play413061119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 413061119
		arg_499_1.duration_ = 2.83

		local var_499_0 = {
			zh = 1.866,
			ja = 2.833
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play413061120(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.25

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(413061119)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 10 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 10)

				if (10 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 10)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061119", "story_v_out_413061.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061119", "story_v_out_413061.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_413061", "413061119", "story_v_out_413061.awb")

						arg_499_1:RecordAudio("413061119", var_502_6)
						arg_499_1:RecordAudio("413061119", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_413061", "413061119", "story_v_out_413061.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_413061", "413061119", "story_v_out_413061.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play413061120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 413061120
		arg_503_1.duration_ = 10.2

		local var_503_0 = {
			zh = 8.73333333333333,
			ja = 10.1993333333333
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play413061121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				local var_506_0 = arg_503_1.var_.effectcitong1

				if not arg_503_1.var_.effectcitong1 then
					var_506_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_506_0.name = "citong1"
					arg_503_1.var_.effectcitong1 = var_506_0
				else
					var_506_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_506_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_506_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_503_1.frameCnt_ <= 1 then
				arg_503_1.dialog_:SetActive(false)
			end

			local var_506_2 = 0.333333333333333
			local var_506_3 = 0.775

			if 0.333333333333333 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_4 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_4:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_503_1.dialogCg_.alpha = arg_507_0
				end))
				var_506_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_5 = arg_503_1:GetWordFromCfg(413061120)
				local var_506_6 = arg_503_1:FormatText(var_506_5.content)

				arg_503_1.text_.text = var_506_6

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_8 = 31 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_6) / 31)

				if (31 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_6) / 31)) > 0 and var_506_3 < var_506_8 then
					arg_503_1.talkMaxDuration = var_506_8
					var_506_2 = var_506_2 + 0.3

					if var_506_8 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_6
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061120", "story_v_out_413061.awb") ~= 0 then
					local var_506_9 = manager.audio:GetVoiceLength("story_v_out_413061", "413061120", "story_v_out_413061.awb") / 1000

					if var_506_9 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_2
					end

					if var_506_5.prefab_name ~= "" and arg_503_1.actors_[var_506_5.prefab_name] ~= nil then
						local var_506_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_5.prefab_name].transform, "story_v_out_413061", "413061120", "story_v_out_413061.awb")

						arg_503_1:RecordAudio("413061120", var_506_10)
						arg_503_1:RecordAudio("413061120", var_506_10)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_413061", "413061120", "story_v_out_413061.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_413061", "413061120", "story_v_out_413061.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_11 = var_506_2 + 0.3
			local var_506_12 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 + 0.3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_11 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_11) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_11 + var_506_12 and arg_503_1.time_ < var_506_11 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play413061121 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 413061121
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play413061122(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.65

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(413061121).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 66 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 66)

				if (66 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 66)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play413061122 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 413061122
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play413061123(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 1.375

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(413061122).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 55 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 55)

				if (55 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 55)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play413061123 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 413061123
		arg_517_1.duration_ = 5.87

		local var_517_0 = {
			zh = 5.833,
			ja = 5.866
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play413061124(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.475

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:GetWordFromCfg(413061123)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 19 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 19)

				if (19 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 19)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061123", "story_v_out_413061.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061123", "story_v_out_413061.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_out_413061", "413061123", "story_v_out_413061.awb")

						arg_517_1:RecordAudio("413061123", var_520_6)
						arg_517_1:RecordAudio("413061123", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_413061", "413061123", "story_v_out_413061.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_413061", "413061123", "story_v_out_413061.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play413061124 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 413061124
		arg_521_1.duration_ = 7.07

		local var_521_0 = {
			zh = 7.066,
			ja = 4.8
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play413061125(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.3

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(413061124)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 12 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 12)

				if (12 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 12)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061124", "story_v_out_413061.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061124", "story_v_out_413061.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_413061", "413061124", "story_v_out_413061.awb")

						arg_521_1:RecordAudio("413061124", var_524_6)
						arg_521_1:RecordAudio("413061124", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_413061", "413061124", "story_v_out_413061.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_413061", "413061124", "story_v_out_413061.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play413061125 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 413061125
		arg_525_1.duration_ = 6.23

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play413061126(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_jump2", "")
			end

			local var_528_1 = arg_525_1.bgs_.SS1304.transform

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPosSS1304 = var_528_1.localPosition
			end

			local var_528_2 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_2 then
				var_528_1.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPosSS1304, Vector3.New(0, 1, 9.55), (arg_525_1.time_ - 0) / var_528_2)
			end

			if arg_525_1.time_ >= 0 + var_528_2 and arg_525_1.time_ < 0 + var_528_2 + arg_528_0 then
				var_528_1.localPosition = Vector3.New(0, 1, 9.55)
			end

			local var_528_3 = arg_525_1.bgs_.SS1304.transform

			if 0.034 < arg_525_1.time_ and arg_525_1.time_ <= 0.034 + arg_528_0 then
				arg_525_1.var_.moveOldPosSS1304 = var_528_3.localPosition
			end

			local var_528_4 = 1.766

			if 0.034 <= arg_525_1.time_ and arg_525_1.time_ < 0.034 + var_528_4 then
				var_528_3.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPosSS1304, Vector3.New(0, 1, 10), (arg_525_1.time_ - 0.034) / var_528_4)
			end

			if arg_525_1.time_ >= 0.034 + var_528_4 and arg_525_1.time_ < 0.034 + var_528_4 + arg_528_0 then
				var_528_3.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_5 = 1.23333333333333
			local var_528_6 = 1.925

			if 1.23333333333333 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_7 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_7:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_8 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(413061125).content)

				arg_525_1.text_.text = var_528_8

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_10 = 77 <= 0 and var_528_6 or var_528_6 * (utf8.len(var_528_8) / 77)

				if (77 <= 0 and var_528_6 or var_528_6 * (utf8.len(var_528_8) / 77)) > 0 and var_528_6 < var_528_10 then
					arg_525_1.talkMaxDuration = var_528_10
					var_528_5 = var_528_5 + 0.3

					if var_528_10 + var_528_5 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_5
					end
				end

				arg_525_1.text_.text = var_528_8
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_11 = var_528_5 + 0.3
			local var_528_12 = math.max(var_528_6, arg_525_1.talkMaxDuration)

			if var_528_5 + 0.3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_11 + var_528_12 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_11) / var_528_12

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_11 + var_528_12 and arg_525_1.time_ < var_528_11 + var_528_12 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1304",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.766,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play413061126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 413061126
		arg_531_1.duration_ = 6

		local var_531_0 = {
			zh = 3.966,
			ja = 6
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play413061127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.45

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:GetWordFromCfg(413061126)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 18 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 18)

				if (18 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 18)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061126", "story_v_out_413061.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061126", "story_v_out_413061.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_out_413061", "413061126", "story_v_out_413061.awb")

						arg_531_1:RecordAudio("413061126", var_534_6)
						arg_531_1:RecordAudio("413061126", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_413061", "413061126", "story_v_out_413061.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_413061", "413061126", "story_v_out_413061.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play413061127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 413061127
		arg_535_1.duration_ = 3.93

		local var_535_0 = {
			zh = 2.233,
			ja = 3.933
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play413061128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.3

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094_split_2")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_1 = arg_535_1:GetWordFromCfg(413061127)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 12 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 12)

				if (12 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 12)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061127", "story_v_out_413061.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061127", "story_v_out_413061.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_out_413061", "413061127", "story_v_out_413061.awb")

						arg_535_1:RecordAudio("413061127", var_538_6)
						arg_535_1:RecordAudio("413061127", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_413061", "413061127", "story_v_out_413061.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_413061", "413061127", "story_v_out_413061.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play413061128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 413061128
		arg_539_1.duration_ = 3.8

		local var_539_0 = {
			zh = 2.5,
			ja = 3.8
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
			arg_539_1.auto_ = false
		end

		function arg_539_1.playNext_(arg_541_0)
			arg_539_1.onStoryFinished_()
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.225

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094_split_2")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:GetWordFromCfg(413061128)
				local var_542_2 = arg_539_1:FormatText(var_542_1.content)

				arg_539_1.text_.text = var_542_2

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 9 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 9)

				if (9 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 9)) > 0 and var_542_0 < var_542_4 then
					arg_539_1.talkMaxDuration = var_542_4

					if var_542_4 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_4 + 0
					end
				end

				arg_539_1.text_.text = var_542_2
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413061", "413061128", "story_v_out_413061.awb") ~= 0 then
					local var_542_5 = manager.audio:GetVoiceLength("story_v_out_413061", "413061128", "story_v_out_413061.awb") / 1000

					if var_542_5 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + 0
					end

					if var_542_1.prefab_name ~= "" and arg_539_1.actors_[var_542_1.prefab_name] ~= nil then
						local var_542_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_1.prefab_name].transform, "story_v_out_413061", "413061128", "story_v_out_413061.awb")

						arg_539_1:RecordAudio("413061128", var_542_6)
						arg_539_1:RecordAudio("413061128", var_542_6)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_413061", "413061128", "story_v_out_413061.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_413061", "413061128", "story_v_out_413061.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_7 and arg_539_1.time_ < 0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/F08g",
		"TextureConfig/Background/SS1304"
	},
	voices = {
		"story_v_out_413061.awb"
	}
}
