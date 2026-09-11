return {
	Play417151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417151001
		arg_1_1.duration_ = 12.37

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11m")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= 0 + 5 and arg_1_1.time_ < 0 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_0 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 1.2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = Color.New(0, 0, 0)

				var_4_2.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_0) / var_4_1)
				arg_1_1.mask_.color = var_4_2
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = 1
				arg_1_1.mask_.color = var_4_3
			end

			local var_4_4 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.2

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

			local var_4_8 = "I11m"

			if arg_1_1.bgs_.I11m == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.I11m

				arg_1_1.bgs_.I11m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11m" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 6.2 and arg_1_1.time_ < var_4_13 + 6.2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1

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

			if 6.93333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 6.93333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_footstep", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 5.28 < arg_1_1.time_ and arg_1_1.time_ <= 5.28 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 7.36666666666667
			local var_4_26 = 0.133333333333333

			if 7.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1154].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417151001).content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 2 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 2)

				if (2 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 2)) > 0 and var_4_26 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_25 = var_4_25 + 0.3

					if var_4_30 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_25 + 0.3
			local var_4_32 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417151002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417151002
		arg_10_1.duration_ = 1.83

		local var_10_0 = {
			zh = 1.066,
			ja = 1.833
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417151003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["10128"] == nil then
				local var_13_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_13_0) then
					local var_13_1 = Object.Instantiate(var_13_0, arg_10_1.canvasGo_.transform)

					var_13_1.transform:SetSiblingIndex(1)

					var_13_1.name = "10128"
					var_13_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_["10128"] = var_13_1

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs((var_13_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_2 = arg_10_1.actors_["10128"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps10128 == nil then
				arg_10_1.var_.actorSpriteComps10128 = var_13_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_3 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_3 and not isNil(var_13_2) then
				if arg_10_1.var_.actorSpriteComps10128 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								iter_13_3.color = Color.New(Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor1.r, (arg_10_1.time_ - 0) / var_13_3), Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor1.g, (arg_10_1.time_ - 0) / var_13_3), (Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor1.b, (arg_10_1.time_ - 0) / var_13_3)))
							else
								local var_13_4 = Mathf.Lerp(iter_13_3.color.r, 1, (arg_10_1.time_ - 0) / var_13_3)

								iter_13_3.color = Color.New(var_13_4, var_13_4, var_13_4)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= 0 + var_13_3 and arg_10_1.time_ < 0 + var_13_3 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps10128 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_13_5 then
						iter_13_5.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_10_1.var_.actorSpriteComps10128 = nil
			end

			local var_13_5 = arg_10_1.actors_["10128"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10128 = var_13_5.localPosition
				var_13_5.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("10128", 3)

				for iter_13_6 = 0, var_13_5.childCount - 1 do
					local var_13_6 = var_13_5:GetChild(iter_13_6)

					if var_13_6.name == "" or not string.find(var_13_6.name, "split") then
						var_13_6.gameObject:SetActive(true)
					else
						var_13_6.gameObject:SetActive(false)
					end
				end
			end

			local var_13_7 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_10_1.time_ - 0) / var_13_7)
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_13_8 = 0
			local var_13_9 = 0.05

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:GetWordFromCfg(417151002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 2 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 2)

				if (2 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 2)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151002", "story_v_out_417151.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151002", "story_v_out_417151.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_417151", "417151002", "story_v_out_417151.awb")

						arg_10_1:RecordAudio("417151002", var_13_15)
						arg_10_1:RecordAudio("417151002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417151", "417151002", "story_v_out_417151.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417151", "417151002", "story_v_out_417151.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_16 and arg_10_1.time_ < var_13_8 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play417151003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417151003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417151004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = arg_14_1.actors_["10128"].transform.localPosition
				arg_14_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 7)

				for iter_17_0 = 0, arg_14_1.actors_["10128"].transform.childCount - 1 do
					local var_17_0 = arg_14_1.actors_["10128"].transform:GetChild(iter_17_0)

					if var_17_0.name == "" or not string.find(var_17_0.name, "split") then
						var_17_0.gameObject:SetActive(true)
					else
						var_17_0.gameObject:SetActive(false)
					end
				end
			end

			local var_17_1 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_1 then
				arg_14_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_14_1.time_ - 0) / var_17_1)
			end

			if arg_14_1.time_ >= 0 + var_17_1 and arg_14_1.time_ < 0 + var_17_1 + arg_17_0 then
				arg_14_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_17_2 = 0
			local var_17_3 = 1.05

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_4 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417151003).content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_6 = 42 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_4) / 42)

				if (42 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_4) / 42)) > 0 and var_17_3 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_2
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_3, arg_14_1.talkMaxDuration)

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_2) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_2 + var_17_7 and arg_14_1.time_ < var_17_2 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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
	Play417151004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417151004
		arg_18_1.duration_ = 3.9

		local var_18_0 = {
			zh = 2.833,
			ja = 3.9
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417151005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.25

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1154].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermb")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417151004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 10 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 10)

				if (10 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 10)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151004", "story_v_out_417151.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151004", "story_v_out_417151.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417151", "417151004", "story_v_out_417151.awb")

						arg_18_1:RecordAudio("417151004", var_21_6)
						arg_18_1:RecordAudio("417151004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417151", "417151004", "story_v_out_417151.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417151", "417151004", "story_v_out_417151.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417151005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417151005
		arg_22_1.duration_ = 3.3

		local var_22_0 = {
			zh = 1.4,
			ja = 3.3
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417151006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10128"]) and arg_22_1.var_.actorSpriteComps10128 == nil then
				arg_22_1.var_.actorSpriteComps10128 = arg_22_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10128"]) then
				if arg_22_1.var_.actorSpriteComps10128 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor1.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor1.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor1.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 1, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10128"]) and arg_22_1.var_.actorSpriteComps10128 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_22_1.var_.actorSpriteComps10128 = nil
			end

			local var_25_2 = arg_22_1.actors_["10128"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos10128 = var_25_2.localPosition
				var_25_2.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10128", 3)

				for iter_25_4 = 0, var_25_2.childCount - 1 do
					local var_25_3 = var_25_2:GetChild(iter_25_4)

					if var_25_3.name == "" or not string.find(var_25_3.name, "split") then
						var_25_3.gameObject:SetActive(true)
					else
						var_25_3.gameObject:SetActive(false)
					end
				end
			end

			local var_25_4 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				var_25_2.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_22_1.time_ - 0) / var_25_4)
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				var_25_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_25_5 = 0
			local var_25_6 = 0.175

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_7 = arg_22_1:GetWordFromCfg(417151005)
				local var_25_8 = arg_22_1:FormatText(var_25_7.content)

				arg_22_1.text_.text = var_25_8

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_10 = 7 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 7)

				if (7 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 7)) > 0 and var_25_6 < var_25_10 then
					arg_22_1.talkMaxDuration = var_25_10

					if var_25_10 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_5
					end
				end

				arg_22_1.text_.text = var_25_8
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151005", "story_v_out_417151.awb") ~= 0 then
					local var_25_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151005", "story_v_out_417151.awb") / 1000

					if var_25_11 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_5
					end

					if var_25_7.prefab_name ~= "" and arg_22_1.actors_[var_25_7.prefab_name] ~= nil then
						local var_25_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_7.prefab_name].transform, "story_v_out_417151", "417151005", "story_v_out_417151.awb")

						arg_22_1:RecordAudio("417151005", var_25_12)
						arg_22_1:RecordAudio("417151005", var_25_12)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417151", "417151005", "story_v_out_417151.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417151", "417151005", "story_v_out_417151.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_13 = math.max(var_25_6, arg_22_1.talkMaxDuration)

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_13 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_5) / var_25_13

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_5 + var_25_13 and arg_22_1.time_ < var_25_5 + var_25_13 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417151006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417151006
		arg_26_1.duration_ = 2.73

		local var_26_0 = {
			zh = 2.733,
			ja = 1.833
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417151007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10128"]) and arg_26_1.var_.actorSpriteComps10128 == nil then
				arg_26_1.var_.actorSpriteComps10128 = arg_26_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10128"]) then
				if arg_26_1.var_.actorSpriteComps10128 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								iter_29_1.color = Color.New(Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor2.r, (arg_26_1.time_ - 0) / var_29_0), Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor2.g, (arg_26_1.time_ - 0) / var_29_0), (Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor2.b, (arg_26_1.time_ - 0) / var_29_0)))
							else
								local var_29_1 = Mathf.Lerp(iter_29_1.color.r, 0.5, (arg_26_1.time_ - 0) / var_29_0)

								iter_29_1.color = Color.New(var_29_1, var_29_1, var_29_1)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10128"]) and arg_26_1.var_.actorSpriteComps10128 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_26_1.var_.actorSpriteComps10128 = nil
			end

			local var_29_2 = 0
			local var_29_3 = 0.2

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1154].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermb")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_4 = arg_26_1:GetWordFromCfg(417151006)
				local var_29_5 = arg_26_1:FormatText(var_29_4.content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_7 = 8 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 8)

				if (8 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 8)) > 0 and var_29_3 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_2
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151006", "story_v_out_417151.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151006", "story_v_out_417151.awb") / 1000

					if var_29_8 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_2
					end

					if var_29_4.prefab_name ~= "" and arg_26_1.actors_[var_29_4.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_4.prefab_name].transform, "story_v_out_417151", "417151006", "story_v_out_417151.awb")

						arg_26_1:RecordAudio("417151006", var_29_9)
						arg_26_1:RecordAudio("417151006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417151", "417151006", "story_v_out_417151.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417151", "417151006", "story_v_out_417151.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_3, arg_26_1.talkMaxDuration)

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_2) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_2 + var_29_10 and arg_26_1.time_ < var_29_2 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417151007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417151007
		arg_30_1.duration_ = 4.13

		local var_30_0 = {
			zh = 4.133,
			ja = 4
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
				arg_30_0:Play417151008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = arg_30_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10128"]) then
				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.45

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_4 = arg_30_1:GetWordFromCfg(417151007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 18 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 18)

				if (18 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 18)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151007", "story_v_out_417151.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151007", "story_v_out_417151.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417151", "417151007", "story_v_out_417151.awb")

						arg_30_1:RecordAudio("417151007", var_33_9)
						arg_30_1:RecordAudio("417151007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417151", "417151007", "story_v_out_417151.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417151", "417151007", "story_v_out_417151.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_10 and arg_30_1.time_ < var_33_2 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417151008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417151008
		arg_34_1.duration_ = 4.3

		local var_34_0 = {
			zh = 3.533,
			ja = 4.3
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
				arg_34_0:Play417151009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["10128"]) and arg_34_1.var_.actorSpriteComps10128 == nil then
				arg_34_1.var_.actorSpriteComps10128 = arg_34_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["10128"]) then
				if arg_34_1.var_.actorSpriteComps10128 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 0.5, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["10128"]) and arg_34_1.var_.actorSpriteComps10128 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps10128 = nil
			end

			local var_37_2 = 0
			local var_37_3 = 0.225

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1154].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomermb")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_4 = arg_34_1:GetWordFromCfg(417151008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 9 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 9)

				if (9 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 9)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151008", "story_v_out_417151.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151008", "story_v_out_417151.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_417151", "417151008", "story_v_out_417151.awb")

						arg_34_1:RecordAudio("417151008", var_37_9)
						arg_34_1:RecordAudio("417151008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417151", "417151008", "story_v_out_417151.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417151", "417151008", "story_v_out_417151.awb")
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

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417151009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417151009
		arg_38_1.duration_ = 3.4

		local var_38_0 = {
			zh = 2.966,
			ja = 3.4
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417151010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = arg_38_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10128"]) then
				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 1, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_2 = 0
			local var_41_3 = 0.4

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_4 = arg_38_1:GetWordFromCfg(417151009)
				local var_41_5 = arg_38_1:FormatText(var_41_4.content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 16 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 16)

				if (16 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 16)) > 0 and var_41_3 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151009", "story_v_out_417151.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151009", "story_v_out_417151.awb") / 1000

					if var_41_8 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_2
					end

					if var_41_4.prefab_name ~= "" and arg_38_1.actors_[var_41_4.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_4.prefab_name].transform, "story_v_out_417151", "417151009", "story_v_out_417151.awb")

						arg_38_1:RecordAudio("417151009", var_41_9)
						arg_38_1:RecordAudio("417151009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417151", "417151009", "story_v_out_417151.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417151", "417151009", "story_v_out_417151.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_10 and arg_38_1.time_ < var_41_2 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417151010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417151010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417151011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = arg_42_1.actors_["10128"].transform.localPosition
				arg_42_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 7)

				for iter_45_0 = 0, arg_42_1.actors_["10128"].transform.childCount - 1 do
					local var_45_0 = arg_42_1.actors_["10128"].transform:GetChild(iter_45_0)

					if var_45_0.name == "" or not string.find(var_45_0.name, "split") then
						var_45_0.gameObject:SetActive(true)
					else
						var_45_0.gameObject:SetActive(false)
					end
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_42_1.time_ - 0) / var_45_1)
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_45_2 = 0
			local var_45_3 = 1.575

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(417151010).content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 63 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 63)

				if (63 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 63)) > 0 and var_45_3 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_7 and arg_42_1.time_ < var_45_2 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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
	Play417151011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417151011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417151012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0.266666666666667 < arg_46_1.time_ and arg_46_1.time_ <= 0.266666666666667 + arg_49_0 then
				arg_46_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_robot", "")
			end

			local var_49_1 = 0
			local var_49_2 = 1.175

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(417151011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 47 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 47)

				if (47 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 47)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417151012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417151012
		arg_50_1.duration_ = 2.6

		local var_50_0 = {
			zh = 1.633,
			ja = 2.6
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
				arg_50_0:Play417151013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.175

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:GetWordFromCfg(417151012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 7 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 7)

				if (7 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 7)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151012", "story_v_out_417151.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151012", "story_v_out_417151.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_417151", "417151012", "story_v_out_417151.awb")

						arg_50_1:RecordAudio("417151012", var_53_6)
						arg_50_1:RecordAudio("417151012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417151", "417151012", "story_v_out_417151.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417151", "417151012", "story_v_out_417151.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417151013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417151013
		arg_54_1.duration_ = 2.93

		local var_54_0 = {
			zh = 2,
			ja = 2.933
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play417151014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10128"]) and arg_54_1.var_.actorSpriteComps10128 == nil then
				arg_54_1.var_.actorSpriteComps10128 = arg_54_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10128"]) then
				if arg_54_1.var_.actorSpriteComps10128 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 1, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10128"]) and arg_54_1.var_.actorSpriteComps10128 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps10128 = nil
			end

			local var_57_2 = arg_54_1.actors_["10128"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos10128 = var_57_2.localPosition
				var_57_2.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10128", 3)

				for iter_57_4 = 0, var_57_2.childCount - 1 do
					local var_57_3 = var_57_2:GetChild(iter_57_4)

					if var_57_3.name == "split_6" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_54_1.time_ - 0) / var_57_4)
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_57_5 = 0
			local var_57_6 = 0.275

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(417151013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 11 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 11)

				if (11 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 11)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151013", "story_v_out_417151.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151013", "story_v_out_417151.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_417151", "417151013", "story_v_out_417151.awb")

						arg_54_1:RecordAudio("417151013", var_57_12)
						arg_54_1:RecordAudio("417151013", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417151", "417151013", "story_v_out_417151.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417151", "417151013", "story_v_out_417151.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_13 = math.max(var_57_6, arg_54_1.talkMaxDuration)

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_13 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_5) / var_57_13

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_5 + var_57_13 and arg_54_1.time_ < var_57_5 + var_57_13 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play417151014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417151014
		arg_58_1.duration_ = 7.4

		local var_58_0 = {
			zh = 6.566,
			ja = 7.4
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
				arg_58_0:Play417151015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = arg_58_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10128"]) then
				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 0.825

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_4 = arg_58_1:GetWordFromCfg(417151014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 33 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 33)

				if (33 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 33)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151014", "story_v_out_417151.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151014", "story_v_out_417151.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_417151", "417151014", "story_v_out_417151.awb")

						arg_58_1:RecordAudio("417151014", var_61_9)
						arg_58_1:RecordAudio("417151014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417151", "417151014", "story_v_out_417151.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417151", "417151014", "story_v_out_417151.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417151015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417151015
		arg_62_1.duration_ = 6.6

		local var_62_0 = {
			zh = 6.6,
			ja = 5.833
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
				arg_62_0:Play417151016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10128"]) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = arg_62_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10128"]) then
				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10128"]) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_2 = 0
			local var_65_3 = 0.825

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(417151015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 33 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 33)

				if (33 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 33)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151015", "story_v_out_417151.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151015", "story_v_out_417151.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_417151", "417151015", "story_v_out_417151.awb")

						arg_62_1:RecordAudio("417151015", var_65_9)
						arg_62_1:RecordAudio("417151015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417151", "417151015", "story_v_out_417151.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417151", "417151015", "story_v_out_417151.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417151016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417151016
		arg_66_1.duration_ = 9.4

		local var_66_0 = {
			zh = 7.066,
			ja = 9.4
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417151017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10128"]) and arg_66_1.var_.actorSpriteComps10128 == nil then
				arg_66_1.var_.actorSpriteComps10128 = arg_66_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10128"]) then
				if arg_66_1.var_.actorSpriteComps10128 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10128"]) and arg_66_1.var_.actorSpriteComps10128 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps10128 = nil
			end

			local var_69_2 = 0
			local var_69_3 = 0.8

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_4 = arg_66_1:GetWordFromCfg(417151016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 32 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 32)

				if (32 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 32)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151016", "story_v_out_417151.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151016", "story_v_out_417151.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_417151", "417151016", "story_v_out_417151.awb")

						arg_66_1:RecordAudio("417151016", var_69_9)
						arg_66_1:RecordAudio("417151016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417151", "417151016", "story_v_out_417151.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417151", "417151016", "story_v_out_417151.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417151017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417151017
		arg_70_1.duration_ = 6.2

		local var_70_0 = {
			zh = 3.933,
			ja = 6.2
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417151018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.8

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(417151017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 17 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 17)

				if (17 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 17)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151017", "story_v_out_417151.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151017", "story_v_out_417151.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_417151", "417151017", "story_v_out_417151.awb")

						arg_70_1:RecordAudio("417151017", var_73_6)
						arg_70_1:RecordAudio("417151017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417151", "417151017", "story_v_out_417151.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417151", "417151017", "story_v_out_417151.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417151018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417151018
		arg_74_1.duration_ = 11.27

		local var_74_0 = {
			zh = 7.5,
			ja = 11.266
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417151019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10128"]) and arg_74_1.var_.actorSpriteComps10128 == nil then
				arg_74_1.var_.actorSpriteComps10128 = arg_74_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10128"]) then
				if arg_74_1.var_.actorSpriteComps10128 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 1, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10128"]) and arg_74_1.var_.actorSpriteComps10128 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps10128 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 0.925

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(417151018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 37 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 37)

				if (37 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 37)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151018", "story_v_out_417151.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151018", "story_v_out_417151.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_417151", "417151018", "story_v_out_417151.awb")

						arg_74_1:RecordAudio("417151018", var_77_9)
						arg_74_1:RecordAudio("417151018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417151", "417151018", "story_v_out_417151.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417151", "417151018", "story_v_out_417151.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417151019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417151019
		arg_78_1.duration_ = 8.37

		local var_78_0 = {
			zh = 6.366,
			ja = 8.366
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417151020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = arg_78_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10128"]) then
				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor2.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor2.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor2.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 0.5, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_2 = 0
			local var_81_3 = 0.675

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_4 = arg_78_1:GetWordFromCfg(417151019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 27 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 27)

				if (27 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 27)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151019", "story_v_out_417151.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151019", "story_v_out_417151.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_417151", "417151019", "story_v_out_417151.awb")

						arg_78_1:RecordAudio("417151019", var_81_9)
						arg_78_1:RecordAudio("417151019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417151", "417151019", "story_v_out_417151.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417151", "417151019", "story_v_out_417151.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417151020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417151020
		arg_82_1.duration_ = 6.7

		local var_82_0 = {
			zh = 5.2,
			ja = 6.7
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417151021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.65

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(417151020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 26 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 26)

				if (26 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 26)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151020", "story_v_out_417151.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151020", "story_v_out_417151.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_417151", "417151020", "story_v_out_417151.awb")

						arg_82_1:RecordAudio("417151020", var_85_6)
						arg_82_1:RecordAudio("417151020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417151", "417151020", "story_v_out_417151.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417151", "417151020", "story_v_out_417151.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417151021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417151021
		arg_86_1.duration_ = 4.37

		local var_86_0 = {
			zh = 3.6,
			ja = 4.366
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417151022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10128"]) and arg_86_1.var_.actorSpriteComps10128 == nil then
				arg_86_1.var_.actorSpriteComps10128 = arg_86_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10128"]) then
				if arg_86_1.var_.actorSpriteComps10128 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 1, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10128"]) and arg_86_1.var_.actorSpriteComps10128 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps10128 = nil
			end

			local var_89_2 = arg_86_1.actors_["10128"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 3)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "split_1" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_89_5 = 0
			local var_89_6 = 0.275

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:GetWordFromCfg(417151021)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 11 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 11)

				if (11 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 11)) > 0 and var_89_6 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_5
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151021", "story_v_out_417151.awb") ~= 0 then
					local var_89_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151021", "story_v_out_417151.awb") / 1000

					if var_89_11 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_5
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_417151", "417151021", "story_v_out_417151.awb")

						arg_86_1:RecordAudio("417151021", var_89_12)
						arg_86_1:RecordAudio("417151021", var_89_12)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417151", "417151021", "story_v_out_417151.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417151", "417151021", "story_v_out_417151.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_6, arg_86_1.talkMaxDuration)

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_5) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_5 + var_89_13 and arg_86_1.time_ < var_89_5 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play417151022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417151022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417151023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10128"]) and arg_90_1.var_.actorSpriteComps10128 == nil then
				arg_90_1.var_.actorSpriteComps10128 = arg_90_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10128"]) then
				if arg_90_1.var_.actorSpriteComps10128 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10128"]) and arg_90_1.var_.actorSpriteComps10128 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps10128 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.925

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(417151022).content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 37 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 37)

				if (37 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 37)) > 0 and var_93_3 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_7 and arg_90_1.time_ < var_93_2 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417151023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417151023
		arg_94_1.duration_ = 8.9

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417151024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10128"]) and arg_94_1.var_.actorSpriteComps10128 == nil then
				arg_94_1.var_.actorSpriteComps10128 = arg_94_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10128"]) then
				if arg_94_1.var_.actorSpriteComps10128 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 1, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10128"]) and arg_94_1.var_.actorSpriteComps10128 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps10128 = nil
			end

			local var_97_2 = arg_94_1.actors_["10128"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10128 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("10128", 3)

				for iter_97_4 = 0, var_97_2.childCount - 1 do
					local var_97_3 = var_97_2:GetChild(iter_97_4)

					if var_97_3.name == "split_2" or not string.find(var_97_3.name, "split") then
						var_97_3.gameObject:SetActive(true)
					else
						var_97_3.gameObject:SetActive(false)
					end
				end
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_94_1.time_ - 0) / var_97_4)
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_97_5 = 0
			local var_97_6 = 1.075

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(417151023)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 43 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 43)

				if (43 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 43)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151023", "story_v_out_417151.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151023", "story_v_out_417151.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_417151", "417151023", "story_v_out_417151.awb")

						arg_94_1:RecordAudio("417151023", var_97_12)
						arg_94_1:RecordAudio("417151023", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417151", "417151023", "story_v_out_417151.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417151", "417151023", "story_v_out_417151.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_13 and arg_94_1.time_ < var_97_5 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play417151024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417151024
		arg_98_1.duration_ = 3.6

		local var_98_0 = {
			zh = 3.066,
			ja = 3.6
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417151025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.25

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(417151024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 10 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 10)

				if (10 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 10)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151024", "story_v_out_417151.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151024", "story_v_out_417151.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_417151", "417151024", "story_v_out_417151.awb")

						arg_98_1:RecordAudio("417151024", var_101_6)
						arg_98_1:RecordAudio("417151024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417151", "417151024", "story_v_out_417151.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417151", "417151024", "story_v_out_417151.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417151025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417151025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417151026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10128"]) and arg_102_1.var_.actorSpriteComps10128 == nil then
				arg_102_1.var_.actorSpriteComps10128 = arg_102_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10128"]) then
				if arg_102_1.var_.actorSpriteComps10128 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10128"]) and arg_102_1.var_.actorSpriteComps10128 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps10128 = nil
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_105_3 = 0
			local var_105_4 = 1.025

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_5 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(417151025).content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 41 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 41)

				if (41 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 41)) > 0 and var_105_4 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_3) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_8 and arg_102_1.time_ < var_105_3 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417151026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417151026
		arg_106_1.duration_ = 4.23

		local var_106_0 = {
			zh = 3.4,
			ja = 4.233
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play417151027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if arg_106_1.actors_["1015"] == nil then
				local var_109_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1015")

				if not isNil(var_109_0) then
					local var_109_1 = Object.Instantiate(var_109_0, arg_106_1.canvasGo_.transform)

					var_109_1.transform:SetSiblingIndex(1)

					var_109_1.name = "1015"
					var_109_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_106_1.actors_["1015"] = var_109_1

					if arg_106_1.isInRecall_ then
						for iter_109_0, iter_109_1 in ipairs((var_109_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_109_1.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_109_2 = arg_106_1.actors_["1015"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps1015 == nil then
				arg_106_1.var_.actorSpriteComps1015 = var_109_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.actorSpriteComps1015 then
					for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_109_3 then
							if arg_106_1.isInRecall_ then
								iter_109_3.color = Color.New(Mathf.Lerp(iter_109_3.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_3), Mathf.Lerp(iter_109_3.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_3), (Mathf.Lerp(iter_109_3.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_3)))
							else
								local var_109_4 = Mathf.Lerp(iter_109_3.color.r, 1, (arg_106_1.time_ - 0) / var_109_3)

								iter_109_3.color = Color.New(var_109_4, var_109_4, var_109_4)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps1015 then
				for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_109_5 then
						iter_109_5.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps1015 = nil
			end

			local var_109_5 = arg_106_1.actors_["10128"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10128 = var_109_5.localPosition
				var_109_5.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("10128", 2)

				for iter_109_6 = 0, var_109_5.childCount - 1 do
					local var_109_6 = var_109_5:GetChild(iter_109_6)

					if var_109_6.name == "" or not string.find(var_109_6.name, "split") then
						var_109_6.gameObject:SetActive(true)
					else
						var_109_6.gameObject:SetActive(false)
					end
				end
			end

			local var_109_7 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_106_1.time_ - 0) / var_109_7)
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_109_8 = arg_106_1.actors_["1015"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1015 = var_109_8.localPosition
				var_109_8.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("1015", 4)

				for iter_109_7 = 0, var_109_8.childCount - 1 do
					local var_109_9 = var_109_8:GetChild(iter_109_7)

					if var_109_9.name == "split_2" or not string.find(var_109_9.name, "split") then
						var_109_9.gameObject:SetActive(true)
					else
						var_109_9.gameObject:SetActive(false)
					end
				end
			end

			local var_109_10 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_10 then
				var_109_8.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_106_1.time_ - 0) / var_109_10)
			end

			if arg_106_1.time_ >= 0 + var_109_10 and arg_106_1.time_ < 0 + var_109_10 + arg_109_0 then
				var_109_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_109_11 = 0
			local var_109_12 = 0.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_13 = arg_106_1:GetWordFromCfg(417151026)
				local var_109_14 = arg_106_1:FormatText(var_109_13.content)

				arg_106_1.text_.text = var_109_14

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_16 = 12 <= 0 and var_109_12 or var_109_12 * (utf8.len(var_109_14) / 12)

				if (12 <= 0 and var_109_12 or var_109_12 * (utf8.len(var_109_14) / 12)) > 0 and var_109_12 < var_109_16 then
					arg_106_1.talkMaxDuration = var_109_16

					if var_109_16 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_11
					end
				end

				arg_106_1.text_.text = var_109_14
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151026", "story_v_out_417151.awb") ~= 0 then
					local var_109_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151026", "story_v_out_417151.awb") / 1000

					if var_109_17 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_11
					end

					if var_109_13.prefab_name ~= "" and arg_106_1.actors_[var_109_13.prefab_name] ~= nil then
						local var_109_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_13.prefab_name].transform, "story_v_out_417151", "417151026", "story_v_out_417151.awb")

						arg_106_1:RecordAudio("417151026", var_109_18)
						arg_106_1:RecordAudio("417151026", var_109_18)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417151", "417151026", "story_v_out_417151.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417151", "417151026", "story_v_out_417151.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_19 = math.max(var_109_12, arg_106_1.talkMaxDuration)

			if var_109_11 <= arg_106_1.time_ and arg_106_1.time_ < var_109_11 + var_109_19 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_11) / var_109_19

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_11 + var_109_19 and arg_106_1.time_ < var_109_11 + var_109_19 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play417151027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417151027
		arg_110_1.duration_ = 8.17

		local var_110_0 = {
			zh = 6.4,
			ja = 8.166
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play417151028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.ST77b == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST77b")
				var_113_0.name = "ST77b"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.ST77b = var_113_0
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.ST77b

				arg_110_1.bgs_.ST77b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST77b" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 4

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 0.15 and arg_110_1.time_ < var_113_4 + 0.15 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_5 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_6 = 2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_5) / var_113_6)
				arg_110_1.mask_.color = var_113_7
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				local var_113_8 = Color.New(0, 0, 0)

				var_113_8.a = 1
				arg_110_1.mask_.color = var_113_8
			end

			local var_113_9 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_10 = 2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 then
				local var_113_11 = Color.New(0, 0, 0)

				var_113_11.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_9) / var_113_10)
				arg_110_1.mask_.color = var_113_11
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 then
				local var_113_12 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_12.a = 0
				arg_110_1.mask_.color = var_113_12
			end

			local var_113_13 = arg_110_1.actors_["10128"].transform

			if 1.966 < arg_110_1.time_ and arg_110_1.time_ <= 1.966 + arg_113_0 then
				arg_110_1.var_.moveOldPos10128 = var_113_13.localPosition
				var_113_13.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10128", 7)

				for iter_113_2 = 0, var_113_13.childCount - 1 do
					local var_113_14 = var_113_13:GetChild(iter_113_2)

					if var_113_14.name == "" or not string.find(var_113_14.name, "split") then
						var_113_14.gameObject:SetActive(true)
					else
						var_113_14.gameObject:SetActive(false)
					end
				end
			end

			local var_113_15 = 0.001

			if 1.966 <= arg_110_1.time_ and arg_110_1.time_ < 1.966 + var_113_15 then
				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_110_1.time_ - 1.966) / var_113_15)
			end

			if arg_110_1.time_ >= 1.966 + var_113_15 and arg_110_1.time_ < 1.966 + var_113_15 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_113_16 = arg_110_1.actors_["1015"].transform

			if 1.966 < arg_110_1.time_ and arg_110_1.time_ <= 1.966 + arg_113_0 then
				arg_110_1.var_.moveOldPos1015 = var_113_16.localPosition
				var_113_16.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1015", 7)

				for iter_113_3 = 0, var_113_16.childCount - 1 do
					local var_113_17 = var_113_16:GetChild(iter_113_3)

					if var_113_17.name == "" or not string.find(var_113_17.name, "split") then
						var_113_17.gameObject:SetActive(true)
					else
						var_113_17.gameObject:SetActive(false)
					end
				end
			end

			local var_113_18 = 0.001

			if 1.966 <= arg_110_1.time_ and arg_110_1.time_ < 1.966 + var_113_18 then
				var_113_16.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_110_1.time_ - 1.966) / var_113_18)
			end

			if arg_110_1.time_ >= 1.966 + var_113_18 and arg_110_1.time_ < 1.966 + var_113_18 + arg_113_0 then
				var_113_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_19 = arg_110_1.actors_["1015"].transform

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				arg_110_1.var_.moveOldPos1015 = var_113_19.localPosition
				var_113_19.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1015", 3)

				for iter_113_4 = 0, var_113_19.childCount - 1 do
					local var_113_20 = var_113_19:GetChild(iter_113_4)

					if var_113_20.name == "" or not string.find(var_113_20.name, "split") then
						var_113_20.gameObject:SetActive(true)
					else
						var_113_20.gameObject:SetActive(false)
					end
				end
			end

			local var_113_21 = 0.001

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_21 then
				var_113_19.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_110_1.time_ - 3.8) / var_113_21)
			end

			if arg_110_1.time_ >= 3.8 + var_113_21 and arg_110_1.time_ < 3.8 + var_113_21 + arg_113_0 then
				var_113_19.localPosition = Vector3.New(0, -340, -288)
			end

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				local var_113_22 = arg_110_1.actors_["1015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_113_22 then
					arg_110_1.var_.alphaOldValue1015 = var_113_22.alpha
					arg_110_1.var_.characterEffect1015 = var_113_22
				end

				arg_110_1.var_.alphaOldValue1015 = 0
			end

			local var_113_23 = 0.166666666666667

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_23 then
				if arg_110_1.var_.characterEffect1015 then
					arg_110_1.var_.characterEffect1015.alpha = Mathf.Lerp(arg_110_1.var_.alphaOldValue1015, 1, (arg_110_1.time_ - 3.8) / var_113_23)
				end
			end

			if arg_110_1.time_ >= 3.8 + var_113_23 and arg_110_1.time_ < 3.8 + var_113_23 + arg_113_0 and arg_110_1.var_.characterEffect1015 then
				arg_110_1.var_.characterEffect1015.alpha = 1
			end

			local var_113_24 = arg_110_1.actors_["1015"]

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 and not isNil(var_113_24) and arg_110_1.var_.actorSpriteComps1015 == nil then
				arg_110_1.var_.actorSpriteComps1015 = var_113_24:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_25 = 0.2

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_25 and not isNil(var_113_24) then
				if arg_110_1.var_.actorSpriteComps1015 then
					for iter_113_5, iter_113_6 in pairs(arg_110_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_113_6 then
							if arg_110_1.isInRecall_ then
								iter_113_6.color = Color.New(Mathf.Lerp(iter_113_6.color.r, arg_110_1.hightColor1.r, (arg_110_1.time_ - 3.8) / var_113_25), Mathf.Lerp(iter_113_6.color.g, arg_110_1.hightColor1.g, (arg_110_1.time_ - 3.8) / var_113_25), (Mathf.Lerp(iter_113_6.color.b, arg_110_1.hightColor1.b, (arg_110_1.time_ - 3.8) / var_113_25)))
							else
								local var_113_26 = Mathf.Lerp(iter_113_6.color.r, 1, (arg_110_1.time_ - 3.8) / var_113_25)

								iter_113_6.color = Color.New(var_113_26, var_113_26, var_113_26)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 3.8 + var_113_25 and arg_110_1.time_ < 3.8 + var_113_25 + arg_113_0 and not isNil(var_113_24) and arg_110_1.var_.actorSpriteComps1015 then
				for iter_113_7, iter_113_8 in pairs(arg_110_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_113_8 then
						iter_113_8.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps1015 = nil
			end

			if 1.966 < arg_110_1.time_ and arg_110_1.time_ <= 1.966 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_28 = 4
			local var_113_29 = 0.25

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_30 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_30:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_31 = arg_110_1:GetWordFromCfg(417151027)
				local var_113_32 = arg_110_1:FormatText(var_113_31.content)

				arg_110_1.text_.text = var_113_32

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_34 = 10 <= 0 and var_113_29 or var_113_29 * (utf8.len(var_113_32) / 10)

				if (10 <= 0 and var_113_29 or var_113_29 * (utf8.len(var_113_32) / 10)) > 0 and var_113_29 < var_113_34 then
					arg_110_1.talkMaxDuration = var_113_34
					var_113_28 = var_113_28 + 0.3

					if var_113_34 + var_113_28 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_34 + var_113_28
					end
				end

				arg_110_1.text_.text = var_113_32
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151027", "story_v_out_417151.awb") ~= 0 then
					local var_113_35 = manager.audio:GetVoiceLength("story_v_out_417151", "417151027", "story_v_out_417151.awb") / 1000

					if var_113_35 + var_113_28 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_35 + var_113_28
					end

					if var_113_31.prefab_name ~= "" and arg_110_1.actors_[var_113_31.prefab_name] ~= nil then
						local var_113_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_31.prefab_name].transform, "story_v_out_417151", "417151027", "story_v_out_417151.awb")

						arg_110_1:RecordAudio("417151027", var_113_36)
						arg_110_1:RecordAudio("417151027", var_113_36)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417151", "417151027", "story_v_out_417151.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417151", "417151027", "story_v_out_417151.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_37 = var_113_28 + 0.3
			local var_113_38 = math.max(var_113_29, arg_110_1.talkMaxDuration)

			if var_113_28 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_37 + var_113_38 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_37) / var_113_38

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_37 + var_113_38 and arg_110_1.time_ < var_113_37 + var_113_38 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play417151028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417151028
		arg_116_1.duration_ = 4.5

		local var_116_0 = {
			zh = 2.366,
			ja = 4.5
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
				arg_116_0:Play417151029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10128"]) and arg_116_1.var_.actorSpriteComps10128 == nil then
				arg_116_1.var_.actorSpriteComps10128 = arg_116_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10128"]) then
				if arg_116_1.var_.actorSpriteComps10128 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10128"]) and arg_116_1.var_.actorSpriteComps10128 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps10128 = nil
			end

			local var_119_2 = arg_116_1.actors_["10128"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10128 = var_119_2.localPosition
				var_119_2.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10128", 3)

				for iter_119_4 = 0, var_119_2.childCount - 1 do
					local var_119_3 = var_119_2:GetChild(iter_119_4)

					if var_119_3.name == "split_6" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_2.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_116_1.time_ - 0) / var_119_4)
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_119_5 = arg_116_1.actors_["1015"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1015 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1015", 7)

				for iter_119_5 = 0, var_119_5.childCount - 1 do
					local var_119_6 = var_119_5:GetChild(iter_119_5)

					if var_119_6.name == "" or not string.find(var_119_6.name, "split") then
						var_119_6.gameObject:SetActive(true)
					else
						var_119_6.gameObject:SetActive(false)
					end
				end
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_8 = 0
			local var_119_9 = 0.325

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(417151028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 13 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 13)

				if (13 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 13)) > 0 and var_119_9 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151028", "story_v_out_417151.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151028", "story_v_out_417151.awb") / 1000

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_417151", "417151028", "story_v_out_417151.awb")

						arg_116_1:RecordAudio("417151028", var_119_15)
						arg_116_1:RecordAudio("417151028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417151", "417151028", "story_v_out_417151.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417151", "417151028", "story_v_out_417151.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_16 and arg_116_1.time_ < var_119_8 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play417151029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417151029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417151030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10128 = arg_120_1.actors_["10128"].transform.localPosition
				arg_120_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("10128", 7)

				for iter_123_0 = 0, arg_120_1.actors_["10128"].transform.childCount - 1 do
					local var_123_0 = arg_120_1.actors_["10128"].transform:GetChild(iter_123_0)

					if var_123_0.name == "" or not string.find(var_123_0.name, "split") then
						var_123_0.gameObject:SetActive(true)
					else
						var_123_0.gameObject:SetActive(false)
					end
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_120_1.time_ - 0) / var_123_1)
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_123_2 = 0
			local var_123_3 = 1.125

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(417151029).content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_6 = 45 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_4) / 45)

				if (45 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_4) / 45)) > 0 and var_123_3 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_7 and arg_120_1.time_ < var_123_2 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play417151030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417151030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417151031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.15

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(417151030).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 46 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 46)

				if (46 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 46)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417151031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417151031
		arg_128_1.duration_ = 2.17

		local var_128_0 = {
			zh = 1.9,
			ja = 2.166
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417151032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10128"]) and arg_128_1.var_.actorSpriteComps10128 == nil then
				arg_128_1.var_.actorSpriteComps10128 = arg_128_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10128"]) then
				if arg_128_1.var_.actorSpriteComps10128 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10128"]) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_2 = arg_128_1.actors_["10128"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10128 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10128", 3)

				for iter_131_4 = 0, var_131_2.childCount - 1 do
					local var_131_3 = var_131_2:GetChild(iter_131_4)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_131_5 = 0
			local var_131_6 = 0.275

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(417151031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 11 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 11)

				if (11 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 11)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151031", "story_v_out_417151.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151031", "story_v_out_417151.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_417151", "417151031", "story_v_out_417151.awb")

						arg_128_1:RecordAudio("417151031", var_131_12)
						arg_128_1:RecordAudio("417151031", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417151", "417151031", "story_v_out_417151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417151", "417151031", "story_v_out_417151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play417151032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417151032
		arg_132_1.duration_ = 11.4

		local var_132_0 = {
			zh = 10.166,
			ja = 11.4
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play417151033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1015"]) and arg_132_1.var_.actorSpriteComps1015 == nil then
				arg_132_1.var_.actorSpriteComps1015 = arg_132_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1015"]) then
				if arg_132_1.var_.actorSpriteComps1015 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1015"]) and arg_132_1.var_.actorSpriteComps1015 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps1015 = nil
			end

			local var_135_2 = arg_132_1.actors_["10128"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10128 == nil then
				arg_132_1.var_.actorSpriteComps10128 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps10128 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_5 = arg_132_1.actors_["10128"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10128 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10128", 2)

				for iter_135_8 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_8)

					if var_135_6.name == "" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_135_8 = arg_132_1.actors_["1015"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1015 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1015", 4)

				for iter_135_9 = 0, var_135_8.childCount - 1 do
					local var_135_9 = var_135_8:GetChild(iter_135_9)

					if var_135_9.name == "" or not string.find(var_135_9.name, "split") then
						var_135_9.gameObject:SetActive(true)
					else
						var_135_9.gameObject:SetActive(false)
					end
				end
			end

			local var_135_10 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_10 then
				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_132_1.time_ - 0) / var_135_10)
			end

			if arg_132_1.time_ >= 0 + var_135_10 and arg_132_1.time_ < 0 + var_135_10 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_135_11 = 0
			local var_135_12 = 1.35

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:GetWordFromCfg(417151032)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_16 = 54 <= 0 and var_135_12 or var_135_12 * (utf8.len(var_135_14) / 54)

				if (54 <= 0 and var_135_12 or var_135_12 * (utf8.len(var_135_14) / 54)) > 0 and var_135_12 < var_135_16 then
					arg_132_1.talkMaxDuration = var_135_16

					if var_135_16 + var_135_11 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_11
					end
				end

				arg_132_1.text_.text = var_135_14
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151032", "story_v_out_417151.awb") ~= 0 then
					local var_135_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151032", "story_v_out_417151.awb") / 1000

					if var_135_17 + var_135_11 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_11
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_417151", "417151032", "story_v_out_417151.awb")

						arg_132_1:RecordAudio("417151032", var_135_18)
						arg_132_1:RecordAudio("417151032", var_135_18)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417151", "417151032", "story_v_out_417151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417151", "417151032", "story_v_out_417151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_19 = math.max(var_135_12, arg_132_1.talkMaxDuration)

			if var_135_11 <= arg_132_1.time_ and arg_132_1.time_ < var_135_11 + var_135_19 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_11) / var_135_19

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_11 + var_135_19 and arg_132_1.time_ < var_135_11 + var_135_19 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play417151033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417151033
		arg_136_1.duration_ = 5.37

		local var_136_0 = {
			zh = 4.7,
			ja = 5.366
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417151034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10128"]) and arg_136_1.var_.actorSpriteComps10128 == nil then
				arg_136_1.var_.actorSpriteComps10128 = arg_136_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10128"]) then
				if arg_136_1.var_.actorSpriteComps10128 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 1, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10128"]) and arg_136_1.var_.actorSpriteComps10128 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps10128 = nil
			end

			local var_139_2 = arg_136_1.actors_["1015"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1015 == nil then
				arg_136_1.var_.actorSpriteComps1015 = var_139_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_3 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.actorSpriteComps1015 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								iter_139_5.color = Color.New(Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_3), Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_3), (Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_3)))
							else
								local var_139_4 = Mathf.Lerp(iter_139_5.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_3)

								iter_139_5.color = Color.New(var_139_4, var_139_4, var_139_4)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1015 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_139_7 then
						iter_139_7.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps1015 = nil
			end

			local var_139_5 = 0
			local var_139_6 = 0.575

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(417151033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 23 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 23)

				if (23 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 23)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151033", "story_v_out_417151.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151033", "story_v_out_417151.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_417151", "417151033", "story_v_out_417151.awb")

						arg_136_1:RecordAudio("417151033", var_139_12)
						arg_136_1:RecordAudio("417151033", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417151", "417151033", "story_v_out_417151.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417151", "417151033", "story_v_out_417151.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417151034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417151034
		arg_140_1.duration_ = 6.57

		local var_140_0 = {
			zh = 4.866,
			ja = 6.566
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417151035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1015"]) and arg_140_1.var_.actorSpriteComps1015 == nil then
				arg_140_1.var_.actorSpriteComps1015 = arg_140_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1015"]) then
				if arg_140_1.var_.actorSpriteComps1015 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1015"]) and arg_140_1.var_.actorSpriteComps1015 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1015 = nil
			end

			local var_143_2 = arg_140_1.actors_["10128"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps10128 == nil then
				arg_140_1.var_.actorSpriteComps10128 = var_143_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_3 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.actorSpriteComps10128 then
					for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_143_5 then
							if arg_140_1.isInRecall_ then
								iter_143_5.color = Color.New(Mathf.Lerp(iter_143_5.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_3), Mathf.Lerp(iter_143_5.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_3), (Mathf.Lerp(iter_143_5.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_3)))
							else
								local var_143_4 = Mathf.Lerp(iter_143_5.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_3)

								iter_143_5.color = Color.New(var_143_4, var_143_4, var_143_4)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps10128 then
				for iter_143_6, iter_143_7 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_143_7 then
						iter_143_7.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps10128 = nil
			end

			local var_143_5 = arg_140_1.actors_["1015"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1015 = var_143_5.localPosition
				var_143_5.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1015", 4)

				for iter_143_8 = 0, var_143_5.childCount - 1 do
					local var_143_6 = var_143_5:GetChild(iter_143_8)

					if var_143_6.name == "split_6" or not string.find(var_143_6.name, "split") then
						var_143_6.gameObject:SetActive(true)
					else
						var_143_6.gameObject:SetActive(false)
					end
				end
			end

			local var_143_7 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				var_143_5.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_140_1.time_ - 0) / var_143_7)
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				var_143_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_143_8 = 0
			local var_143_9 = 0.575

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(417151034)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 23 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 23)

				if (23 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 23)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151034", "story_v_out_417151.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151034", "story_v_out_417151.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_417151", "417151034", "story_v_out_417151.awb")

						arg_140_1:RecordAudio("417151034", var_143_15)
						arg_140_1:RecordAudio("417151034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417151", "417151034", "story_v_out_417151.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417151", "417151034", "story_v_out_417151.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play417151035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417151035
		arg_144_1.duration_ = 3.4

		local var_144_0 = {
			zh = 3.1,
			ja = 3.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417151036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10128"]) and arg_144_1.var_.actorSpriteComps10128 == nil then
				arg_144_1.var_.actorSpriteComps10128 = arg_144_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10128"]) then
				if arg_144_1.var_.actorSpriteComps10128 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 1, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10128"]) and arg_144_1.var_.actorSpriteComps10128 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps10128 = nil
			end

			local var_147_2 = arg_144_1.actors_["1015"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1015 == nil then
				arg_144_1.var_.actorSpriteComps1015 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps1015 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								iter_147_5.color = Color.New(Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor2.r, (arg_144_1.time_ - 0) / var_147_3), Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor2.g, (arg_144_1.time_ - 0) / var_147_3), (Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor2.b, (arg_144_1.time_ - 0) / var_147_3)))
							else
								local var_147_4 = Mathf.Lerp(iter_147_5.color.r, 0.5, (arg_144_1.time_ - 0) / var_147_3)

								iter_147_5.color = Color.New(var_147_4, var_147_4, var_147_4)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1015 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_147_7 then
						iter_147_7.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps1015 = nil
			end

			local var_147_5 = 0
			local var_147_6 = 0.375

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(417151035)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_10 = 15 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_8) / 15)

				if (15 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_8) / 15)) > 0 and var_147_6 < var_147_10 then
					arg_144_1.talkMaxDuration = var_147_10

					if var_147_10 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_5
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151035", "story_v_out_417151.awb") ~= 0 then
					local var_147_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151035", "story_v_out_417151.awb") / 1000

					if var_147_11 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_5
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_417151", "417151035", "story_v_out_417151.awb")

						arg_144_1:RecordAudio("417151035", var_147_12)
						arg_144_1:RecordAudio("417151035", var_147_12)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417151", "417151035", "story_v_out_417151.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417151", "417151035", "story_v_out_417151.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_6, arg_144_1.talkMaxDuration)

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_5) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_5 + var_147_13 and arg_144_1.time_ < var_147_5 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417151036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417151036
		arg_148_1.duration_ = 9.43

		local var_148_0 = {
			zh = 9.2,
			ja = 9.433
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417151037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1.025

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(417151036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 41 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 41)

				if (41 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 41)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151036", "story_v_out_417151.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151036", "story_v_out_417151.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_417151", "417151036", "story_v_out_417151.awb")

						arg_148_1:RecordAudio("417151036", var_151_6)
						arg_148_1:RecordAudio("417151036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417151", "417151036", "story_v_out_417151.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417151", "417151036", "story_v_out_417151.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play417151037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417151037
		arg_152_1.duration_ = 6.2

		local var_152_0 = {
			zh = 5.266,
			ja = 6.2
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417151038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1015"]) and arg_152_1.var_.actorSpriteComps1015 == nil then
				arg_152_1.var_.actorSpriteComps1015 = arg_152_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1015"]) then
				if arg_152_1.var_.actorSpriteComps1015 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 1, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1015"]) and arg_152_1.var_.actorSpriteComps1015 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_152_1.var_.actorSpriteComps1015 = nil
			end

			local var_155_2 = arg_152_1.actors_["10128"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps10128 == nil then
				arg_152_1.var_.actorSpriteComps10128 = var_155_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_3 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.actorSpriteComps10128 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_155_5 then
							if arg_152_1.isInRecall_ then
								iter_155_5.color = Color.New(Mathf.Lerp(iter_155_5.color.r, arg_152_1.hightColor2.r, (arg_152_1.time_ - 0) / var_155_3), Mathf.Lerp(iter_155_5.color.g, arg_152_1.hightColor2.g, (arg_152_1.time_ - 0) / var_155_3), (Mathf.Lerp(iter_155_5.color.b, arg_152_1.hightColor2.b, (arg_152_1.time_ - 0) / var_155_3)))
							else
								local var_155_4 = Mathf.Lerp(iter_155_5.color.r, 0.5, (arg_152_1.time_ - 0) / var_155_3)

								iter_155_5.color = Color.New(var_155_4, var_155_4, var_155_4)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps10128 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_155_7 then
						iter_155_7.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps10128 = nil
			end

			local var_155_5 = 0
			local var_155_6 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_7 = arg_152_1:GetWordFromCfg(417151037)
				local var_155_8 = arg_152_1:FormatText(var_155_7.content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 27 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 27)

				if (27 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 27)) > 0 and var_155_6 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151037", "story_v_out_417151.awb") ~= 0 then
					local var_155_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151037", "story_v_out_417151.awb") / 1000

					if var_155_11 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_5
					end

					if var_155_7.prefab_name ~= "" and arg_152_1.actors_[var_155_7.prefab_name] ~= nil then
						local var_155_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_7.prefab_name].transform, "story_v_out_417151", "417151037", "story_v_out_417151.awb")

						arg_152_1:RecordAudio("417151037", var_155_12)
						arg_152_1:RecordAudio("417151037", var_155_12)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417151", "417151037", "story_v_out_417151.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417151", "417151037", "story_v_out_417151.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_13 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_13 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_13

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_13 and arg_152_1.time_ < var_155_5 + var_155_13 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417151038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417151038
		arg_156_1.duration_ = 9.9

		local var_156_0 = {
			zh = 6.8,
			ja = 9.9
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417151039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.65

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(417151038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 26 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 26)

				if (26 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 26)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151038", "story_v_out_417151.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151038", "story_v_out_417151.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_417151", "417151038", "story_v_out_417151.awb")

						arg_156_1:RecordAudio("417151038", var_159_6)
						arg_156_1:RecordAudio("417151038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417151", "417151038", "story_v_out_417151.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417151", "417151038", "story_v_out_417151.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417151039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417151039
		arg_160_1.duration_ = 4.7

		local var_160_0 = {
			zh = 4.366,
			ja = 4.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417151040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["10128"]) and arg_160_1.var_.actorSpriteComps10128 == nil then
				arg_160_1.var_.actorSpriteComps10128 = arg_160_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["10128"]) then
				if arg_160_1.var_.actorSpriteComps10128 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								iter_163_1.color = Color.New(Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor1.r, (arg_160_1.time_ - 0) / var_163_0), Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor1.g, (arg_160_1.time_ - 0) / var_163_0), (Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor1.b, (arg_160_1.time_ - 0) / var_163_0)))
							else
								local var_163_1 = Mathf.Lerp(iter_163_1.color.r, 1, (arg_160_1.time_ - 0) / var_163_0)

								iter_163_1.color = Color.New(var_163_1, var_163_1, var_163_1)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["10128"]) and arg_160_1.var_.actorSpriteComps10128 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_163_3 then
						iter_163_3.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_160_1.var_.actorSpriteComps10128 = nil
			end

			local var_163_2 = arg_160_1.actors_["1015"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps1015 == nil then
				arg_160_1.var_.actorSpriteComps1015 = var_163_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_3 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 and not isNil(var_163_2) then
				if arg_160_1.var_.actorSpriteComps1015 then
					for iter_163_4, iter_163_5 in pairs(arg_160_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_163_5 then
							if arg_160_1.isInRecall_ then
								iter_163_5.color = Color.New(Mathf.Lerp(iter_163_5.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 0) / var_163_3), Mathf.Lerp(iter_163_5.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 0) / var_163_3), (Mathf.Lerp(iter_163_5.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 0) / var_163_3)))
							else
								local var_163_4 = Mathf.Lerp(iter_163_5.color.r, 0.5, (arg_160_1.time_ - 0) / var_163_3)

								iter_163_5.color = Color.New(var_163_4, var_163_4, var_163_4)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps1015 then
				for iter_163_6, iter_163_7 in pairs(arg_160_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_163_7 then
						iter_163_7.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps1015 = nil
			end

			local var_163_5 = 0
			local var_163_6 = 0.5

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_7 = arg_160_1:GetWordFromCfg(417151039)
				local var_163_8 = arg_160_1:FormatText(var_163_7.content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 20 <= 0 and var_163_6 or var_163_6 * (utf8.len(var_163_8) / 20)

				if (20 <= 0 and var_163_6 or var_163_6 * (utf8.len(var_163_8) / 20)) > 0 and var_163_6 < var_163_10 then
					arg_160_1.talkMaxDuration = var_163_10

					if var_163_10 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_5
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151039", "story_v_out_417151.awb") ~= 0 then
					local var_163_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151039", "story_v_out_417151.awb") / 1000

					if var_163_11 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_5
					end

					if var_163_7.prefab_name ~= "" and arg_160_1.actors_[var_163_7.prefab_name] ~= nil then
						local var_163_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_7.prefab_name].transform, "story_v_out_417151", "417151039", "story_v_out_417151.awb")

						arg_160_1:RecordAudio("417151039", var_163_12)
						arg_160_1:RecordAudio("417151039", var_163_12)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417151", "417151039", "story_v_out_417151.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417151", "417151039", "story_v_out_417151.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_13 = math.max(var_163_6, arg_160_1.talkMaxDuration)

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_13 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_5) / var_163_13

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_5 + var_163_13 and arg_160_1.time_ < var_163_5 + var_163_13 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417151040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417151040
		arg_164_1.duration_ = 5.13

		local var_164_0 = {
			zh = 5.133,
			ja = 4.4
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417151041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1015"]) and arg_164_1.var_.actorSpriteComps1015 == nil then
				arg_164_1.var_.actorSpriteComps1015 = arg_164_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1015"]) then
				if arg_164_1.var_.actorSpriteComps1015 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								iter_167_1.color = Color.New(Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_0), Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_0), (Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_0)))
							else
								local var_167_1 = Mathf.Lerp(iter_167_1.color.r, 1, (arg_164_1.time_ - 0) / var_167_0)

								iter_167_1.color = Color.New(var_167_1, var_167_1, var_167_1)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1015"]) and arg_164_1.var_.actorSpriteComps1015 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_167_3 then
						iter_167_3.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps1015 = nil
			end

			local var_167_2 = arg_164_1.actors_["10128"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10128 == nil then
				arg_164_1.var_.actorSpriteComps10128 = var_167_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_3 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.actorSpriteComps10128 then
					for iter_167_4, iter_167_5 in pairs(arg_164_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_167_5 then
							if arg_164_1.isInRecall_ then
								iter_167_5.color = Color.New(Mathf.Lerp(iter_167_5.color.r, arg_164_1.hightColor2.r, (arg_164_1.time_ - 0) / var_167_3), Mathf.Lerp(iter_167_5.color.g, arg_164_1.hightColor2.g, (arg_164_1.time_ - 0) / var_167_3), (Mathf.Lerp(iter_167_5.color.b, arg_164_1.hightColor2.b, (arg_164_1.time_ - 0) / var_167_3)))
							else
								local var_167_4 = Mathf.Lerp(iter_167_5.color.r, 0.5, (arg_164_1.time_ - 0) / var_167_3)

								iter_167_5.color = Color.New(var_167_4, var_167_4, var_167_4)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10128 then
				for iter_167_6, iter_167_7 in pairs(arg_164_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_167_7 then
						iter_167_7.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_164_1.var_.actorSpriteComps10128 = nil
			end

			local var_167_5 = 0
			local var_167_6 = 0.65

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(417151040)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 26 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 26)

				if (26 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 26)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151040", "story_v_out_417151.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151040", "story_v_out_417151.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_417151", "417151040", "story_v_out_417151.awb")

						arg_164_1:RecordAudio("417151040", var_167_12)
						arg_164_1:RecordAudio("417151040", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417151", "417151040", "story_v_out_417151.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417151", "417151040", "story_v_out_417151.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417151041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417151041
		arg_168_1.duration_ = 4.4

		local var_168_0 = {
			zh = 2.633,
			ja = 4.4
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417151042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["10128"]) and arg_168_1.var_.actorSpriteComps10128 == nil then
				arg_168_1.var_.actorSpriteComps10128 = arg_168_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["10128"]) then
				if arg_168_1.var_.actorSpriteComps10128 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								iter_171_1.color = Color.New(Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_0), Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_0), (Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_0)))
							else
								local var_171_1 = Mathf.Lerp(iter_171_1.color.r, 1, (arg_168_1.time_ - 0) / var_171_0)

								iter_171_1.color = Color.New(var_171_1, var_171_1, var_171_1)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["10128"]) and arg_168_1.var_.actorSpriteComps10128 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_171_3 then
						iter_171_3.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps10128 = nil
			end

			local var_171_2 = arg_168_1.actors_["1015"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps1015 == nil then
				arg_168_1.var_.actorSpriteComps1015 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps1015 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_171_5 then
							if arg_168_1.isInRecall_ then
								iter_171_5.color = Color.New(Mathf.Lerp(iter_171_5.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_5.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_5.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_5.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_5.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps1015 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_171_7 then
						iter_171_7.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps1015 = nil
			end

			local var_171_5 = 0
			local var_171_6 = 0.25

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_7 = arg_168_1:GetWordFromCfg(417151041)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 10 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 10)

				if (10 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 10)) > 0 and var_171_6 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_8
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151041", "story_v_out_417151.awb") ~= 0 then
					local var_171_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151041", "story_v_out_417151.awb") / 1000

					if var_171_11 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_5
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_out_417151", "417151041", "story_v_out_417151.awb")

						arg_168_1:RecordAudio("417151041", var_171_12)
						arg_168_1:RecordAudio("417151041", var_171_12)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417151", "417151041", "story_v_out_417151.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417151", "417151041", "story_v_out_417151.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_13 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_13 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_13

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_13 and arg_168_1.time_ < var_171_5 + var_171_13 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play417151042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417151042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417151043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10128"]) and arg_172_1.var_.actorSpriteComps10128 == nil then
				arg_172_1.var_.actorSpriteComps10128 = arg_172_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10128"]) then
				if arg_172_1.var_.actorSpriteComps10128 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10128"]) and arg_172_1.var_.actorSpriteComps10128 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps10128 = nil
			end

			local var_175_2 = arg_172_1.actors_["10128"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos10128 = var_175_2.localPosition
				var_175_2.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("10128", 7)

				for iter_175_4 = 0, var_175_2.childCount - 1 do
					local var_175_3 = var_175_2:GetChild(iter_175_4)

					if var_175_3.name == "" or not string.find(var_175_3.name, "split") then
						var_175_3.gameObject:SetActive(true)
					else
						var_175_3.gameObject:SetActive(false)
					end
				end
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_2.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_172_1.time_ - 0) / var_175_4)
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_175_5 = arg_172_1.actors_["1015"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1015 = var_175_5.localPosition
				var_175_5.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1015", 7)

				for iter_175_5 = 0, var_175_5.childCount - 1 do
					local var_175_6 = var_175_5:GetChild(iter_175_5)

					if var_175_6.name == "" or not string.find(var_175_6.name, "split") then
						var_175_6.gameObject:SetActive(true)
					else
						var_175_6.gameObject:SetActive(false)
					end
				end
			end

			local var_175_7 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				var_175_5.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_172_1.time_ - 0) / var_175_7)
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				var_175_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_175_8 = 0
			local var_175_9 = 0.575

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_10 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(417151042).content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_12 = 23 <= 0 and var_175_9 or var_175_9 * (utf8.len(var_175_10) / 23)

				if (23 <= 0 and var_175_9 or var_175_9 * (utf8.len(var_175_10) / 23)) > 0 and var_175_9 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12

					if var_175_12 + var_175_8 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_8
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_9, arg_172_1.talkMaxDuration)

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_8) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_8 + var_175_13 and arg_172_1.time_ < var_175_8 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play417151043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417151043
		arg_176_1.duration_ = 3

		local var_176_0 = {
			zh = 3,
			ja = 2.833
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417151044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.225

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015_split_1")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:GetWordFromCfg(417151043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 9 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 9)

				if (9 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 9)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151043", "story_v_out_417151.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151043", "story_v_out_417151.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_417151", "417151043", "story_v_out_417151.awb")

						arg_176_1:RecordAudio("417151043", var_179_6)
						arg_176_1:RecordAudio("417151043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417151", "417151043", "story_v_out_417151.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417151", "417151043", "story_v_out_417151.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417151044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417151044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417151045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0.683333333333333 < arg_180_1.time_ and arg_180_1.time_ <= 0.683333333333333 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_door", "")
			end

			local var_183_1 = 0
			local var_183_2 = 1.575

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(417151044).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 63 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 63)

				if (63 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 63)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417151045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417151045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417151046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.75

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(417151045).content)

				arg_184_1.text_.text = var_187_1

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_3 = 30 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 30)

				if (30 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 30)) > 0 and var_187_0 < var_187_3 then
					arg_184_1.talkMaxDuration = var_187_3

					if var_187_3 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_3 + 0
					end
				end

				arg_184_1.text_.text = var_187_1
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_4 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_4

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417151046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417151046
		arg_188_1.duration_ = 2.1

		local var_188_0 = {
			zh = 1.2,
			ja = 2.1
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417151047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.actors_["1034"] == nil then
				local var_191_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_191_0) then
					local var_191_1 = Object.Instantiate(var_191_0, arg_188_1.canvasGo_.transform)

					var_191_1.transform:SetSiblingIndex(1)

					var_191_1.name = "1034"
					var_191_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_188_1.actors_["1034"] = var_191_1

					if arg_188_1.isInRecall_ then
						for iter_191_0, iter_191_1 in ipairs((var_191_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_191_1.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_191_2 = arg_188_1.actors_["1034"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_191_3 then
							if arg_188_1.isInRecall_ then
								iter_191_3.color = Color.New(Mathf.Lerp(iter_191_3.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_3.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_3.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_3.color.r, 1, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_3.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_5 then
						iter_191_5.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_5 = arg_188_1.actors_["1034"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1034 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1034", 3)

				for iter_191_6 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_6)

					if var_191_6.name == "split_1" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_191_8 = 0
			local var_191_9 = 0.075

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(417151046)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 3 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 3)

				if (3 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 3)) > 0 and var_191_9 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151046", "story_v_out_417151.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151046", "story_v_out_417151.awb") / 1000

					if var_191_14 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_8
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_out_417151", "417151046", "story_v_out_417151.awb")

						arg_188_1:RecordAudio("417151046", var_191_15)
						arg_188_1:RecordAudio("417151046", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417151", "417151046", "story_v_out_417151.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417151", "417151046", "story_v_out_417151.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_16 and arg_188_1.time_ < var_191_8 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play417151047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417151047
		arg_192_1.duration_ = 3.63

		local var_192_0 = {
			zh = 3.633,
			ja = 2.933
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417151048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10128"]) and arg_192_1.var_.actorSpriteComps10128 == nil then
				arg_192_1.var_.actorSpriteComps10128 = arg_192_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10128"]) then
				if arg_192_1.var_.actorSpriteComps10128 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 1, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10128"]) and arg_192_1.var_.actorSpriteComps10128 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10128 = nil
			end

			local var_195_2 = arg_192_1.actors_["10128"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10128 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10128", 3)

				for iter_195_4 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_4)

					if var_195_3.name == "split_2" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_195_5 = arg_192_1.actors_["1034"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_5.localPosition
				var_195_5.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 7)

				for iter_195_5 = 0, var_195_5.childCount - 1 do
					local var_195_6 = var_195_5:GetChild(iter_195_5)

					if var_195_6.name == "split_7" or not string.find(var_195_6.name, "split") then
						var_195_6.gameObject:SetActive(true)
					else
						var_195_6.gameObject:SetActive(false)
					end
				end
			end

			local var_195_7 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				var_195_5.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_192_1.time_ - 0) / var_195_7)
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				var_195_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_195_8 = 0
			local var_195_9 = 0.3

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(417151047)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 12 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 12)

				if (12 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 12)) > 0 and var_195_9 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151047", "story_v_out_417151.awb") ~= 0 then
					local var_195_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151047", "story_v_out_417151.awb") / 1000

					if var_195_14 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_8
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_out_417151", "417151047", "story_v_out_417151.awb")

						arg_192_1:RecordAudio("417151047", var_195_15)
						arg_192_1:RecordAudio("417151047", var_195_15)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417151", "417151047", "story_v_out_417151.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417151", "417151047", "story_v_out_417151.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play417151048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417151048
		arg_196_1.duration_ = 7.43

		local var_196_0 = {
			zh = 5.6,
			ja = 7.433
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play417151049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1034"]) and arg_196_1.var_.actorSpriteComps1034 == nil then
				arg_196_1.var_.actorSpriteComps1034 = arg_196_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1034"]) then
				if arg_196_1.var_.actorSpriteComps1034 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 1, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1034"]) and arg_196_1.var_.actorSpriteComps1034 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps1034 = nil
			end

			local var_199_2 = arg_196_1.actors_["10128"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10128 == nil then
				arg_196_1.var_.actorSpriteComps10128 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10128 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								iter_199_5.color = Color.New(Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_5.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_5.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10128 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_199_7 then
						iter_199_7.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps10128 = nil
			end

			local var_199_5 = arg_196_1.actors_["1034"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1034 = var_199_5.localPosition
				var_199_5.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1034", 4)

				for iter_199_8 = 0, var_199_5.childCount - 1 do
					local var_199_6 = var_199_5:GetChild(iter_199_8)

					if var_199_6.name == "split_5" or not string.find(var_199_6.name, "split") then
						var_199_6.gameObject:SetActive(true)
					else
						var_199_6.gameObject:SetActive(false)
					end
				end
			end

			local var_199_7 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				var_199_5.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_196_1.time_ - 0) / var_199_7)
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				var_199_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_199_8 = arg_196_1.actors_["10128"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10128 = var_199_8.localPosition
				var_199_8.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10128", 2)

				for iter_199_9 = 0, var_199_8.childCount - 1 do
					local var_199_9 = var_199_8:GetChild(iter_199_9)

					if var_199_9.name == "split_2" or not string.find(var_199_9.name, "split") then
						var_199_9.gameObject:SetActive(true)
					else
						var_199_9.gameObject:SetActive(false)
					end
				end
			end

			local var_199_10 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_10 then
				var_199_8.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_196_1.time_ - 0) / var_199_10)
			end

			if arg_196_1.time_ >= 0 + var_199_10 and arg_196_1.time_ < 0 + var_199_10 + arg_199_0 then
				var_199_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_199_11 = 0
			local var_199_12 = 0.725

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_13 = arg_196_1:GetWordFromCfg(417151048)
				local var_199_14 = arg_196_1:FormatText(var_199_13.content)

				arg_196_1.text_.text = var_199_14

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_16 = 29 <= 0 and var_199_12 or var_199_12 * (utf8.len(var_199_14) / 29)

				if (29 <= 0 and var_199_12 or var_199_12 * (utf8.len(var_199_14) / 29)) > 0 and var_199_12 < var_199_16 then
					arg_196_1.talkMaxDuration = var_199_16

					if var_199_16 + var_199_11 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_16 + var_199_11
					end
				end

				arg_196_1.text_.text = var_199_14
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151048", "story_v_out_417151.awb") ~= 0 then
					local var_199_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151048", "story_v_out_417151.awb") / 1000

					if var_199_17 + var_199_11 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_11
					end

					if var_199_13.prefab_name ~= "" and arg_196_1.actors_[var_199_13.prefab_name] ~= nil then
						local var_199_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_13.prefab_name].transform, "story_v_out_417151", "417151048", "story_v_out_417151.awb")

						arg_196_1:RecordAudio("417151048", var_199_18)
						arg_196_1:RecordAudio("417151048", var_199_18)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417151", "417151048", "story_v_out_417151.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417151", "417151048", "story_v_out_417151.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_19 = math.max(var_199_12, arg_196_1.talkMaxDuration)

			if var_199_11 <= arg_196_1.time_ and arg_196_1.time_ < var_199_11 + var_199_19 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_11) / var_199_19

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_11 + var_199_19 and arg_196_1.time_ < var_199_11 + var_199_19 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play417151049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417151049
		arg_200_1.duration_ = 3.17

		local var_200_0 = {
			zh = 3.166,
			ja = 3.133
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417151050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10128"]) and arg_200_1.var_.actorSpriteComps10128 == nil then
				arg_200_1.var_.actorSpriteComps10128 = arg_200_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10128"]) then
				if arg_200_1.var_.actorSpriteComps10128 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10128"]) and arg_200_1.var_.actorSpriteComps10128 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10128 = nil
			end

			local var_203_2 = arg_200_1.actors_["1034"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1034 == nil then
				arg_200_1.var_.actorSpriteComps1034 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps1034 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1034 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps1034 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 0.425

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:GetWordFromCfg(417151049)
				local var_203_8 = arg_200_1:FormatText(var_203_7.content)

				arg_200_1.text_.text = var_203_8

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 17 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 17)

				if (17 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 17)) > 0 and var_203_6 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_8
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151049", "story_v_out_417151.awb") ~= 0 then
					local var_203_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151049", "story_v_out_417151.awb") / 1000

					if var_203_11 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_5
					end

					if var_203_7.prefab_name ~= "" and arg_200_1.actors_[var_203_7.prefab_name] ~= nil then
						local var_203_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_7.prefab_name].transform, "story_v_out_417151", "417151049", "story_v_out_417151.awb")

						arg_200_1:RecordAudio("417151049", var_203_12)
						arg_200_1:RecordAudio("417151049", var_203_12)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_417151", "417151049", "story_v_out_417151.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_417151", "417151049", "story_v_out_417151.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_13 and arg_200_1.time_ < var_203_5 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play417151050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417151050
		arg_204_1.duration_ = 12.37

		local var_204_0 = {
			zh = 8.833,
			ja = 12.366
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play417151051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1034"]) and arg_204_1.var_.actorSpriteComps1034 == nil then
				arg_204_1.var_.actorSpriteComps1034 = arg_204_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1034"]) then
				if arg_204_1.var_.actorSpriteComps1034 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 1, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1034"]) and arg_204_1.var_.actorSpriteComps1034 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps1034 = nil
			end

			local var_207_2 = arg_204_1.actors_["10128"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10128 == nil then
				arg_204_1.var_.actorSpriteComps10128 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps10128 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								iter_207_5.color = Color.New(Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_5.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_5.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10128 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_207_7 then
						iter_207_7.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10128 = nil
			end

			local var_207_5 = arg_204_1.actors_["1034"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1034 = var_207_5.localPosition
				var_207_5.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("1034", 4)

				for iter_207_8 = 0, var_207_5.childCount - 1 do
					local var_207_6 = var_207_5:GetChild(iter_207_8)

					if var_207_6.name == "split_6" or not string.find(var_207_6.name, "split") then
						var_207_6.gameObject:SetActive(true)
					else
						var_207_6.gameObject:SetActive(false)
					end
				end
			end

			local var_207_7 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_204_1.time_ - 0) / var_207_7)
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_207_8 = 0
			local var_207_9 = 1.1

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_10 = arg_204_1:GetWordFromCfg(417151050)
				local var_207_11 = arg_204_1:FormatText(var_207_10.content)

				arg_204_1.text_.text = var_207_11

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 44 <= 0 and var_207_9 or var_207_9 * (utf8.len(var_207_11) / 44)

				if (44 <= 0 and var_207_9 or var_207_9 * (utf8.len(var_207_11) / 44)) > 0 and var_207_9 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_8
					end
				end

				arg_204_1.text_.text = var_207_11
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151050", "story_v_out_417151.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151050", "story_v_out_417151.awb") / 1000

					if var_207_14 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_8
					end

					if var_207_10.prefab_name ~= "" and arg_204_1.actors_[var_207_10.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_10.prefab_name].transform, "story_v_out_417151", "417151050", "story_v_out_417151.awb")

						arg_204_1:RecordAudio("417151050", var_207_15)
						arg_204_1:RecordAudio("417151050", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417151", "417151050", "story_v_out_417151.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417151", "417151050", "story_v_out_417151.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_9, arg_204_1.talkMaxDuration)

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_8) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_8 + var_207_16 and arg_204_1.time_ < var_207_8 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play417151051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417151051
		arg_208_1.duration_ = 7.1

		local var_208_0 = {
			zh = 4.933,
			ja = 7.1
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play417151052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.5

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(417151051)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 20 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 20)

				if (20 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 20)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151051", "story_v_out_417151.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151051", "story_v_out_417151.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_417151", "417151051", "story_v_out_417151.awb")

						arg_208_1:RecordAudio("417151051", var_211_6)
						arg_208_1:RecordAudio("417151051", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417151", "417151051", "story_v_out_417151.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417151", "417151051", "story_v_out_417151.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417151052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417151052
		arg_212_1.duration_ = 3.57

		local var_212_0 = {
			zh = 2.133,
			ja = 3.566
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play417151053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1034 = arg_212_1.actors_["1034"].transform.localPosition
				arg_212_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1034", 4)

				for iter_215_0 = 0, arg_212_1.actors_["1034"].transform.childCount - 1 do
					local var_215_0 = arg_212_1.actors_["1034"].transform:GetChild(iter_215_0)

					if var_215_0.name == "split_1" or not string.find(var_215_0.name, "split") then
						var_215_0.gameObject:SetActive(true)
					else
						var_215_0.gameObject:SetActive(false)
					end
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_212_1.time_ - 0) / var_215_1)
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["1034"].transform.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_215_2 = arg_212_1.actors_["1034"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps1034 == nil then
				arg_212_1.var_.actorSpriteComps1034 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps1034 then
					for iter_215_1, iter_215_2 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_215_2 then
							if arg_212_1.isInRecall_ then
								iter_215_2.color = Color.New(Mathf.Lerp(iter_215_2.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_2.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_2.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_2.color.r, 1, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_2.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps1034 then
				for iter_215_3, iter_215_4 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_215_4 then
						iter_215_4.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps1034 = nil
			end

			local var_215_5 = 0
			local var_215_6 = 0.225

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(417151052)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 9 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 9)

				if (9 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 9)) > 0 and var_215_6 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_5
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151052", "story_v_out_417151.awb") ~= 0 then
					local var_215_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151052", "story_v_out_417151.awb") / 1000

					if var_215_11 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_5
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_out_417151", "417151052", "story_v_out_417151.awb")

						arg_212_1:RecordAudio("417151052", var_215_12)
						arg_212_1:RecordAudio("417151052", var_215_12)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417151", "417151052", "story_v_out_417151.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417151", "417151052", "story_v_out_417151.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_13 = math.max(var_215_6, arg_212_1.talkMaxDuration)

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_13 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_5) / var_215_13

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_5 + var_215_13 and arg_212_1.time_ < var_215_5 + var_215_13 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play417151053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417151053
		arg_216_1.duration_ = 8.5

		local var_216_0 = {
			zh = 7.833,
			ja = 8.5
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play417151054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1015"]) and arg_216_1.var_.actorSpriteComps1015 == nil then
				arg_216_1.var_.actorSpriteComps1015 = arg_216_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1015"]) then
				if arg_216_1.var_.actorSpriteComps1015 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 1, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1015"]) and arg_216_1.var_.actorSpriteComps1015 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps1015 = nil
			end

			local var_219_2 = arg_216_1.actors_["10128"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10128 = var_219_2.localPosition
				var_219_2.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10128", 7)

				for iter_219_4 = 0, var_219_2.childCount - 1 do
					local var_219_3 = var_219_2:GetChild(iter_219_4)

					if var_219_3.name == "" or not string.find(var_219_3.name, "split") then
						var_219_3.gameObject:SetActive(true)
					else
						var_219_3.gameObject:SetActive(false)
					end
				end
			end

			local var_219_4 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				var_219_2.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_216_1.time_ - 0) / var_219_4)
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				var_219_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_219_5 = arg_216_1.actors_["1015"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1015 = var_219_5.localPosition
				var_219_5.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1015", 3)

				for iter_219_5 = 0, var_219_5.childCount - 1 do
					local var_219_6 = var_219_5:GetChild(iter_219_5)

					if var_219_6.name == "" or not string.find(var_219_6.name, "split") then
						var_219_6.gameObject:SetActive(true)
					else
						var_219_6.gameObject:SetActive(false)
					end
				end
			end

			local var_219_7 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				var_219_5.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_216_1.time_ - 0) / var_219_7)
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				var_219_5.localPosition = Vector3.New(0, -340, -288)
			end

			local var_219_8 = arg_216_1.actors_["1034"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1034 = var_219_8.localPosition
				var_219_8.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1034", 7)

				for iter_219_6 = 0, var_219_8.childCount - 1 do
					local var_219_9 = var_219_8:GetChild(iter_219_6)

					if var_219_9.name == "split_1" or not string.find(var_219_9.name, "split") then
						var_219_9.gameObject:SetActive(true)
					else
						var_219_9.gameObject:SetActive(false)
					end
				end
			end

			local var_219_10 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_10 then
				var_219_8.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_216_1.time_ - 0) / var_219_10)
			end

			if arg_216_1.time_ >= 0 + var_219_10 and arg_216_1.time_ < 0 + var_219_10 + arg_219_0 then
				var_219_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_219_11 = 0
			local var_219_12 = 0.675

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_11 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_13 = arg_216_1:GetWordFromCfg(417151053)
				local var_219_14 = arg_216_1:FormatText(var_219_13.content)

				arg_216_1.text_.text = var_219_14

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_16 = 27 <= 0 and var_219_12 or var_219_12 * (utf8.len(var_219_14) / 27)

				if (27 <= 0 and var_219_12 or var_219_12 * (utf8.len(var_219_14) / 27)) > 0 and var_219_12 < var_219_16 then
					arg_216_1.talkMaxDuration = var_219_16

					if var_219_16 + var_219_11 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_11
					end
				end

				arg_216_1.text_.text = var_219_14
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151053", "story_v_out_417151.awb") ~= 0 then
					local var_219_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151053", "story_v_out_417151.awb") / 1000

					if var_219_17 + var_219_11 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_17 + var_219_11
					end

					if var_219_13.prefab_name ~= "" and arg_216_1.actors_[var_219_13.prefab_name] ~= nil then
						local var_219_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_13.prefab_name].transform, "story_v_out_417151", "417151053", "story_v_out_417151.awb")

						arg_216_1:RecordAudio("417151053", var_219_18)
						arg_216_1:RecordAudio("417151053", var_219_18)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417151", "417151053", "story_v_out_417151.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417151", "417151053", "story_v_out_417151.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_19 = math.max(var_219_12, arg_216_1.talkMaxDuration)

			if var_219_11 <= arg_216_1.time_ and arg_216_1.time_ < var_219_11 + var_219_19 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_11) / var_219_19

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_11 + var_219_19 and arg_216_1.time_ < var_219_11 + var_219_19 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play417151054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417151054
		arg_220_1.duration_ = 1.6

		local var_220_0 = {
			zh = 1.066,
			ja = 1.6
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play417151055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10128"]) and arg_220_1.var_.actorSpriteComps10128 == nil then
				arg_220_1.var_.actorSpriteComps10128 = arg_220_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10128"]) then
				if arg_220_1.var_.actorSpriteComps10128 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 1, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10128"]) and arg_220_1.var_.actorSpriteComps10128 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10128 = nil
			end

			local var_223_2 = arg_220_1.actors_["10128"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10128 = var_223_2.localPosition
				var_223_2.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10128", 3)

				for iter_223_4 = 0, var_223_2.childCount - 1 do
					local var_223_3 = var_223_2:GetChild(iter_223_4)

					if var_223_3.name == "split_2" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				var_223_2.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_220_1.time_ - 0) / var_223_4)
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				var_223_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_223_5 = arg_220_1.actors_["1015"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1015 = var_223_5.localPosition
				var_223_5.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1015", 7)

				for iter_223_5 = 0, var_223_5.childCount - 1 do
					local var_223_6 = var_223_5:GetChild(iter_223_5)

					if var_223_6.name == "" or not string.find(var_223_6.name, "split") then
						var_223_6.gameObject:SetActive(true)
					else
						var_223_6.gameObject:SetActive(false)
					end
				end
			end

			local var_223_7 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_220_1.time_ - 0) / var_223_7)
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_8 = 0
			local var_223_9 = 0.075

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_10 = arg_220_1:GetWordFromCfg(417151054)
				local var_223_11 = arg_220_1:FormatText(var_223_10.content)

				arg_220_1.text_.text = var_223_11

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 3 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 3)

				if (3 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 3)) > 0 and var_223_9 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_11
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151054", "story_v_out_417151.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151054", "story_v_out_417151.awb") / 1000

					if var_223_14 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_8
					end

					if var_223_10.prefab_name ~= "" and arg_220_1.actors_[var_223_10.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_10.prefab_name].transform, "story_v_out_417151", "417151054", "story_v_out_417151.awb")

						arg_220_1:RecordAudio("417151054", var_223_15)
						arg_220_1:RecordAudio("417151054", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417151", "417151054", "story_v_out_417151.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417151", "417151054", "story_v_out_417151.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_16 and arg_220_1.time_ < var_223_8 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play417151055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417151055
		arg_224_1.duration_ = 10.33

		local var_224_0 = {
			zh = 9.933,
			ja = 10.333
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play417151056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1015"]) and arg_224_1.var_.actorSpriteComps1015 == nil then
				arg_224_1.var_.actorSpriteComps1015 = arg_224_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1015"]) then
				if arg_224_1.var_.actorSpriteComps1015 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1015"]) and arg_224_1.var_.actorSpriteComps1015 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps1015 = nil
			end

			local var_227_2 = arg_224_1.actors_["10128"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10128 == nil then
				arg_224_1.var_.actorSpriteComps10128 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps10128 then
					for iter_227_4, iter_227_5 in pairs(arg_224_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_227_5 then
							if arg_224_1.isInRecall_ then
								iter_227_5.color = Color.New(Mathf.Lerp(iter_227_5.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_5.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_5.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_5.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_5.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10128 then
				for iter_227_6, iter_227_7 in pairs(arg_224_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_227_7 then
						iter_227_7.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10128 = nil
			end

			local var_227_5 = arg_224_1.actors_["1015"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1015 = var_227_5.localPosition
				var_227_5.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("1015", 4)

				for iter_227_8 = 0, var_227_5.childCount - 1 do
					local var_227_6 = var_227_5:GetChild(iter_227_8)

					if var_227_6.name == "" or not string.find(var_227_6.name, "split") then
						var_227_6.gameObject:SetActive(true)
					else
						var_227_6.gameObject:SetActive(false)
					end
				end
			end

			local var_227_7 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				var_227_5.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_224_1.time_ - 0) / var_227_7)
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				var_227_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_227_8 = arg_224_1.actors_["10128"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10128 = var_227_8.localPosition
				var_227_8.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10128", 2)

				for iter_227_9 = 0, var_227_8.childCount - 1 do
					local var_227_9 = var_227_8:GetChild(iter_227_9)

					if var_227_9.name == "" or not string.find(var_227_9.name, "split") then
						var_227_9.gameObject:SetActive(true)
					else
						var_227_9.gameObject:SetActive(false)
					end
				end
			end

			local var_227_10 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_10 then
				var_227_8.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_224_1.time_ - 0) / var_227_10)
			end

			if arg_224_1.time_ >= 0 + var_227_10 and arg_224_1.time_ < 0 + var_227_10 + arg_227_0 then
				var_227_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_227_11 = 0
			local var_227_12 = 1.05

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_13 = arg_224_1:GetWordFromCfg(417151055)
				local var_227_14 = arg_224_1:FormatText(var_227_13.content)

				arg_224_1.text_.text = var_227_14

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_16 = 42 <= 0 and var_227_12 or var_227_12 * (utf8.len(var_227_14) / 42)

				if (42 <= 0 and var_227_12 or var_227_12 * (utf8.len(var_227_14) / 42)) > 0 and var_227_12 < var_227_16 then
					arg_224_1.talkMaxDuration = var_227_16

					if var_227_16 + var_227_11 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_16 + var_227_11
					end
				end

				arg_224_1.text_.text = var_227_14
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151055", "story_v_out_417151.awb") ~= 0 then
					local var_227_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151055", "story_v_out_417151.awb") / 1000

					if var_227_17 + var_227_11 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_17 + var_227_11
					end

					if var_227_13.prefab_name ~= "" and arg_224_1.actors_[var_227_13.prefab_name] ~= nil then
						local var_227_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_13.prefab_name].transform, "story_v_out_417151", "417151055", "story_v_out_417151.awb")

						arg_224_1:RecordAudio("417151055", var_227_18)
						arg_224_1:RecordAudio("417151055", var_227_18)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417151", "417151055", "story_v_out_417151.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417151", "417151055", "story_v_out_417151.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_19 = math.max(var_227_12, arg_224_1.talkMaxDuration)

			if var_227_11 <= arg_224_1.time_ and arg_224_1.time_ < var_227_11 + var_227_19 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_11) / var_227_19

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_11 + var_227_19 and arg_224_1.time_ < var_227_11 + var_227_19 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play417151056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417151056
		arg_228_1.duration_ = 5.1

		local var_228_0 = {
			zh = 4.966,
			ja = 5.1
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play417151057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1015 = arg_228_1.actors_["1015"].transform.localPosition
				arg_228_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("1015", 7)

				for iter_231_0 = 0, arg_228_1.actors_["1015"].transform.childCount - 1 do
					local var_231_0 = arg_228_1.actors_["1015"].transform:GetChild(iter_231_0)

					if var_231_0.name == "split_2" or not string.find(var_231_0.name, "split") then
						var_231_0.gameObject:SetActive(true)
					else
						var_231_0.gameObject:SetActive(false)
					end
				end
			end

			local var_231_1 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_1 then
				arg_228_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_228_1.time_ - 0) / var_231_1)
			end

			if arg_228_1.time_ >= 0 + var_231_1 and arg_228_1.time_ < 0 + var_231_1 + arg_231_0 then
				arg_228_1.actors_["1015"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_231_2 = arg_228_1.actors_["10128"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10128 = var_231_2.localPosition
				var_231_2.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10128", 7)

				for iter_231_1 = 0, var_231_2.childCount - 1 do
					local var_231_3 = var_231_2:GetChild(iter_231_1)

					if var_231_3.name == "split_2" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				var_231_2.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_228_1.time_ - 0) / var_231_4)
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				var_231_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_231_5 = arg_228_1.actors_["1034"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1034 = var_231_5.localPosition
				var_231_5.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("1034", 3)

				for iter_231_2 = 0, var_231_5.childCount - 1 do
					local var_231_6 = var_231_5:GetChild(iter_231_2)

					if var_231_6.name == "split_2" or not string.find(var_231_6.name, "split") then
						var_231_6.gameObject:SetActive(true)
					else
						var_231_6.gameObject:SetActive(false)
					end
				end
			end

			local var_231_7 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				var_231_5.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_228_1.time_ - 0) / var_231_7)
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				var_231_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_231_8 = arg_228_1.actors_["1034"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1034 == nil then
				arg_228_1.var_.actorSpriteComps1034 = var_231_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_9 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_9 and not isNil(var_231_8) then
				if arg_228_1.var_.actorSpriteComps1034 then
					for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_231_4 then
							if arg_228_1.isInRecall_ then
								iter_231_4.color = Color.New(Mathf.Lerp(iter_231_4.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_9), Mathf.Lerp(iter_231_4.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_9), (Mathf.Lerp(iter_231_4.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_9)))
							else
								local var_231_10 = Mathf.Lerp(iter_231_4.color.r, 1, (arg_228_1.time_ - 0) / var_231_9)

								iter_231_4.color = Color.New(var_231_10, var_231_10, var_231_10)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_9 and arg_228_1.time_ < 0 + var_231_9 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps1034 then
				for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_231_6 then
						iter_231_6.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps1034 = nil
			end

			local var_231_11 = 0
			local var_231_12 = 0.55

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_11 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_13 = arg_228_1:GetWordFromCfg(417151056)
				local var_231_14 = arg_228_1:FormatText(var_231_13.content)

				arg_228_1.text_.text = var_231_14

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_16 = 22 <= 0 and var_231_12 or var_231_12 * (utf8.len(var_231_14) / 22)

				if (22 <= 0 and var_231_12 or var_231_12 * (utf8.len(var_231_14) / 22)) > 0 and var_231_12 < var_231_16 then
					arg_228_1.talkMaxDuration = var_231_16

					if var_231_16 + var_231_11 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_16 + var_231_11
					end
				end

				arg_228_1.text_.text = var_231_14
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151056", "story_v_out_417151.awb") ~= 0 then
					local var_231_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151056", "story_v_out_417151.awb") / 1000

					if var_231_17 + var_231_11 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_17 + var_231_11
					end

					if var_231_13.prefab_name ~= "" and arg_228_1.actors_[var_231_13.prefab_name] ~= nil then
						local var_231_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_13.prefab_name].transform, "story_v_out_417151", "417151056", "story_v_out_417151.awb")

						arg_228_1:RecordAudio("417151056", var_231_18)
						arg_228_1:RecordAudio("417151056", var_231_18)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_417151", "417151056", "story_v_out_417151.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_417151", "417151056", "story_v_out_417151.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_19 = math.max(var_231_12, arg_228_1.talkMaxDuration)

			if var_231_11 <= arg_228_1.time_ and arg_228_1.time_ < var_231_11 + var_231_19 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_11) / var_231_19

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_11 + var_231_19 and arg_228_1.time_ < var_231_11 + var_231_19 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play417151057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 417151057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play417151058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1034"]) and arg_232_1.var_.actorSpriteComps1034 == nil then
				arg_232_1.var_.actorSpriteComps1034 = arg_232_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_0 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1034"]) then
				if arg_232_1.var_.actorSpriteComps1034 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								iter_235_1.color = Color.New(Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor2.r, (arg_232_1.time_ - 0) / var_235_0), Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor2.g, (arg_232_1.time_ - 0) / var_235_0), (Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor2.b, (arg_232_1.time_ - 0) / var_235_0)))
							else
								local var_235_1 = Mathf.Lerp(iter_235_1.color.r, 0.5, (arg_232_1.time_ - 0) / var_235_0)

								iter_235_1.color = Color.New(var_235_1, var_235_1, var_235_1)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1034"]) and arg_232_1.var_.actorSpriteComps1034 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_235_3 then
						iter_235_3.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_232_1.var_.actorSpriteComps1034 = nil
			end

			local var_235_2 = arg_232_1.actors_["1015"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1015 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1015", 7)

				for iter_235_4 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_4)

					if var_235_3.name == "" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_235_5 = arg_232_1.actors_["1034"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1034 = var_235_5.localPosition
				var_235_5.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1034", 7)

				for iter_235_5 = 0, var_235_5.childCount - 1 do
					local var_235_6 = var_235_5:GetChild(iter_235_5)

					if var_235_6.name == "" or not string.find(var_235_6.name, "split") then
						var_235_6.gameObject:SetActive(true)
					else
						var_235_6.gameObject:SetActive(false)
					end
				end
			end

			local var_235_7 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				var_235_5.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_232_1.time_ - 0) / var_235_7)
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				var_235_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_235_8 = 0
			local var_235_9 = 1.1

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_10 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(417151057).content)

				arg_232_1.text_.text = var_235_10

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_12 = 44 <= 0 and var_235_9 or var_235_9 * (utf8.len(var_235_10) / 44)

				if (44 <= 0 and var_235_9 or var_235_9 * (utf8.len(var_235_10) / 44)) > 0 and var_235_9 < var_235_12 then
					arg_232_1.talkMaxDuration = var_235_12

					if var_235_12 + var_235_8 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_8
					end
				end

				arg_232_1.text_.text = var_235_10
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_9, arg_232_1.talkMaxDuration)

			if var_235_8 <= arg_232_1.time_ and arg_232_1.time_ < var_235_8 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_8) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_8 + var_235_13 and arg_232_1.time_ < var_235_8 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play417151058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417151058
		arg_236_1.duration_ = 5.27

		local var_236_0 = {
			zh = 2.066,
			ja = 5.266
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417151059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["1034"]) and arg_236_1.var_.actorSpriteComps1034 == nil then
				arg_236_1.var_.actorSpriteComps1034 = arg_236_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["1034"]) then
				if arg_236_1.var_.actorSpriteComps1034 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 1, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1034"]) and arg_236_1.var_.actorSpriteComps1034 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps1034 = nil
			end

			local var_239_2 = arg_236_1.actors_["1034"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1034 = var_239_2.localPosition
				var_239_2.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1034", 3)

				for iter_239_4 = 0, var_239_2.childCount - 1 do
					local var_239_3 = var_239_2:GetChild(iter_239_4)

					if var_239_3.name == "" or not string.find(var_239_3.name, "split") then
						var_239_3.gameObject:SetActive(true)
					else
						var_239_3.gameObject:SetActive(false)
					end
				end
			end

			local var_239_4 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				var_239_2.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_236_1.time_ - 0) / var_239_4)
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				var_239_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_239_5 = 0
			local var_239_6 = 0.3

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_7 = arg_236_1:GetWordFromCfg(417151058)
				local var_239_8 = arg_236_1:FormatText(var_239_7.content)

				arg_236_1.text_.text = var_239_8

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 12 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 12)

				if (12 <= 0 and var_239_6 or var_239_6 * (utf8.len(var_239_8) / 12)) > 0 and var_239_6 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_5
					end
				end

				arg_236_1.text_.text = var_239_8
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151058", "story_v_out_417151.awb") ~= 0 then
					local var_239_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151058", "story_v_out_417151.awb") / 1000

					if var_239_11 + var_239_5 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_5
					end

					if var_239_7.prefab_name ~= "" and arg_236_1.actors_[var_239_7.prefab_name] ~= nil then
						local var_239_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_7.prefab_name].transform, "story_v_out_417151", "417151058", "story_v_out_417151.awb")

						arg_236_1:RecordAudio("417151058", var_239_12)
						arg_236_1:RecordAudio("417151058", var_239_12)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_417151", "417151058", "story_v_out_417151.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_417151", "417151058", "story_v_out_417151.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_13 = math.max(var_239_6, arg_236_1.talkMaxDuration)

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_13 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_5) / var_239_13

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_5 + var_239_13 and arg_236_1.time_ < var_239_5 + var_239_13 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417151059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417151059
		arg_240_1.duration_ = 7

		local var_240_0 = {
			zh = 4.566,
			ja = 7
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play417151060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10128"]) and arg_240_1.var_.actorSpriteComps10128 == nil then
				arg_240_1.var_.actorSpriteComps10128 = arg_240_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10128"]) then
				if arg_240_1.var_.actorSpriteComps10128 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10128"]) and arg_240_1.var_.actorSpriteComps10128 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10128 = nil
			end

			local var_243_2 = arg_240_1.actors_["10128"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10128 = var_243_2.localPosition
				var_243_2.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10128", 3)

				for iter_243_4 = 0, var_243_2.childCount - 1 do
					local var_243_3 = var_243_2:GetChild(iter_243_4)

					if var_243_3.name == "" or not string.find(var_243_3.name, "split") then
						var_243_3.gameObject:SetActive(true)
					else
						var_243_3.gameObject:SetActive(false)
					end
				end
			end

			local var_243_4 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				var_243_2.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_240_1.time_ - 0) / var_243_4)
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				var_243_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_243_5 = arg_240_1.actors_["1034"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1034 = var_243_5.localPosition
				var_243_5.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("1034", 7)

				for iter_243_5 = 0, var_243_5.childCount - 1 do
					local var_243_6 = var_243_5:GetChild(iter_243_5)

					if var_243_6.name == "" or not string.find(var_243_6.name, "split") then
						var_243_6.gameObject:SetActive(true)
					else
						var_243_6.gameObject:SetActive(false)
					end
				end
			end

			local var_243_7 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_240_1.time_ - 0) / var_243_7)
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_243_8 = 0
			local var_243_9 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_10 = arg_240_1:GetWordFromCfg(417151059)
				local var_243_11 = arg_240_1:FormatText(var_243_10.content)

				arg_240_1.text_.text = var_243_11

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 21 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 21)

				if (21 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 21)) > 0 and var_243_9 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_11
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151059", "story_v_out_417151.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151059", "story_v_out_417151.awb") / 1000

					if var_243_14 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_8
					end

					if var_243_10.prefab_name ~= "" and arg_240_1.actors_[var_243_10.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_10.prefab_name].transform, "story_v_out_417151", "417151059", "story_v_out_417151.awb")

						arg_240_1:RecordAudio("417151059", var_243_15)
						arg_240_1:RecordAudio("417151059", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417151", "417151059", "story_v_out_417151.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417151", "417151059", "story_v_out_417151.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play417151060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417151060
		arg_244_1.duration_ = 3.5

		local var_244_0 = {
			zh = 1.7,
			ja = 3.5
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417151061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1034"]) and arg_244_1.var_.actorSpriteComps1034 == nil then
				arg_244_1.var_.actorSpriteComps1034 = arg_244_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1034"]) then
				if arg_244_1.var_.actorSpriteComps1034 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 0) / var_247_0), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 0) / var_247_0), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 0) / var_247_0)))
							else
								local var_247_1 = Mathf.Lerp(iter_247_1.color.r, 1, (arg_244_1.time_ - 0) / var_247_0)

								iter_247_1.color = Color.New(var_247_1, var_247_1, var_247_1)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1034"]) and arg_244_1.var_.actorSpriteComps1034 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps1034 = nil
			end

			local var_247_2 = arg_244_1.actors_["10128"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10128 == nil then
				arg_244_1.var_.actorSpriteComps10128 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps10128 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								iter_247_5.color = Color.New(Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_3), Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_3), (Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_3)))
							else
								local var_247_4 = Mathf.Lerp(iter_247_5.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_3)

								iter_247_5.color = Color.New(var_247_4, var_247_4, var_247_4)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10128 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_247_7 then
						iter_247_7.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10128 = nil
			end

			local var_247_5 = arg_244_1.actors_["1034"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1034 = var_247_5.localPosition
				var_247_5.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1034", 4)

				for iter_247_8 = 0, var_247_5.childCount - 1 do
					local var_247_6 = var_247_5:GetChild(iter_247_8)

					if var_247_6.name == "" or not string.find(var_247_6.name, "split") then
						var_247_6.gameObject:SetActive(true)
					else
						var_247_6.gameObject:SetActive(false)
					end
				end
			end

			local var_247_7 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				var_247_5.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_244_1.time_ - 0) / var_247_7)
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				var_247_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_247_8 = arg_244_1.actors_["10128"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10128 = var_247_8.localPosition
				var_247_8.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10128", 2)

				for iter_247_9 = 0, var_247_8.childCount - 1 do
					local var_247_9 = var_247_8:GetChild(iter_247_9)

					if var_247_9.name == "" or not string.find(var_247_9.name, "split") then
						var_247_9.gameObject:SetActive(true)
					else
						var_247_9.gameObject:SetActive(false)
					end
				end
			end

			local var_247_10 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_10 then
				var_247_8.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_244_1.time_ - 0) / var_247_10)
			end

			if arg_244_1.time_ >= 0 + var_247_10 and arg_244_1.time_ < 0 + var_247_10 + arg_247_0 then
				var_247_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_247_11 = 0
			local var_247_12 = 0.15

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_13 = arg_244_1:GetWordFromCfg(417151060)
				local var_247_14 = arg_244_1:FormatText(var_247_13.content)

				arg_244_1.text_.text = var_247_14

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_16 = 6 <= 0 and var_247_12 or var_247_12 * (utf8.len(var_247_14) / 6)

				if (6 <= 0 and var_247_12 or var_247_12 * (utf8.len(var_247_14) / 6)) > 0 and var_247_12 < var_247_16 then
					arg_244_1.talkMaxDuration = var_247_16

					if var_247_16 + var_247_11 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_16 + var_247_11
					end
				end

				arg_244_1.text_.text = var_247_14
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151060", "story_v_out_417151.awb") ~= 0 then
					local var_247_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151060", "story_v_out_417151.awb") / 1000

					if var_247_17 + var_247_11 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_17 + var_247_11
					end

					if var_247_13.prefab_name ~= "" and arg_244_1.actors_[var_247_13.prefab_name] ~= nil then
						local var_247_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_13.prefab_name].transform, "story_v_out_417151", "417151060", "story_v_out_417151.awb")

						arg_244_1:RecordAudio("417151060", var_247_18)
						arg_244_1:RecordAudio("417151060", var_247_18)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417151", "417151060", "story_v_out_417151.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417151", "417151060", "story_v_out_417151.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_19 = math.max(var_247_12, arg_244_1.talkMaxDuration)

			if var_247_11 <= arg_244_1.time_ and arg_244_1.time_ < var_247_11 + var_247_19 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_11) / var_247_19

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_11 + var_247_19 and arg_244_1.time_ < var_247_11 + var_247_19 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
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
	Play417151061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417151061
		arg_248_1.duration_ = 6.23

		local var_248_0 = {
			zh = 3.566,
			ja = 6.233
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417151062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.45

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(417151061)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 18 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 18)

				if (18 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 18)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151061", "story_v_out_417151.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151061", "story_v_out_417151.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_417151", "417151061", "story_v_out_417151.awb")

						arg_248_1:RecordAudio("417151061", var_251_6)
						arg_248_1:RecordAudio("417151061", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417151", "417151061", "story_v_out_417151.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417151", "417151061", "story_v_out_417151.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417151062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417151062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417151063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1034"]) and arg_252_1.var_.actorSpriteComps1034 == nil then
				arg_252_1.var_.actorSpriteComps1034 = arg_252_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1034"]) then
				if arg_252_1.var_.actorSpriteComps1034 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1034"]) and arg_252_1.var_.actorSpriteComps1034 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps1034 = nil
			end

			local var_255_2 = arg_252_1.actors_["10128"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10128 = var_255_2.localPosition
				var_255_2.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10128", 7)

				for iter_255_4 = 0, var_255_2.childCount - 1 do
					local var_255_3 = var_255_2:GetChild(iter_255_4)

					if var_255_3.name == "" or not string.find(var_255_3.name, "split") then
						var_255_3.gameObject:SetActive(true)
					else
						var_255_3.gameObject:SetActive(false)
					end
				end
			end

			local var_255_4 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				var_255_2.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_252_1.time_ - 0) / var_255_4)
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				var_255_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_255_5 = arg_252_1.actors_["1034"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1034 = var_255_5.localPosition
				var_255_5.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("1034", 7)

				for iter_255_5 = 0, var_255_5.childCount - 1 do
					local var_255_6 = var_255_5:GetChild(iter_255_5)

					if var_255_6.name == "" or not string.find(var_255_6.name, "split") then
						var_255_6.gameObject:SetActive(true)
					else
						var_255_6.gameObject:SetActive(false)
					end
				end
			end

			local var_255_7 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				var_255_5.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_252_1.time_ - 0) / var_255_7)
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				var_255_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_255_8 = 0
			local var_255_9 = 1.375

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(417151062).content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_12 = 55 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_10) / 55)

				if (55 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_10) / 55)) > 0 and var_255_9 < var_255_12 then
					arg_252_1.talkMaxDuration = var_255_12

					if var_255_12 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_13 and arg_252_1.time_ < var_255_8 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play417151063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417151063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417151064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_259_1 = 0
			local var_259_2 = 1.05

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(417151063).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 42 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 42)

				if (42 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 42)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417151064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417151064
		arg_260_1.duration_ = 4.93

		local var_260_0 = {
			zh = 3.533,
			ja = 4.933
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play417151065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["10128"]) and arg_260_1.var_.actorSpriteComps10128 == nil then
				arg_260_1.var_.actorSpriteComps10128 = arg_260_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["10128"]) then
				if arg_260_1.var_.actorSpriteComps10128 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								iter_263_1.color = Color.New(Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, (arg_260_1.time_ - 0) / var_263_0), Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, (arg_260_1.time_ - 0) / var_263_0), (Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, (arg_260_1.time_ - 0) / var_263_0)))
							else
								local var_263_1 = Mathf.Lerp(iter_263_1.color.r, 1, (arg_260_1.time_ - 0) / var_263_0)

								iter_263_1.color = Color.New(var_263_1, var_263_1, var_263_1)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["10128"]) and arg_260_1.var_.actorSpriteComps10128 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_260_1.var_.actorSpriteComps10128 = nil
			end

			local var_263_2 = arg_260_1.actors_["10128"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10128 = var_263_2.localPosition
				var_263_2.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10128", 3)

				for iter_263_4 = 0, var_263_2.childCount - 1 do
					local var_263_3 = var_263_2:GetChild(iter_263_4)

					if var_263_3.name == "split_6" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_2.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_260_1.time_ - 0) / var_263_4)
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_263_5 = 0
			local var_263_6 = 0.45

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:GetWordFromCfg(417151064)
				local var_263_8 = arg_260_1:FormatText(var_263_7.content)

				arg_260_1.text_.text = var_263_8

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 18 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 18)

				if (18 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 18)) > 0 and var_263_6 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_8
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151064", "story_v_out_417151.awb") ~= 0 then
					local var_263_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151064", "story_v_out_417151.awb") / 1000

					if var_263_11 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_5
					end

					if var_263_7.prefab_name ~= "" and arg_260_1.actors_[var_263_7.prefab_name] ~= nil then
						local var_263_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_7.prefab_name].transform, "story_v_out_417151", "417151064", "story_v_out_417151.awb")

						arg_260_1:RecordAudio("417151064", var_263_12)
						arg_260_1:RecordAudio("417151064", var_263_12)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417151", "417151064", "story_v_out_417151.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417151", "417151064", "story_v_out_417151.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_13 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_13 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_13

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_13 and arg_260_1.time_ < var_263_5 + var_263_13 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play417151065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417151065
		arg_264_1.duration_ = 3.77

		local var_264_0 = {
			zh = 1.866,
			ja = 3.766
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417151066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1015"]) and arg_264_1.var_.actorSpriteComps1015 == nil then
				arg_264_1.var_.actorSpriteComps1015 = arg_264_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1015"]) then
				if arg_264_1.var_.actorSpriteComps1015 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								iter_267_1.color = Color.New(Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_0), Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_0), (Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_0)))
							else
								local var_267_1 = Mathf.Lerp(iter_267_1.color.r, 1, (arg_264_1.time_ - 0) / var_267_0)

								iter_267_1.color = Color.New(var_267_1, var_267_1, var_267_1)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1015"]) and arg_264_1.var_.actorSpriteComps1015 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps1015 = nil
			end

			local var_267_2 = arg_264_1.actors_["10128"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10128 == nil then
				arg_264_1.var_.actorSpriteComps10128 = var_267_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_3 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.actorSpriteComps10128 then
					for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_267_5 then
							if arg_264_1.isInRecall_ then
								iter_267_5.color = Color.New(Mathf.Lerp(iter_267_5.color.r, arg_264_1.hightColor2.r, (arg_264_1.time_ - 0) / var_267_3), Mathf.Lerp(iter_267_5.color.g, arg_264_1.hightColor2.g, (arg_264_1.time_ - 0) / var_267_3), (Mathf.Lerp(iter_267_5.color.b, arg_264_1.hightColor2.b, (arg_264_1.time_ - 0) / var_267_3)))
							else
								local var_267_4 = Mathf.Lerp(iter_267_5.color.r, 0.5, (arg_264_1.time_ - 0) / var_267_3)

								iter_267_5.color = Color.New(var_267_4, var_267_4, var_267_4)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10128 then
				for iter_267_6, iter_267_7 in pairs(arg_264_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_267_7 then
						iter_267_7.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_264_1.var_.actorSpriteComps10128 = nil
			end

			local var_267_5 = arg_264_1.actors_["10128"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10128 = var_267_5.localPosition
				var_267_5.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10128", 2)

				for iter_267_8 = 0, var_267_5.childCount - 1 do
					local var_267_6 = var_267_5:GetChild(iter_267_8)

					if var_267_6.name == "" or not string.find(var_267_6.name, "split") then
						var_267_6.gameObject:SetActive(true)
					else
						var_267_6.gameObject:SetActive(false)
					end
				end
			end

			local var_267_7 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				var_267_5.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_264_1.time_ - 0) / var_267_7)
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				var_267_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_267_8 = arg_264_1.actors_["1015"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1015 = var_267_8.localPosition
				var_267_8.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1015", 4)

				for iter_267_9 = 0, var_267_8.childCount - 1 do
					local var_267_9 = var_267_8:GetChild(iter_267_9)

					if var_267_9.name == "" or not string.find(var_267_9.name, "split") then
						var_267_9.gameObject:SetActive(true)
					else
						var_267_9.gameObject:SetActive(false)
					end
				end
			end

			local var_267_10 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_10 then
				var_267_8.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_264_1.time_ - 0) / var_267_10)
			end

			if arg_264_1.time_ >= 0 + var_267_10 and arg_264_1.time_ < 0 + var_267_10 + arg_267_0 then
				var_267_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_267_11 = 0
			local var_267_12 = 0.25

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_13 = arg_264_1:GetWordFromCfg(417151065)
				local var_267_14 = arg_264_1:FormatText(var_267_13.content)

				arg_264_1.text_.text = var_267_14

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_16 = 10 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_14) / 10)

				if (10 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_14) / 10)) > 0 and var_267_12 < var_267_16 then
					arg_264_1.talkMaxDuration = var_267_16

					if var_267_16 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_16 + var_267_11
					end
				end

				arg_264_1.text_.text = var_267_14
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151065", "story_v_out_417151.awb") ~= 0 then
					local var_267_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151065", "story_v_out_417151.awb") / 1000

					if var_267_17 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_17 + var_267_11
					end

					if var_267_13.prefab_name ~= "" and arg_264_1.actors_[var_267_13.prefab_name] ~= nil then
						local var_267_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_13.prefab_name].transform, "story_v_out_417151", "417151065", "story_v_out_417151.awb")

						arg_264_1:RecordAudio("417151065", var_267_18)
						arg_264_1:RecordAudio("417151065", var_267_18)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417151", "417151065", "story_v_out_417151.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417151", "417151065", "story_v_out_417151.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_19 = math.max(var_267_12, arg_264_1.talkMaxDuration)

			if var_267_11 <= arg_264_1.time_ and arg_264_1.time_ < var_267_11 + var_267_19 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_11) / var_267_19

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_11 + var_267_19 and arg_264_1.time_ < var_267_11 + var_267_19 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play417151066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 417151066
		arg_268_1.duration_ = 1.67

		local var_268_0 = {
			zh = 0.999999999999,
			ja = 1.666
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play417151067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["10128"]) and arg_268_1.var_.actorSpriteComps10128 == nil then
				arg_268_1.var_.actorSpriteComps10128 = arg_268_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["10128"]) then
				if arg_268_1.var_.actorSpriteComps10128 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								iter_271_1.color = Color.New(Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor1.r, (arg_268_1.time_ - 0) / var_271_0), Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor1.g, (arg_268_1.time_ - 0) / var_271_0), (Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor1.b, (arg_268_1.time_ - 0) / var_271_0)))
							else
								local var_271_1 = Mathf.Lerp(iter_271_1.color.r, 1, (arg_268_1.time_ - 0) / var_271_0)

								iter_271_1.color = Color.New(var_271_1, var_271_1, var_271_1)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["10128"]) and arg_268_1.var_.actorSpriteComps10128 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_271_3 then
						iter_271_3.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_268_1.var_.actorSpriteComps10128 = nil
			end

			local var_271_2 = arg_268_1.actors_["1015"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps1015 == nil then
				arg_268_1.var_.actorSpriteComps1015 = var_271_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_3 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 and not isNil(var_271_2) then
				if arg_268_1.var_.actorSpriteComps1015 then
					for iter_271_4, iter_271_5 in pairs(arg_268_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_271_5 then
							if arg_268_1.isInRecall_ then
								iter_271_5.color = Color.New(Mathf.Lerp(iter_271_5.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_3), Mathf.Lerp(iter_271_5.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_3), (Mathf.Lerp(iter_271_5.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_3)))
							else
								local var_271_4 = Mathf.Lerp(iter_271_5.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_3)

								iter_271_5.color = Color.New(var_271_4, var_271_4, var_271_4)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.actorSpriteComps1015 then
				for iter_271_6, iter_271_7 in pairs(arg_268_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_271_7 then
						iter_271_7.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps1015 = nil
			end

			local var_271_5 = 0
			local var_271_6 = 0.125

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_5 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_7 = arg_268_1:GetWordFromCfg(417151066)
				local var_271_8 = arg_268_1:FormatText(var_271_7.content)

				arg_268_1.text_.text = var_271_8

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_10 = 5 <= 0 and var_271_6 or var_271_6 * (utf8.len(var_271_8) / 5)

				if (5 <= 0 and var_271_6 or var_271_6 * (utf8.len(var_271_8) / 5)) > 0 and var_271_6 < var_271_10 then
					arg_268_1.talkMaxDuration = var_271_10

					if var_271_10 + var_271_5 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_5
					end
				end

				arg_268_1.text_.text = var_271_8
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151066", "story_v_out_417151.awb") ~= 0 then
					local var_271_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151066", "story_v_out_417151.awb") / 1000

					if var_271_11 + var_271_5 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_11 + var_271_5
					end

					if var_271_7.prefab_name ~= "" and arg_268_1.actors_[var_271_7.prefab_name] ~= nil then
						local var_271_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_7.prefab_name].transform, "story_v_out_417151", "417151066", "story_v_out_417151.awb")

						arg_268_1:RecordAudio("417151066", var_271_12)
						arg_268_1:RecordAudio("417151066", var_271_12)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_417151", "417151066", "story_v_out_417151.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_417151", "417151066", "story_v_out_417151.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_13 = math.max(var_271_6, arg_268_1.talkMaxDuration)

			if var_271_5 <= arg_268_1.time_ and arg_268_1.time_ < var_271_5 + var_271_13 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_5) / var_271_13

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_5 + var_271_13 and arg_268_1.time_ < var_271_5 + var_271_13 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play417151067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 417151067
		arg_272_1.duration_ = 2.5

		local var_272_0 = {
			zh = 2.5,
			ja = 2.333
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play417151068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1015"]) and arg_272_1.var_.actorSpriteComps1015 == nil then
				arg_272_1.var_.actorSpriteComps1015 = arg_272_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_0 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1015"]) then
				if arg_272_1.var_.actorSpriteComps1015 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								iter_275_1.color = Color.New(Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor1.r, (arg_272_1.time_ - 0) / var_275_0), Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor1.g, (arg_272_1.time_ - 0) / var_275_0), (Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor1.b, (arg_272_1.time_ - 0) / var_275_0)))
							else
								local var_275_1 = Mathf.Lerp(iter_275_1.color.r, 1, (arg_272_1.time_ - 0) / var_275_0)

								iter_275_1.color = Color.New(var_275_1, var_275_1, var_275_1)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1015"]) and arg_272_1.var_.actorSpriteComps1015 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_275_3 then
						iter_275_3.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_272_1.var_.actorSpriteComps1015 = nil
			end

			local var_275_2 = arg_272_1.actors_["10128"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_2) and arg_272_1.var_.actorSpriteComps10128 == nil then
				arg_272_1.var_.actorSpriteComps10128 = var_275_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_3 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_3 and not isNil(var_275_2) then
				if arg_272_1.var_.actorSpriteComps10128 then
					for iter_275_4, iter_275_5 in pairs(arg_272_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_275_5 then
							if arg_272_1.isInRecall_ then
								iter_275_5.color = Color.New(Mathf.Lerp(iter_275_5.color.r, arg_272_1.hightColor2.r, (arg_272_1.time_ - 0) / var_275_3), Mathf.Lerp(iter_275_5.color.g, arg_272_1.hightColor2.g, (arg_272_1.time_ - 0) / var_275_3), (Mathf.Lerp(iter_275_5.color.b, arg_272_1.hightColor2.b, (arg_272_1.time_ - 0) / var_275_3)))
							else
								local var_275_4 = Mathf.Lerp(iter_275_5.color.r, 0.5, (arg_272_1.time_ - 0) / var_275_3)

								iter_275_5.color = Color.New(var_275_4, var_275_4, var_275_4)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_3 and arg_272_1.time_ < 0 + var_275_3 + arg_275_0 and not isNil(var_275_2) and arg_272_1.var_.actorSpriteComps10128 then
				for iter_275_6, iter_275_7 in pairs(arg_272_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_275_7 then
						iter_275_7.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_272_1.var_.actorSpriteComps10128 = nil
			end

			local var_275_5 = 0
			local var_275_6 = 0.25

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_7 = arg_272_1:GetWordFromCfg(417151067)
				local var_275_8 = arg_272_1:FormatText(var_275_7.content)

				arg_272_1.text_.text = var_275_8

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_10 = 10 <= 0 and var_275_6 or var_275_6 * (utf8.len(var_275_8) / 10)

				if (10 <= 0 and var_275_6 or var_275_6 * (utf8.len(var_275_8) / 10)) > 0 and var_275_6 < var_275_10 then
					arg_272_1.talkMaxDuration = var_275_10

					if var_275_10 + var_275_5 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_5
					end
				end

				arg_272_1.text_.text = var_275_8
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151067", "story_v_out_417151.awb") ~= 0 then
					local var_275_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151067", "story_v_out_417151.awb") / 1000

					if var_275_11 + var_275_5 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_11 + var_275_5
					end

					if var_275_7.prefab_name ~= "" and arg_272_1.actors_[var_275_7.prefab_name] ~= nil then
						local var_275_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_7.prefab_name].transform, "story_v_out_417151", "417151067", "story_v_out_417151.awb")

						arg_272_1:RecordAudio("417151067", var_275_12)
						arg_272_1:RecordAudio("417151067", var_275_12)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_417151", "417151067", "story_v_out_417151.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_417151", "417151067", "story_v_out_417151.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_13 = math.max(var_275_6, arg_272_1.talkMaxDuration)

			if var_275_5 <= arg_272_1.time_ and arg_272_1.time_ < var_275_5 + var_275_13 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_5) / var_275_13

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_5 + var_275_13 and arg_272_1.time_ < var_275_5 + var_275_13 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play417151068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 417151068
		arg_276_1.duration_ = 13.57

		local var_276_0 = {
			zh = 11.333,
			ja = 13.566
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play417151069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["10128"]) and arg_276_1.var_.actorSpriteComps10128 == nil then
				arg_276_1.var_.actorSpriteComps10128 = arg_276_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["10128"]) then
				if arg_276_1.var_.actorSpriteComps10128 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 1, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["10128"]) and arg_276_1.var_.actorSpriteComps10128 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps10128 = nil
			end

			local var_279_2 = arg_276_1.actors_["1015"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps1015 == nil then
				arg_276_1.var_.actorSpriteComps1015 = var_279_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_3 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_3 and not isNil(var_279_2) then
				if arg_276_1.var_.actorSpriteComps1015 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								iter_279_5.color = Color.New(Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_3), Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_3), (Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_3)))
							else
								local var_279_4 = Mathf.Lerp(iter_279_5.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_3)

								iter_279_5.color = Color.New(var_279_4, var_279_4, var_279_4)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_3 and arg_276_1.time_ < 0 + var_279_3 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps1015 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_279_7 then
						iter_279_7.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps1015 = nil
			end

			local var_279_5 = 0
			local var_279_6 = 1.125

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_7 = arg_276_1:GetWordFromCfg(417151068)
				local var_279_8 = arg_276_1:FormatText(var_279_7.content)

				arg_276_1.text_.text = var_279_8

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 45 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 45)

				if (45 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 45)) > 0 and var_279_6 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10

					if var_279_10 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_8
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151068", "story_v_out_417151.awb") ~= 0 then
					local var_279_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151068", "story_v_out_417151.awb") / 1000

					if var_279_11 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_11 + var_279_5
					end

					if var_279_7.prefab_name ~= "" and arg_276_1.actors_[var_279_7.prefab_name] ~= nil then
						local var_279_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_7.prefab_name].transform, "story_v_out_417151", "417151068", "story_v_out_417151.awb")

						arg_276_1:RecordAudio("417151068", var_279_12)
						arg_276_1:RecordAudio("417151068", var_279_12)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_417151", "417151068", "story_v_out_417151.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_417151", "417151068", "story_v_out_417151.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_13 and arg_276_1.time_ < var_279_5 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play417151069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 417151069
		arg_280_1.duration_ = 8.3

		local var_280_0 = {
			zh = 6.166,
			ja = 8.3
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play417151070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1015"]) and arg_280_1.var_.actorSpriteComps1015 == nil then
				arg_280_1.var_.actorSpriteComps1015 = arg_280_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_0 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1015"]) then
				if arg_280_1.var_.actorSpriteComps1015 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								iter_283_1.color = Color.New(Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor1.r, (arg_280_1.time_ - 0) / var_283_0), Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor1.g, (arg_280_1.time_ - 0) / var_283_0), (Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor1.b, (arg_280_1.time_ - 0) / var_283_0)))
							else
								local var_283_1 = Mathf.Lerp(iter_283_1.color.r, 1, (arg_280_1.time_ - 0) / var_283_0)

								iter_283_1.color = Color.New(var_283_1, var_283_1, var_283_1)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1015"]) and arg_280_1.var_.actorSpriteComps1015 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_283_3 then
						iter_283_3.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_280_1.var_.actorSpriteComps1015 = nil
			end

			local var_283_2 = arg_280_1.actors_["10128"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps10128 == nil then
				arg_280_1.var_.actorSpriteComps10128 = var_283_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_3 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.actorSpriteComps10128 then
					for iter_283_4, iter_283_5 in pairs(arg_280_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_283_5 then
							if arg_280_1.isInRecall_ then
								iter_283_5.color = Color.New(Mathf.Lerp(iter_283_5.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_3), Mathf.Lerp(iter_283_5.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_3), (Mathf.Lerp(iter_283_5.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_3)))
							else
								local var_283_4 = Mathf.Lerp(iter_283_5.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_3)

								iter_283_5.color = Color.New(var_283_4, var_283_4, var_283_4)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps10128 then
				for iter_283_6, iter_283_7 in pairs(arg_280_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_283_7 then
						iter_283_7.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps10128 = nil
			end

			local var_283_5 = arg_280_1.actors_["10128"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10128 = var_283_5.localPosition
				var_283_5.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10128", 7)

				for iter_283_8 = 0, var_283_5.childCount - 1 do
					local var_283_6 = var_283_5:GetChild(iter_283_8)

					if var_283_6.name == "" or not string.find(var_283_6.name, "split") then
						var_283_6.gameObject:SetActive(true)
					else
						var_283_6.gameObject:SetActive(false)
					end
				end
			end

			local var_283_7 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				var_283_5.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_280_1.time_ - 0) / var_283_7)
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				var_283_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_283_8 = arg_280_1.actors_["1015"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1015 = var_283_8.localPosition
				var_283_8.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("1015", 3)

				for iter_283_9 = 0, var_283_8.childCount - 1 do
					local var_283_9 = var_283_8:GetChild(iter_283_9)

					if var_283_9.name == "split_1" or not string.find(var_283_9.name, "split") then
						var_283_9.gameObject:SetActive(true)
					else
						var_283_9.gameObject:SetActive(false)
					end
				end
			end

			local var_283_10 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_10 then
				var_283_8.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_280_1.time_ - 0) / var_283_10)
			end

			if arg_280_1.time_ >= 0 + var_283_10 and arg_280_1.time_ < 0 + var_283_10 + arg_283_0 then
				var_283_8.localPosition = Vector3.New(0, -340, -288)
			end

			local var_283_11 = 0
			local var_283_12 = 0.85

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_11 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_13 = arg_280_1:GetWordFromCfg(417151069)
				local var_283_14 = arg_280_1:FormatText(var_283_13.content)

				arg_280_1.text_.text = var_283_14

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_16 = 34 <= 0 and var_283_12 or var_283_12 * (utf8.len(var_283_14) / 34)

				if (34 <= 0 and var_283_12 or var_283_12 * (utf8.len(var_283_14) / 34)) > 0 and var_283_12 < var_283_16 then
					arg_280_1.talkMaxDuration = var_283_16

					if var_283_16 + var_283_11 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_16 + var_283_11
					end
				end

				arg_280_1.text_.text = var_283_14
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151069", "story_v_out_417151.awb") ~= 0 then
					local var_283_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151069", "story_v_out_417151.awb") / 1000

					if var_283_17 + var_283_11 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_17 + var_283_11
					end

					if var_283_13.prefab_name ~= "" and arg_280_1.actors_[var_283_13.prefab_name] ~= nil then
						local var_283_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_13.prefab_name].transform, "story_v_out_417151", "417151069", "story_v_out_417151.awb")

						arg_280_1:RecordAudio("417151069", var_283_18)
						arg_280_1:RecordAudio("417151069", var_283_18)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_417151", "417151069", "story_v_out_417151.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_417151", "417151069", "story_v_out_417151.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_19 = math.max(var_283_12, arg_280_1.talkMaxDuration)

			if var_283_11 <= arg_280_1.time_ and arg_280_1.time_ < var_283_11 + var_283_19 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_11) / var_283_19

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_11 + var_283_19 and arg_280_1.time_ < var_283_11 + var_283_19 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play417151070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417151070
		arg_284_1.duration_ = 9.2

		local var_284_0 = {
			zh = 8.233,
			ja = 9.2
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play417151071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 1.05

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:GetWordFromCfg(417151070)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 42 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 42)

				if (42 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 42)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151070", "story_v_out_417151.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151070", "story_v_out_417151.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_417151", "417151070", "story_v_out_417151.awb")

						arg_284_1:RecordAudio("417151070", var_287_6)
						arg_284_1:RecordAudio("417151070", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_417151", "417151070", "story_v_out_417151.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_417151", "417151070", "story_v_out_417151.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play417151071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417151071
		arg_288_1.duration_ = 10.97

		local var_288_0 = {
			zh = 10.966,
			ja = 10.833
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play417151072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.25

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(417151071)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 50 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 50)

				if (50 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 50)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151071", "story_v_out_417151.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151071", "story_v_out_417151.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_417151", "417151071", "story_v_out_417151.awb")

						arg_288_1:RecordAudio("417151071", var_291_6)
						arg_288_1:RecordAudio("417151071", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_417151", "417151071", "story_v_out_417151.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_417151", "417151071", "story_v_out_417151.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417151072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417151072
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417151073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1015"]) and arg_292_1.var_.actorSpriteComps1015 == nil then
				arg_292_1.var_.actorSpriteComps1015 = arg_292_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1015"]) then
				if arg_292_1.var_.actorSpriteComps1015 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								iter_295_1.color = Color.New(Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor2.r, (arg_292_1.time_ - 0) / var_295_0), Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor2.g, (arg_292_1.time_ - 0) / var_295_0), (Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor2.b, (arg_292_1.time_ - 0) / var_295_0)))
							else
								local var_295_1 = Mathf.Lerp(iter_295_1.color.r, 0.5, (arg_292_1.time_ - 0) / var_295_0)

								iter_295_1.color = Color.New(var_295_1, var_295_1, var_295_1)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1015"]) and arg_292_1.var_.actorSpriteComps1015 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_292_1.var_.actorSpriteComps1015 = nil
			end

			local var_295_2 = arg_292_1.actors_["1015"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1015 = var_295_2.localPosition
				var_295_2.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("1015", 7)

				for iter_295_4 = 0, var_295_2.childCount - 1 do
					local var_295_3 = var_295_2:GetChild(iter_295_4)

					if var_295_3.name == "split_7" or not string.find(var_295_3.name, "split") then
						var_295_3.gameObject:SetActive(true)
					else
						var_295_3.gameObject:SetActive(false)
					end
				end
			end

			local var_295_4 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_2.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_292_1.time_ - 0) / var_295_4)
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_295_5 = 0
			local var_295_6 = 0.775

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_7 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(417151072).content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 31 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_7) / 31)

				if (31 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_7) / 31)) > 0 and var_295_6 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_5
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_6, arg_292_1.talkMaxDuration)

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_5) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_5 + var_295_10 and arg_292_1.time_ < var_295_5 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play417151073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417151073
		arg_296_1.duration_ = 7.7

		local var_296_0 = {
			zh = 3.8,
			ja = 7.7
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play417151074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10128"]) and arg_296_1.var_.actorSpriteComps10128 == nil then
				arg_296_1.var_.actorSpriteComps10128 = arg_296_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10128"]) then
				if arg_296_1.var_.actorSpriteComps10128 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 1, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10128"]) and arg_296_1.var_.actorSpriteComps10128 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10128 = nil
			end

			local var_299_2 = arg_296_1.actors_["10128"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10128 = var_299_2.localPosition
				var_299_2.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10128", 3)

				for iter_299_4 = 0, var_299_2.childCount - 1 do
					local var_299_3 = var_299_2:GetChild(iter_299_4)

					if var_299_3.name == "" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_2.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_296_1.time_ - 0) / var_299_4)
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_299_5 = 0
			local var_299_6 = 0.45

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_7 = arg_296_1:GetWordFromCfg(417151073)
				local var_299_8 = arg_296_1:FormatText(var_299_7.content)

				arg_296_1.text_.text = var_299_8

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_10 = 18 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 18)

				if (18 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 18)) > 0 and var_299_6 < var_299_10 then
					arg_296_1.talkMaxDuration = var_299_10

					if var_299_10 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_5
					end
				end

				arg_296_1.text_.text = var_299_8
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151073", "story_v_out_417151.awb") ~= 0 then
					local var_299_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151073", "story_v_out_417151.awb") / 1000

					if var_299_11 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_5
					end

					if var_299_7.prefab_name ~= "" and arg_296_1.actors_[var_299_7.prefab_name] ~= nil then
						local var_299_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_7.prefab_name].transform, "story_v_out_417151", "417151073", "story_v_out_417151.awb")

						arg_296_1:RecordAudio("417151073", var_299_12)
						arg_296_1:RecordAudio("417151073", var_299_12)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417151", "417151073", "story_v_out_417151.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417151", "417151073", "story_v_out_417151.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_13 = math.max(var_299_6, arg_296_1.talkMaxDuration)

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_13 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_5) / var_299_13

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_5 + var_299_13 and arg_296_1.time_ < var_299_5 + var_299_13 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play417151074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417151074
		arg_300_1.duration_ = 10.1

		local var_300_0 = {
			zh = 10.1,
			ja = 8.966
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417151075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1015"]) and arg_300_1.var_.actorSpriteComps1015 == nil then
				arg_300_1.var_.actorSpriteComps1015 = arg_300_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1015"]) then
				if arg_300_1.var_.actorSpriteComps1015 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor1.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor1.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor1.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 1, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1015"]) and arg_300_1.var_.actorSpriteComps1015 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_300_1.var_.actorSpriteComps1015 = nil
			end

			local var_303_2 = arg_300_1.actors_["10128"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10128 == nil then
				arg_300_1.var_.actorSpriteComps10128 = var_303_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_3 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.actorSpriteComps10128 then
					for iter_303_4, iter_303_5 in pairs(arg_300_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_303_5 then
							if arg_300_1.isInRecall_ then
								iter_303_5.color = Color.New(Mathf.Lerp(iter_303_5.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_3), Mathf.Lerp(iter_303_5.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_3), (Mathf.Lerp(iter_303_5.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_3)))
							else
								local var_303_4 = Mathf.Lerp(iter_303_5.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_3)

								iter_303_5.color = Color.New(var_303_4, var_303_4, var_303_4)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10128 then
				for iter_303_6, iter_303_7 in pairs(arg_300_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_303_7 then
						iter_303_7.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10128 = nil
			end

			local var_303_5 = arg_300_1.actors_["10128"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10128 = var_303_5.localPosition
				var_303_5.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10128", 2)

				for iter_303_8 = 0, var_303_5.childCount - 1 do
					local var_303_6 = var_303_5:GetChild(iter_303_8)

					if var_303_6.name == "" or not string.find(var_303_6.name, "split") then
						var_303_6.gameObject:SetActive(true)
					else
						var_303_6.gameObject:SetActive(false)
					end
				end
			end

			local var_303_7 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				var_303_5.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_300_1.time_ - 0) / var_303_7)
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				var_303_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_303_8 = arg_300_1.actors_["1015"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1015 = var_303_8.localPosition
				var_303_8.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("1015", 4)

				for iter_303_9 = 0, var_303_8.childCount - 1 do
					local var_303_9 = var_303_8:GetChild(iter_303_9)

					if var_303_9.name == "" or not string.find(var_303_9.name, "split") then
						var_303_9.gameObject:SetActive(true)
					else
						var_303_9.gameObject:SetActive(false)
					end
				end
			end

			local var_303_10 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_10 then
				var_303_8.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_300_1.time_ - 0) / var_303_10)
			end

			if arg_300_1.time_ >= 0 + var_303_10 and arg_300_1.time_ < 0 + var_303_10 + arg_303_0 then
				var_303_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_303_11 = 0
			local var_303_12 = 0.95

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_11 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_13 = arg_300_1:GetWordFromCfg(417151074)
				local var_303_14 = arg_300_1:FormatText(var_303_13.content)

				arg_300_1.text_.text = var_303_14

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_16 = 38 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 38)

				if (38 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 38)) > 0 and var_303_12 < var_303_16 then
					arg_300_1.talkMaxDuration = var_303_16

					if var_303_16 + var_303_11 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_16 + var_303_11
					end
				end

				arg_300_1.text_.text = var_303_14
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151074", "story_v_out_417151.awb") ~= 0 then
					local var_303_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151074", "story_v_out_417151.awb") / 1000

					if var_303_17 + var_303_11 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_17 + var_303_11
					end

					if var_303_13.prefab_name ~= "" and arg_300_1.actors_[var_303_13.prefab_name] ~= nil then
						local var_303_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_13.prefab_name].transform, "story_v_out_417151", "417151074", "story_v_out_417151.awb")

						arg_300_1:RecordAudio("417151074", var_303_18)
						arg_300_1:RecordAudio("417151074", var_303_18)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_417151", "417151074", "story_v_out_417151.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_417151", "417151074", "story_v_out_417151.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_19 = math.max(var_303_12, arg_300_1.talkMaxDuration)

			if var_303_11 <= arg_300_1.time_ and arg_300_1.time_ < var_303_11 + var_303_19 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_11) / var_303_19

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_11 + var_303_19 and arg_300_1.time_ < var_303_11 + var_303_19 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play417151075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 417151075
		arg_304_1.duration_ = 10.03

		local var_304_0 = {
			zh = 8.133,
			ja = 10.033
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play417151076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.125

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(417151075)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 45 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 45)

				if (45 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 45)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151075", "story_v_out_417151.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151075", "story_v_out_417151.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_417151", "417151075", "story_v_out_417151.awb")

						arg_304_1:RecordAudio("417151075", var_307_6)
						arg_304_1:RecordAudio("417151075", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_417151", "417151075", "story_v_out_417151.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_417151", "417151075", "story_v_out_417151.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play417151076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 417151076
		arg_308_1.duration_ = 12.4

		local var_308_0 = {
			zh = 10.2,
			ja = 12.4
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play417151077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 1.275

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:GetWordFromCfg(417151076)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 51 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 51)

				if (51 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 51)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151076", "story_v_out_417151.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151076", "story_v_out_417151.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_417151", "417151076", "story_v_out_417151.awb")

						arg_308_1:RecordAudio("417151076", var_311_6)
						arg_308_1:RecordAudio("417151076", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_417151", "417151076", "story_v_out_417151.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_417151", "417151076", "story_v_out_417151.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play417151077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 417151077
		arg_312_1.duration_ = 6.8

		local var_312_0 = {
			zh = 6.8,
			ja = 6
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play417151078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.75

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:GetWordFromCfg(417151077)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 30 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 30)

				if (30 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 30)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151077", "story_v_out_417151.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151077", "story_v_out_417151.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_out_417151", "417151077", "story_v_out_417151.awb")

						arg_312_1:RecordAudio("417151077", var_315_6)
						arg_312_1:RecordAudio("417151077", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_417151", "417151077", "story_v_out_417151.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_417151", "417151077", "story_v_out_417151.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play417151078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 417151078
		arg_316_1.duration_ = 3.23

		local var_316_0 = {
			zh = 2.166,
			ja = 3.233
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play417151079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10128"]) and arg_316_1.var_.actorSpriteComps10128 == nil then
				arg_316_1.var_.actorSpriteComps10128 = arg_316_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10128"]) then
				if arg_316_1.var_.actorSpriteComps10128 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 1, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10128"]) and arg_316_1.var_.actorSpriteComps10128 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps10128 = nil
			end

			local var_319_2 = arg_316_1.actors_["1015"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1015 == nil then
				arg_316_1.var_.actorSpriteComps1015 = var_319_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_3 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_3 and not isNil(var_319_2) then
				if arg_316_1.var_.actorSpriteComps1015 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								iter_319_5.color = Color.New(Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_3), Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_3), (Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_3)))
							else
								local var_319_4 = Mathf.Lerp(iter_319_5.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_3)

								iter_319_5.color = Color.New(var_319_4, var_319_4, var_319_4)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_3 and arg_316_1.time_ < 0 + var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1015 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_319_7 then
						iter_319_7.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps1015 = nil
			end

			local var_319_5 = arg_316_1.actors_["10128"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10128 = var_319_5.localPosition
				var_319_5.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10128", 2)

				for iter_319_8 = 0, var_319_5.childCount - 1 do
					local var_319_6 = var_319_5:GetChild(iter_319_8)

					if var_319_6.name == "split_6" or not string.find(var_319_6.name, "split") then
						var_319_6.gameObject:SetActive(true)
					else
						var_319_6.gameObject:SetActive(false)
					end
				end
			end

			local var_319_7 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				var_319_5.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_316_1.time_ - 0) / var_319_7)
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				var_319_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_319_8 = 0
			local var_319_9 = 0.325

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_10 = arg_316_1:GetWordFromCfg(417151078)
				local var_319_11 = arg_316_1:FormatText(var_319_10.content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 13 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 13)

				if (13 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 13)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151078", "story_v_out_417151.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151078", "story_v_out_417151.awb") / 1000

					if var_319_14 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_8
					end

					if var_319_10.prefab_name ~= "" and arg_316_1.actors_[var_319_10.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_10.prefab_name].transform, "story_v_out_417151", "417151078", "story_v_out_417151.awb")

						arg_316_1:RecordAudio("417151078", var_319_15)
						arg_316_1:RecordAudio("417151078", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_417151", "417151078", "story_v_out_417151.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_417151", "417151078", "story_v_out_417151.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play417151079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 417151079
		arg_320_1.duration_ = 11.4

		local var_320_0 = {
			zh = 8.7,
			ja = 11.4
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play417151080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.95

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(417151079)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 38)

				if (38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 38)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151079", "story_v_out_417151.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151079", "story_v_out_417151.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_417151", "417151079", "story_v_out_417151.awb")

						arg_320_1:RecordAudio("417151079", var_323_6)
						arg_320_1:RecordAudio("417151079", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_417151", "417151079", "story_v_out_417151.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_417151", "417151079", "story_v_out_417151.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play417151080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 417151080
		arg_324_1.duration_ = 12.83

		local var_324_0 = {
			zh = 9.3,
			ja = 12.833
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play417151081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.3

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:GetWordFromCfg(417151080)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 51 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 51)

				if (51 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 51)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151080", "story_v_out_417151.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151080", "story_v_out_417151.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_417151", "417151080", "story_v_out_417151.awb")

						arg_324_1:RecordAudio("417151080", var_327_6)
						arg_324_1:RecordAudio("417151080", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_417151", "417151080", "story_v_out_417151.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_417151", "417151080", "story_v_out_417151.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play417151081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 417151081
		arg_328_1.duration_ = 5.87

		local var_328_0 = {
			zh = 5.466,
			ja = 5.866
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play417151082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1015"]) and arg_328_1.var_.actorSpriteComps1015 == nil then
				arg_328_1.var_.actorSpriteComps1015 = arg_328_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1015"]) then
				if arg_328_1.var_.actorSpriteComps1015 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor1.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor1.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor1.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 1, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1015"]) and arg_328_1.var_.actorSpriteComps1015 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_328_1.var_.actorSpriteComps1015 = nil
			end

			local var_331_2 = arg_328_1.actors_["10128"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.actorSpriteComps10128 == nil then
				arg_328_1.var_.actorSpriteComps10128 = var_331_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_3 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_3 and not isNil(var_331_2) then
				if arg_328_1.var_.actorSpriteComps10128 then
					for iter_331_4, iter_331_5 in pairs(arg_328_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_331_5 then
							if arg_328_1.isInRecall_ then
								iter_331_5.color = Color.New(Mathf.Lerp(iter_331_5.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_3), Mathf.Lerp(iter_331_5.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_3), (Mathf.Lerp(iter_331_5.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_3)))
							else
								local var_331_4 = Mathf.Lerp(iter_331_5.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_3)

								iter_331_5.color = Color.New(var_331_4, var_331_4, var_331_4)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_3 and arg_328_1.time_ < 0 + var_331_3 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.actorSpriteComps10128 then
				for iter_331_6, iter_331_7 in pairs(arg_328_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_331_7 then
						iter_331_7.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps10128 = nil
			end

			local var_331_5 = 0
			local var_331_6 = 0.55

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_7 = arg_328_1:GetWordFromCfg(417151081)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_10 = 22 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 22)

				if (22 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 22)) > 0 and var_331_6 < var_331_10 then
					arg_328_1.talkMaxDuration = var_331_10

					if var_331_10 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_5
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151081", "story_v_out_417151.awb") ~= 0 then
					local var_331_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151081", "story_v_out_417151.awb") / 1000

					if var_331_11 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_5
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_417151", "417151081", "story_v_out_417151.awb")

						arg_328_1:RecordAudio("417151081", var_331_12)
						arg_328_1:RecordAudio("417151081", var_331_12)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_417151", "417151081", "story_v_out_417151.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_417151", "417151081", "story_v_out_417151.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_13 = math.max(var_331_6, arg_328_1.talkMaxDuration)

			if var_331_5 <= arg_328_1.time_ and arg_328_1.time_ < var_331_5 + var_331_13 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_5) / var_331_13

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_5 + var_331_13 and arg_328_1.time_ < var_331_5 + var_331_13 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play417151082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 417151082
		arg_332_1.duration_ = 9.67

		local var_332_0 = {
			zh = 5.5,
			ja = 9.666
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play417151083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["10128"]) and arg_332_1.var_.actorSpriteComps10128 == nil then
				arg_332_1.var_.actorSpriteComps10128 = arg_332_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_0 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["10128"]) then
				if arg_332_1.var_.actorSpriteComps10128 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								iter_335_1.color = Color.New(Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor1.r, (arg_332_1.time_ - 0) / var_335_0), Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor1.g, (arg_332_1.time_ - 0) / var_335_0), (Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor1.b, (arg_332_1.time_ - 0) / var_335_0)))
							else
								local var_335_1 = Mathf.Lerp(iter_335_1.color.r, 1, (arg_332_1.time_ - 0) / var_335_0)

								iter_335_1.color = Color.New(var_335_1, var_335_1, var_335_1)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["10128"]) and arg_332_1.var_.actorSpriteComps10128 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_335_3 then
						iter_335_3.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_332_1.var_.actorSpriteComps10128 = nil
			end

			local var_335_2 = arg_332_1.actors_["1015"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps1015 == nil then
				arg_332_1.var_.actorSpriteComps1015 = var_335_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_3 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_3 and not isNil(var_335_2) then
				if arg_332_1.var_.actorSpriteComps1015 then
					for iter_335_4, iter_335_5 in pairs(arg_332_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_335_5 then
							if arg_332_1.isInRecall_ then
								iter_335_5.color = Color.New(Mathf.Lerp(iter_335_5.color.r, arg_332_1.hightColor2.r, (arg_332_1.time_ - 0) / var_335_3), Mathf.Lerp(iter_335_5.color.g, arg_332_1.hightColor2.g, (arg_332_1.time_ - 0) / var_335_3), (Mathf.Lerp(iter_335_5.color.b, arg_332_1.hightColor2.b, (arg_332_1.time_ - 0) / var_335_3)))
							else
								local var_335_4 = Mathf.Lerp(iter_335_5.color.r, 0.5, (arg_332_1.time_ - 0) / var_335_3)

								iter_335_5.color = Color.New(var_335_4, var_335_4, var_335_4)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_3 and arg_332_1.time_ < 0 + var_335_3 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps1015 then
				for iter_335_6, iter_335_7 in pairs(arg_332_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_335_7 then
						iter_335_7.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_332_1.var_.actorSpriteComps1015 = nil
			end

			local var_335_5 = 0
			local var_335_6 = 0.775

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_7 = arg_332_1:GetWordFromCfg(417151082)
				local var_335_8 = arg_332_1:FormatText(var_335_7.content)

				arg_332_1.text_.text = var_335_8

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_10 = 31 <= 0 and var_335_6 or var_335_6 * (utf8.len(var_335_8) / 31)

				if (31 <= 0 and var_335_6 or var_335_6 * (utf8.len(var_335_8) / 31)) > 0 and var_335_6 < var_335_10 then
					arg_332_1.talkMaxDuration = var_335_10

					if var_335_10 + var_335_5 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_5
					end
				end

				arg_332_1.text_.text = var_335_8
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151082", "story_v_out_417151.awb") ~= 0 then
					local var_335_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151082", "story_v_out_417151.awb") / 1000

					if var_335_11 + var_335_5 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_11 + var_335_5
					end

					if var_335_7.prefab_name ~= "" and arg_332_1.actors_[var_335_7.prefab_name] ~= nil then
						local var_335_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_7.prefab_name].transform, "story_v_out_417151", "417151082", "story_v_out_417151.awb")

						arg_332_1:RecordAudio("417151082", var_335_12)
						arg_332_1:RecordAudio("417151082", var_335_12)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_417151", "417151082", "story_v_out_417151.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_417151", "417151082", "story_v_out_417151.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_13 = math.max(var_335_6, arg_332_1.talkMaxDuration)

			if var_335_5 <= arg_332_1.time_ and arg_332_1.time_ < var_335_5 + var_335_13 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_5) / var_335_13

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_5 + var_335_13 and arg_332_1.time_ < var_335_5 + var_335_13 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play417151083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 417151083
		arg_336_1.duration_ = 7.07

		local var_336_0 = {
			zh = 3.166,
			ja = 7.066
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play417151084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1015"]) and arg_336_1.var_.actorSpriteComps1015 == nil then
				arg_336_1.var_.actorSpriteComps1015 = arg_336_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_0 = 0.2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1015"]) then
				if arg_336_1.var_.actorSpriteComps1015 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								iter_339_1.color = Color.New(Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor1.r, (arg_336_1.time_ - 0) / var_339_0), Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor1.g, (arg_336_1.time_ - 0) / var_339_0), (Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor1.b, (arg_336_1.time_ - 0) / var_339_0)))
							else
								local var_339_1 = Mathf.Lerp(iter_339_1.color.r, 1, (arg_336_1.time_ - 0) / var_339_0)

								iter_339_1.color = Color.New(var_339_1, var_339_1, var_339_1)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1015"]) and arg_336_1.var_.actorSpriteComps1015 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_339_3 then
						iter_339_3.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_336_1.var_.actorSpriteComps1015 = nil
			end

			local var_339_2 = arg_336_1.actors_["10128"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_2) and arg_336_1.var_.actorSpriteComps10128 == nil then
				arg_336_1.var_.actorSpriteComps10128 = var_339_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_3 = 0.2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_3 and not isNil(var_339_2) then
				if arg_336_1.var_.actorSpriteComps10128 then
					for iter_339_4, iter_339_5 in pairs(arg_336_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_339_5 then
							if arg_336_1.isInRecall_ then
								iter_339_5.color = Color.New(Mathf.Lerp(iter_339_5.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_3), Mathf.Lerp(iter_339_5.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_3), (Mathf.Lerp(iter_339_5.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_3)))
							else
								local var_339_4 = Mathf.Lerp(iter_339_5.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_3)

								iter_339_5.color = Color.New(var_339_4, var_339_4, var_339_4)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_3 and arg_336_1.time_ < 0 + var_339_3 + arg_339_0 and not isNil(var_339_2) and arg_336_1.var_.actorSpriteComps10128 then
				for iter_339_6, iter_339_7 in pairs(arg_336_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_339_7 then
						iter_339_7.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps10128 = nil
			end

			local var_339_5 = 0
			local var_339_6 = 0.325

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_7 = arg_336_1:GetWordFromCfg(417151083)
				local var_339_8 = arg_336_1:FormatText(var_339_7.content)

				arg_336_1.text_.text = var_339_8

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_10 = 13 <= 0 and var_339_6 or var_339_6 * (utf8.len(var_339_8) / 13)

				if (13 <= 0 and var_339_6 or var_339_6 * (utf8.len(var_339_8) / 13)) > 0 and var_339_6 < var_339_10 then
					arg_336_1.talkMaxDuration = var_339_10

					if var_339_10 + var_339_5 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_5
					end
				end

				arg_336_1.text_.text = var_339_8
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151083", "story_v_out_417151.awb") ~= 0 then
					local var_339_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151083", "story_v_out_417151.awb") / 1000

					if var_339_11 + var_339_5 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_5
					end

					if var_339_7.prefab_name ~= "" and arg_336_1.actors_[var_339_7.prefab_name] ~= nil then
						local var_339_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_7.prefab_name].transform, "story_v_out_417151", "417151083", "story_v_out_417151.awb")

						arg_336_1:RecordAudio("417151083", var_339_12)
						arg_336_1:RecordAudio("417151083", var_339_12)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_417151", "417151083", "story_v_out_417151.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_417151", "417151083", "story_v_out_417151.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_13 = math.max(var_339_6, arg_336_1.talkMaxDuration)

			if var_339_5 <= arg_336_1.time_ and arg_336_1.time_ < var_339_5 + var_339_13 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_5) / var_339_13

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_5 + var_339_13 and arg_336_1.time_ < var_339_5 + var_339_13 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play417151084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 417151084
		arg_340_1.duration_ = 12.13

		local var_340_0 = {
			zh = 8.8,
			ja = 12.133
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play417151085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["10128"]) and arg_340_1.var_.actorSpriteComps10128 == nil then
				arg_340_1.var_.actorSpriteComps10128 = arg_340_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_0 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["10128"]) then
				if arg_340_1.var_.actorSpriteComps10128 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								iter_343_1.color = Color.New(Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_0), Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_0), (Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_0)))
							else
								local var_343_1 = Mathf.Lerp(iter_343_1.color.r, 1, (arg_340_1.time_ - 0) / var_343_0)

								iter_343_1.color = Color.New(var_343_1, var_343_1, var_343_1)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["10128"]) and arg_340_1.var_.actorSpriteComps10128 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_343_3 then
						iter_343_3.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps10128 = nil
			end

			local var_343_2 = arg_340_1.actors_["1015"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps1015 == nil then
				arg_340_1.var_.actorSpriteComps1015 = var_343_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_3 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_3 and not isNil(var_343_2) then
				if arg_340_1.var_.actorSpriteComps1015 then
					for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_343_5 then
							if arg_340_1.isInRecall_ then
								iter_343_5.color = Color.New(Mathf.Lerp(iter_343_5.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 0) / var_343_3), Mathf.Lerp(iter_343_5.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 0) / var_343_3), (Mathf.Lerp(iter_343_5.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 0) / var_343_3)))
							else
								local var_343_4 = Mathf.Lerp(iter_343_5.color.r, 0.5, (arg_340_1.time_ - 0) / var_343_3)

								iter_343_5.color = Color.New(var_343_4, var_343_4, var_343_4)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_3 and arg_340_1.time_ < 0 + var_343_3 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps1015 then
				for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_343_7 then
						iter_343_7.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps1015 = nil
			end

			local var_343_5 = 0
			local var_343_6 = 1.1

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_7 = arg_340_1:GetWordFromCfg(417151084)
				local var_343_8 = arg_340_1:FormatText(var_343_7.content)

				arg_340_1.text_.text = var_343_8

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 44 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 44)

				if (44 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 44)) > 0 and var_343_6 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_5
					end
				end

				arg_340_1.text_.text = var_343_8
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151084", "story_v_out_417151.awb") ~= 0 then
					local var_343_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151084", "story_v_out_417151.awb") / 1000

					if var_343_11 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_5
					end

					if var_343_7.prefab_name ~= "" and arg_340_1.actors_[var_343_7.prefab_name] ~= nil then
						local var_343_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_7.prefab_name].transform, "story_v_out_417151", "417151084", "story_v_out_417151.awb")

						arg_340_1:RecordAudio("417151084", var_343_12)
						arg_340_1:RecordAudio("417151084", var_343_12)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_417151", "417151084", "story_v_out_417151.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_417151", "417151084", "story_v_out_417151.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_13 = math.max(var_343_6, arg_340_1.talkMaxDuration)

			if var_343_5 <= arg_340_1.time_ and arg_340_1.time_ < var_343_5 + var_343_13 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_5) / var_343_13

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_5 + var_343_13 and arg_340_1.time_ < var_343_5 + var_343_13 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play417151085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 417151085
		arg_344_1.duration_ = 13.1

		local var_344_0 = {
			zh = 9.433,
			ja = 13.1
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play417151086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10128 = arg_344_1.actors_["10128"].transform.localPosition
				arg_344_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10128", 2)

				for iter_347_0 = 0, arg_344_1.actors_["10128"].transform.childCount - 1 do
					local var_347_0 = arg_344_1.actors_["10128"].transform:GetChild(iter_347_0)

					if var_347_0.name == "split_1" or not string.find(var_347_0.name, "split") then
						var_347_0.gameObject:SetActive(true)
					else
						var_347_0.gameObject:SetActive(false)
					end
				end
			end

			local var_347_1 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_1 then
				arg_344_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_344_1.time_ - 0) / var_347_1)
			end

			if arg_344_1.time_ >= 0 + var_347_1 and arg_344_1.time_ < 0 + var_347_1 + arg_347_0 then
				arg_344_1.actors_["10128"].transform.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_347_2 = 0
			local var_347_3 = 1.1

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(417151085)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 44 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 44)

				if (44 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 44)) > 0 and var_347_3 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151085", "story_v_out_417151.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151085", "story_v_out_417151.awb") / 1000

					if var_347_8 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_2
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_out_417151", "417151085", "story_v_out_417151.awb")

						arg_344_1:RecordAudio("417151085", var_347_9)
						arg_344_1:RecordAudio("417151085", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_417151", "417151085", "story_v_out_417151.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_417151", "417151085", "story_v_out_417151.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_10 and arg_344_1.time_ < var_347_2 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play417151086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 417151086
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play417151087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["10128"]) and arg_348_1.var_.actorSpriteComps10128 == nil then
				arg_348_1.var_.actorSpriteComps10128 = arg_348_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["10128"]) then
				if arg_348_1.var_.actorSpriteComps10128 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor2.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor2.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor2.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 0.5, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["10128"]) and arg_348_1.var_.actorSpriteComps10128 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_348_1.var_.actorSpriteComps10128 = nil
			end

			local var_351_2 = 0
			local var_351_3 = 0.875

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_4 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(417151086).content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_6 = 35 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_4) / 35)

				if (35 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_4) / 35)) > 0 and var_351_3 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_2
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_3, arg_348_1.talkMaxDuration)

			if var_351_2 <= arg_348_1.time_ and arg_348_1.time_ < var_351_2 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_2) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_2 + var_351_7 and arg_348_1.time_ < var_351_2 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play417151087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 417151087
		arg_352_1.duration_ = 12.6

		local var_352_0 = {
			zh = 8.666,
			ja = 12.6
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play417151088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["10128"]) and arg_352_1.var_.actorSpriteComps10128 == nil then
				arg_352_1.var_.actorSpriteComps10128 = arg_352_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["10128"]) then
				if arg_352_1.var_.actorSpriteComps10128 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 1, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["10128"]) and arg_352_1.var_.actorSpriteComps10128 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps10128 = nil
			end

			local var_355_2 = 0
			local var_355_3 = 1.125

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_2 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_4 = arg_352_1:GetWordFromCfg(417151087)
				local var_355_5 = arg_352_1:FormatText(var_355_4.content)

				arg_352_1.text_.text = var_355_5

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_7 = 45 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 45)

				if (45 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 45)) > 0 and var_355_3 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_2
					end
				end

				arg_352_1.text_.text = var_355_5
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151087", "story_v_out_417151.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151087", "story_v_out_417151.awb") / 1000

					if var_355_8 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_2
					end

					if var_355_4.prefab_name ~= "" and arg_352_1.actors_[var_355_4.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_4.prefab_name].transform, "story_v_out_417151", "417151087", "story_v_out_417151.awb")

						arg_352_1:RecordAudio("417151087", var_355_9)
						arg_352_1:RecordAudio("417151087", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_417151", "417151087", "story_v_out_417151.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_417151", "417151087", "story_v_out_417151.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_3, arg_352_1.talkMaxDuration)

			if var_355_2 <= arg_352_1.time_ and arg_352_1.time_ < var_355_2 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_2) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_2 + var_355_10 and arg_352_1.time_ < var_355_2 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play417151088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 417151088
		arg_356_1.duration_ = 3.33

		local var_356_0 = {
			zh = 3.333,
			ja = 3.166
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play417151089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1015"]) and arg_356_1.var_.actorSpriteComps1015 == nil then
				arg_356_1.var_.actorSpriteComps1015 = arg_356_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_0 = 0.2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1015"]) then
				if arg_356_1.var_.actorSpriteComps1015 then
					for iter_359_0, iter_359_1 in pairs(arg_356_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_359_1 then
							if arg_356_1.isInRecall_ then
								iter_359_1.color = Color.New(Mathf.Lerp(iter_359_1.color.r, arg_356_1.hightColor1.r, (arg_356_1.time_ - 0) / var_359_0), Mathf.Lerp(iter_359_1.color.g, arg_356_1.hightColor1.g, (arg_356_1.time_ - 0) / var_359_0), (Mathf.Lerp(iter_359_1.color.b, arg_356_1.hightColor1.b, (arg_356_1.time_ - 0) / var_359_0)))
							else
								local var_359_1 = Mathf.Lerp(iter_359_1.color.r, 1, (arg_356_1.time_ - 0) / var_359_0)

								iter_359_1.color = Color.New(var_359_1, var_359_1, var_359_1)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1015"]) and arg_356_1.var_.actorSpriteComps1015 then
				for iter_359_2, iter_359_3 in pairs(arg_356_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_359_3 then
						iter_359_3.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_356_1.var_.actorSpriteComps1015 = nil
			end

			local var_359_2 = arg_356_1.actors_["10128"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10128 == nil then
				arg_356_1.var_.actorSpriteComps10128 = var_359_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_3 = 0.2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_3 and not isNil(var_359_2) then
				if arg_356_1.var_.actorSpriteComps10128 then
					for iter_359_4, iter_359_5 in pairs(arg_356_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_359_5 then
							if arg_356_1.isInRecall_ then
								iter_359_5.color = Color.New(Mathf.Lerp(iter_359_5.color.r, arg_356_1.hightColor2.r, (arg_356_1.time_ - 0) / var_359_3), Mathf.Lerp(iter_359_5.color.g, arg_356_1.hightColor2.g, (arg_356_1.time_ - 0) / var_359_3), (Mathf.Lerp(iter_359_5.color.b, arg_356_1.hightColor2.b, (arg_356_1.time_ - 0) / var_359_3)))
							else
								local var_359_4 = Mathf.Lerp(iter_359_5.color.r, 0.5, (arg_356_1.time_ - 0) / var_359_3)

								iter_359_5.color = Color.New(var_359_4, var_359_4, var_359_4)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= 0 + var_359_3 and arg_356_1.time_ < 0 + var_359_3 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10128 then
				for iter_359_6, iter_359_7 in pairs(arg_356_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_359_7 then
						iter_359_7.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_356_1.var_.actorSpriteComps10128 = nil
			end

			local var_359_5 = arg_356_1.actors_["1015"].transform

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1015 = var_359_5.localPosition
				var_359_5.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("1015", 4)

				for iter_359_8 = 0, var_359_5.childCount - 1 do
					local var_359_6 = var_359_5:GetChild(iter_359_8)

					if var_359_6.name == "split_5" or not string.find(var_359_6.name, "split") then
						var_359_6.gameObject:SetActive(true)
					else
						var_359_6.gameObject:SetActive(false)
					end
				end
			end

			local var_359_7 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				var_359_5.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_356_1.time_ - 0) / var_359_7)
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				var_359_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_359_8 = 0
			local var_359_9 = 0.2

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_8 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_10 = arg_356_1:GetWordFromCfg(417151088)
				local var_359_11 = arg_356_1:FormatText(var_359_10.content)

				arg_356_1.text_.text = var_359_11

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_13 = 8 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 8)

				if (8 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 8)) > 0 and var_359_9 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_8
					end
				end

				arg_356_1.text_.text = var_359_11
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151088", "story_v_out_417151.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151088", "story_v_out_417151.awb") / 1000

					if var_359_14 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_8
					end

					if var_359_10.prefab_name ~= "" and arg_356_1.actors_[var_359_10.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_10.prefab_name].transform, "story_v_out_417151", "417151088", "story_v_out_417151.awb")

						arg_356_1:RecordAudio("417151088", var_359_15)
						arg_356_1:RecordAudio("417151088", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_417151", "417151088", "story_v_out_417151.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_417151", "417151088", "story_v_out_417151.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_9, arg_356_1.talkMaxDuration)

			if var_359_8 <= arg_356_1.time_ and arg_356_1.time_ < var_359_8 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_8) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_8 + var_359_16 and arg_356_1.time_ < var_359_8 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play417151089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 417151089
		arg_360_1.duration_ = 7.87

		local var_360_0 = {
			zh = 7.866,
			ja = 7.8
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play417151090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["10128"]) and arg_360_1.var_.actorSpriteComps10128 == nil then
				arg_360_1.var_.actorSpriteComps10128 = arg_360_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_0 = 0.2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["10128"]) then
				if arg_360_1.var_.actorSpriteComps10128 then
					for iter_363_0, iter_363_1 in pairs(arg_360_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_363_1 then
							if arg_360_1.isInRecall_ then
								iter_363_1.color = Color.New(Mathf.Lerp(iter_363_1.color.r, arg_360_1.hightColor1.r, (arg_360_1.time_ - 0) / var_363_0), Mathf.Lerp(iter_363_1.color.g, arg_360_1.hightColor1.g, (arg_360_1.time_ - 0) / var_363_0), (Mathf.Lerp(iter_363_1.color.b, arg_360_1.hightColor1.b, (arg_360_1.time_ - 0) / var_363_0)))
							else
								local var_363_1 = Mathf.Lerp(iter_363_1.color.r, 1, (arg_360_1.time_ - 0) / var_363_0)

								iter_363_1.color = Color.New(var_363_1, var_363_1, var_363_1)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["10128"]) and arg_360_1.var_.actorSpriteComps10128 then
				for iter_363_2, iter_363_3 in pairs(arg_360_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_363_3 then
						iter_363_3.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_360_1.var_.actorSpriteComps10128 = nil
			end

			local var_363_2 = arg_360_1.actors_["1015"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_2) and arg_360_1.var_.actorSpriteComps1015 == nil then
				arg_360_1.var_.actorSpriteComps1015 = var_363_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_3 = 0.2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_3 and not isNil(var_363_2) then
				if arg_360_1.var_.actorSpriteComps1015 then
					for iter_363_4, iter_363_5 in pairs(arg_360_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_363_5 then
							if arg_360_1.isInRecall_ then
								iter_363_5.color = Color.New(Mathf.Lerp(iter_363_5.color.r, arg_360_1.hightColor2.r, (arg_360_1.time_ - 0) / var_363_3), Mathf.Lerp(iter_363_5.color.g, arg_360_1.hightColor2.g, (arg_360_1.time_ - 0) / var_363_3), (Mathf.Lerp(iter_363_5.color.b, arg_360_1.hightColor2.b, (arg_360_1.time_ - 0) / var_363_3)))
							else
								local var_363_4 = Mathf.Lerp(iter_363_5.color.r, 0.5, (arg_360_1.time_ - 0) / var_363_3)

								iter_363_5.color = Color.New(var_363_4, var_363_4, var_363_4)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_3 and arg_360_1.time_ < 0 + var_363_3 + arg_363_0 and not isNil(var_363_2) and arg_360_1.var_.actorSpriteComps1015 then
				for iter_363_6, iter_363_7 in pairs(arg_360_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_363_7 then
						iter_363_7.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_360_1.var_.actorSpriteComps1015 = nil
			end

			local var_363_5 = 0
			local var_363_6 = 0.85

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:GetWordFromCfg(417151089)
				local var_363_8 = arg_360_1:FormatText(var_363_7.content)

				arg_360_1.text_.text = var_363_8

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_10 = 34 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_8) / 34)

				if (34 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_8) / 34)) > 0 and var_363_6 < var_363_10 then
					arg_360_1.talkMaxDuration = var_363_10

					if var_363_10 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_5
					end
				end

				arg_360_1.text_.text = var_363_8
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151089", "story_v_out_417151.awb") ~= 0 then
					local var_363_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151089", "story_v_out_417151.awb") / 1000

					if var_363_11 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_11 + var_363_5
					end

					if var_363_7.prefab_name ~= "" and arg_360_1.actors_[var_363_7.prefab_name] ~= nil then
						local var_363_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_7.prefab_name].transform, "story_v_out_417151", "417151089", "story_v_out_417151.awb")

						arg_360_1:RecordAudio("417151089", var_363_12)
						arg_360_1:RecordAudio("417151089", var_363_12)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_417151", "417151089", "story_v_out_417151.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_417151", "417151089", "story_v_out_417151.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_13 = math.max(var_363_6, arg_360_1.talkMaxDuration)

			if var_363_5 <= arg_360_1.time_ and arg_360_1.time_ < var_363_5 + var_363_13 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_5) / var_363_13

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_5 + var_363_13 and arg_360_1.time_ < var_363_5 + var_363_13 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play417151090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 417151090
		arg_364_1.duration_ = 7.37

		local var_364_0 = {
			zh = 7.2,
			ja = 7.366
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play417151091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.85

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:GetWordFromCfg(417151090)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 34 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 34)

				if (34 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 34)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151090", "story_v_out_417151.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151090", "story_v_out_417151.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_417151", "417151090", "story_v_out_417151.awb")

						arg_364_1:RecordAudio("417151090", var_367_6)
						arg_364_1:RecordAudio("417151090", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_417151", "417151090", "story_v_out_417151.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_417151", "417151090", "story_v_out_417151.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play417151091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 417151091
		arg_368_1.duration_ = 10.93

		local var_368_0 = {
			zh = 7.666,
			ja = 10.933
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play417151092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.975

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(417151091)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 39 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 39)

				if (39 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 39)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151091", "story_v_out_417151.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151091", "story_v_out_417151.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_417151", "417151091", "story_v_out_417151.awb")

						arg_368_1:RecordAudio("417151091", var_371_6)
						arg_368_1:RecordAudio("417151091", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_417151", "417151091", "story_v_out_417151.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_417151", "417151091", "story_v_out_417151.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play417151092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 417151092
		arg_372_1.duration_ = 7.07

		local var_372_0 = {
			zh = 5.4,
			ja = 7.066
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play417151093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.475

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:GetWordFromCfg(417151092)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 19 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 19)

				if (19 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 19)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151092", "story_v_out_417151.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151092", "story_v_out_417151.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_417151", "417151092", "story_v_out_417151.awb")

						arg_372_1:RecordAudio("417151092", var_375_6)
						arg_372_1:RecordAudio("417151092", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_417151", "417151092", "story_v_out_417151.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_417151", "417151092", "story_v_out_417151.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play417151093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 417151093
		arg_376_1.duration_ = 8.5

		local var_376_0 = {
			zh = 5.8,
			ja = 8.5
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play417151094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.65

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(417151093)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 26 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 26)

				if (26 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 26)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151093", "story_v_out_417151.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151093", "story_v_out_417151.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_417151", "417151093", "story_v_out_417151.awb")

						arg_376_1:RecordAudio("417151093", var_379_6)
						arg_376_1:RecordAudio("417151093", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_417151", "417151093", "story_v_out_417151.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_417151", "417151093", "story_v_out_417151.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play417151094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417151094
		arg_380_1.duration_ = 5.7

		local var_380_0 = {
			zh = 4.8,
			ja = 5.7
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play417151095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1015"]) and arg_380_1.var_.actorSpriteComps1015 == nil then
				arg_380_1.var_.actorSpriteComps1015 = arg_380_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_0 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1015"]) then
				if arg_380_1.var_.actorSpriteComps1015 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								iter_383_1.color = Color.New(Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor1.r, (arg_380_1.time_ - 0) / var_383_0), Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor1.g, (arg_380_1.time_ - 0) / var_383_0), (Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor1.b, (arg_380_1.time_ - 0) / var_383_0)))
							else
								local var_383_1 = Mathf.Lerp(iter_383_1.color.r, 1, (arg_380_1.time_ - 0) / var_383_0)

								iter_383_1.color = Color.New(var_383_1, var_383_1, var_383_1)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1015"]) and arg_380_1.var_.actorSpriteComps1015 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_383_3 then
						iter_383_3.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_380_1.var_.actorSpriteComps1015 = nil
			end

			local var_383_2 = arg_380_1.actors_["10128"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps10128 == nil then
				arg_380_1.var_.actorSpriteComps10128 = var_383_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_3 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_3 and not isNil(var_383_2) then
				if arg_380_1.var_.actorSpriteComps10128 then
					for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_383_5 then
							if arg_380_1.isInRecall_ then
								iter_383_5.color = Color.New(Mathf.Lerp(iter_383_5.color.r, arg_380_1.hightColor2.r, (arg_380_1.time_ - 0) / var_383_3), Mathf.Lerp(iter_383_5.color.g, arg_380_1.hightColor2.g, (arg_380_1.time_ - 0) / var_383_3), (Mathf.Lerp(iter_383_5.color.b, arg_380_1.hightColor2.b, (arg_380_1.time_ - 0) / var_383_3)))
							else
								local var_383_4 = Mathf.Lerp(iter_383_5.color.r, 0.5, (arg_380_1.time_ - 0) / var_383_3)

								iter_383_5.color = Color.New(var_383_4, var_383_4, var_383_4)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_3 and arg_380_1.time_ < 0 + var_383_3 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps10128 then
				for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_383_7 then
						iter_383_7.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_380_1.var_.actorSpriteComps10128 = nil
			end

			local var_383_5 = arg_380_1.actors_["1015"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1015 = var_383_5.localPosition
				var_383_5.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1015", 4)

				for iter_383_8 = 0, var_383_5.childCount - 1 do
					local var_383_6 = var_383_5:GetChild(iter_383_8)

					if var_383_6.name == "split_6" or not string.find(var_383_6.name, "split") then
						var_383_6.gameObject:SetActive(true)
					else
						var_383_6.gameObject:SetActive(false)
					end
				end
			end

			local var_383_7 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				var_383_5.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_380_1.time_ - 0) / var_383_7)
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				var_383_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_383_8 = 0
			local var_383_9 = 0.6

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_8 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_10 = arg_380_1:GetWordFromCfg(417151094)
				local var_383_11 = arg_380_1:FormatText(var_383_10.content)

				arg_380_1.text_.text = var_383_11

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_13 = 24 <= 0 and var_383_9 or var_383_9 * (utf8.len(var_383_11) / 24)

				if (24 <= 0 and var_383_9 or var_383_9 * (utf8.len(var_383_11) / 24)) > 0 and var_383_9 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_8 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_8
					end
				end

				arg_380_1.text_.text = var_383_11
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151094", "story_v_out_417151.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151094", "story_v_out_417151.awb") / 1000

					if var_383_14 + var_383_8 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_8
					end

					if var_383_10.prefab_name ~= "" and arg_380_1.actors_[var_383_10.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_10.prefab_name].transform, "story_v_out_417151", "417151094", "story_v_out_417151.awb")

						arg_380_1:RecordAudio("417151094", var_383_15)
						arg_380_1:RecordAudio("417151094", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_417151", "417151094", "story_v_out_417151.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_417151", "417151094", "story_v_out_417151.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_9, arg_380_1.talkMaxDuration)

			if var_383_8 <= arg_380_1.time_ and arg_380_1.time_ < var_383_8 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_8) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_8 + var_383_16 and arg_380_1.time_ < var_383_8 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play417151095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417151095
		arg_384_1.duration_ = 9.23

		local var_384_0 = {
			zh = 6.966,
			ja = 9.233
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417151096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["10128"]) and arg_384_1.var_.actorSpriteComps10128 == nil then
				arg_384_1.var_.actorSpriteComps10128 = arg_384_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["10128"]) then
				if arg_384_1.var_.actorSpriteComps10128 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								iter_387_1.color = Color.New(Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, (arg_384_1.time_ - 0) / var_387_0), Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, (arg_384_1.time_ - 0) / var_387_0), (Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, (arg_384_1.time_ - 0) / var_387_0)))
							else
								local var_387_1 = Mathf.Lerp(iter_387_1.color.r, 1, (arg_384_1.time_ - 0) / var_387_0)

								iter_387_1.color = Color.New(var_387_1, var_387_1, var_387_1)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["10128"]) and arg_384_1.var_.actorSpriteComps10128 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_387_3 then
						iter_387_3.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_384_1.var_.actorSpriteComps10128 = nil
			end

			local var_387_2 = arg_384_1.actors_["1015"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps1015 == nil then
				arg_384_1.var_.actorSpriteComps1015 = var_387_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_3 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_3 and not isNil(var_387_2) then
				if arg_384_1.var_.actorSpriteComps1015 then
					for iter_387_4, iter_387_5 in pairs(arg_384_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_387_5 then
							if arg_384_1.isInRecall_ then
								iter_387_5.color = Color.New(Mathf.Lerp(iter_387_5.color.r, arg_384_1.hightColor2.r, (arg_384_1.time_ - 0) / var_387_3), Mathf.Lerp(iter_387_5.color.g, arg_384_1.hightColor2.g, (arg_384_1.time_ - 0) / var_387_3), (Mathf.Lerp(iter_387_5.color.b, arg_384_1.hightColor2.b, (arg_384_1.time_ - 0) / var_387_3)))
							else
								local var_387_4 = Mathf.Lerp(iter_387_5.color.r, 0.5, (arg_384_1.time_ - 0) / var_387_3)

								iter_387_5.color = Color.New(var_387_4, var_387_4, var_387_4)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_3 and arg_384_1.time_ < 0 + var_387_3 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps1015 then
				for iter_387_6, iter_387_7 in pairs(arg_384_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_387_7 then
						iter_387_7.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_384_1.var_.actorSpriteComps1015 = nil
			end

			local var_387_5 = 0
			local var_387_6 = 0.95

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_7 = arg_384_1:GetWordFromCfg(417151095)
				local var_387_8 = arg_384_1:FormatText(var_387_7.content)

				arg_384_1.text_.text = var_387_8

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_10 = 38 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 38)

				if (38 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 38)) > 0 and var_387_6 < var_387_10 then
					arg_384_1.talkMaxDuration = var_387_10

					if var_387_10 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_5
					end
				end

				arg_384_1.text_.text = var_387_8
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151095", "story_v_out_417151.awb") ~= 0 then
					local var_387_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151095", "story_v_out_417151.awb") / 1000

					if var_387_11 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_11 + var_387_5
					end

					if var_387_7.prefab_name ~= "" and arg_384_1.actors_[var_387_7.prefab_name] ~= nil then
						local var_387_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_7.prefab_name].transform, "story_v_out_417151", "417151095", "story_v_out_417151.awb")

						arg_384_1:RecordAudio("417151095", var_387_12)
						arg_384_1:RecordAudio("417151095", var_387_12)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_417151", "417151095", "story_v_out_417151.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_417151", "417151095", "story_v_out_417151.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_13 = math.max(var_387_6, arg_384_1.talkMaxDuration)

			if var_387_5 <= arg_384_1.time_ and arg_384_1.time_ < var_387_5 + var_387_13 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_5) / var_387_13

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_5 + var_387_13 and arg_384_1.time_ < var_387_5 + var_387_13 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play417151096 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417151096
		arg_388_1.duration_ = 11.2

		local var_388_0 = {
			zh = 6.8,
			ja = 11.2
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play417151097(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1015"]) and arg_388_1.var_.actorSpriteComps1015 == nil then
				arg_388_1.var_.actorSpriteComps1015 = arg_388_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1015"]) then
				if arg_388_1.var_.actorSpriteComps1015 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								iter_391_1.color = Color.New(Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor1.r, (arg_388_1.time_ - 0) / var_391_0), Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor1.g, (arg_388_1.time_ - 0) / var_391_0), (Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor1.b, (arg_388_1.time_ - 0) / var_391_0)))
							else
								local var_391_1 = Mathf.Lerp(iter_391_1.color.r, 1, (arg_388_1.time_ - 0) / var_391_0)

								iter_391_1.color = Color.New(var_391_1, var_391_1, var_391_1)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1015"]) and arg_388_1.var_.actorSpriteComps1015 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps1015 = nil
			end

			local var_391_2 = arg_388_1.actors_["10128"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10128 == nil then
				arg_388_1.var_.actorSpriteComps10128 = var_391_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_3 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.actorSpriteComps10128 then
					for iter_391_4, iter_391_5 in pairs(arg_388_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_391_5 then
							if arg_388_1.isInRecall_ then
								iter_391_5.color = Color.New(Mathf.Lerp(iter_391_5.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_3), Mathf.Lerp(iter_391_5.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_3), (Mathf.Lerp(iter_391_5.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_3)))
							else
								local var_391_4 = Mathf.Lerp(iter_391_5.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_3)

								iter_391_5.color = Color.New(var_391_4, var_391_4, var_391_4)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10128 then
				for iter_391_6, iter_391_7 in pairs(arg_388_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_391_7 then
						iter_391_7.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps10128 = nil
			end

			local var_391_5 = 0
			local var_391_6 = 0.7

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_7 = arg_388_1:GetWordFromCfg(417151096)
				local var_391_8 = arg_388_1:FormatText(var_391_7.content)

				arg_388_1.text_.text = var_391_8

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 28 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_8) / 28)

				if (28 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_8) / 28)) > 0 and var_391_6 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_5
					end
				end

				arg_388_1.text_.text = var_391_8
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151096", "story_v_out_417151.awb") ~= 0 then
					local var_391_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151096", "story_v_out_417151.awb") / 1000

					if var_391_11 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_11 + var_391_5
					end

					if var_391_7.prefab_name ~= "" and arg_388_1.actors_[var_391_7.prefab_name] ~= nil then
						local var_391_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_7.prefab_name].transform, "story_v_out_417151", "417151096", "story_v_out_417151.awb")

						arg_388_1:RecordAudio("417151096", var_391_12)
						arg_388_1:RecordAudio("417151096", var_391_12)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_417151", "417151096", "story_v_out_417151.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_417151", "417151096", "story_v_out_417151.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_13 = math.max(var_391_6, arg_388_1.talkMaxDuration)

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_13 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_5) / var_391_13

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_5 + var_391_13 and arg_388_1.time_ < var_391_5 + var_391_13 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play417151097 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 417151097
		arg_392_1.duration_ = 4.4

		local var_392_0 = {
			zh = 3.1,
			ja = 4.4
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play417151098(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10128"]) and arg_392_1.var_.actorSpriteComps10128 == nil then
				arg_392_1.var_.actorSpriteComps10128 = arg_392_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10128"]) then
				if arg_392_1.var_.actorSpriteComps10128 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								iter_395_1.color = Color.New(Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor1.r, (arg_392_1.time_ - 0) / var_395_0), Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor1.g, (arg_392_1.time_ - 0) / var_395_0), (Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor1.b, (arg_392_1.time_ - 0) / var_395_0)))
							else
								local var_395_1 = Mathf.Lerp(iter_395_1.color.r, 1, (arg_392_1.time_ - 0) / var_395_0)

								iter_395_1.color = Color.New(var_395_1, var_395_1, var_395_1)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10128"]) and arg_392_1.var_.actorSpriteComps10128 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_392_1.var_.actorSpriteComps10128 = nil
			end

			local var_395_2 = arg_392_1.actors_["1015"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps1015 == nil then
				arg_392_1.var_.actorSpriteComps1015 = var_395_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_3 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_3 and not isNil(var_395_2) then
				if arg_392_1.var_.actorSpriteComps1015 then
					for iter_395_4, iter_395_5 in pairs(arg_392_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_395_5 then
							if arg_392_1.isInRecall_ then
								iter_395_5.color = Color.New(Mathf.Lerp(iter_395_5.color.r, arg_392_1.hightColor2.r, (arg_392_1.time_ - 0) / var_395_3), Mathf.Lerp(iter_395_5.color.g, arg_392_1.hightColor2.g, (arg_392_1.time_ - 0) / var_395_3), (Mathf.Lerp(iter_395_5.color.b, arg_392_1.hightColor2.b, (arg_392_1.time_ - 0) / var_395_3)))
							else
								local var_395_4 = Mathf.Lerp(iter_395_5.color.r, 0.5, (arg_392_1.time_ - 0) / var_395_3)

								iter_395_5.color = Color.New(var_395_4, var_395_4, var_395_4)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_3 and arg_392_1.time_ < 0 + var_395_3 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.actorSpriteComps1015 then
				for iter_395_6, iter_395_7 in pairs(arg_392_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_395_7 then
						iter_395_7.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps1015 = nil
			end

			local var_395_5 = arg_392_1.actors_["10128"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10128 = var_395_5.localPosition
				var_395_5.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("10128", 2)

				for iter_395_8 = 0, var_395_5.childCount - 1 do
					local var_395_6 = var_395_5:GetChild(iter_395_8)

					if var_395_6.name == "split_4" or not string.find(var_395_6.name, "split") then
						var_395_6.gameObject:SetActive(true)
					else
						var_395_6.gameObject:SetActive(false)
					end
				end
			end

			local var_395_7 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				var_395_5.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_392_1.time_ - 0) / var_395_7)
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				var_395_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_395_8 = 0
			local var_395_9 = 0.35

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_10 = arg_392_1:GetWordFromCfg(417151097)
				local var_395_11 = arg_392_1:FormatText(var_395_10.content)

				arg_392_1.text_.text = var_395_11

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_13 = 14 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 14)

				if (14 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_11) / 14)) > 0 and var_395_9 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_11
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151097", "story_v_out_417151.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_out_417151", "417151097", "story_v_out_417151.awb") / 1000

					if var_395_14 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_8
					end

					if var_395_10.prefab_name ~= "" and arg_392_1.actors_[var_395_10.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_10.prefab_name].transform, "story_v_out_417151", "417151097", "story_v_out_417151.awb")

						arg_392_1:RecordAudio("417151097", var_395_15)
						arg_392_1:RecordAudio("417151097", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_417151", "417151097", "story_v_out_417151.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_417151", "417151097", "story_v_out_417151.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_16 and arg_392_1.time_ < var_395_8 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play417151098 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 417151098
		arg_396_1.duration_ = 4

		local var_396_0 = {
			zh = 2.633,
			ja = 4
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play417151099(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1015"]) and arg_396_1.var_.actorSpriteComps1015 == nil then
				arg_396_1.var_.actorSpriteComps1015 = arg_396_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_0 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1015"]) then
				if arg_396_1.var_.actorSpriteComps1015 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								iter_399_1.color = Color.New(Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor1.r, (arg_396_1.time_ - 0) / var_399_0), Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor1.g, (arg_396_1.time_ - 0) / var_399_0), (Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor1.b, (arg_396_1.time_ - 0) / var_399_0)))
							else
								local var_399_1 = Mathf.Lerp(iter_399_1.color.r, 1, (arg_396_1.time_ - 0) / var_399_0)

								iter_399_1.color = Color.New(var_399_1, var_399_1, var_399_1)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1015"]) and arg_396_1.var_.actorSpriteComps1015 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_399_3 then
						iter_399_3.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_396_1.var_.actorSpriteComps1015 = nil
			end

			local var_399_2 = arg_396_1.actors_["10128"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10128 == nil then
				arg_396_1.var_.actorSpriteComps10128 = var_399_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_3 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_3 and not isNil(var_399_2) then
				if arg_396_1.var_.actorSpriteComps10128 then
					for iter_399_4, iter_399_5 in pairs(arg_396_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_399_5 then
							if arg_396_1.isInRecall_ then
								iter_399_5.color = Color.New(Mathf.Lerp(iter_399_5.color.r, arg_396_1.hightColor2.r, (arg_396_1.time_ - 0) / var_399_3), Mathf.Lerp(iter_399_5.color.g, arg_396_1.hightColor2.g, (arg_396_1.time_ - 0) / var_399_3), (Mathf.Lerp(iter_399_5.color.b, arg_396_1.hightColor2.b, (arg_396_1.time_ - 0) / var_399_3)))
							else
								local var_399_4 = Mathf.Lerp(iter_399_5.color.r, 0.5, (arg_396_1.time_ - 0) / var_399_3)

								iter_399_5.color = Color.New(var_399_4, var_399_4, var_399_4)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_3 and arg_396_1.time_ < 0 + var_399_3 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10128 then
				for iter_399_6, iter_399_7 in pairs(arg_396_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_399_7 then
						iter_399_7.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_396_1.var_.actorSpriteComps10128 = nil
			end

			local var_399_5 = 0
			local var_399_6 = 0.325

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_7 = arg_396_1:GetWordFromCfg(417151098)
				local var_399_8 = arg_396_1:FormatText(var_399_7.content)

				arg_396_1.text_.text = var_399_8

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_10 = 13 <= 0 and var_399_6 or var_399_6 * (utf8.len(var_399_8) / 13)

				if (13 <= 0 and var_399_6 or var_399_6 * (utf8.len(var_399_8) / 13)) > 0 and var_399_6 < var_399_10 then
					arg_396_1.talkMaxDuration = var_399_10

					if var_399_10 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_10 + var_399_5
					end
				end

				arg_396_1.text_.text = var_399_8
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151098", "story_v_out_417151.awb") ~= 0 then
					local var_399_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151098", "story_v_out_417151.awb") / 1000

					if var_399_11 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_11 + var_399_5
					end

					if var_399_7.prefab_name ~= "" and arg_396_1.actors_[var_399_7.prefab_name] ~= nil then
						local var_399_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_7.prefab_name].transform, "story_v_out_417151", "417151098", "story_v_out_417151.awb")

						arg_396_1:RecordAudio("417151098", var_399_12)
						arg_396_1:RecordAudio("417151098", var_399_12)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_417151", "417151098", "story_v_out_417151.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_417151", "417151098", "story_v_out_417151.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_13 = math.max(var_399_6, arg_396_1.talkMaxDuration)

			if var_399_5 <= arg_396_1.time_ and arg_396_1.time_ < var_399_5 + var_399_13 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_5) / var_399_13

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_5 + var_399_13 and arg_396_1.time_ < var_399_5 + var_399_13 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play417151099 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 417151099
		arg_400_1.duration_ = 9.9

		local var_400_0 = {
			zh = 9.666,
			ja = 9.9
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play417151100(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos1015 = arg_400_1.actors_["1015"].transform.localPosition
				arg_400_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("1015", 4)

				for iter_403_0 = 0, arg_400_1.actors_["1015"].transform.childCount - 1 do
					local var_403_0 = arg_400_1.actors_["1015"].transform:GetChild(iter_403_0)

					if var_403_0.name == "split_1" or not string.find(var_403_0.name, "split") then
						var_403_0.gameObject:SetActive(true)
					else
						var_403_0.gameObject:SetActive(false)
					end
				end
			end

			local var_403_1 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_1 then
				arg_400_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_400_1.time_ - 0) / var_403_1)
			end

			if arg_400_1.time_ >= 0 + var_403_1 and arg_400_1.time_ < 0 + var_403_1 + arg_403_0 then
				arg_400_1.actors_["1015"].transform.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_403_2 = 0
			local var_403_3 = 0.975

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_4 = arg_400_1:GetWordFromCfg(417151099)
				local var_403_5 = arg_400_1:FormatText(var_403_4.content)

				arg_400_1.text_.text = var_403_5

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_7 = 39 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 39)

				if (39 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 39)) > 0 and var_403_3 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_5
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151099", "story_v_out_417151.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_417151", "417151099", "story_v_out_417151.awb") / 1000

					if var_403_8 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_2
					end

					if var_403_4.prefab_name ~= "" and arg_400_1.actors_[var_403_4.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_4.prefab_name].transform, "story_v_out_417151", "417151099", "story_v_out_417151.awb")

						arg_400_1:RecordAudio("417151099", var_403_9)
						arg_400_1:RecordAudio("417151099", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_417151", "417151099", "story_v_out_417151.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_417151", "417151099", "story_v_out_417151.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_10 and arg_400_1.time_ < var_403_2 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play417151100 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 417151100
		arg_404_1.duration_ = 7.53

		local var_404_0 = {
			zh = 7.533,
			ja = 7.433
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play417151101(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.825

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:GetWordFromCfg(417151100)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 33 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 33)

				if (33 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 33)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151100", "story_v_out_417151.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151100", "story_v_out_417151.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_417151", "417151100", "story_v_out_417151.awb")

						arg_404_1:RecordAudio("417151100", var_407_6)
						arg_404_1:RecordAudio("417151100", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_417151", "417151100", "story_v_out_417151.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_417151", "417151100", "story_v_out_417151.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play417151101 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 417151101
		arg_408_1.duration_ = 8.83

		local var_408_0 = {
			zh = 6.7,
			ja = 8.833
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play417151102(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["10128"]) and arg_408_1.var_.actorSpriteComps10128 == nil then
				arg_408_1.var_.actorSpriteComps10128 = arg_408_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_0 = 0.2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["10128"]) then
				if arg_408_1.var_.actorSpriteComps10128 then
					for iter_411_0, iter_411_1 in pairs(arg_408_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_411_1 then
							if arg_408_1.isInRecall_ then
								iter_411_1.color = Color.New(Mathf.Lerp(iter_411_1.color.r, arg_408_1.hightColor1.r, (arg_408_1.time_ - 0) / var_411_0), Mathf.Lerp(iter_411_1.color.g, arg_408_1.hightColor1.g, (arg_408_1.time_ - 0) / var_411_0), (Mathf.Lerp(iter_411_1.color.b, arg_408_1.hightColor1.b, (arg_408_1.time_ - 0) / var_411_0)))
							else
								local var_411_1 = Mathf.Lerp(iter_411_1.color.r, 1, (arg_408_1.time_ - 0) / var_411_0)

								iter_411_1.color = Color.New(var_411_1, var_411_1, var_411_1)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["10128"]) and arg_408_1.var_.actorSpriteComps10128 then
				for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_411_3 then
						iter_411_3.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_408_1.var_.actorSpriteComps10128 = nil
			end

			local var_411_2 = arg_408_1.actors_["1015"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.actorSpriteComps1015 == nil then
				arg_408_1.var_.actorSpriteComps1015 = var_411_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_3 = 0.2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_3 and not isNil(var_411_2) then
				if arg_408_1.var_.actorSpriteComps1015 then
					for iter_411_4, iter_411_5 in pairs(arg_408_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_411_5 then
							if arg_408_1.isInRecall_ then
								iter_411_5.color = Color.New(Mathf.Lerp(iter_411_5.color.r, arg_408_1.hightColor2.r, (arg_408_1.time_ - 0) / var_411_3), Mathf.Lerp(iter_411_5.color.g, arg_408_1.hightColor2.g, (arg_408_1.time_ - 0) / var_411_3), (Mathf.Lerp(iter_411_5.color.b, arg_408_1.hightColor2.b, (arg_408_1.time_ - 0) / var_411_3)))
							else
								local var_411_4 = Mathf.Lerp(iter_411_5.color.r, 0.5, (arg_408_1.time_ - 0) / var_411_3)

								iter_411_5.color = Color.New(var_411_4, var_411_4, var_411_4)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_3 and arg_408_1.time_ < 0 + var_411_3 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.actorSpriteComps1015 then
				for iter_411_6, iter_411_7 in pairs(arg_408_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_411_7 then
						iter_411_7.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_408_1.var_.actorSpriteComps1015 = nil
			end

			local var_411_5 = 0
			local var_411_6 = 0.85

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_7 = arg_408_1:GetWordFromCfg(417151101)
				local var_411_8 = arg_408_1:FormatText(var_411_7.content)

				arg_408_1.text_.text = var_411_8

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_10 = 34 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 34)

				if (34 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 34)) > 0 and var_411_6 < var_411_10 then
					arg_408_1.talkMaxDuration = var_411_10

					if var_411_10 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_5
					end
				end

				arg_408_1.text_.text = var_411_8
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151101", "story_v_out_417151.awb") ~= 0 then
					local var_411_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151101", "story_v_out_417151.awb") / 1000

					if var_411_11 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_11 + var_411_5
					end

					if var_411_7.prefab_name ~= "" and arg_408_1.actors_[var_411_7.prefab_name] ~= nil then
						local var_411_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_7.prefab_name].transform, "story_v_out_417151", "417151101", "story_v_out_417151.awb")

						arg_408_1:RecordAudio("417151101", var_411_12)
						arg_408_1:RecordAudio("417151101", var_411_12)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_417151", "417151101", "story_v_out_417151.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_417151", "417151101", "story_v_out_417151.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_13 = math.max(var_411_6, arg_408_1.talkMaxDuration)

			if var_411_5 <= arg_408_1.time_ and arg_408_1.time_ < var_411_5 + var_411_13 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_5) / var_411_13

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_5 + var_411_13 and arg_408_1.time_ < var_411_5 + var_411_13 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play417151102 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 417151102
		arg_412_1.duration_ = 4.67

		local var_412_0 = {
			zh = 3.666,
			ja = 4.666
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play417151103(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["1015"]) and arg_412_1.var_.actorSpriteComps1015 == nil then
				arg_412_1.var_.actorSpriteComps1015 = arg_412_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_0 = 0.2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["1015"]) then
				if arg_412_1.var_.actorSpriteComps1015 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["1015"]) and arg_412_1.var_.actorSpriteComps1015 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_415_3 then
						iter_415_3.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps1015 = nil
			end

			local var_415_2 = arg_412_1.actors_["10128"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10128 == nil then
				arg_412_1.var_.actorSpriteComps10128 = var_415_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_3 = 0.2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.actorSpriteComps10128 then
					for iter_415_4, iter_415_5 in pairs(arg_412_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_415_5 then
							if arg_412_1.isInRecall_ then
								iter_415_5.color = Color.New(Mathf.Lerp(iter_415_5.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_3), Mathf.Lerp(iter_415_5.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_3), (Mathf.Lerp(iter_415_5.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_3)))
							else
								local var_415_4 = Mathf.Lerp(iter_415_5.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_3)

								iter_415_5.color = Color.New(var_415_4, var_415_4, var_415_4)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10128 then
				for iter_415_6, iter_415_7 in pairs(arg_412_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_415_7 then
						iter_415_7.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10128 = nil
			end

			local var_415_5 = 0
			local var_415_6 = 0.4

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_7 = arg_412_1:GetWordFromCfg(417151102)
				local var_415_8 = arg_412_1:FormatText(var_415_7.content)

				arg_412_1.text_.text = var_415_8

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_10 = 16 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_8) / 16)

				if (16 <= 0 and var_415_6 or var_415_6 * (utf8.len(var_415_8) / 16)) > 0 and var_415_6 < var_415_10 then
					arg_412_1.talkMaxDuration = var_415_10

					if var_415_10 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_5
					end
				end

				arg_412_1.text_.text = var_415_8
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151102", "story_v_out_417151.awb") ~= 0 then
					local var_415_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151102", "story_v_out_417151.awb") / 1000

					if var_415_11 + var_415_5 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_11 + var_415_5
					end

					if var_415_7.prefab_name ~= "" and arg_412_1.actors_[var_415_7.prefab_name] ~= nil then
						local var_415_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_7.prefab_name].transform, "story_v_out_417151", "417151102", "story_v_out_417151.awb")

						arg_412_1:RecordAudio("417151102", var_415_12)
						arg_412_1:RecordAudio("417151102", var_415_12)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_417151", "417151102", "story_v_out_417151.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_417151", "417151102", "story_v_out_417151.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_13 = math.max(var_415_6, arg_412_1.talkMaxDuration)

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_13 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_5) / var_415_13

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_5 + var_415_13 and arg_412_1.time_ < var_415_5 + var_415_13 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play417151103 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 417151103
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play417151104(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["1015"]) and arg_416_1.var_.actorSpriteComps1015 == nil then
				arg_416_1.var_.actorSpriteComps1015 = arg_416_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["1015"]) then
				if arg_416_1.var_.actorSpriteComps1015 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["1015"]) and arg_416_1.var_.actorSpriteComps1015 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_416_1.var_.actorSpriteComps1015 = nil
			end

			local var_419_2 = arg_416_1.actors_["10128"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos10128 = var_419_2.localPosition
				var_419_2.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10128", 7)

				for iter_419_4 = 0, var_419_2.childCount - 1 do
					local var_419_3 = var_419_2:GetChild(iter_419_4)

					if var_419_3.name == "" or not string.find(var_419_3.name, "split") then
						var_419_3.gameObject:SetActive(true)
					else
						var_419_3.gameObject:SetActive(false)
					end
				end
			end

			local var_419_4 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				var_419_2.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_416_1.time_ - 0) / var_419_4)
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				var_419_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_419_5 = arg_416_1.actors_["1015"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1015 = var_419_5.localPosition
				var_419_5.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("1015", 7)

				for iter_419_5 = 0, var_419_5.childCount - 1 do
					local var_419_6 = var_419_5:GetChild(iter_419_5)

					if var_419_6.name == "" or not string.find(var_419_6.name, "split") then
						var_419_6.gameObject:SetActive(true)
					else
						var_419_6.gameObject:SetActive(false)
					end
				end
			end

			local var_419_7 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				var_419_5.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_416_1.time_ - 0) / var_419_7)
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				var_419_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_419_8 = 0
			local var_419_9 = 1.225

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_10 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(417151103).content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_12 = 49 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_10) / 49)

				if (49 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_10) / 49)) > 0 and var_419_9 < var_419_12 then
					arg_416_1.talkMaxDuration = var_419_12

					if var_419_12 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_12 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_10
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_13 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_13 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_13

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_13 and arg_416_1.time_ < var_419_8 + var_419_13 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play417151104 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 417151104
		arg_420_1.duration_ = 3.8

		local var_420_0 = {
			zh = 1.933,
			ja = 3.8
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play417151105(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1015"]) and arg_420_1.var_.actorSpriteComps1015 == nil then
				arg_420_1.var_.actorSpriteComps1015 = arg_420_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_0 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1015"]) then
				if arg_420_1.var_.actorSpriteComps1015 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1015"]) and arg_420_1.var_.actorSpriteComps1015 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_423_3 then
						iter_423_3.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_420_1.var_.actorSpriteComps1015 = nil
			end

			local var_423_2 = arg_420_1.actors_["1015"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1015 = var_423_2.localPosition
				var_423_2.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("1015", 3)

				for iter_423_4 = 0, var_423_2.childCount - 1 do
					local var_423_3 = var_423_2:GetChild(iter_423_4)

					if var_423_3.name == "" or not string.find(var_423_3.name, "split") then
						var_423_3.gameObject:SetActive(true)
					else
						var_423_3.gameObject:SetActive(false)
					end
				end
			end

			local var_423_4 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				var_423_2.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_420_1.time_ - 0) / var_423_4)
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				var_423_2.localPosition = Vector3.New(0, -340, -288)
			end

			local var_423_5 = 0
			local var_423_6 = 0.25

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_7 = arg_420_1:GetWordFromCfg(417151104)
				local var_423_8 = arg_420_1:FormatText(var_423_7.content)

				arg_420_1.text_.text = var_423_8

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_10 = 10 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_8) / 10)

				if (10 <= 0 and var_423_6 or var_423_6 * (utf8.len(var_423_8) / 10)) > 0 and var_423_6 < var_423_10 then
					arg_420_1.talkMaxDuration = var_423_10

					if var_423_10 + var_423_5 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_5
					end
				end

				arg_420_1.text_.text = var_423_8
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151104", "story_v_out_417151.awb") ~= 0 then
					local var_423_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151104", "story_v_out_417151.awb") / 1000

					if var_423_11 + var_423_5 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_11 + var_423_5
					end

					if var_423_7.prefab_name ~= "" and arg_420_1.actors_[var_423_7.prefab_name] ~= nil then
						local var_423_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_7.prefab_name].transform, "story_v_out_417151", "417151104", "story_v_out_417151.awb")

						arg_420_1:RecordAudio("417151104", var_423_12)
						arg_420_1:RecordAudio("417151104", var_423_12)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_417151", "417151104", "story_v_out_417151.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_417151", "417151104", "story_v_out_417151.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_13 = math.max(var_423_6, arg_420_1.talkMaxDuration)

			if var_423_5 <= arg_420_1.time_ and arg_420_1.time_ < var_423_5 + var_423_13 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_5) / var_423_13

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_5 + var_423_13 and arg_420_1.time_ < var_423_5 + var_423_13 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play417151105 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 417151105
		arg_424_1.duration_ = 10.97

		local var_424_0 = {
			zh = 5.7,
			ja = 10.966
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
				arg_424_0:Play417151106(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["10128"]) and arg_424_1.var_.actorSpriteComps10128 == nil then
				arg_424_1.var_.actorSpriteComps10128 = arg_424_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_0 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["10128"]) then
				if arg_424_1.var_.actorSpriteComps10128 then
					for iter_427_0, iter_427_1 in pairs(arg_424_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_427_1 then
							if arg_424_1.isInRecall_ then
								iter_427_1.color = Color.New(Mathf.Lerp(iter_427_1.color.r, arg_424_1.hightColor1.r, (arg_424_1.time_ - 0) / var_427_0), Mathf.Lerp(iter_427_1.color.g, arg_424_1.hightColor1.g, (arg_424_1.time_ - 0) / var_427_0), (Mathf.Lerp(iter_427_1.color.b, arg_424_1.hightColor1.b, (arg_424_1.time_ - 0) / var_427_0)))
							else
								local var_427_1 = Mathf.Lerp(iter_427_1.color.r, 1, (arg_424_1.time_ - 0) / var_427_0)

								iter_427_1.color = Color.New(var_427_1, var_427_1, var_427_1)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["10128"]) and arg_424_1.var_.actorSpriteComps10128 then
				for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_427_3 then
						iter_427_3.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_424_1.var_.actorSpriteComps10128 = nil
			end

			local var_427_2 = arg_424_1.actors_["1015"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps1015 == nil then
				arg_424_1.var_.actorSpriteComps1015 = var_427_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_3 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_3 and not isNil(var_427_2) then
				if arg_424_1.var_.actorSpriteComps1015 then
					for iter_427_4, iter_427_5 in pairs(arg_424_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_427_5 then
							if arg_424_1.isInRecall_ then
								iter_427_5.color = Color.New(Mathf.Lerp(iter_427_5.color.r, arg_424_1.hightColor2.r, (arg_424_1.time_ - 0) / var_427_3), Mathf.Lerp(iter_427_5.color.g, arg_424_1.hightColor2.g, (arg_424_1.time_ - 0) / var_427_3), (Mathf.Lerp(iter_427_5.color.b, arg_424_1.hightColor2.b, (arg_424_1.time_ - 0) / var_427_3)))
							else
								local var_427_4 = Mathf.Lerp(iter_427_5.color.r, 0.5, (arg_424_1.time_ - 0) / var_427_3)

								iter_427_5.color = Color.New(var_427_4, var_427_4, var_427_4)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_3 and arg_424_1.time_ < 0 + var_427_3 + arg_427_0 and not isNil(var_427_2) and arg_424_1.var_.actorSpriteComps1015 then
				for iter_427_6, iter_427_7 in pairs(arg_424_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_427_7 then
						iter_427_7.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_424_1.var_.actorSpriteComps1015 = nil
			end

			local var_427_5 = arg_424_1.actors_["10128"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10128 = var_427_5.localPosition
				var_427_5.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10128", 3)

				for iter_427_8 = 0, var_427_5.childCount - 1 do
					local var_427_6 = var_427_5:GetChild(iter_427_8)

					if var_427_6.name == "" or not string.find(var_427_6.name, "split") then
						var_427_6.gameObject:SetActive(true)
					else
						var_427_6.gameObject:SetActive(false)
					end
				end
			end

			local var_427_7 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				var_427_5.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_424_1.time_ - 0) / var_427_7)
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				var_427_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_427_8 = arg_424_1.actors_["1015"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1015 = var_427_8.localPosition
				var_427_8.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("1015", 7)

				for iter_427_9 = 0, var_427_8.childCount - 1 do
					local var_427_9 = var_427_8:GetChild(iter_427_9)

					if var_427_9.name == "" or not string.find(var_427_9.name, "split") then
						var_427_9.gameObject:SetActive(true)
					else
						var_427_9.gameObject:SetActive(false)
					end
				end
			end

			local var_427_10 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_10 then
				var_427_8.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_424_1.time_ - 0) / var_427_10)
			end

			if arg_424_1.time_ >= 0 + var_427_10 and arg_424_1.time_ < 0 + var_427_10 + arg_427_0 then
				var_427_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_427_11 = 0
			local var_427_12 = 0.6

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_11 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_13 = arg_424_1:GetWordFromCfg(417151105)
				local var_427_14 = arg_424_1:FormatText(var_427_13.content)

				arg_424_1.text_.text = var_427_14

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_16 = 24 <= 0 and var_427_12 or var_427_12 * (utf8.len(var_427_14) / 24)

				if (24 <= 0 and var_427_12 or var_427_12 * (utf8.len(var_427_14) / 24)) > 0 and var_427_12 < var_427_16 then
					arg_424_1.talkMaxDuration = var_427_16

					if var_427_16 + var_427_11 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_16 + var_427_11
					end
				end

				arg_424_1.text_.text = var_427_14
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151105", "story_v_out_417151.awb") ~= 0 then
					local var_427_17 = manager.audio:GetVoiceLength("story_v_out_417151", "417151105", "story_v_out_417151.awb") / 1000

					if var_427_17 + var_427_11 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_17 + var_427_11
					end

					if var_427_13.prefab_name ~= "" and arg_424_1.actors_[var_427_13.prefab_name] ~= nil then
						local var_427_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_13.prefab_name].transform, "story_v_out_417151", "417151105", "story_v_out_417151.awb")

						arg_424_1:RecordAudio("417151105", var_427_18)
						arg_424_1:RecordAudio("417151105", var_427_18)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_417151", "417151105", "story_v_out_417151.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_417151", "417151105", "story_v_out_417151.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_19 = math.max(var_427_12, arg_424_1.talkMaxDuration)

			if var_427_11 <= arg_424_1.time_ and arg_424_1.time_ < var_427_11 + var_427_19 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_11) / var_427_19

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_11 + var_427_19 and arg_424_1.time_ < var_427_11 + var_427_19 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
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
	Play417151106 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 417151106
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play417151107(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["10128"]) and arg_428_1.var_.actorSpriteComps10128 == nil then
				arg_428_1.var_.actorSpriteComps10128 = arg_428_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_0 = 0.2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["10128"]) then
				if arg_428_1.var_.actorSpriteComps10128 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								iter_431_1.color = Color.New(Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor2.r, (arg_428_1.time_ - 0) / var_431_0), Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor2.g, (arg_428_1.time_ - 0) / var_431_0), (Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor2.b, (arg_428_1.time_ - 0) / var_431_0)))
							else
								local var_431_1 = Mathf.Lerp(iter_431_1.color.r, 0.5, (arg_428_1.time_ - 0) / var_431_0)

								iter_431_1.color = Color.New(var_431_1, var_431_1, var_431_1)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["10128"]) and arg_428_1.var_.actorSpriteComps10128 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_431_3 then
						iter_431_3.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_428_1.var_.actorSpriteComps10128 = nil
			end

			local var_431_2 = arg_428_1.actors_["10128"].transform

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos10128 = var_431_2.localPosition
				var_431_2.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10128", 7)

				for iter_431_4 = 0, var_431_2.childCount - 1 do
					local var_431_3 = var_431_2:GetChild(iter_431_4)

					if var_431_3.name == "" or not string.find(var_431_3.name, "split") then
						var_431_3.gameObject:SetActive(true)
					else
						var_431_3.gameObject:SetActive(false)
					end
				end
			end

			local var_431_4 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				var_431_2.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_428_1.time_ - 0) / var_431_4)
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				var_431_2.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.034 < arg_428_1.time_ and arg_428_1.time_ <= 0.034 + arg_431_0 then
				arg_428_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_paper", "")
			end

			local var_431_6 = 0
			local var_431_7 = 0.8

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_8 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(417151106).content)

				arg_428_1.text_.text = var_431_8

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_10 = 32 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_8) / 32)

				if (32 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_8) / 32)) > 0 and var_431_7 < var_431_10 then
					arg_428_1.talkMaxDuration = var_431_10

					if var_431_10 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_8
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_11 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_11 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_11

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_11 and arg_428_1.time_ < var_431_6 + var_431_11 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play417151107 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 417151107
		arg_432_1.duration_ = 9.57

		local var_432_0 = {
			zh = 6.366,
			ja = 9.566
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play417151108(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["10128"]) and arg_432_1.var_.actorSpriteComps10128 == nil then
				arg_432_1.var_.actorSpriteComps10128 = arg_432_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_0 = 0.2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["10128"]) then
				if arg_432_1.var_.actorSpriteComps10128 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								iter_435_1.color = Color.New(Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_0), Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_0), (Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_0)))
							else
								local var_435_1 = Mathf.Lerp(iter_435_1.color.r, 1, (arg_432_1.time_ - 0) / var_435_0)

								iter_435_1.color = Color.New(var_435_1, var_435_1, var_435_1)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["10128"]) and arg_432_1.var_.actorSpriteComps10128 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_435_3 then
						iter_435_3.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10128 = nil
			end

			local var_435_2 = arg_432_1.actors_["10128"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10128 = var_435_2.localPosition
				var_435_2.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10128", 3)

				for iter_435_4 = 0, var_435_2.childCount - 1 do
					local var_435_3 = var_435_2:GetChild(iter_435_4)

					if var_435_3.name == "" or not string.find(var_435_3.name, "split") then
						var_435_3.gameObject:SetActive(true)
					else
						var_435_3.gameObject:SetActive(false)
					end
				end
			end

			local var_435_4 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				var_435_2.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_432_1.time_ - 0) / var_435_4)
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				var_435_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_435_5 = 0
			local var_435_6 = 0.75

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_7 = arg_432_1:GetWordFromCfg(417151107)
				local var_435_8 = arg_432_1:FormatText(var_435_7.content)

				arg_432_1.text_.text = var_435_8

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_10 = 30 <= 0 and var_435_6 or var_435_6 * (utf8.len(var_435_8) / 30)

				if (30 <= 0 and var_435_6 or var_435_6 * (utf8.len(var_435_8) / 30)) > 0 and var_435_6 < var_435_10 then
					arg_432_1.talkMaxDuration = var_435_10

					if var_435_10 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_10 + var_435_5
					end
				end

				arg_432_1.text_.text = var_435_8
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151107", "story_v_out_417151.awb") ~= 0 then
					local var_435_11 = manager.audio:GetVoiceLength("story_v_out_417151", "417151107", "story_v_out_417151.awb") / 1000

					if var_435_11 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_5
					end

					if var_435_7.prefab_name ~= "" and arg_432_1.actors_[var_435_7.prefab_name] ~= nil then
						local var_435_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_7.prefab_name].transform, "story_v_out_417151", "417151107", "story_v_out_417151.awb")

						arg_432_1:RecordAudio("417151107", var_435_12)
						arg_432_1:RecordAudio("417151107", var_435_12)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_417151", "417151107", "story_v_out_417151.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_417151", "417151107", "story_v_out_417151.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_13 = math.max(var_435_6, arg_432_1.talkMaxDuration)

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_13 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_5) / var_435_13

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_5 + var_435_13 and arg_432_1.time_ < var_435_5 + var_435_13 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play417151108 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 417151108
		arg_436_1.duration_ = 11.2

		local var_436_0 = {
			zh = 8.733,
			ja = 11.2
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play417151109(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 1.15

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:GetWordFromCfg(417151108)
				local var_439_2 = arg_436_1:FormatText(var_439_1.content)

				arg_436_1.text_.text = var_439_2

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 46 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 46)

				if (46 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 46)) > 0 and var_439_0 < var_439_4 then
					arg_436_1.talkMaxDuration = var_439_4

					if var_439_4 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_4 + 0
					end
				end

				arg_436_1.text_.text = var_439_2
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151108", "story_v_out_417151.awb") ~= 0 then
					local var_439_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151108", "story_v_out_417151.awb") / 1000

					if var_439_5 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + 0
					end

					if var_439_1.prefab_name ~= "" and arg_436_1.actors_[var_439_1.prefab_name] ~= nil then
						local var_439_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_1.prefab_name].transform, "story_v_out_417151", "417151108", "story_v_out_417151.awb")

						arg_436_1:RecordAudio("417151108", var_439_6)
						arg_436_1:RecordAudio("417151108", var_439_6)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_417151", "417151108", "story_v_out_417151.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_417151", "417151108", "story_v_out_417151.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play417151109 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 417151109
		arg_440_1.duration_ = 4.73

		local var_440_0 = {
			zh = 4.733,
			ja = 3.666
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play417151110(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.6

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_1 = arg_440_1:GetWordFromCfg(417151109)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 24 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 24)

				if (24 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 24)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151109", "story_v_out_417151.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151109", "story_v_out_417151.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_417151", "417151109", "story_v_out_417151.awb")

						arg_440_1:RecordAudio("417151109", var_443_6)
						arg_440_1:RecordAudio("417151109", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_417151", "417151109", "story_v_out_417151.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_417151", "417151109", "story_v_out_417151.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play417151110 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 417151110
		arg_444_1.duration_ = 8.27

		local var_444_0 = {
			zh = 5.2,
			ja = 8.266
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
			arg_444_1.auto_ = false
		end

		function arg_444_1.playNext_(arg_446_0)
			arg_444_1.onStoryFinished_()
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.625

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:GetWordFromCfg(417151110)
				local var_447_2 = arg_444_1:FormatText(var_447_1.content)

				arg_444_1.text_.text = var_447_2

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 25 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 25)

				if (25 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 25)) > 0 and var_447_0 < var_447_4 then
					arg_444_1.talkMaxDuration = var_447_4

					if var_447_4 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_4 + 0
					end
				end

				arg_444_1.text_.text = var_447_2
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417151", "417151110", "story_v_out_417151.awb") ~= 0 then
					local var_447_5 = manager.audio:GetVoiceLength("story_v_out_417151", "417151110", "story_v_out_417151.awb") / 1000

					if var_447_5 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + 0
					end

					if var_447_1.prefab_name ~= "" and arg_444_1.actors_[var_447_1.prefab_name] ~= nil then
						local var_447_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_1.prefab_name].transform, "story_v_out_417151", "417151110", "story_v_out_417151.awb")

						arg_444_1:RecordAudio("417151110", var_447_6)
						arg_444_1:RecordAudio("417151110", var_447_6)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_417151", "417151110", "story_v_out_417151.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_417151", "417151110", "story_v_out_417151.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_7 and arg_444_1.time_ < 0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/ST77b"
	},
	voices = {
		"story_v_out_417151.awb"
	}
}
