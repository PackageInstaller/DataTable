return {
	Play417031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417031001
		arg_1_1.duration_ = 14.03

		local var_1_0 = {
			zh = 11.433,
			ja = 14.033
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST77a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST77a")
				var_4_0.name = "ST77a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST77a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST77a

				arg_1_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST77a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_6 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_6

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_6
						arg_1_1.bgmTxt2_.text = var_4_6
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

			if 0.25 < arg_1_1.time_ and arg_1_1.time_ <= 0.25 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST77a")

				arg_1_1.timestampColorController_:SetSelectedState("hot")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501009).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501010).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_10 + 3 and arg_1_1.time_ < var_4_10 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_11 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 1.2

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				var_4_14.a = 1
				arg_1_1.mask_.color = var_4_14
			end

			local var_4_15 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_16 = 1.2

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_15) / var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_18.a = 0
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_19 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_20 = 1

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_19) / var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_22.a = 0
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_23 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_23 + 3 and arg_1_1.time_ < var_4_23 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 5.4
			local var_4_25 = 0.775

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_27 = arg_1_1:GetWordFromCfg(417031001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 31 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 31)

				if (31 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 31)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031001", "story_v_out_417031.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_417031", "417031001", "story_v_out_417031.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_417031", "417031001", "story_v_out_417031.awb")

						arg_1_1:RecordAudio("417031001", var_4_32)
						arg_1_1:RecordAudio("417031001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417031", "417031001", "story_v_out_417031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417031", "417031001", "story_v_out_417031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417031002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417031002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417031003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["10022"] == nil then
				local var_13_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_13_0) then
					local var_13_1 = Object.Instantiate(var_13_0, arg_10_1.canvasGo_.transform)

					var_13_1.transform:SetSiblingIndex(1)

					var_13_1.name = "10022"
					var_13_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_["10022"] = var_13_1

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs((var_13_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_2 = arg_10_1.actors_["10022"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps10022 == nil then
				arg_10_1.var_.actorSpriteComps10022 = var_13_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_3 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_3 and not isNil(var_13_2) then
				if arg_10_1.var_.actorSpriteComps10022 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								iter_13_3.color = Color.New(Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor2.r, (arg_10_1.time_ - 0) / var_13_3), Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor2.g, (arg_10_1.time_ - 0) / var_13_3), (Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor2.b, (arg_10_1.time_ - 0) / var_13_3)))
							else
								local var_13_4 = Mathf.Lerp(iter_13_3.color.r, 0.5, (arg_10_1.time_ - 0) / var_13_3)

								iter_13_3.color = Color.New(var_13_4, var_13_4, var_13_4)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= 0 + var_13_3 and arg_10_1.time_ < 0 + var_13_3 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps10022 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_13_5 then
						iter_13_5.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_10_1.var_.actorSpriteComps10022 = nil
			end

			if 0.05 < arg_10_1.time_ and arg_10_1.time_ <= 0.05 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_13_6 = 0
			local var_13_7 = 1.25

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_8 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417031002).content)

				arg_10_1.text_.text = var_13_8

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_10 = 50 <= 0 and var_13_7 or var_13_7 * (utf8.len(var_13_8) / 50)

				if (50 <= 0 and var_13_7 or var_13_7 * (utf8.len(var_13_8) / 50)) > 0 and var_13_7 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_6 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_6
					end
				end

				arg_10_1.text_.text = var_13_8
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_11 = math.max(var_13_7, arg_10_1.talkMaxDuration)

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_11 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_6) / var_13_11

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_6 + var_13_11 and arg_10_1.time_ < var_13_6 + var_13_11 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417031003
		arg_14_1.duration_ = 9.1

		local var_14_0 = {
			zh = 6.2,
			ja = 9.1
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
				arg_14_0:Play417031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.825

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:GetWordFromCfg(417031003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 33 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 33)

				if (33 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 33)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031003", "story_v_out_417031.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031003", "story_v_out_417031.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_417031", "417031003", "story_v_out_417031.awb")

						arg_14_1:RecordAudio("417031003", var_17_6)
						arg_14_1:RecordAudio("417031003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417031", "417031003", "story_v_out_417031.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417031", "417031003", "story_v_out_417031.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417031004
		arg_18_1.duration_ = 10.6

		local var_18_0 = {
			zh = 9.4,
			ja = 10.6
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
				arg_18_0:Play417031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.25

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417031004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 50 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 50)

				if (50 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 50)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031004", "story_v_out_417031.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031004", "story_v_out_417031.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417031", "417031004", "story_v_out_417031.awb")

						arg_18_1:RecordAudio("417031004", var_21_6)
						arg_18_1:RecordAudio("417031004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417031", "417031004", "story_v_out_417031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417031", "417031004", "story_v_out_417031.awb")
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
	Play417031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417031005
		arg_22_1.duration_ = 10

		local var_22_0 = {
			zh = 10,
			ja = 9.133
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
				arg_22_0:Play417031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 1.25

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(417031005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 50 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 50)

				if (50 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 50)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031005", "story_v_out_417031.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031005", "story_v_out_417031.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417031", "417031005", "story_v_out_417031.awb")

						arg_22_1:RecordAudio("417031005", var_25_6)
						arg_22_1:RecordAudio("417031005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417031", "417031005", "story_v_out_417031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417031", "417031005", "story_v_out_417031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417031006
		arg_26_1.duration_ = 12.97

		local var_26_0 = {
			zh = 6.366,
			ja = 12.966
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
				arg_26_0:Play417031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.775

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(417031006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 31 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 31)

				if (31 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 31)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031006", "story_v_out_417031.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031006", "story_v_out_417031.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417031", "417031006", "story_v_out_417031.awb")

						arg_26_1:RecordAudio("417031006", var_29_6)
						arg_26_1:RecordAudio("417031006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417031", "417031006", "story_v_out_417031.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417031", "417031006", "story_v_out_417031.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417031007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 1.4 < arg_30_1.time_ and arg_30_1.time_ <= 1.4 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_33_1 = 0
			local var_33_2 = 1.675

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(417031007).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 67 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 67)

				if (67 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 67)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417031008
		arg_34_1.duration_ = 2.97

		local var_34_0 = {
			zh = 1.633,
			ja = 2.966
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
				arg_34_0:Play417031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["1015"] == nil then
				local var_37_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1015")

				if not isNil(var_37_0) then
					local var_37_1 = Object.Instantiate(var_37_0, arg_34_1.canvasGo_.transform)

					var_37_1.transform:SetSiblingIndex(1)

					var_37_1.name = "1015"
					var_37_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_34_1.actors_["1015"] = var_37_1

					if arg_34_1.isInRecall_ then
						for iter_37_0, iter_37_1 in ipairs((var_37_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_37_1.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_37_2 = arg_34_1.actors_["1015"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps1015 == nil then
				arg_34_1.var_.actorSpriteComps1015 = var_37_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_3 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.actorSpriteComps1015 then
					for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_37_3 then
							if arg_34_1.isInRecall_ then
								iter_37_3.color = Color.New(Mathf.Lerp(iter_37_3.color.r, arg_34_1.hightColor1.r, (arg_34_1.time_ - 0) / var_37_3), Mathf.Lerp(iter_37_3.color.g, arg_34_1.hightColor1.g, (arg_34_1.time_ - 0) / var_37_3), (Mathf.Lerp(iter_37_3.color.b, arg_34_1.hightColor1.b, (arg_34_1.time_ - 0) / var_37_3)))
							else
								local var_37_4 = Mathf.Lerp(iter_37_3.color.r, 1, (arg_34_1.time_ - 0) / var_37_3)

								iter_37_3.color = Color.New(var_37_4, var_37_4, var_37_4)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps1015 then
				for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_37_5 then
						iter_37_5.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps1015 = nil
			end

			local var_37_5 = arg_34_1.actors_["1015"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1015 = var_37_5.localPosition
				var_37_5.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1015", 3)

				for iter_37_6 = 0, var_37_5.childCount - 1 do
					local var_37_6 = var_37_5:GetChild(iter_37_6)

					if var_37_6.name == "" or not string.find(var_37_6.name, "split") then
						var_37_6.gameObject:SetActive(true)
					else
						var_37_6.gameObject:SetActive(false)
					end
				end
			end

			local var_37_7 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_34_1.time_ - 0) / var_37_7)
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(0, -340, -288)
			end

			local var_37_8 = 0
			local var_37_9 = 0.175

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_10 = arg_34_1:GetWordFromCfg(417031008)
				local var_37_11 = arg_34_1:FormatText(var_37_10.content)

				arg_34_1.text_.text = var_37_11

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 7 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 7)

				if (7 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 7)) > 0 and var_37_9 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_11
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031008", "story_v_out_417031.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031008", "story_v_out_417031.awb") / 1000

					if var_37_14 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_8
					end

					if var_37_10.prefab_name ~= "" and arg_34_1.actors_[var_37_10.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_10.prefab_name].transform, "story_v_out_417031", "417031008", "story_v_out_417031.awb")

						arg_34_1:RecordAudio("417031008", var_37_15)
						arg_34_1:RecordAudio("417031008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417031", "417031008", "story_v_out_417031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417031", "417031008", "story_v_out_417031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_16 and arg_34_1.time_ < var_37_8 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417031009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1015"]) and arg_38_1.var_.actorSpriteComps1015 == nil then
				arg_38_1.var_.actorSpriteComps1015 = arg_38_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1015"]) then
				if arg_38_1.var_.actorSpriteComps1015 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1015"]) and arg_38_1.var_.actorSpriteComps1015 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps1015 = nil
			end

			if 0.05 < arg_38_1.time_ and arg_38_1.time_ <= 0.05 + arg_41_0 then
				arg_38_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_hit", "")
			end

			local var_41_3 = 0
			local var_41_4 = 0.75

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_5 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(417031009).content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 30 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 30)

				if (30 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 30)) > 0 and var_41_4 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_3
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_8 = math.max(var_41_4, arg_38_1.talkMaxDuration)

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_8 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_3) / var_41_8

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_3 + var_41_8 and arg_38_1.time_ < var_41_3 + var_41_8 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417031010
		arg_42_1.duration_ = 2.53

		local var_42_0 = {
			zh = 2.533,
			ja = 1.733
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
				arg_42_0:Play417031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1015"]) and arg_42_1.var_.actorSpriteComps1015 == nil then
				arg_42_1.var_.actorSpriteComps1015 = arg_42_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1015"]) then
				if arg_42_1.var_.actorSpriteComps1015 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1015"]) and arg_42_1.var_.actorSpriteComps1015 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps1015 = nil
			end

			local var_45_2 = arg_42_1.actors_["1015"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1015 = var_45_2.localPosition
				var_45_2.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1015", 3)

				for iter_45_4 = 0, var_45_2.childCount - 1 do
					local var_45_3 = var_45_2:GetChild(iter_45_4)

					if var_45_3.name == "split_5" or not string.find(var_45_3.name, "split") then
						var_45_3.gameObject:SetActive(true)
					else
						var_45_3.gameObject:SetActive(false)
					end
				end
			end

			local var_45_4 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				var_45_2.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_42_1.time_ - 0) / var_45_4)
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				var_45_2.localPosition = Vector3.New(0, -340, -288)
			end

			local var_45_5 = 0
			local var_45_6 = 0.2

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(417031010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 8 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 8)

				if (8 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 8)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031010", "story_v_out_417031.awb") ~= 0 then
					local var_45_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031010", "story_v_out_417031.awb") / 1000

					if var_45_11 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_5
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_out_417031", "417031010", "story_v_out_417031.awb")

						arg_42_1:RecordAudio("417031010", var_45_12)
						arg_42_1:RecordAudio("417031010", var_45_12)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417031", "417031010", "story_v_out_417031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417031", "417031010", "story_v_out_417031.awb")
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
				actorName = "1015",
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
	Play417031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417031011
		arg_46_1.duration_ = 4.63

		local var_46_0 = {
			zh = 1.766,
			ja = 4.633
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["1034"] == nil then
				local var_49_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_49_0) then
					local var_49_1 = Object.Instantiate(var_49_0, arg_46_1.canvasGo_.transform)

					var_49_1.transform:SetSiblingIndex(1)

					var_49_1.name = "1034"
					var_49_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_["1034"] = var_49_1

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs((var_49_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_2 = arg_46_1.actors_["1034"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = var_49_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_3 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								iter_49_3.color = Color.New(Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_3), Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_3), (Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_3)))
							else
								local var_49_4 = Mathf.Lerp(iter_49_3.color.r, 1, (arg_46_1.time_ - 0) / var_49_3)

								iter_49_3.color = Color.New(var_49_4, var_49_4, var_49_4)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_5 then
						iter_49_5.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_5 = arg_46_1.actors_["1015"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.actorSpriteComps1015 == nil then
				arg_46_1.var_.actorSpriteComps1015 = var_49_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_6 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_6 and not isNil(var_49_5) then
				if arg_46_1.var_.actorSpriteComps1015 then
					for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_49_7 then
							if arg_46_1.isInRecall_ then
								iter_49_7.color = Color.New(Mathf.Lerp(iter_49_7.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_6), Mathf.Lerp(iter_49_7.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_6), (Mathf.Lerp(iter_49_7.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_6)))
							else
								local var_49_7 = Mathf.Lerp(iter_49_7.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_6)

								iter_49_7.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_6 and arg_46_1.time_ < 0 + var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.actorSpriteComps1015 then
				for iter_49_8, iter_49_9 in pairs(arg_46_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_49_9 then
						iter_49_9.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps1015 = nil
			end

			local var_49_8 = arg_46_1.actors_["1015"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1015 = var_49_8.localPosition
				var_49_8.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1015", 7)

				for iter_49_10 = 0, var_49_8.childCount - 1 do
					local var_49_9 = var_49_8:GetChild(iter_49_10)

					if var_49_9.name == "" or not string.find(var_49_9.name, "split") then
						var_49_9.gameObject:SetActive(true)
					else
						var_49_9.gameObject:SetActive(false)
					end
				end
			end

			local var_49_10 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_10 then
				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_46_1.time_ - 0) / var_49_10)
			end

			if arg_46_1.time_ >= 0 + var_49_10 and arg_46_1.time_ < 0 + var_49_10 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_11 = arg_46_1.actors_["1034"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1034 = var_49_11.localPosition
				var_49_11.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1034", 3)

				for iter_49_11 = 0, var_49_11.childCount - 1 do
					local var_49_12 = var_49_11:GetChild(iter_49_11)

					if var_49_12.name == "split_6" or not string.find(var_49_12.name, "split") then
						var_49_12.gameObject:SetActive(true)
					else
						var_49_12.gameObject:SetActive(false)
					end
				end
			end

			local var_49_13 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_13 then
				var_49_11.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_46_1.time_ - 0) / var_49_13)
			end

			if arg_46_1.time_ >= 0 + var_49_13 and arg_46_1.time_ < 0 + var_49_13 + arg_49_0 then
				var_49_11.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_49_14 = 0
			local var_49_15 = 0.2

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_14 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_16 = arg_46_1:GetWordFromCfg(417031011)
				local var_49_17 = arg_46_1:FormatText(var_49_16.content)

				arg_46_1.text_.text = var_49_17

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_19 = 8 <= 0 and var_49_15 or var_49_15 * (utf8.len(var_49_17) / 8)

				if (8 <= 0 and var_49_15 or var_49_15 * (utf8.len(var_49_17) / 8)) > 0 and var_49_15 < var_49_19 then
					arg_46_1.talkMaxDuration = var_49_19

					if var_49_19 + var_49_14 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_19 + var_49_14
					end
				end

				arg_46_1.text_.text = var_49_17
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031011", "story_v_out_417031.awb") ~= 0 then
					local var_49_20 = manager.audio:GetVoiceLength("story_v_out_417031", "417031011", "story_v_out_417031.awb") / 1000

					if var_49_20 + var_49_14 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_14
					end

					if var_49_16.prefab_name ~= "" and arg_46_1.actors_[var_49_16.prefab_name] ~= nil then
						local var_49_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_16.prefab_name].transform, "story_v_out_417031", "417031011", "story_v_out_417031.awb")

						arg_46_1:RecordAudio("417031011", var_49_21)
						arg_46_1:RecordAudio("417031011", var_49_21)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417031", "417031011", "story_v_out_417031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417031", "417031011", "story_v_out_417031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_22 = math.max(var_49_15, arg_46_1.talkMaxDuration)

			if var_49_14 <= arg_46_1.time_ and arg_46_1.time_ < var_49_14 + var_49_22 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_14) / var_49_22

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_14 + var_49_22 and arg_46_1.time_ < var_49_14 + var_49_22 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play417031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417031012
		arg_50_1.duration_ = 4.8

		local var_50_0 = {
			zh = 4.8,
			ja = 4.133
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
				arg_50_0:Play417031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1015"]) and arg_50_1.var_.actorSpriteComps1015 == nil then
				arg_50_1.var_.actorSpriteComps1015 = arg_50_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1015"]) then
				if arg_50_1.var_.actorSpriteComps1015 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1015"]) and arg_50_1.var_.actorSpriteComps1015 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps1015 = nil
			end

			local var_53_2 = arg_50_1.actors_["1034"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps1034 == nil then
				arg_50_1.var_.actorSpriteComps1034 = var_53_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_3 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.actorSpriteComps1034 then
					for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_53_5 then
							if arg_50_1.isInRecall_ then
								iter_53_5.color = Color.New(Mathf.Lerp(iter_53_5.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_3), Mathf.Lerp(iter_53_5.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_3), (Mathf.Lerp(iter_53_5.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_3)))
							else
								local var_53_4 = Mathf.Lerp(iter_53_5.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_3)

								iter_53_5.color = Color.New(var_53_4, var_53_4, var_53_4)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps1034 then
				for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_53_7 then
						iter_53_7.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps1034 = nil
			end

			local var_53_5 = arg_50_1.actors_["1034"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_5.localPosition
				var_53_5.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 4)

				for iter_53_8 = 0, var_53_5.childCount - 1 do
					local var_53_6 = var_53_5:GetChild(iter_53_8)

					if var_53_6.name == "split_6" or not string.find(var_53_6.name, "split") then
						var_53_6.gameObject:SetActive(true)
					else
						var_53_6.gameObject:SetActive(false)
					end
				end
			end

			local var_53_7 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_50_1.time_ - 0) / var_53_7)
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_53_8 = arg_50_1.actors_["1015"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1015 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1015", 2)

				for iter_53_9 = 0, var_53_8.childCount - 1 do
					local var_53_9 = var_53_8:GetChild(iter_53_9)

					if var_53_9.name == "split_4" or not string.find(var_53_9.name, "split") then
						var_53_9.gameObject:SetActive(true)
					else
						var_53_9.gameObject:SetActive(false)
					end
				end
			end

			local var_53_10 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_10 then
				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_50_1.time_ - 0) / var_53_10)
			end

			if arg_50_1.time_ >= 0 + var_53_10 and arg_50_1.time_ < 0 + var_53_10 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_53_11 = 0
			local var_53_12 = 0.675

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_13 = arg_50_1:GetWordFromCfg(417031012)
				local var_53_14 = arg_50_1:FormatText(var_53_13.content)

				arg_50_1.text_.text = var_53_14

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_16 = 27 <= 0 and var_53_12 or var_53_12 * (utf8.len(var_53_14) / 27)

				if (27 <= 0 and var_53_12 or var_53_12 * (utf8.len(var_53_14) / 27)) > 0 and var_53_12 < var_53_16 then
					arg_50_1.talkMaxDuration = var_53_16

					if var_53_16 + var_53_11 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_11
					end
				end

				arg_50_1.text_.text = var_53_14
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031012", "story_v_out_417031.awb") ~= 0 then
					local var_53_17 = manager.audio:GetVoiceLength("story_v_out_417031", "417031012", "story_v_out_417031.awb") / 1000

					if var_53_17 + var_53_11 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_17 + var_53_11
					end

					if var_53_13.prefab_name ~= "" and arg_50_1.actors_[var_53_13.prefab_name] ~= nil then
						local var_53_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_13.prefab_name].transform, "story_v_out_417031", "417031012", "story_v_out_417031.awb")

						arg_50_1:RecordAudio("417031012", var_53_18)
						arg_50_1:RecordAudio("417031012", var_53_18)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417031", "417031012", "story_v_out_417031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417031", "417031012", "story_v_out_417031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_19 = math.max(var_53_12, arg_50_1.talkMaxDuration)

			if var_53_11 <= arg_50_1.time_ and arg_50_1.time_ < var_53_11 + var_53_19 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_11) / var_53_19

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_11 + var_53_19 and arg_50_1.time_ < var_53_11 + var_53_19 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "1015",
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
	Play417031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417031013
		arg_54_1.duration_ = 8.8

		local var_54_0 = {
			zh = 6.133,
			ja = 8.8
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
				arg_54_0:Play417031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1034"]) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = arg_54_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1034"]) then
				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1034"]) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_2 = arg_54_1.actors_["1015"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps1015 == nil then
				arg_54_1.var_.actorSpriteComps1015 = var_57_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_3 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.actorSpriteComps1015 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_57_5 then
							if arg_54_1.isInRecall_ then
								iter_57_5.color = Color.New(Mathf.Lerp(iter_57_5.color.r, arg_54_1.hightColor2.r, (arg_54_1.time_ - 0) / var_57_3), Mathf.Lerp(iter_57_5.color.g, arg_54_1.hightColor2.g, (arg_54_1.time_ - 0) / var_57_3), (Mathf.Lerp(iter_57_5.color.b, arg_54_1.hightColor2.b, (arg_54_1.time_ - 0) / var_57_3)))
							else
								local var_57_4 = Mathf.Lerp(iter_57_5.color.r, 0.5, (arg_54_1.time_ - 0) / var_57_3)

								iter_57_5.color = Color.New(var_57_4, var_57_4, var_57_4)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps1015 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_57_7 then
						iter_57_7.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps1015 = nil
			end

			local var_57_5 = 0
			local var_57_6 = 0.775

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(417031013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 31 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 31)

				if (31 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 31)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031013", "story_v_out_417031.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031013", "story_v_out_417031.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_417031", "417031013", "story_v_out_417031.awb")

						arg_54_1:RecordAudio("417031013", var_57_12)
						arg_54_1:RecordAudio("417031013", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417031", "417031013", "story_v_out_417031.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417031", "417031013", "story_v_out_417031.awb")
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

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417031014
		arg_58_1.duration_ = 7.83

		local var_58_0 = {
			zh = 7.7,
			ja = 7.833
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
				arg_58_0:Play417031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.95

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:GetWordFromCfg(417031014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 38 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 38)

				if (38 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 38)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031014", "story_v_out_417031.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031014", "story_v_out_417031.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_417031", "417031014", "story_v_out_417031.awb")

						arg_58_1:RecordAudio("417031014", var_61_6)
						arg_58_1:RecordAudio("417031014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417031", "417031014", "story_v_out_417031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417031", "417031014", "story_v_out_417031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417031015
		arg_62_1.duration_ = 11.4

		local var_62_0 = {
			zh = 6.833,
			ja = 11.4
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
				arg_62_0:Play417031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1034 = arg_62_1.actors_["1034"].transform.localPosition
				arg_62_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1034", 4)

				for iter_65_0 = 0, arg_62_1.actors_["1034"].transform.childCount - 1 do
					local var_65_0 = arg_62_1.actors_["1034"].transform:GetChild(iter_65_0)

					if var_65_0.name == "split_6" or not string.find(var_65_0.name, "split") then
						var_65_0.gameObject:SetActive(true)
					else
						var_65_0.gameObject:SetActive(false)
					end
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_62_1.time_ - 0) / var_65_1)
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["1034"].transform.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_65_2 = 0
			local var_65_3 = 0.725

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(417031015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 29 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 29)

				if (29 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 29)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031015", "story_v_out_417031.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031015", "story_v_out_417031.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_417031", "417031015", "story_v_out_417031.awb")

						arg_62_1:RecordAudio("417031015", var_65_9)
						arg_62_1:RecordAudio("417031015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417031", "417031015", "story_v_out_417031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417031", "417031015", "story_v_out_417031.awb")
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

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play417031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417031016
		arg_66_1.duration_ = 3.8

		local var_66_0 = {
			zh = 3.8,
			ja = 3
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
				arg_66_0:Play417031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1015"]) and arg_66_1.var_.actorSpriteComps1015 == nil then
				arg_66_1.var_.actorSpriteComps1015 = arg_66_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1015"]) then
				if arg_66_1.var_.actorSpriteComps1015 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 1, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1015"]) and arg_66_1.var_.actorSpriteComps1015 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps1015 = nil
			end

			local var_69_2 = arg_66_1.actors_["1034"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = var_69_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_3 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								iter_69_5.color = Color.New(Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_3), Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_3), (Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_3)))
							else
								local var_69_4 = Mathf.Lerp(iter_69_5.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_3)

								iter_69_5.color = Color.New(var_69_4, var_69_4, var_69_4)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_7 then
						iter_69_7.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_5 = arg_66_1.actors_["1015"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1015 = var_69_5.localPosition
				var_69_5.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1015", 2)

				for iter_69_8 = 0, var_69_5.childCount - 1 do
					local var_69_6 = var_69_5:GetChild(iter_69_8)

					if var_69_6.name == "" or not string.find(var_69_6.name, "split") then
						var_69_6.gameObject:SetActive(true)
					else
						var_69_6.gameObject:SetActive(false)
					end
				end
			end

			local var_69_7 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				var_69_5.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_66_1.time_ - 0) / var_69_7)
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				var_69_5.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_69_8 = 0
			local var_69_9 = 0.45

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_10 = arg_66_1:GetWordFromCfg(417031016)
				local var_69_11 = arg_66_1:FormatText(var_69_10.content)

				arg_66_1.text_.text = var_69_11

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 18 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_11) / 18)

				if (18 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_11) / 18)) > 0 and var_69_9 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_11
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031016", "story_v_out_417031.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031016", "story_v_out_417031.awb") / 1000

					if var_69_14 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_8
					end

					if var_69_10.prefab_name ~= "" and arg_66_1.actors_[var_69_10.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_10.prefab_name].transform, "story_v_out_417031", "417031016", "story_v_out_417031.awb")

						arg_66_1:RecordAudio("417031016", var_69_15)
						arg_66_1:RecordAudio("417031016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417031", "417031016", "story_v_out_417031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417031", "417031016", "story_v_out_417031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_16 and arg_66_1.time_ < var_69_8 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play417031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417031017
		arg_70_1.duration_ = 2.57

		local var_70_0 = {
			zh = 1.633,
			ja = 2.566
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
				arg_70_0:Play417031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1034"]) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = arg_70_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1034"]) then
				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1034"]) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			local var_73_2 = arg_70_1.actors_["1015"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps1015 == nil then
				arg_70_1.var_.actorSpriteComps1015 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps1015 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_5.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_5.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps1015 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps1015 = nil
			end

			local var_73_5 = 0
			local var_73_6 = 0.15

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(417031017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 6 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 6)

				if (6 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 6)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031017", "story_v_out_417031.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031017", "story_v_out_417031.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_417031", "417031017", "story_v_out_417031.awb")

						arg_70_1:RecordAudio("417031017", var_73_12)
						arg_70_1:RecordAudio("417031017", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417031", "417031017", "story_v_out_417031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417031", "417031017", "story_v_out_417031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_5) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_5 + var_73_13 and arg_70_1.time_ < var_73_5 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417031018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1034"]) and arg_74_1.var_.actorSpriteComps1034 == nil then
				arg_74_1.var_.actorSpriteComps1034 = arg_74_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1034"]) then
				if arg_74_1.var_.actorSpriteComps1034 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1034"]) and arg_74_1.var_.actorSpriteComps1034 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			if 0.01 < arg_74_1.time_ and arg_74_1.time_ <= 0.01 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_pad", "")
			end

			local var_77_3 = 0
			local var_77_4 = 1.575

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_5 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(417031018).content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 63 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 63)

				if (63 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 63)) > 0 and var_77_4 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_3 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_3
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_4, arg_74_1.talkMaxDuration)

			if var_77_3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_3 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_3) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_3 + var_77_8 and arg_74_1.time_ < var_77_3 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417031019
		arg_78_1.duration_ = 10.8

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 1.266 < arg_78_1.time_ and arg_78_1.time_ <= 1.266 + arg_81_0 then
				arg_78_1.var_.moveOldPos1015 = arg_78_1.actors_["1015"].transform.localPosition
				arg_78_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1015", 7)

				for iter_81_0 = 0, arg_78_1.actors_["1015"].transform.childCount - 1 do
					local var_81_0 = arg_78_1.actors_["1015"].transform:GetChild(iter_81_0)

					if var_81_0.name == "" or not string.find(var_81_0.name, "split") then
						var_81_0.gameObject:SetActive(true)
					else
						var_81_0.gameObject:SetActive(false)
					end
				end
			end

			local var_81_1 = 0.001

			if 1.266 <= arg_78_1.time_ and arg_78_1.time_ < 1.266 + var_81_1 then
				arg_78_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_78_1.time_ - 1.266) / var_81_1)
			end

			if arg_78_1.time_ >= 1.266 + var_81_1 and arg_78_1.time_ < 1.266 + var_81_1 + arg_81_0 then
				arg_78_1.actors_["1015"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_2 = arg_78_1.actors_["1034"].transform

			if 1.266 < arg_78_1.time_ and arg_78_1.time_ <= 1.266 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 7)

				for iter_81_1 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_1)

					if var_81_3.name == "" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if 1.266 <= arg_78_1.time_ and arg_78_1.time_ < 1.266 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_78_1.time_ - 1.266) / var_81_4)
			end

			if arg_78_1.time_ >= 1.266 + var_81_4 and arg_78_1.time_ < 1.266 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.3 < arg_78_1.time_ and arg_78_1.time_ <= 1.3 + arg_81_0 then
				arg_78_1.cswbg_:SetActive(true)

				local var_81_5 = arg_78_1.cswt_:GetComponent("RectTransform")

				arg_78_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_81_5.offsetMin = Vector2.New(400, 105)
				var_81_5.offsetMax = Vector2.New(-400, -200)
				arg_78_1.cswt_.text = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(419094).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.cswt_)

				arg_78_1.cswt_.fontSize = 92
				arg_78_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_78_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.3 < arg_78_1.time_ and arg_78_1.time_ <= 1.3 + arg_81_0 then
				local var_81_6 = arg_78_1.fswbg_.transform:Find("textbox/adapt/content") or arg_78_1.fswbg_.transform:Find("textbox/content")
				local var_81_7 = arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_81_8 = var_81_6:GetComponent("RectTransform")

				var_81_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_81_8.offsetMin = Vector2.New(0, 0)
				var_81_8.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_78_1.time_ and arg_78_1.time_ <= 1.3 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(true)
				arg_78_1.dialog_:SetActive(false)

				arg_78_1.fswtw_.percent = 0
				arg_78_1.fswt_.text = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(417031019).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.fswt_)

				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_78_1.fswtw_:SetDirty()

				arg_78_1.typewritterCharCountI18N = 0

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_9 = 2.3

			if 2.3 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_10 = 43
			local var_81_11 = 2.86666666666667
			local var_81_12, var_81_13 = arg_78_1:GetPercentByPara(arg_78_1:FormatText(arg_78_1:GetWordFromCfg(417031019).content), 1)

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_14 = var_81_10 <= 0 and var_81_11 or var_81_11 * ((var_81_13 - arg_78_1.typewritterCharCountI18N) / var_81_10)

				if (var_81_10 <= 0 and var_81_11 or var_81_11 * ((var_81_13 - arg_78_1.typewritterCharCountI18N) / var_81_10)) > 0 and var_81_11 < var_81_14 then
					arg_78_1.talkMaxDuration = var_81_14

					if var_81_14 + var_81_9 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_9
					end
				end
			end

			local var_81_15 = math.max(2.86666666666667, arg_78_1.talkMaxDuration)

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_15 then
				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_12, (arg_78_1.time_ - var_81_9) / var_81_15)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= var_81_9 + var_81_15 and arg_78_1.time_ < var_81_9 + var_81_15 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_12

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_13
			end

			local var_81_16 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_17 = 1.3

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_17 then
				local var_81_18 = Color.New(0, 0, 0)

				var_81_18.a = Mathf.Lerp(0, 1, (arg_78_1.time_ - var_81_16) / var_81_17)
				arg_78_1.mask_.color = var_81_18
			end

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 then
				local var_81_19 = Color.New(0, 0, 0)

				var_81_19.a = 1
				arg_78_1.mask_.color = var_81_19
			end

			local var_81_20 = 1.3

			if 1.3 < arg_78_1.time_ and arg_78_1.time_ <= var_81_20 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_21 = 2

			if var_81_20 <= arg_78_1.time_ and arg_78_1.time_ < var_81_20 + var_81_21 then
				local var_81_22 = Color.New(0, 0, 0)

				var_81_22.a = Mathf.Lerp(1, 0, (arg_78_1.time_ - var_81_20) / var_81_21)
				arg_78_1.mask_.color = var_81_22
			end

			if arg_78_1.time_ >= var_81_20 + var_81_21 and arg_78_1.time_ < var_81_20 + var_81_21 + arg_81_0 then
				local var_81_23 = Color.New(0, 0, 0)

				arg_78_1.mask_.enabled = false
				var_81_23.a = 0
				arg_78_1.mask_.color = var_81_23
			end

			local var_81_24 = "STblack"

			if arg_78_1.bgs_.STblack == nil then
				local var_81_25 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_24)
				var_81_25.name = var_81_24
				var_81_25.transform.parent = arg_78_1.stage_.transform
				var_81_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_24] = var_81_25
			end

			if 1.3 < arg_78_1.time_ and arg_78_1.time_ <= 1.3 + arg_81_0 then
				local var_81_26 = arg_78_1.bgs_.STblack

				arg_78_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_27 = var_81_26:GetComponent("SpriteRenderer")

				if var_81_27 and var_81_27.sprite then
					local var_81_28 = 2 * (var_81_26.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_26.transform.localScale = Vector3.New(var_81_28 / var_81_27.sprite.bounds.size.y < var_81_28 * manager.ui.mainCameraCom_.aspect / var_81_27.sprite.bounds.size.x and var_81_28 * manager.ui.mainCameraCom_.aspect / var_81_27.sprite.bounds.size.x or var_81_28 / var_81_27.sprite.bounds.size.y, var_81_28 / var_81_27.sprite.bounds.size.y < var_81_28 * manager.ui.mainCameraCom_.aspect / var_81_27.sprite.bounds.size.x and var_81_28 * manager.ui.mainCameraCom_.aspect / var_81_27.sprite.bounds.size.x or var_81_28 / var_81_27.sprite.bounds.size.y, 0)
				end

				for iter_81_2, iter_81_3 in pairs(arg_78_1.bgs_) do
					if iter_81_2 ~= "STblack" then
						iter_81_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_29 = 2.3
			local var_81_30 = manager.audio:GetVoiceLength("story_v_out_417031", "417031019", "") / 1000

			if var_81_30 > 0 and 8.5 < var_81_30 and var_81_30 + var_81_29 > arg_78_1.duration_ then
				arg_78_1.duration_ = var_81_30 + var_81_29
			end

			if var_81_29 < arg_78_1.time_ and arg_78_1.time_ <= var_81_29 + arg_81_0 then
				arg_78_1:AudioAction("play", "voice", "story_v_out_417031", "417031019", "")
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play417031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417031020
		arg_82_1.duration_ = 10.37

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.fswbg_:SetActive(true)
				arg_82_1.dialog_:SetActive(false)

				arg_82_1.fswtw_.percent = 0
				arg_82_1.fswt_.text = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(417031020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.fswt_)

				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_82_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_82_1.fswtw_:SetDirty()

				arg_82_1.typewritterCharCountI18N = 0

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_0 = 0.566666666666667

			if 0.566666666666667 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.var_.oldValueTypewriter = arg_82_1.fswtw_.percent

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_1 = 49
			local var_85_2 = 3.33333333333333
			local var_85_3, var_85_4 = arg_82_1:GetPercentByPara(arg_82_1:FormatText(arg_82_1:GetWordFromCfg(417031020).content), 1)

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				local var_85_5 = var_85_1 <= 0 and var_85_2 or var_85_2 * ((var_85_4 - arg_82_1.typewritterCharCountI18N) / var_85_1)

				if (var_85_1 <= 0 and var_85_2 or var_85_2 * ((var_85_4 - arg_82_1.typewritterCharCountI18N) / var_85_1)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end
			end

			local var_85_6 = math.max(3.33333333333333, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_6 then
				arg_82_1.fswtw_.percent = Mathf.Lerp(arg_82_1.var_.oldValueTypewriter, var_85_3, (arg_82_1.time_ - var_85_0) / var_85_6)
				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_82_1.fswtw_:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_6 and arg_82_1.time_ < var_85_0 + var_85_6 + arg_85_0 then
				arg_82_1.fswtw_.percent = var_85_3

				arg_82_1.fswtw_:SetDirty()
				arg_82_1:ShowNextGo(true)

				arg_82_1.typewritterCharCountI18N = var_85_4
			end

			local var_85_7 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_7 + 0.566666666666667 and arg_82_1.time_ < var_85_7 + 0.566666666666667 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_8 = 0.566666666666667
			local var_85_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031020", "") / 1000

			if var_85_9 > 0 and 9.8 < var_85_9 and var_85_9 + var_85_8 > arg_82_1.duration_ then
				arg_82_1.duration_ = var_85_9 + var_85_8
			end

			if var_85_8 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1:AudioAction("play", "voice", "story_v_out_417031", "417031020", "")
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417031021
		arg_86_1.duration_ = 12.2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.fswbg_:SetActive(true)
				arg_86_1.dialog_:SetActive(false)

				arg_86_1.fswtw_.percent = 0
				arg_86_1.fswt_.text = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(417031021).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.fswt_)

				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_86_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_86_1.fswtw_:SetDirty()

				arg_86_1.typewritterCharCountI18N = 0

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_0 = 0.566666666666667

			if 0.566666666666667 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.var_.oldValueTypewriter = arg_86_1.fswtw_.percent

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_1 = 53
			local var_89_2 = 3.53333333333333
			local var_89_3, var_89_4 = arg_86_1:GetPercentByPara(arg_86_1:FormatText(arg_86_1:GetWordFromCfg(417031021).content), 1)

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				local var_89_5 = var_89_1 <= 0 and var_89_2 or var_89_2 * ((var_89_4 - arg_86_1.typewritterCharCountI18N) / var_89_1)

				if (var_89_1 <= 0 and var_89_2 or var_89_2 * ((var_89_4 - arg_86_1.typewritterCharCountI18N) / var_89_1)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_0
					end
				end
			end

			local var_89_6 = math.max(3.53333333333333, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_6 then
				arg_86_1.fswtw_.percent = Mathf.Lerp(arg_86_1.var_.oldValueTypewriter, var_89_3, (arg_86_1.time_ - var_89_0) / var_89_6)
				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_86_1.fswtw_:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_6 and arg_86_1.time_ < var_89_0 + var_89_6 + arg_89_0 then
				arg_86_1.fswtw_.percent = var_89_3

				arg_86_1.fswtw_:SetDirty()
				arg_86_1:ShowNextGo(true)

				arg_86_1.typewritterCharCountI18N = var_89_4
			end

			local var_89_7 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			if arg_86_1.time_ >= var_89_7 + 0.566666666666667 and arg_86_1.time_ < var_89_7 + 0.566666666666667 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_8 = 0.566666666666667
			local var_89_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031021", "") / 1000

			if var_89_9 > 0 and 11.633 < var_89_9 and var_89_9 + var_89_8 > arg_86_1.duration_ then
				arg_86_1.duration_ = var_89_9 + var_89_8
			end

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1:AudioAction("play", "voice", "story_v_out_417031", "417031021", "")
			end

			local var_89_11 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			if arg_86_1.time_ >= var_89_11 + 0.566666666666667 and arg_86_1.time_ < var_89_11 + 0.566666666666667 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417031022
		arg_90_1.duration_ = 5.97

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.cswbg_:SetActive(true)

				local var_93_0 = arg_90_1.cswt_:GetComponent("RectTransform")

				arg_90_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_93_0.offsetMin = Vector2.New(400, 105)
				var_93_0.offsetMax = Vector2.New(-400, -200)
				arg_90_1.cswt_.text = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(419095).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.cswt_)

				arg_90_1.cswt_.fontSize = 105
				arg_90_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_90_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 8.88178419700125e-16 < arg_90_1.time_ and arg_90_1.time_ <= 8.88178419700125e-16 + arg_93_0 then
				local var_93_1 = arg_90_1.fswbg_.transform:Find("textbox/adapt/content") or arg_90_1.fswbg_.transform:Find("textbox/content")
				local var_93_2 = arg_90_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_93_3 = var_93_1:GetComponent("RectTransform")

				var_93_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_93_3.offsetMin = Vector2.New(0, 0)
				var_93_3.offsetMax = Vector2.New(0, 0)
			end

			if 8.88178419700125e-16 < arg_90_1.time_ and arg_90_1.time_ <= 8.88178419700125e-16 + arg_93_0 then
				arg_90_1.fswbg_:SetActive(true)
				arg_90_1.dialog_:SetActive(false)

				arg_90_1.fswtw_.percent = 0
				arg_90_1.fswt_.text = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(417031022).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.fswt_)

				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_90_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_90_1.fswtw_:SetDirty()

				arg_90_1.typewritterCharCountI18N = 0

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_4 = 1

			if 1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.var_.oldValueTypewriter = arg_90_1.fswtw_.percent

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_5 = 24
			local var_93_6 = 1.6
			local var_93_7, var_93_8 = arg_90_1:GetPercentByPara(arg_90_1:FormatText(arg_90_1:GetWordFromCfg(417031022).content), 1)

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				local var_93_9 = var_93_5 <= 0 and var_93_6 or var_93_6 * ((var_93_8 - arg_90_1.typewritterCharCountI18N) / var_93_5)

				if (var_93_5 <= 0 and var_93_6 or var_93_6 * ((var_93_8 - arg_90_1.typewritterCharCountI18N) / var_93_5)) > 0 and var_93_6 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end
			end

			local var_93_10 = math.max(1.6, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_10 then
				arg_90_1.fswtw_.percent = Mathf.Lerp(arg_90_1.var_.oldValueTypewriter, var_93_7, (arg_90_1.time_ - var_93_4) / var_93_10)
				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.fswtw_:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_10 and arg_90_1.time_ < var_93_4 + var_93_10 + arg_93_0 then
				arg_90_1.fswtw_.percent = var_93_7

				arg_90_1.fswtw_:SetDirty()
				arg_90_1:ShowNextGo(true)

				arg_90_1.typewritterCharCountI18N = var_93_8
			end

			local var_93_11 = 0

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_12 = 2

			if var_93_11 <= arg_90_1.time_ and arg_90_1.time_ < var_93_11 + var_93_12 then
				local var_93_13 = Color.New(0, 0, 0)

				var_93_13.a = Mathf.Lerp(1, 0, (arg_90_1.time_ - var_93_11) / var_93_12)
				arg_90_1.mask_.color = var_93_13
			end

			if arg_90_1.time_ >= var_93_11 + var_93_12 and arg_90_1.time_ < var_93_11 + var_93_12 + arg_93_0 then
				local var_93_14 = Color.New(0, 0, 0)

				arg_90_1.mask_.enabled = false
				var_93_14.a = 0
				arg_90_1.mask_.color = var_93_14
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				local var_93_15 = arg_90_1.bgs_.STblack

				arg_90_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_93_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_93_16 = var_93_15:GetComponent("SpriteRenderer")

				if var_93_16 and var_93_16.sprite then
					local var_93_17 = 2 * (var_93_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_93_15.transform.localScale = Vector3.New(var_93_17 / var_93_16.sprite.bounds.size.y < var_93_17 * manager.ui.mainCameraCom_.aspect / var_93_16.sprite.bounds.size.x and var_93_17 * manager.ui.mainCameraCom_.aspect / var_93_16.sprite.bounds.size.x or var_93_17 / var_93_16.sprite.bounds.size.y, var_93_17 / var_93_16.sprite.bounds.size.y < var_93_17 * manager.ui.mainCameraCom_.aspect / var_93_16.sprite.bounds.size.x and var_93_17 * manager.ui.mainCameraCom_.aspect / var_93_16.sprite.bounds.size.x or var_93_17 / var_93_16.sprite.bounds.size.y, 0)
				end

				for iter_93_0, iter_93_1 in pairs(arg_90_1.bgs_) do
					if iter_93_0 ~= "STblack" then
						iter_93_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_93_18 = 1
			local var_93_19 = manager.audio:GetVoiceLength("story_v_out_417031", "417031022", "") / 1000

			if var_93_19 > 0 and 4.966 < var_93_19 and var_93_19 + var_93_18 > arg_90_1.duration_ then
				arg_90_1.duration_ = var_93_19 + var_93_18
			end

			if var_93_18 < arg_90_1.time_ and arg_90_1.time_ <= var_93_18 + arg_93_0 then
				arg_90_1:AudioAction("play", "voice", "story_v_out_417031", "417031022", "")
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417031023
		arg_94_1.duration_ = 6.3

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 8.88178419700125e-16 < arg_94_1.time_ and arg_94_1.time_ <= 8.88178419700125e-16 + arg_97_0 then
				arg_94_1.fswbg_:SetActive(true)
				arg_94_1.dialog_:SetActive(false)

				arg_94_1.fswtw_.percent = 0
				arg_94_1.fswt_.text = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(417031023).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.fswt_)

				arg_94_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_94_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_94_1.fswtw_:SetDirty()

				arg_94_1.typewritterCharCountI18N = 0

				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_0 = 0.533333333333333

			if 0.533333333333333 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.var_.oldValueTypewriter = arg_94_1.fswtw_.percent

				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_1 = 33
			local var_97_2 = 2.2
			local var_97_3, var_97_4 = arg_94_1:GetPercentByPara(arg_94_1:FormatText(arg_94_1:GetWordFromCfg(417031023).content), 1)

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				local var_97_5 = var_97_1 <= 0 and var_97_2 or var_97_2 * ((var_97_4 - arg_94_1.typewritterCharCountI18N) / var_97_1)

				if (var_97_1 <= 0 and var_97_2 or var_97_2 * ((var_97_4 - arg_94_1.typewritterCharCountI18N) / var_97_1)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_0
					end
				end
			end

			local var_97_6 = math.max(2.2, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_6 then
				arg_94_1.fswtw_.percent = Mathf.Lerp(arg_94_1.var_.oldValueTypewriter, var_97_3, (arg_94_1.time_ - var_97_0) / var_97_6)
				arg_94_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_94_1.fswtw_:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_6 and arg_94_1.time_ < var_97_0 + var_97_6 + arg_97_0 then
				arg_94_1.fswtw_.percent = var_97_3

				arg_94_1.fswtw_:SetDirty()
				arg_94_1:ShowNextGo(true)

				arg_94_1.typewritterCharCountI18N = var_97_4
			end

			local var_97_7 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_7 + 0.533333333333333 and arg_94_1.time_ < var_97_7 + 0.533333333333333 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_8 = 0.533333333333333
			local var_97_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031023", "") / 1000

			if var_97_9 > 0 and 5.766 < var_97_9 and var_97_9 + var_97_8 > arg_94_1.duration_ then
				arg_94_1.duration_ = var_97_9 + var_97_8
			end

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1:AudioAction("play", "voice", "story_v_out_417031", "417031023", "")
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417031024
		arg_98_1.duration_ = 8.37

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 8.88178419700125e-16 < arg_98_1.time_ and arg_98_1.time_ <= 8.88178419700125e-16 + arg_101_0 then
				arg_98_1.fswbg_:SetActive(true)
				arg_98_1.dialog_:SetActive(false)

				arg_98_1.fswtw_.percent = 0
				arg_98_1.fswt_.text = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(417031024).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.fswt_)

				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_98_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_98_1.fswtw_:SetDirty()

				arg_98_1.typewritterCharCountI18N = 0

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_0 = 0.0340000000000009

			if 0.0340000000000009 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.var_.oldValueTypewriter = arg_98_1.fswtw_.percent

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_1 = 35
			local var_101_2 = 2.33333333333333
			local var_101_3, var_101_4 = arg_98_1:GetPercentByPara(arg_98_1:FormatText(arg_98_1:GetWordFromCfg(417031024).content), 1)

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				local var_101_5 = var_101_1 <= 0 and var_101_2 or var_101_2 * ((var_101_4 - arg_98_1.typewritterCharCountI18N) / var_101_1)

				if (var_101_1 <= 0 and var_101_2 or var_101_2 * ((var_101_4 - arg_98_1.typewritterCharCountI18N) / var_101_1)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end
			end

			local var_101_6 = math.max(2.33333333333333, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_6 then
				arg_98_1.fswtw_.percent = Mathf.Lerp(arg_98_1.var_.oldValueTypewriter, var_101_3, (arg_98_1.time_ - var_101_0) / var_101_6)
				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_98_1.fswtw_:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_6 and arg_98_1.time_ < var_101_0 + var_101_6 + arg_101_0 then
				arg_98_1.fswtw_.percent = var_101_3

				arg_98_1.fswtw_:SetDirty()
				arg_98_1:ShowNextGo(true)

				arg_98_1.typewritterCharCountI18N = var_101_4
			end

			local var_101_7 = 0.0340000000000009
			local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031024", "") / 1000

			if var_101_8 > 0 and 8.333 < var_101_8 and var_101_8 + var_101_7 > arg_98_1.duration_ then
				arg_98_1.duration_ = var_101_8 + var_101_7
			end

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1:AudioAction("play", "voice", "story_v_out_417031", "417031024", "")
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417031025
		arg_102_1.duration_ = 10.47

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 8.88178419700125e-16 < arg_102_1.time_ and arg_102_1.time_ <= 8.88178419700125e-16 + arg_105_0 then
				arg_102_1.fswbg_:SetActive(true)
				arg_102_1.dialog_:SetActive(false)

				arg_102_1.fswtw_.percent = 0
				arg_102_1.fswt_.text = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(417031025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.fswt_)

				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_102_1.fswtw_:SetDirty()

				arg_102_1.typewritterCharCountI18N = 0

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_0 = 0.0340000000000009

			if 0.0340000000000009 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_1 = 55
			local var_105_2 = 3.66666666666667
			local var_105_3, var_105_4 = arg_102_1:GetPercentByPara(arg_102_1:FormatText(arg_102_1:GetWordFromCfg(417031025).content), 1)

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_5 = var_105_1 <= 0 and var_105_2 or var_105_2 * ((var_105_4 - arg_102_1.typewritterCharCountI18N) / var_105_1)

				if (var_105_1 <= 0 and var_105_2 or var_105_2 * ((var_105_4 - arg_102_1.typewritterCharCountI18N) / var_105_1)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_0
					end
				end
			end

			local var_105_6 = math.max(3.66666666666667, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_6 then
				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_3, (arg_102_1.time_ - var_105_0) / var_105_6)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_6 and arg_102_1.time_ < var_105_0 + var_105_6 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_3

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_4
			end

			local var_105_7 = 0.0340000000000009
			local var_105_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031025", "") / 1000

			if var_105_8 > 0 and 10.433 < var_105_8 and var_105_8 + var_105_7 > arg_102_1.duration_ then
				arg_102_1.duration_ = var_105_8 + var_105_7
			end

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1:AudioAction("play", "voice", "story_v_out_417031", "417031025", "")
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417031026
		arg_106_1.duration_ = 7.93

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play417031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 1.334 < arg_106_1.time_ and arg_106_1.time_ <= 1.334 + arg_109_0 then
				local var_109_0 = arg_106_1.bgs_.ST77a

				arg_106_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_109_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_1 = var_109_0:GetComponent("SpriteRenderer")

				if var_109_1 and var_109_1.sprite then
					local var_109_2 = 2 * (var_109_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_109_0.transform.localScale = Vector3.New(var_109_2 / var_109_1.sprite.bounds.size.y < var_109_2 * manager.ui.mainCameraCom_.aspect / var_109_1.sprite.bounds.size.x and var_109_2 * manager.ui.mainCameraCom_.aspect / var_109_1.sprite.bounds.size.x or var_109_2 / var_109_1.sprite.bounds.size.y, var_109_2 / var_109_1.sprite.bounds.size.y < var_109_2 * manager.ui.mainCameraCom_.aspect / var_109_1.sprite.bounds.size.x and var_109_2 * manager.ui.mainCameraCom_.aspect / var_109_1.sprite.bounds.size.x or var_109_2 / var_109_1.sprite.bounds.size.y, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "ST77a" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.334 < arg_106_1.time_ and arg_106_1.time_ <= 1.334 + arg_109_0 then
				arg_106_1.cswbg_:SetActive(false)
			end

			if 1.3 < arg_106_1.time_ and arg_106_1.time_ <= 1.3 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			if 1.334 < arg_106_1.time_ and arg_106_1.time_ <= 1.334 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_3 = 0

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_4 = 1.3

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_4 then
				local var_109_5 = Color.New(0, 0, 0)

				var_109_5.a = Mathf.Lerp(0, 1, (arg_106_1.time_ - var_109_3) / var_109_4)
				arg_106_1.mask_.color = var_109_5
			end

			if arg_106_1.time_ >= var_109_3 + var_109_4 and arg_106_1.time_ < var_109_3 + var_109_4 + arg_109_0 then
				local var_109_6 = Color.New(0, 0, 0)

				var_109_6.a = 1
				arg_106_1.mask_.color = var_109_6
			end

			local var_109_7 = 1.3

			if 1.3 < arg_106_1.time_ and arg_106_1.time_ <= var_109_7 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_8 = 2

			if var_109_7 <= arg_106_1.time_ and arg_106_1.time_ < var_109_7 + var_109_8 then
				local var_109_9 = Color.New(0, 0, 0)

				var_109_9.a = Mathf.Lerp(1, 0, (arg_106_1.time_ - var_109_7) / var_109_8)
				arg_106_1.mask_.color = var_109_9
			end

			if arg_106_1.time_ >= var_109_7 + var_109_8 and arg_106_1.time_ < var_109_7 + var_109_8 + arg_109_0 then
				local var_109_10 = Color.New(0, 0, 0)

				arg_106_1.mask_.enabled = false
				var_109_10.a = 0
				arg_106_1.mask_.color = var_109_10
			end

			if 2.86666666666667 < arg_106_1.time_ and arg_106_1.time_ <= 2.86666666666667 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_teacup01", "")
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_12 = 2.93333333333333
			local var_109_13 = 1.2

			if 2.93333333333333 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_14 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_14:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(417031026).content)

				arg_106_1.text_.text = var_109_15

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 48 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 48)

				if (48 <= 0 and var_109_13 or var_109_13 * (utf8.len(var_109_15) / 48)) > 0 and var_109_13 < var_109_17 then
					arg_106_1.talkMaxDuration = var_109_17
					var_109_12 = var_109_12 + 0.3

					if var_109_17 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_15
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = var_109_12 + 0.3
			local var_109_19 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 + 0.3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_18 + var_109_19 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_18) / var_109_19

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_18 + var_109_19 and arg_106_1.time_ < var_109_18 + var_109_19 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417031027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417031027
		arg_112_1.duration_ = 9.47

		local var_112_0 = {
			zh = 6.966,
			ja = 9.466
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417031028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = arg_112_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1034"]) then
				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_2 = arg_112_1.actors_["1034"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1034 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1034", 4)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "split_6" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_112_1.time_ - 0) / var_115_4)
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_115_5 = 0
			local var_115_6 = 0.875

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(417031027)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 34 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 34)

				if (34 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 34)) > 0 and var_115_6 < var_115_10 then
					arg_112_1.talkMaxDuration = var_115_10

					if var_115_10 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031027", "story_v_out_417031.awb") ~= 0 then
					local var_115_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031027", "story_v_out_417031.awb") / 1000

					if var_115_11 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_5
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_417031", "417031027", "story_v_out_417031.awb")

						arg_112_1:RecordAudio("417031027", var_115_12)
						arg_112_1:RecordAudio("417031027", var_115_12)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417031", "417031027", "story_v_out_417031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417031", "417031027", "story_v_out_417031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_13 and arg_112_1.time_ < var_115_5 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417031028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417031028
		arg_116_1.duration_ = 6.13

		local var_116_0 = {
			zh = 4.433,
			ja = 6.133
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
				arg_116_0:Play417031029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1015"]) and arg_116_1.var_.actorSpriteComps1015 == nil then
				arg_116_1.var_.actorSpriteComps1015 = arg_116_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1015"]) then
				if arg_116_1.var_.actorSpriteComps1015 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1015"]) and arg_116_1.var_.actorSpriteComps1015 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1015 = nil
			end

			local var_119_2 = arg_116_1.actors_["1034"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_3), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_3), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_3)))
							else
								local var_119_4 = Mathf.Lerp(iter_119_5.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_3)

								iter_119_5.color = Color.New(var_119_4, var_119_4, var_119_4)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_5 = arg_116_1.actors_["1015"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1015 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1015", 2)

				for iter_119_8 = 0, var_119_5.childCount - 1 do
					local var_119_6 = var_119_5:GetChild(iter_119_8)

					if var_119_6.name == "" or not string.find(var_119_6.name, "split") then
						var_119_6.gameObject:SetActive(true)
					else
						var_119_6.gameObject:SetActive(false)
					end
				end
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_119_8 = 0
			local var_119_9 = 0.5

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(417031028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 20 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 20)

				if (20 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 20)) > 0 and var_119_9 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031028", "story_v_out_417031.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031028", "story_v_out_417031.awb") / 1000

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_417031", "417031028", "story_v_out_417031.awb")

						arg_116_1:RecordAudio("417031028", var_119_15)
						arg_116_1:RecordAudio("417031028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417031", "417031028", "story_v_out_417031.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417031", "417031028", "story_v_out_417031.awb")
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
	Play417031029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417031029
		arg_120_1.duration_ = 10.8

		local var_120_0 = {
			zh = 5.266,
			ja = 10.8
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417031030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1034"]) and arg_120_1.var_.actorSpriteComps1034 == nil then
				arg_120_1.var_.actorSpriteComps1034 = arg_120_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1034"]) then
				if arg_120_1.var_.actorSpriteComps1034 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1034"]) and arg_120_1.var_.actorSpriteComps1034 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps1034 = nil
			end

			local var_123_2 = arg_120_1.actors_["1015"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1015 == nil then
				arg_120_1.var_.actorSpriteComps1015 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps1015 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1015 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps1015 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 0.625

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(417031029)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 25 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 25)

				if (25 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 25)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031029", "story_v_out_417031.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031029", "story_v_out_417031.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_417031", "417031029", "story_v_out_417031.awb")

						arg_120_1:RecordAudio("417031029", var_123_12)
						arg_120_1:RecordAudio("417031029", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417031", "417031029", "story_v_out_417031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417031", "417031029", "story_v_out_417031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417031030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417031030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417031031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1034"]) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = arg_124_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1034"]) then
				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1034"]) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_2 = arg_124_1.actors_["1015"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1015 = var_127_2.localPosition
				var_127_2.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1015", 7)

				for iter_127_4 = 0, var_127_2.childCount - 1 do
					local var_127_3 = var_127_2:GetChild(iter_127_4)

					if var_127_3.name == "" or not string.find(var_127_3.name, "split") then
						var_127_3.gameObject:SetActive(true)
					else
						var_127_3.gameObject:SetActive(false)
					end
				end
			end

			local var_127_4 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				var_127_2.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_124_1.time_ - 0) / var_127_4)
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				var_127_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_127_5 = arg_124_1.actors_["1034"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1034 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1034", 7)

				for iter_127_5 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_5)

					if var_127_6.name == "" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_124_1.time_ and arg_124_1.time_ <= 0.05 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_tea", "")
			end

			local var_127_9 = 0
			local var_127_10 = 0.95

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_11 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(417031030).content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 38 <= 0 and var_127_10 or var_127_10 * (utf8.len(var_127_11) / 38)

				if (38 <= 0 and var_127_10 or var_127_10 * (utf8.len(var_127_11) / 38)) > 0 and var_127_10 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_9 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_9
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_10, arg_124_1.talkMaxDuration)

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_9) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_9 + var_127_14 and arg_124_1.time_ < var_127_9 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417031031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417031031
		arg_128_1.duration_ = 3.13

		local var_128_0 = {
			zh = 3.133,
			ja = 2.2
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
				arg_128_0:Play417031032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1015"]) and arg_128_1.var_.actorSpriteComps1015 == nil then
				arg_128_1.var_.actorSpriteComps1015 = arg_128_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1015"]) then
				if arg_128_1.var_.actorSpriteComps1015 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1015"]) and arg_128_1.var_.actorSpriteComps1015 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps1015 = nil
			end

			local var_131_2 = arg_128_1.actors_["1015"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1015 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1015", 2)

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
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_131_5 = 0
			local var_131_6 = 0.15

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(417031031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 6 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 6)

				if (6 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 6)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031031", "story_v_out_417031.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031031", "story_v_out_417031.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_417031", "417031031", "story_v_out_417031.awb")

						arg_128_1:RecordAudio("417031031", var_131_12)
						arg_128_1:RecordAudio("417031031", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417031", "417031031", "story_v_out_417031.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417031", "417031031", "story_v_out_417031.awb")
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
				actorName = "1015",
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
	Play417031032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417031032
		arg_132_1.duration_ = 3.13

		local var_132_0 = {
			zh = 2.066,
			ja = 3.133
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
				arg_132_0:Play417031033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1034"]) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = arg_132_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1034"]) then
				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1034"]) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_2 = arg_132_1.actors_["1015"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1015 == nil then
				arg_132_1.var_.actorSpriteComps1015 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps1015 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1015 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps1015 = nil
			end

			local var_135_5 = arg_132_1.actors_["1034"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1034 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1034", 4)

				for iter_135_8 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_8)

					if var_135_6.name == "split_6" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_135_8 = 0
			local var_135_9 = 0.2

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(417031032)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 8 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 8)

				if (8 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 8)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031032", "story_v_out_417031.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031032", "story_v_out_417031.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_417031", "417031032", "story_v_out_417031.awb")

						arg_132_1:RecordAudio("417031032", var_135_15)
						arg_132_1:RecordAudio("417031032", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417031", "417031032", "story_v_out_417031.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417031", "417031032", "story_v_out_417031.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_16 and arg_132_1.time_ < var_135_8 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play417031033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417031033
		arg_136_1.duration_ = 7.87

		local var_136_0 = {
			zh = 5.233,
			ja = 7.866
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
				arg_136_0:Play417031034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1015"]) and arg_136_1.var_.actorSpriteComps1015 == nil then
				arg_136_1.var_.actorSpriteComps1015 = arg_136_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1015"]) then
				if arg_136_1.var_.actorSpriteComps1015 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1015"]) and arg_136_1.var_.actorSpriteComps1015 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps1015 = nil
			end

			local var_139_2 = arg_136_1.actors_["1034"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = var_139_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_3 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_7 then
						iter_139_7.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_5 = arg_136_1.actors_["1015"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1015 = var_139_5.localPosition
				var_139_5.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1015", 2)

				for iter_139_8 = 0, var_139_5.childCount - 1 do
					local var_139_6 = var_139_5:GetChild(iter_139_8)

					if var_139_6.name == "split_1" or not string.find(var_139_6.name, "split") then
						var_139_6.gameObject:SetActive(true)
					else
						var_139_6.gameObject:SetActive(false)
					end
				end
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_5.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_136_1.time_ - 0) / var_139_7)
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_5.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_139_8 = 0
			local var_139_9 = 0.625

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(417031033)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 25 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 25)

				if (25 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 25)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031033", "story_v_out_417031.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031033", "story_v_out_417031.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_417031", "417031033", "story_v_out_417031.awb")

						arg_136_1:RecordAudio("417031033", var_139_15)
						arg_136_1:RecordAudio("417031033", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417031", "417031033", "story_v_out_417031.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417031", "417031033", "story_v_out_417031.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play417031034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417031034
		arg_140_1.duration_ = 5.9

		local var_140_0 = {
			zh = 4.7,
			ja = 5.9
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
				arg_140_0:Play417031035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = arg_140_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1034"]) then
				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_2 = arg_140_1.actors_["1015"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps1015 == nil then
				arg_140_1.var_.actorSpriteComps1015 = var_143_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_3 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.actorSpriteComps1015 then
					for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps1015 then
				for iter_143_6, iter_143_7 in pairs(arg_140_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_143_7 then
						iter_143_7.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps1015 = nil
			end

			local var_143_5 = 0
			local var_143_6 = 0.55

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:GetWordFromCfg(417031034)
				local var_143_8 = arg_140_1:FormatText(var_143_7.content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 22 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_8) / 22)

				if (22 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_8) / 22)) > 0 and var_143_6 < var_143_10 then
					arg_140_1.talkMaxDuration = var_143_10

					if var_143_10 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031034", "story_v_out_417031.awb") ~= 0 then
					local var_143_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031034", "story_v_out_417031.awb") / 1000

					if var_143_11 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_5
					end

					if var_143_7.prefab_name ~= "" and arg_140_1.actors_[var_143_7.prefab_name] ~= nil then
						local var_143_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_7.prefab_name].transform, "story_v_out_417031", "417031034", "story_v_out_417031.awb")

						arg_140_1:RecordAudio("417031034", var_143_12)
						arg_140_1:RecordAudio("417031034", var_143_12)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417031", "417031034", "story_v_out_417031.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417031", "417031034", "story_v_out_417031.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_13 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_13 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_13

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_13 and arg_140_1.time_ < var_143_5 + var_143_13 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417031035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417031035
		arg_144_1.duration_ = 4.87

		local var_144_0 = {
			zh = 3.333,
			ja = 4.866
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
				arg_144_0:Play417031036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1015"]) and arg_144_1.var_.actorSpriteComps1015 == nil then
				arg_144_1.var_.actorSpriteComps1015 = arg_144_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1015"]) then
				if arg_144_1.var_.actorSpriteComps1015 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
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

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1015"]) and arg_144_1.var_.actorSpriteComps1015 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps1015 = nil
			end

			local var_147_2 = arg_144_1.actors_["1034"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1034 == nil then
				arg_144_1.var_.actorSpriteComps1034 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps1034 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1034 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_147_7 then
						iter_147_7.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps1034 = nil
			end

			local var_147_5 = 0
			local var_147_6 = 0.425

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(417031035)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_10 = 17 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_8) / 17)

				if (17 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_8) / 17)) > 0 and var_147_6 < var_147_10 then
					arg_144_1.talkMaxDuration = var_147_10

					if var_147_10 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_5
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031035", "story_v_out_417031.awb") ~= 0 then
					local var_147_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031035", "story_v_out_417031.awb") / 1000

					if var_147_11 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_5
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_417031", "417031035", "story_v_out_417031.awb")

						arg_144_1:RecordAudio("417031035", var_147_12)
						arg_144_1:RecordAudio("417031035", var_147_12)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417031", "417031035", "story_v_out_417031.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417031", "417031035", "story_v_out_417031.awb")
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
	Play417031036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417031036
		arg_148_1.duration_ = 6.73

		local var_148_0 = {
			zh = 5.533,
			ja = 6.733
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
				arg_148_0:Play417031037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1034"]) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = arg_148_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1034"]) then
				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1034"]) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_2 = arg_148_1.actors_["1015"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps1015 == nil then
				arg_148_1.var_.actorSpriteComps1015 = var_151_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_3 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.actorSpriteComps1015 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								iter_151_5.color = Color.New(Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_3), Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_3), (Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_3)))
							else
								local var_151_4 = Mathf.Lerp(iter_151_5.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_3)

								iter_151_5.color = Color.New(var_151_4, var_151_4, var_151_4)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps1015 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_151_7 then
						iter_151_7.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps1015 = nil
			end

			local var_151_5 = arg_148_1.actors_["1034"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1034 = var_151_5.localPosition
				var_151_5.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1034", 4)

				for iter_151_8 = 0, var_151_5.childCount - 1 do
					local var_151_6 = var_151_5:GetChild(iter_151_8)

					if var_151_6.name == "split_3" or not string.find(var_151_6.name, "split") then
						var_151_6.gameObject:SetActive(true)
					else
						var_151_6.gameObject:SetActive(false)
					end
				end
			end

			local var_151_7 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				var_151_5.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_148_1.time_ - 0) / var_151_7)
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				var_151_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_151_8 = 0
			local var_151_9 = 0.675

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(417031036)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 27 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 27)

				if (27 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 27)) > 0 and var_151_9 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031036", "story_v_out_417031.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031036", "story_v_out_417031.awb") / 1000

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_417031", "417031036", "story_v_out_417031.awb")

						arg_148_1:RecordAudio("417031036", var_151_15)
						arg_148_1:RecordAudio("417031036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417031", "417031036", "story_v_out_417031.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417031", "417031036", "story_v_out_417031.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417031037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417031037
		arg_152_1.duration_ = 3.63

		local var_152_0 = {
			zh = 3.633,
			ja = 3.6
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
				arg_152_0:Play417031038(arg_152_1)
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

			local var_155_2 = arg_152_1.actors_["1034"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps1034 == nil then
				arg_152_1.var_.actorSpriteComps1034 = var_155_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_3 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.actorSpriteComps1034 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps1034 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_155_7 then
						iter_155_7.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps1034 = nil
			end

			local var_155_5 = arg_152_1.actors_["1015"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1015 = var_155_5.localPosition
				var_155_5.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1015", 2)

				for iter_155_8 = 0, var_155_5.childCount - 1 do
					local var_155_6 = var_155_5:GetChild(iter_155_8)

					if var_155_6.name == "" or not string.find(var_155_6.name, "split") then
						var_155_6.gameObject:SetActive(true)
					else
						var_155_6.gameObject:SetActive(false)
					end
				end
			end

			local var_155_7 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				var_155_5.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_152_1.time_ - 0) / var_155_7)
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				var_155_5.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_155_8 = 0
			local var_155_9 = 0.425

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
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

				local var_155_10 = arg_152_1:GetWordFromCfg(417031037)
				local var_155_11 = arg_152_1:FormatText(var_155_10.content)

				arg_152_1.text_.text = var_155_11

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 17 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 17)

				if (17 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 17)) > 0 and var_155_9 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_11
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031037", "story_v_out_417031.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031037", "story_v_out_417031.awb") / 1000

					if var_155_14 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_8
					end

					if var_155_10.prefab_name ~= "" and arg_152_1.actors_[var_155_10.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_10.prefab_name].transform, "story_v_out_417031", "417031037", "story_v_out_417031.awb")

						arg_152_1:RecordAudio("417031037", var_155_15)
						arg_152_1:RecordAudio("417031037", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417031", "417031037", "story_v_out_417031.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417031", "417031037", "story_v_out_417031.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_16 and arg_152_1.time_ < var_155_8 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play417031038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417031038
		arg_156_1.duration_ = 13.8

		local var_156_0 = {
			zh = 13.8,
			ja = 7.6
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
				arg_156_0:Play417031039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = arg_156_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1034"]) then
				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor1.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor1.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor1.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 1, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_2 = arg_156_1.actors_["1015"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1015 == nil then
				arg_156_1.var_.actorSpriteComps1015 = var_159_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_3 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.actorSpriteComps1015 then
					for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_159_5 then
							if arg_156_1.isInRecall_ then
								iter_159_5.color = Color.New(Mathf.Lerp(iter_159_5.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_3), Mathf.Lerp(iter_159_5.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_3), (Mathf.Lerp(iter_159_5.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_3)))
							else
								local var_159_4 = Mathf.Lerp(iter_159_5.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_3)

								iter_159_5.color = Color.New(var_159_4, var_159_4, var_159_4)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1015 then
				for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_159_7 then
						iter_159_7.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1015 = nil
			end

			local var_159_5 = 0
			local var_159_6 = 1.3

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:GetWordFromCfg(417031038)
				local var_159_8 = arg_156_1:FormatText(var_159_7.content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 52 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_8) / 52)

				if (52 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_8) / 52)) > 0 and var_159_6 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031038", "story_v_out_417031.awb") ~= 0 then
					local var_159_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031038", "story_v_out_417031.awb") / 1000

					if var_159_11 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_5
					end

					if var_159_7.prefab_name ~= "" and arg_156_1.actors_[var_159_7.prefab_name] ~= nil then
						local var_159_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_7.prefab_name].transform, "story_v_out_417031", "417031038", "story_v_out_417031.awb")

						arg_156_1:RecordAudio("417031038", var_159_12)
						arg_156_1:RecordAudio("417031038", var_159_12)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417031", "417031038", "story_v_out_417031.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417031", "417031038", "story_v_out_417031.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_13 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_13 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_13

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_13 and arg_156_1.time_ < var_159_5 + var_159_13 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417031039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417031039
		arg_160_1.duration_ = 8.9

		local var_160_0 = {
			zh = 5.9,
			ja = 8.9
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
				arg_160_0:Play417031040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.725

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(417031039)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 29 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 29)

				if (29 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 29)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031039", "story_v_out_417031.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031039", "story_v_out_417031.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_417031", "417031039", "story_v_out_417031.awb")

						arg_160_1:RecordAudio("417031039", var_163_6)
						arg_160_1:RecordAudio("417031039", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417031", "417031039", "story_v_out_417031.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417031", "417031039", "story_v_out_417031.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417031040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417031040
		arg_164_1.duration_ = 9.73

		local var_164_0 = {
			zh = 9.266,
			ja = 9.733
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
				arg_164_0:Play417031041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1034 = arg_164_1.actors_["1034"].transform.localPosition
				arg_164_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("1034", 4)

				for iter_167_0 = 0, arg_164_1.actors_["1034"].transform.childCount - 1 do
					local var_167_0 = arg_164_1.actors_["1034"].transform:GetChild(iter_167_0)

					if var_167_0.name == "split_4" or not string.find(var_167_0.name, "split") then
						var_167_0.gameObject:SetActive(true)
					else
						var_167_0.gameObject:SetActive(false)
					end
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_164_1.time_ - 0) / var_167_1)
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1034"].transform.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_167_2 = 0
			local var_167_3 = 0.875

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(417031040)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 35 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 35)

				if (35 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 35)) > 0 and var_167_3 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031040", "story_v_out_417031.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031040", "story_v_out_417031.awb") / 1000

					if var_167_8 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_2
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_417031", "417031040", "story_v_out_417031.awb")

						arg_164_1:RecordAudio("417031040", var_167_9)
						arg_164_1:RecordAudio("417031040", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417031", "417031040", "story_v_out_417031.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417031", "417031040", "story_v_out_417031.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_10 and arg_164_1.time_ < var_167_2 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417031041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417031041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417031042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1034"]) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = arg_168_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1034"]) then
				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								iter_171_1.color = Color.New(Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_0), Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_0), (Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_0)))
							else
								local var_171_1 = Mathf.Lerp(iter_171_1.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_0)

								iter_171_1.color = Color.New(var_171_1, var_171_1, var_171_1)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1034"]) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						iter_171_3.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_2 = arg_168_1.actors_["1015"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1015 = var_171_2.localPosition
				var_171_2.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1015", 7)

				for iter_171_4 = 0, var_171_2.childCount - 1 do
					local var_171_3 = var_171_2:GetChild(iter_171_4)

					if var_171_3.name == "" or not string.find(var_171_3.name, "split") then
						var_171_3.gameObject:SetActive(true)
					else
						var_171_3.gameObject:SetActive(false)
					end
				end
			end

			local var_171_4 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				var_171_2.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_168_1.time_ - 0) / var_171_4)
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				var_171_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_171_5 = arg_168_1.actors_["1034"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1034 = var_171_5.localPosition
				var_171_5.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1034", 7)

				for iter_171_5 = 0, var_171_5.childCount - 1 do
					local var_171_6 = var_171_5:GetChild(iter_171_5)

					if var_171_6.name == "" or not string.find(var_171_6.name, "split") then
						var_171_6.gameObject:SetActive(true)
					else
						var_171_6.gameObject:SetActive(false)
					end
				end
			end

			local var_171_7 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				var_171_5.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_168_1.time_ - 0) / var_171_7)
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				var_171_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_171_8 = 0
			local var_171_9 = 1.3

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_10 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(417031041).content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_12 = 52 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_10) / 52)

				if (52 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_10) / 52)) > 0 and var_171_9 < var_171_12 then
					arg_168_1.talkMaxDuration = var_171_12

					if var_171_12 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_13 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_13 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_13

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_13 and arg_168_1.time_ < var_171_8 + var_171_13 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play417031042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417031042
		arg_172_1.duration_ = 6

		local var_172_0 = {
			zh = 4.833,
			ja = 6
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417031043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1015"]) and arg_172_1.var_.actorSpriteComps1015 == nil then
				arg_172_1.var_.actorSpriteComps1015 = arg_172_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1015"]) then
				if arg_172_1.var_.actorSpriteComps1015 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 1, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1015"]) and arg_172_1.var_.actorSpriteComps1015 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_172_1.var_.actorSpriteComps1015 = nil
			end

			local var_175_2 = arg_172_1.actors_["1015"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1015 = var_175_2.localPosition
				var_175_2.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1015", 2)

				for iter_175_4 = 0, var_175_2.childCount - 1 do
					local var_175_3 = var_175_2:GetChild(iter_175_4)

					if var_175_3.name == "split_4" or not string.find(var_175_3.name, "split") then
						var_175_3.gameObject:SetActive(true)
					else
						var_175_3.gameObject:SetActive(false)
					end
				end
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_2.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_172_1.time_ - 0) / var_175_4)
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_2.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_175_5 = 0
			local var_175_6 = 0.65

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(417031042)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 26 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 26)

				if (26 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 26)) > 0 and var_175_6 < var_175_10 then
					arg_172_1.talkMaxDuration = var_175_10

					if var_175_10 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031042", "story_v_out_417031.awb") ~= 0 then
					local var_175_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031042", "story_v_out_417031.awb") / 1000

					if var_175_11 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_5
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_417031", "417031042", "story_v_out_417031.awb")

						arg_172_1:RecordAudio("417031042", var_175_12)
						arg_172_1:RecordAudio("417031042", var_175_12)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417031", "417031042", "story_v_out_417031.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417031", "417031042", "story_v_out_417031.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_13 and arg_172_1.time_ < var_175_5 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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
	Play417031043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417031043
		arg_176_1.duration_ = 9.2

		local var_176_0 = {
			zh = 7.033,
			ja = 9.2
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
				arg_176_0:Play417031044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1034"]) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = arg_176_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1034"]) then
				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								iter_179_1.color = Color.New(Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_0), Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_0), (Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_0)))
							else
								local var_179_1 = Mathf.Lerp(iter_179_1.color.r, 1, (arg_176_1.time_ - 0) / var_179_0)

								iter_179_1.color = Color.New(var_179_1, var_179_1, var_179_1)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1034"]) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						iter_179_3.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_2 = arg_176_1.actors_["1015"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps1015 == nil then
				arg_176_1.var_.actorSpriteComps1015 = var_179_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_3 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.actorSpriteComps1015 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								iter_179_5.color = Color.New(Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, (arg_176_1.time_ - 0) / var_179_3), Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, (arg_176_1.time_ - 0) / var_179_3), (Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, (arg_176_1.time_ - 0) / var_179_3)))
							else
								local var_179_4 = Mathf.Lerp(iter_179_5.color.r, 0.5, (arg_176_1.time_ - 0) / var_179_3)

								iter_179_5.color = Color.New(var_179_4, var_179_4, var_179_4)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps1015 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_179_7 then
						iter_179_7.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps1015 = nil
			end

			local var_179_5 = arg_176_1.actors_["1034"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1034 = var_179_5.localPosition
				var_179_5.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1034", 4)

				for iter_179_8 = 0, var_179_5.childCount - 1 do
					local var_179_6 = var_179_5:GetChild(iter_179_8)

					if var_179_6.name == "split_6" or not string.find(var_179_6.name, "split") then
						var_179_6.gameObject:SetActive(true)
					else
						var_179_6.gameObject:SetActive(false)
					end
				end
			end

			local var_179_7 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				var_179_5.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_176_1.time_ - 0) / var_179_7)
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				var_179_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_179_8 = 0
			local var_179_9 = 0.825

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_10 = arg_176_1:GetWordFromCfg(417031043)
				local var_179_11 = arg_176_1:FormatText(var_179_10.content)

				arg_176_1.text_.text = var_179_11

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 33 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 33)

				if (33 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 33)) > 0 and var_179_9 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_8
					end
				end

				arg_176_1.text_.text = var_179_11
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031043", "story_v_out_417031.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031043", "story_v_out_417031.awb") / 1000

					if var_179_14 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_8
					end

					if var_179_10.prefab_name ~= "" and arg_176_1.actors_[var_179_10.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_10.prefab_name].transform, "story_v_out_417031", "417031043", "story_v_out_417031.awb")

						arg_176_1:RecordAudio("417031043", var_179_15)
						arg_176_1:RecordAudio("417031043", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417031", "417031043", "story_v_out_417031.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417031", "417031043", "story_v_out_417031.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_16 and arg_176_1.time_ < var_179_8 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play417031044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417031044
		arg_180_1.duration_ = 8.23

		local var_180_0 = {
			zh = 8.233,
			ja = 7.266
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417031045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1015"]) and arg_180_1.var_.actorSpriteComps1015 == nil then
				arg_180_1.var_.actorSpriteComps1015 = arg_180_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1015"]) then
				if arg_180_1.var_.actorSpriteComps1015 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1015"]) and arg_180_1.var_.actorSpriteComps1015 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps1015 = nil
			end

			local var_183_2 = arg_180_1.actors_["1034"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								iter_183_5.color = Color.New(Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_3), Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_3), (Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_3)))
							else
								local var_183_4 = Mathf.Lerp(iter_183_5.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_3)

								iter_183_5.color = Color.New(var_183_4, var_183_4, var_183_4)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_7 then
						iter_183_7.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_5 = 0
			local var_183_6 = 0.975

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_7 = arg_180_1:GetWordFromCfg(417031044)
				local var_183_8 = arg_180_1:FormatText(var_183_7.content)

				arg_180_1.text_.text = var_183_8

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 39 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 39)

				if (39 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 39)) > 0 and var_183_6 < var_183_10 then
					arg_180_1.talkMaxDuration = var_183_10

					if var_183_10 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_5
					end
				end

				arg_180_1.text_.text = var_183_8
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031044", "story_v_out_417031.awb") ~= 0 then
					local var_183_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031044", "story_v_out_417031.awb") / 1000

					if var_183_11 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_5
					end

					if var_183_7.prefab_name ~= "" and arg_180_1.actors_[var_183_7.prefab_name] ~= nil then
						local var_183_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_7.prefab_name].transform, "story_v_out_417031", "417031044", "story_v_out_417031.awb")

						arg_180_1:RecordAudio("417031044", var_183_12)
						arg_180_1:RecordAudio("417031044", var_183_12)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417031", "417031044", "story_v_out_417031.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417031", "417031044", "story_v_out_417031.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_6, arg_180_1.talkMaxDuration)

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_5) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_5 + var_183_13 and arg_180_1.time_ < var_183_5 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417031045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417031045
		arg_184_1.duration_ = 10.47

		local var_184_0 = {
			zh = 5.066,
			ja = 10.466
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417031046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1034"]) and arg_184_1.var_.actorSpriteComps1034 == nil then
				arg_184_1.var_.actorSpriteComps1034 = arg_184_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1034"]) then
				if arg_184_1.var_.actorSpriteComps1034 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 1, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1034"]) and arg_184_1.var_.actorSpriteComps1034 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps1034 = nil
			end

			local var_187_2 = arg_184_1.actors_["1015"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps1015 == nil then
				arg_184_1.var_.actorSpriteComps1015 = var_187_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_3 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.actorSpriteComps1015 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								iter_187_5.color = Color.New(Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_3), Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_3), (Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_3)))
							else
								local var_187_4 = Mathf.Lerp(iter_187_5.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_3)

								iter_187_5.color = Color.New(var_187_4, var_187_4, var_187_4)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps1015 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_187_7 then
						iter_187_7.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps1015 = nil
			end

			local var_187_5 = 0
			local var_187_6 = 0.575

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:GetWordFromCfg(417031045)
				local var_187_8 = arg_184_1:FormatText(var_187_7.content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 23 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_8) / 23)

				if (23 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_8) / 23)) > 0 and var_187_6 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10

					if var_187_10 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031045", "story_v_out_417031.awb") ~= 0 then
					local var_187_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031045", "story_v_out_417031.awb") / 1000

					if var_187_11 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_5
					end

					if var_187_7.prefab_name ~= "" and arg_184_1.actors_[var_187_7.prefab_name] ~= nil then
						local var_187_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_7.prefab_name].transform, "story_v_out_417031", "417031045", "story_v_out_417031.awb")

						arg_184_1:RecordAudio("417031045", var_187_12)
						arg_184_1:RecordAudio("417031045", var_187_12)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417031", "417031045", "story_v_out_417031.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417031", "417031045", "story_v_out_417031.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_13 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_13 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_13

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_13 and arg_184_1.time_ < var_187_5 + var_187_13 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417031046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417031046
		arg_188_1.duration_ = 9.53

		local var_188_0 = {
			zh = 9.533,
			ja = 5.733
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
				arg_188_0:Play417031047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1015"]) and arg_188_1.var_.actorSpriteComps1015 == nil then
				arg_188_1.var_.actorSpriteComps1015 = arg_188_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1015"]) then
				if arg_188_1.var_.actorSpriteComps1015 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1015"]) and arg_188_1.var_.actorSpriteComps1015 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1015 = nil
			end

			local var_191_2 = arg_188_1.actors_["1034"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								iter_191_5.color = Color.New(Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_5.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_5.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_7 then
						iter_191_7.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_5 = arg_188_1.actors_["1015"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1015 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1015", 2)

				for iter_191_8 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_8)

					if var_191_6.name == "split_2" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1015, Vector3.New(-390, -340, -288), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(-390, -340, -288)
			end

			local var_191_8 = 0
			local var_191_9 = 0.925

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(417031046)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 37 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 37)

				if (37 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 37)) > 0 and var_191_9 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031046", "story_v_out_417031.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031046", "story_v_out_417031.awb") / 1000

					if var_191_14 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_8
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_out_417031", "417031046", "story_v_out_417031.awb")

						arg_188_1:RecordAudio("417031046", var_191_15)
						arg_188_1:RecordAudio("417031046", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417031", "417031046", "story_v_out_417031.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417031", "417031046", "story_v_out_417031.awb")
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
				actorName = "1015",
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
	Play417031047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417031047
		arg_192_1.duration_ = 6.43

		local var_192_0 = {
			zh = 6.43266666666667,
			ja = 2.29966666666667
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
				arg_192_0:Play417031048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1034"]) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = arg_192_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1034"]) then
				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1034"]) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_2 = arg_192_1.actors_["1015"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps1015 == nil then
				arg_192_1.var_.actorSpriteComps1015 = var_195_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_3 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.actorSpriteComps1015 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								iter_195_5.color = Color.New(Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_3), Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_3), (Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_3)))
							else
								local var_195_4 = Mathf.Lerp(iter_195_5.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_3)

								iter_195_5.color = Color.New(var_195_4, var_195_4, var_195_4)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps1015 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_195_7 then
						iter_195_7.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps1015 = nil
			end

			local var_195_5 = arg_192_1.actors_["1034"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_5.localPosition
				var_195_5.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 7)

				for iter_195_8 = 0, var_195_5.childCount - 1 do
					local var_195_6 = var_195_5:GetChild(iter_195_8)

					if var_195_6.name == "split_8" or not string.find(var_195_6.name, "split") then
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

			local var_195_8 = arg_192_1.actors_["1015"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1015 = var_195_8.localPosition
				var_195_8.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1015", 7)

				for iter_195_9 = 0, var_195_8.childCount - 1 do
					local var_195_9 = var_195_8:GetChild(iter_195_9)

					if var_195_9.name == "" or not string.find(var_195_9.name, "split") then
						var_195_9.gameObject:SetActive(true)
					else
						var_195_9.gameObject:SetActive(false)
					end
				end
			end

			local var_195_10 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_10 then
				var_195_8.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_192_1.time_ - 0) / var_195_10)
			end

			if arg_192_1.time_ >= 0 + var_195_10 and arg_192_1.time_ < 0 + var_195_10 + arg_195_0 then
				var_195_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_195_11 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_11 + 0.691666666666667 and arg_192_1.time_ < var_195_11 + 0.691666666666667 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			if 0.333333333332 < arg_192_1.time_ and arg_192_1.time_ <= 0.333333333332 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_hitdoor", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_13 = 0.566666666666667
			local var_195_14 = 0.125

			if 0.566666666666667 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_15 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_15:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_16 = arg_192_1:GetWordFromCfg(417031047)
				local var_195_17 = arg_192_1:FormatText(var_195_16.content)

				arg_192_1.text_.text = var_195_17

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_19 = 5 <= 0 and var_195_14 or var_195_14 * (utf8.len(var_195_17) / 5)

				if (5 <= 0 and var_195_14 or var_195_14 * (utf8.len(var_195_17) / 5)) > 0 and var_195_14 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19
					var_195_13 = var_195_13 + 0.3

					if var_195_19 + var_195_13 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_13
					end
				end

				arg_192_1.text_.text = var_195_17
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031047", "story_v_out_417031.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_417031", "417031047", "story_v_out_417031.awb") / 1000

					if var_195_20 + var_195_13 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_13
					end

					if var_195_16.prefab_name ~= "" and arg_192_1.actors_[var_195_16.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_16.prefab_name].transform, "story_v_out_417031", "417031047", "story_v_out_417031.awb")

						arg_192_1:RecordAudio("417031047", var_195_21)
						arg_192_1:RecordAudio("417031047", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417031", "417031047", "story_v_out_417031.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417031", "417031047", "story_v_out_417031.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = var_195_13 + 0.3
			local var_195_23 = math.max(var_195_14, arg_192_1.talkMaxDuration)

			if var_195_13 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_22 + var_195_23 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_22) / var_195_23

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_22 + var_195_23 and arg_192_1.time_ < var_195_22 + var_195_23 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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
				actorName = "1015",
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
	Play417031048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417031048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417031049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1034"]) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = arg_198_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1034"]) then
				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1034"]) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_2 = 0
			local var_201_3 = 1.25

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(417031048).content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 50 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 50)

				if (50 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 50)) > 0 and var_201_3 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_7 and arg_198_1.time_ < var_201_2 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417031049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417031049
		arg_202_1.duration_ = 14.37

		local var_202_0 = {
			zh = 9.833,
			ja = 14.366
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417031050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1034"]) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = arg_202_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1034"]) then
				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 1, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1034"]) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_2 = arg_202_1.actors_["1034"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1034 = var_205_2.localPosition
				var_205_2.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1034", 3)

				for iter_205_4 = 0, var_205_2.childCount - 1 do
					local var_205_3 = var_205_2:GetChild(iter_205_4)

					if var_205_3.name == "split_6" or not string.find(var_205_3.name, "split") then
						var_205_3.gameObject:SetActive(true)
					else
						var_205_3.gameObject:SetActive(false)
					end
				end
			end

			local var_205_4 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				var_205_2.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_202_1.time_ - 0) / var_205_4)
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				var_205_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_205_5 = 0
			local var_205_6 = 1.075

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_7 = arg_202_1:GetWordFromCfg(417031049)
				local var_205_8 = arg_202_1:FormatText(var_205_7.content)

				arg_202_1.text_.text = var_205_8

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_10 = 43 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 43)

				if (43 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 43)) > 0 and var_205_6 < var_205_10 then
					arg_202_1.talkMaxDuration = var_205_10

					if var_205_10 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_5
					end
				end

				arg_202_1.text_.text = var_205_8
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031049", "story_v_out_417031.awb") ~= 0 then
					local var_205_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031049", "story_v_out_417031.awb") / 1000

					if var_205_11 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_5
					end

					if var_205_7.prefab_name ~= "" and arg_202_1.actors_[var_205_7.prefab_name] ~= nil then
						local var_205_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_7.prefab_name].transform, "story_v_out_417031", "417031049", "story_v_out_417031.awb")

						arg_202_1:RecordAudio("417031049", var_205_12)
						arg_202_1:RecordAudio("417031049", var_205_12)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417031", "417031049", "story_v_out_417031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417031", "417031049", "story_v_out_417031.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_13 = math.max(var_205_6, arg_202_1.talkMaxDuration)

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_13 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_5) / var_205_13

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_5 + var_205_13 and arg_202_1.time_ < var_205_5 + var_205_13 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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

		arg_202_1:InitPlayNodeList()
	end,
	Play417031050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417031050
		arg_206_1.duration_ = 7.8

		local var_206_0 = {
			zh = 5.733,
			ja = 7.8
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417031051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1015"]) and arg_206_1.var_.actorSpriteComps1015 == nil then
				arg_206_1.var_.actorSpriteComps1015 = arg_206_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1015"]) then
				if arg_206_1.var_.actorSpriteComps1015 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1015"]) and arg_206_1.var_.actorSpriteComps1015 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1015 = nil
			end

			local var_209_2 = arg_206_1.actors_["1034"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_5 = arg_206_1.actors_["1015"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1015 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1015", 3)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(0, -340, -288)
			end

			local var_209_8 = arg_206_1.actors_["1034"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 7)

				for iter_209_9 = 0, var_209_8.childCount - 1 do
					local var_209_9 = var_209_8:GetChild(iter_209_9)

					if var_209_9.name == "" or not string.find(var_209_9.name, "split") then
						var_209_9.gameObject:SetActive(true)
					else
						var_209_9.gameObject:SetActive(false)
					end
				end
			end

			local var_209_10 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_10 then
				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_206_1.time_ - 0) / var_209_10)
			end

			if arg_206_1.time_ >= 0 + var_209_10 and arg_206_1.time_ < 0 + var_209_10 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_11 = 0
			local var_209_12 = 0.7

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_11 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_13 = arg_206_1:GetWordFromCfg(417031050)
				local var_209_14 = arg_206_1:FormatText(var_209_13.content)

				arg_206_1.text_.text = var_209_14

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_16 = 28 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 28)

				if (28 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 28)) > 0 and var_209_12 < var_209_16 then
					arg_206_1.talkMaxDuration = var_209_16

					if var_209_16 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_16 + var_209_11
					end
				end

				arg_206_1.text_.text = var_209_14
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031050", "story_v_out_417031.awb") ~= 0 then
					local var_209_17 = manager.audio:GetVoiceLength("story_v_out_417031", "417031050", "story_v_out_417031.awb") / 1000

					if var_209_17 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_11
					end

					if var_209_13.prefab_name ~= "" and arg_206_1.actors_[var_209_13.prefab_name] ~= nil then
						local var_209_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_13.prefab_name].transform, "story_v_out_417031", "417031050", "story_v_out_417031.awb")

						arg_206_1:RecordAudio("417031050", var_209_18)
						arg_206_1:RecordAudio("417031050", var_209_18)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417031", "417031050", "story_v_out_417031.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417031", "417031050", "story_v_out_417031.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_19 = math.max(var_209_12, arg_206_1.talkMaxDuration)

			if var_209_11 <= arg_206_1.time_ and arg_206_1.time_ < var_209_11 + var_209_19 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_11) / var_209_19

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_11 + var_209_19 and arg_206_1.time_ < var_209_11 + var_209_19 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play417031051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417031051
		arg_210_1.duration_ = 1.37

		local var_210_0 = {
			zh = 1.133,
			ja = 1.366
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417031052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1034"]) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = arg_210_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1034"]) then
				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1034"]) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_2 = arg_210_1.actors_["1015"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1015 == nil then
				arg_210_1.var_.actorSpriteComps1015 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps1015 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1015 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1015 = nil
			end

			local var_213_5 = 0
			local var_213_6 = 0.05

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_7 = arg_210_1:GetWordFromCfg(417031051)
				local var_213_8 = arg_210_1:FormatText(var_213_7.content)

				arg_210_1.text_.text = var_213_8

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 2 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 2)

				if (2 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 2)) > 0 and var_213_6 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_8
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031051", "story_v_out_417031.awb") ~= 0 then
					local var_213_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031051", "story_v_out_417031.awb") / 1000

					if var_213_11 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_11 + var_213_5
					end

					if var_213_7.prefab_name ~= "" and arg_210_1.actors_[var_213_7.prefab_name] ~= nil then
						local var_213_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_7.prefab_name].transform, "story_v_out_417031", "417031051", "story_v_out_417031.awb")

						arg_210_1:RecordAudio("417031051", var_213_12)
						arg_210_1:RecordAudio("417031051", var_213_12)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417031", "417031051", "story_v_out_417031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417031", "417031051", "story_v_out_417031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_13 and arg_210_1.time_ < var_213_5 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417031052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417031052
		arg_214_1.duration_ = 8.2

		local var_214_0 = {
			zh = 8.2,
			ja = 7
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417031053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1015"]) and arg_214_1.var_.actorSpriteComps1015 == nil then
				arg_214_1.var_.actorSpriteComps1015 = arg_214_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1015"]) then
				if arg_214_1.var_.actorSpriteComps1015 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1015"]) and arg_214_1.var_.actorSpriteComps1015 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1015 = nil
			end

			local var_217_2 = arg_214_1.actors_["1034"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1034 == nil then
				arg_214_1.var_.actorSpriteComps1034 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps1034 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_5.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_5.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1034 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps1034 = nil
			end

			local var_217_5 = 0
			local var_217_6 = 1.1

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(417031052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 44 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 44)

				if (44 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 44)) > 0 and var_217_6 < var_217_10 then
					arg_214_1.talkMaxDuration = var_217_10

					if var_217_10 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031052", "story_v_out_417031.awb") ~= 0 then
					local var_217_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031052", "story_v_out_417031.awb") / 1000

					if var_217_11 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_5
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_417031", "417031052", "story_v_out_417031.awb")

						arg_214_1:RecordAudio("417031052", var_217_12)
						arg_214_1:RecordAudio("417031052", var_217_12)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417031", "417031052", "story_v_out_417031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417031", "417031052", "story_v_out_417031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_13 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_13

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_13 and arg_214_1.time_ < var_217_5 + var_217_13 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417031053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417031053
		arg_218_1.duration_ = 10.37

		local var_218_0 = {
			zh = 9.8,
			ja = 10.366
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417031054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1015 = arg_218_1.actors_["1015"].transform.localPosition
				arg_218_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1015", 3)

				for iter_221_0 = 0, arg_218_1.actors_["1015"].transform.childCount - 1 do
					local var_221_0 = arg_218_1.actors_["1015"].transform:GetChild(iter_221_0)

					if var_221_0.name == "" or not string.find(var_221_0.name, "split") then
						var_221_0.gameObject:SetActive(true)
					else
						var_221_0.gameObject:SetActive(false)
					end
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_218_1.time_ - 0) / var_221_1)
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["1015"].transform.localPosition = Vector3.New(0, -340, -288)
			end

			local var_221_2 = 0
			local var_221_3 = 0.975

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:GetWordFromCfg(417031053)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 39 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 39)

				if (39 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 39)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031053", "story_v_out_417031.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031053", "story_v_out_417031.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_417031", "417031053", "story_v_out_417031.awb")

						arg_218_1:RecordAudio("417031053", var_221_9)
						arg_218_1:RecordAudio("417031053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417031", "417031053", "story_v_out_417031.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417031", "417031053", "story_v_out_417031.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play417031054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417031054
		arg_222_1.duration_ = 8.2

		local var_222_0 = {
			zh = 5.566,
			ja = 8.2
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417031055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1015 = arg_222_1.actors_["1015"].transform.localPosition
				arg_222_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1015", 3)

				for iter_225_0 = 0, arg_222_1.actors_["1015"].transform.childCount - 1 do
					local var_225_0 = arg_222_1.actors_["1015"].transform:GetChild(iter_225_0)

					if var_225_0.name == "split_4" or not string.find(var_225_0.name, "split") then
						var_225_0.gameObject:SetActive(true)
					else
						var_225_0.gameObject:SetActive(false)
					end
				end
			end

			local var_225_1 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 then
				arg_222_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1015, Vector3.New(0, -340, -288), (arg_222_1.time_ - 0) / var_225_1)
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 then
				arg_222_1.actors_["1015"].transform.localPosition = Vector3.New(0, -340, -288)
			end

			local var_225_2 = 0
			local var_225_3 = 0.525

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_4 = arg_222_1:GetWordFromCfg(417031054)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 21 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 21)

				if (21 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 21)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031054", "story_v_out_417031.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031054", "story_v_out_417031.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_out_417031", "417031054", "story_v_out_417031.awb")

						arg_222_1:RecordAudio("417031054", var_225_9)
						arg_222_1:RecordAudio("417031054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417031", "417031054", "story_v_out_417031.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417031", "417031054", "story_v_out_417031.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play417031055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417031055
		arg_226_1.duration_ = 6.52

		local var_226_0 = {
			zh = 5.983,
			ja = 6.516
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417031056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if arg_226_1.bgs_.I07a == nil then
				local var_229_0 = Object.Instantiate(arg_226_1.paintGo_)

				var_229_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_229_0.name = "I07a"
				var_229_0.transform.parent = arg_226_1.stage_.transform
				var_229_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.bgs_.I07a = var_229_0
			end

			if 2 < arg_226_1.time_ and arg_226_1.time_ <= 2 + arg_229_0 then
				local var_229_1 = arg_226_1.bgs_.I07a

				arg_226_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_229_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_229_2 = var_229_1:GetComponent("SpriteRenderer")

				if var_229_2 and var_229_2.sprite then
					local var_229_3 = 2 * (var_229_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_229_1.transform.localScale = Vector3.New(var_229_3 / var_229_2.sprite.bounds.size.y < var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x and var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x or var_229_3 / var_229_2.sprite.bounds.size.y, var_229_3 / var_229_2.sprite.bounds.size.y < var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x and var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x or var_229_3 / var_229_2.sprite.bounds.size.y, 0)
				end

				for iter_229_0, iter_229_1 in pairs(arg_226_1.bgs_) do
					if iter_229_0 ~= "I07a" then
						iter_229_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_229_4 = 0

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.allBtn_.enabled = false
			end

			if arg_226_1.time_ >= var_229_4 + 0.3 and arg_226_1.time_ < var_229_4 + 0.3 + arg_229_0 then
				arg_226_1.allBtn_.enabled = true
			end

			local var_229_5 = 0

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_6 = 2

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_6 then
				local var_229_7 = Color.New(0, 0, 0)

				var_229_7.a = Mathf.Lerp(0, 1, (arg_226_1.time_ - var_229_5) / var_229_6)
				arg_226_1.mask_.color = var_229_7
			end

			if arg_226_1.time_ >= var_229_5 + var_229_6 and arg_226_1.time_ < var_229_5 + var_229_6 + arg_229_0 then
				local var_229_8 = Color.New(0, 0, 0)

				var_229_8.a = 1
				arg_226_1.mask_.color = var_229_8
			end

			local var_229_9 = 2

			if 2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_10 = 2

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 then
				local var_229_11 = Color.New(0, 0, 0)

				var_229_11.a = Mathf.Lerp(1, 0, (arg_226_1.time_ - var_229_9) / var_229_10)
				arg_226_1.mask_.color = var_229_11
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 then
				local var_229_12 = Color.New(0, 0, 0)

				arg_226_1.mask_.enabled = false
				var_229_12.a = 0
				arg_226_1.mask_.color = var_229_12
			end

			local var_229_13 = arg_226_1.actors_["1015"].transform

			if 1.96666666666667 < arg_226_1.time_ and arg_226_1.time_ <= 1.96666666666667 + arg_229_0 then
				arg_226_1.var_.moveOldPos1015 = var_229_13.localPosition
				var_229_13.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1015", 7)

				for iter_229_2 = 0, var_229_13.childCount - 1 do
					local var_229_14 = var_229_13:GetChild(iter_229_2)

					if var_229_14.name == "" or not string.find(var_229_14.name, "split") then
						var_229_14.gameObject:SetActive(true)
					else
						var_229_14.gameObject:SetActive(false)
					end
				end
			end

			local var_229_15 = 0.001

			if 1.96666666666667 <= arg_226_1.time_ and arg_226_1.time_ < 1.96666666666667 + var_229_15 then
				var_229_13.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_226_1.time_ - 1.96666666666667) / var_229_15)
			end

			if arg_226_1.time_ >= 1.96666666666667 + var_229_15 and arg_226_1.time_ < 1.96666666666667 + var_229_15 + arg_229_0 then
				var_229_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_16 = arg_226_1.actors_["1034"].transform

			if 1.96666666666667 < arg_226_1.time_ and arg_226_1.time_ <= 1.96666666666667 + arg_229_0 then
				arg_226_1.var_.moveOldPos1034 = var_229_16.localPosition
				var_229_16.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1034", 7)

				for iter_229_3 = 0, var_229_16.childCount - 1 do
					local var_229_17 = var_229_16:GetChild(iter_229_3)

					if var_229_17.name == "" or not string.find(var_229_17.name, "split") then
						var_229_17.gameObject:SetActive(true)
					else
						var_229_17.gameObject:SetActive(false)
					end
				end
			end

			local var_229_18 = 0.001

			if 1.96666666666667 <= arg_226_1.time_ and arg_226_1.time_ < 1.96666666666667 + var_229_18 then
				var_229_16.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_226_1.time_ - 1.96666666666667) / var_229_18)
			end

			if arg_226_1.time_ >= 1.96666666666667 + var_229_18 and arg_226_1.time_ < 1.96666666666667 + var_229_18 + arg_229_0 then
				var_229_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_19 = 2.00066666666667

			arg_226_1.isInRecall_ = true

			if var_229_19 < arg_226_1.time_ and arg_226_1.time_ <= var_229_19 + arg_229_0 then
				arg_226_1.screenFilterGo_:SetActive(true)

				arg_226_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_226_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_226_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_229_4, iter_229_5 in pairs(arg_226_1.actors_) do
					for iter_229_6, iter_229_7 in ipairs((iter_229_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_229_7.color = iter_229_7.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_229_20 = 0.0166666666666667

			if var_229_19 <= arg_226_1.time_ and arg_226_1.time_ < var_229_19 + var_229_20 then
				arg_226_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_226_1.time_ - var_229_19) / var_229_20)
			end

			if arg_226_1.time_ >= var_229_19 + var_229_20 and arg_226_1.time_ < var_229_19 + var_229_20 + arg_229_0 then
				arg_226_1.screenFilterEffect_.weight = 1
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_21 = 3.75
			local var_229_22 = 0.25

			if 3.75 < arg_226_1.time_ and arg_226_1.time_ <= var_229_21 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_23 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_23:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1118].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_226_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_229_24 = arg_226_1:GetWordFromCfg(417031055)
				local var_229_25 = arg_226_1:FormatText(var_229_24.content)

				arg_226_1.text_.text = var_229_25

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_27 = 10 <= 0 and var_229_22 or var_229_22 * (utf8.len(var_229_25) / 10)

				if (10 <= 0 and var_229_22 or var_229_22 * (utf8.len(var_229_25) / 10)) > 0 and var_229_22 < var_229_27 then
					arg_226_1.talkMaxDuration = var_229_27
					var_229_21 = var_229_21 + 0.3

					if var_229_27 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_27 + var_229_21
					end
				end

				arg_226_1.text_.text = var_229_25
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031055", "story_v_out_417031.awb") ~= 0 then
					local var_229_28 = manager.audio:GetVoiceLength("story_v_out_417031", "417031055", "story_v_out_417031.awb") / 1000

					if var_229_28 + var_229_21 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_28 + var_229_21
					end

					if var_229_24.prefab_name ~= "" and arg_226_1.actors_[var_229_24.prefab_name] ~= nil then
						local var_229_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_24.prefab_name].transform, "story_v_out_417031", "417031055", "story_v_out_417031.awb")

						arg_226_1:RecordAudio("417031055", var_229_29)
						arg_226_1:RecordAudio("417031055", var_229_29)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417031", "417031055", "story_v_out_417031.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417031", "417031055", "story_v_out_417031.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_30 = var_229_21 + 0.3
			local var_229_31 = math.max(var_229_22, arg_226_1.talkMaxDuration)

			if var_229_21 + 0.3 <= arg_226_1.time_ and arg_226_1.time_ < var_229_30 + var_229_31 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_30) / var_229_31

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_30 + var_229_31 and arg_226_1.time_ < var_229_30 + var_229_31 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play417031056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 417031056
		arg_232_1.duration_ = 4.1

		local var_232_0 = {
			zh = 1.466,
			ja = 4.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play417031057(arg_232_1)
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
								iter_235_1.color = Color.New(Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_0), Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_0), (Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_0)))
							else
								local var_235_1 = Mathf.Lerp(iter_235_1.color.r, 1, (arg_232_1.time_ - 0) / var_235_0)

								iter_235_1.color = Color.New(var_235_1, var_235_1, var_235_1)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1034"]) and arg_232_1.var_.actorSpriteComps1034 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_235_3 then
						iter_235_3.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps1034 = nil
			end

			local var_235_2 = arg_232_1.actors_["1034"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1034 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1034", 3)

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
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_235_5 = 0
			local var_235_6 = 0.125

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:GetWordFromCfg(417031056)
				local var_235_8 = arg_232_1:FormatText(var_235_7.content)

				arg_232_1.text_.text = var_235_8

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 5 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 5)

				if (5 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 5)) > 0 and var_235_6 < var_235_10 then
					arg_232_1.talkMaxDuration = var_235_10

					if var_235_10 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_8
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031056", "story_v_out_417031.awb") ~= 0 then
					local var_235_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031056", "story_v_out_417031.awb") / 1000

					if var_235_11 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_5
					end

					if var_235_7.prefab_name ~= "" and arg_232_1.actors_[var_235_7.prefab_name] ~= nil then
						local var_235_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_7.prefab_name].transform, "story_v_out_417031", "417031056", "story_v_out_417031.awb")

						arg_232_1:RecordAudio("417031056", var_235_12)
						arg_232_1:RecordAudio("417031056", var_235_12)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_417031", "417031056", "story_v_out_417031.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_417031", "417031056", "story_v_out_417031.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_13 and arg_232_1.time_ < var_235_5 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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
	Play417031057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417031057
		arg_236_1.duration_ = 7.6

		local var_236_0 = {
			zh = 7.033,
			ja = 7.6
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
				arg_236_0:Play417031058(arg_236_1)
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
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1034"]) and arg_236_1.var_.actorSpriteComps1034 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps1034 = nil
			end

			local var_239_2 = 0
			local var_239_3 = 0.575

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1118].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_236_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_239_4 = arg_236_1:GetWordFromCfg(417031057)
				local var_239_5 = arg_236_1:FormatText(var_239_4.content)

				arg_236_1.text_.text = var_239_5

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 23 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 23)

				if (23 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 23)) > 0 and var_239_3 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_5
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031057", "story_v_out_417031.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031057", "story_v_out_417031.awb") / 1000

					if var_239_8 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_2
					end

					if var_239_4.prefab_name ~= "" and arg_236_1.actors_[var_239_4.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_4.prefab_name].transform, "story_v_out_417031", "417031057", "story_v_out_417031.awb")

						arg_236_1:RecordAudio("417031057", var_239_9)
						arg_236_1:RecordAudio("417031057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_417031", "417031057", "story_v_out_417031.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_417031", "417031057", "story_v_out_417031.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_10 and arg_236_1.time_ < var_239_2 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417031058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417031058
		arg_240_1.duration_ = 11.33

		local var_240_0 = {
			zh = 11.333,
			ja = 9.633
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
				arg_240_0:Play417031059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.075

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1118].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:GetWordFromCfg(417031058)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 43 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 43)

				if (43 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 43)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031058", "story_v_out_417031.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031058", "story_v_out_417031.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_417031", "417031058", "story_v_out_417031.awb")

						arg_240_1:RecordAudio("417031058", var_243_6)
						arg_240_1:RecordAudio("417031058", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417031", "417031058", "story_v_out_417031.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417031", "417031058", "story_v_out_417031.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417031059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417031059
		arg_244_1.duration_ = 3.77

		local var_244_0 = {
			zh = 3.366,
			ja = 3.766
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
				arg_244_0:Play417031060(arg_244_1)
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

			local var_247_2 = arg_244_1.actors_["1034"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1034 = var_247_2.localPosition
				var_247_2.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1034", 3)

				for iter_247_4 = 0, var_247_2.childCount - 1 do
					local var_247_3 = var_247_2:GetChild(iter_247_4)

					if var_247_3.name == "split_6" or not string.find(var_247_3.name, "split") then
						var_247_3.gameObject:SetActive(true)
					else
						var_247_3.gameObject:SetActive(false)
					end
				end
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_2.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_244_1.time_ - 0) / var_247_4)
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_247_5 = 0
			local var_247_6 = 0.475

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
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

				local var_247_7 = arg_244_1:GetWordFromCfg(417031059)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_10 = 19 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 19)

				if (19 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 19)) > 0 and var_247_6 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031059", "story_v_out_417031.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031059", "story_v_out_417031.awb") / 1000

					if var_247_11 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_5
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_417031", "417031059", "story_v_out_417031.awb")

						arg_244_1:RecordAudio("417031059", var_247_12)
						arg_244_1:RecordAudio("417031059", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417031", "417031059", "story_v_out_417031.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417031", "417031059", "story_v_out_417031.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_13 and arg_244_1.time_ < var_247_5 + var_247_13 + arg_247_0 then
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
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play417031060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417031060
		arg_248_1.duration_ = 9.37

		local var_248_0 = {
			zh = 9.366,
			ja = 8.633
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
				arg_248_0:Play417031061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1034"]) and arg_248_1.var_.actorSpriteComps1034 == nil then
				arg_248_1.var_.actorSpriteComps1034 = arg_248_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1034"]) then
				if arg_248_1.var_.actorSpriteComps1034 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								iter_251_1.color = Color.New(Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor2.r, (arg_248_1.time_ - 0) / var_251_0), Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor2.g, (arg_248_1.time_ - 0) / var_251_0), (Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor2.b, (arg_248_1.time_ - 0) / var_251_0)))
							else
								local var_251_1 = Mathf.Lerp(iter_251_1.color.r, 0.5, (arg_248_1.time_ - 0) / var_251_0)

								iter_251_1.color = Color.New(var_251_1, var_251_1, var_251_1)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1034"]) and arg_248_1.var_.actorSpriteComps1034 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_251_3 then
						iter_251_3.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_248_1.var_.actorSpriteComps1034 = nil
			end

			local var_251_2 = 0
			local var_251_3 = 0.875

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1118].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_4 = arg_248_1:GetWordFromCfg(417031060)
				local var_251_5 = arg_248_1:FormatText(var_251_4.content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 35 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 35)

				if (35 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 35)) > 0 and var_251_3 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031060", "story_v_out_417031.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031060", "story_v_out_417031.awb") / 1000

					if var_251_8 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_2
					end

					if var_251_4.prefab_name ~= "" and arg_248_1.actors_[var_251_4.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_4.prefab_name].transform, "story_v_out_417031", "417031060", "story_v_out_417031.awb")

						arg_248_1:RecordAudio("417031060", var_251_9)
						arg_248_1:RecordAudio("417031060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417031", "417031060", "story_v_out_417031.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417031", "417031060", "story_v_out_417031.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_10 and arg_248_1.time_ < var_251_2 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417031061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417031061
		arg_252_1.duration_ = 8.13

		local var_252_0 = {
			zh = 7.666,
			ja = 8.133
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417031062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.625

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1118].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:GetWordFromCfg(417031061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 25 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 25)

				if (25 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 25)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031061", "story_v_out_417031.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031061", "story_v_out_417031.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_417031", "417031061", "story_v_out_417031.awb")

						arg_252_1:RecordAudio("417031061", var_255_6)
						arg_252_1:RecordAudio("417031061", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417031", "417031061", "story_v_out_417031.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417031", "417031061", "story_v_out_417031.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417031062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417031062
		arg_256_1.duration_ = 8.9

		local var_256_0 = {
			zh = 8.899999999999,
			ja = 6.965999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417031063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if arg_256_1.bgs_.ST04c == nil then
				local var_259_0 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04c")
				var_259_0.name = "ST04c"
				var_259_0.transform.parent = arg_256_1.stage_.transform
				var_259_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_.ST04c = var_259_0
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				local var_259_1 = arg_256_1.bgs_.ST04c

				arg_256_1.bgs_.ST04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_259_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_2 = var_259_1:GetComponent("SpriteRenderer")

				if var_259_2 and var_259_2.sprite then
					local var_259_3 = 2 * (var_259_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_259_1.transform.localScale = Vector3.New(var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "ST04c" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_4 = 2

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			if arg_256_1.time_ >= var_259_4 + 0.3 and arg_256_1.time_ < var_259_4 + 0.3 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_5 = 0

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_6 = 2

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 then
				local var_259_7 = Color.New(0, 0, 0)

				var_259_7.a = Mathf.Lerp(0, 1, (arg_256_1.time_ - var_259_5) / var_259_6)
				arg_256_1.mask_.color = var_259_7
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 then
				local var_259_8 = Color.New(0, 0, 0)

				var_259_8.a = 1
				arg_256_1.mask_.color = var_259_8
			end

			local var_259_9 = 2

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_10 = 2

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 then
				local var_259_11 = Color.New(0, 0, 0)

				var_259_11.a = Mathf.Lerp(1, 0, (arg_256_1.time_ - var_259_9) / var_259_10)
				arg_256_1.mask_.color = var_259_11
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 then
				local var_259_12 = Color.New(0, 0, 0)

				arg_256_1.mask_.enabled = false
				var_259_12.a = 0
				arg_256_1.mask_.color = var_259_12
			end

			local var_259_13 = arg_256_1.actors_["1034"].transform

			if 1.966 < arg_256_1.time_ and arg_256_1.time_ <= 1.966 + arg_259_0 then
				arg_256_1.var_.moveOldPos1034 = var_259_13.localPosition
				var_259_13.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("1034", 7)

				for iter_259_2 = 0, var_259_13.childCount - 1 do
					local var_259_14 = var_259_13:GetChild(iter_259_2)

					if var_259_14.name == "" or not string.find(var_259_14.name, "split") then
						var_259_14.gameObject:SetActive(true)
					else
						var_259_14.gameObject:SetActive(false)
					end
				end
			end

			local var_259_15 = 0.001

			if 1.966 <= arg_256_1.time_ and arg_256_1.time_ < 1.966 + var_259_15 then
				var_259_13.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_256_1.time_ - 1.966) / var_259_15)
			end

			if arg_256_1.time_ >= 1.966 + var_259_15 and arg_256_1.time_ < 1.966 + var_259_15 + arg_259_0 then
				var_259_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_259_16 = 2

			arg_256_1.isInRecall_ = false

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 then
				arg_256_1.screenFilterGo_:SetActive(false)

				for iter_259_3, iter_259_4 in pairs(arg_256_1.actors_) do
					for iter_259_5, iter_259_6 in ipairs((iter_259_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_259_6.color = iter_259_6.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_259_17 = 0.0166666666666667

			if var_259_16 <= arg_256_1.time_ and arg_256_1.time_ < var_259_16 + var_259_17 then
				arg_256_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_256_1.time_ - var_259_16) / var_259_17)
			end

			if arg_256_1.time_ >= var_259_16 + var_259_17 and arg_256_1.time_ < var_259_16 + var_259_17 + arg_259_0 then
				arg_256_1.screenFilterEffect_.weight = 0
			end

			if 1.53333333333333 < arg_256_1.time_ and arg_256_1.time_ <= 1.53333333333333 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.966 < arg_256_1.time_ and arg_256_1.time_ <= 0.966 + arg_259_0 then
				arg_256_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_259_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_21 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_21

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_21
						arg_256_1.bgmTxt2_.text = var_259_21
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_22 = 3.699999999999
			local var_259_23 = 0.575

			if 3.699999999999 < arg_256_1.time_ and arg_256_1.time_ <= var_259_22 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_24 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_24:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_256_1.dialogCg_.alpha = arg_261_0
				end))
				var_259_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_25 = arg_256_1:GetWordFromCfg(417031062)
				local var_259_26 = arg_256_1:FormatText(var_259_25.content)

				arg_256_1.text_.text = var_259_26

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_28 = 23 <= 0 and var_259_23 or var_259_23 * (utf8.len(var_259_26) / 23)

				if (23 <= 0 and var_259_23 or var_259_23 * (utf8.len(var_259_26) / 23)) > 0 and var_259_23 < var_259_28 then
					arg_256_1.talkMaxDuration = var_259_28
					var_259_22 = var_259_22 + 0.3

					if var_259_28 + var_259_22 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_28 + var_259_22
					end
				end

				arg_256_1.text_.text = var_259_26
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031062", "story_v_out_417031.awb") ~= 0 then
					local var_259_29 = manager.audio:GetVoiceLength("story_v_out_417031", "417031062", "story_v_out_417031.awb") / 1000

					if var_259_29 + var_259_22 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_29 + var_259_22
					end

					if var_259_25.prefab_name ~= "" and arg_256_1.actors_[var_259_25.prefab_name] ~= nil then
						local var_259_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_25.prefab_name].transform, "story_v_out_417031", "417031062", "story_v_out_417031.awb")

						arg_256_1:RecordAudio("417031062", var_259_30)
						arg_256_1:RecordAudio("417031062", var_259_30)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417031", "417031062", "story_v_out_417031.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417031", "417031062", "story_v_out_417031.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_31 = var_259_22 + 0.3
			local var_259_32 = math.max(var_259_23, arg_256_1.talkMaxDuration)

			if var_259_22 + 0.3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_31 + var_259_32 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_31) / var_259_32

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_31 + var_259_32 and arg_256_1.time_ < var_259_31 + var_259_32 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play417031063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417031063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play417031064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.5

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(417031063).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 60 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 60)

				if (60 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 60)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play417031064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417031064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play417031065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.425

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(417031064).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 57 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 57)

				if (57 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 57)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417031065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417031065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play417031066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0.05 < arg_271_1.time_ and arg_271_1.time_ <= 0.05 + arg_274_0 then
				arg_271_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_splash", "")
			end

			local var_274_1 = 0
			local var_274_2 = 1.225

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(417031065).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 49 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 49)

				if (49 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 49)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play417031066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417031066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play417031067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1034"]) and arg_275_1.var_.actorSpriteComps1034 == nil then
				arg_275_1.var_.actorSpriteComps1034 = arg_275_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1034"]) then
				if arg_275_1.var_.actorSpriteComps1034 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 1, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1034"]) and arg_275_1.var_.actorSpriteComps1034 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps1034 = nil
			end

			local var_278_2 = arg_275_1.actors_["1034"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1034 = var_278_2.localPosition
				var_278_2.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("1034", 3)

				for iter_278_4 = 0, var_278_2.childCount - 1 do
					local var_278_3 = var_278_2:GetChild(iter_278_4)

					if var_278_3.name == "split_4" or not string.find(var_278_3.name, "split") then
						var_278_3.gameObject:SetActive(true)
					else
						var_278_3.gameObject:SetActive(false)
					end
				end
			end

			local var_278_4 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				var_278_2.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_275_1.time_ - 0) / var_278_4)
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				var_278_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 0.05 < arg_275_1.time_ and arg_275_1.time_ <= 0.05 + arg_278_0 then
				arg_275_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_278_6 = 0
			local var_278_7 = 0.05

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(417031066).content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 2 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_8) / 2)

				if (2 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_8) / 2)) > 0 and var_278_7 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_11 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_11 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_11

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_11 and arg_275_1.time_ < var_278_6 + var_278_11 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play417031067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417031067
		arg_279_1.duration_ = 2.57

		local var_279_0 = {
			zh = 2,
			ja = 2.566
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play417031068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.125

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(417031067)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 5 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 5)

				if (5 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 5)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031067", "story_v_out_417031.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031067", "story_v_out_417031.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_417031", "417031067", "story_v_out_417031.awb")

						arg_279_1:RecordAudio("417031067", var_282_6)
						arg_279_1:RecordAudio("417031067", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417031", "417031067", "story_v_out_417031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417031", "417031067", "story_v_out_417031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play417031068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417031068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play417031069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1034"]) and arg_283_1.var_.actorSpriteComps1034 == nil then
				arg_283_1.var_.actorSpriteComps1034 = arg_283_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1034"]) then
				if arg_283_1.var_.actorSpriteComps1034 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1034"]) and arg_283_1.var_.actorSpriteComps1034 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps1034 = nil
			end

			local var_286_2 = 0
			local var_286_3 = 1.325

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(417031068).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 53 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 53)

				if (53 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 53)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play417031069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417031069
		arg_287_1.duration_ = 7.3

		local var_287_0 = {
			zh = 5.833,
			ja = 7.3
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
				arg_287_0:Play417031070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.675

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_287_1.callingController_:SetSelectedState("calling")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(417031069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 27 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 27)

				if (27 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 27)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031069", "story_v_out_417031.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031069", "story_v_out_417031.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_417031", "417031069", "story_v_out_417031.awb")

						arg_287_1:RecordAudio("417031069", var_290_6)
						arg_287_1:RecordAudio("417031069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_417031", "417031069", "story_v_out_417031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_417031", "417031069", "story_v_out_417031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play417031070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417031070
		arg_291_1.duration_ = 8.83

		local var_291_0 = {
			zh = 5.3,
			ja = 8.833
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
				arg_291_0:Play417031071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1034"]) and arg_291_1.var_.actorSpriteComps1034 == nil then
				arg_291_1.var_.actorSpriteComps1034 = arg_291_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1034"]) then
				if arg_291_1.var_.actorSpriteComps1034 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 1, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1034"]) and arg_291_1.var_.actorSpriteComps1034 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps1034 = nil
			end

			local var_294_2 = arg_291_1.actors_["1034"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034 = var_294_2.localPosition
				var_294_2.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1034", 3)

				for iter_294_4 = 0, var_294_2.childCount - 1 do
					local var_294_3 = var_294_2:GetChild(iter_294_4)

					if var_294_3.name == "split_6" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				var_294_2.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_291_1.time_ - 0) / var_294_4)
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				var_294_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_294_5 = 0
			local var_294_6 = 0.6

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_7 = arg_291_1:GetWordFromCfg(417031070)
				local var_294_8 = arg_291_1:FormatText(var_294_7.content)

				arg_291_1.text_.text = var_294_8

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_10 = 24 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 24)

				if (24 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_8) / 24)) > 0 and var_294_6 < var_294_10 then
					arg_291_1.talkMaxDuration = var_294_10

					if var_294_10 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_8
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031070", "story_v_out_417031.awb") ~= 0 then
					local var_294_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031070", "story_v_out_417031.awb") / 1000

					if var_294_11 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_5
					end

					if var_294_7.prefab_name ~= "" and arg_291_1.actors_[var_294_7.prefab_name] ~= nil then
						local var_294_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_7.prefab_name].transform, "story_v_out_417031", "417031070", "story_v_out_417031.awb")

						arg_291_1:RecordAudio("417031070", var_294_12)
						arg_291_1:RecordAudio("417031070", var_294_12)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_417031", "417031070", "story_v_out_417031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_417031", "417031070", "story_v_out_417031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_13 = math.max(var_294_6, arg_291_1.talkMaxDuration)

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_13 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_5) / var_294_13

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_5 + var_294_13 and arg_291_1.time_ < var_294_5 + var_294_13 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play417031071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417031071
		arg_295_1.duration_ = 7.97

		local var_295_0 = {
			zh = 5.7,
			ja = 7.966
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
				arg_295_0:Play417031072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1034"]) and arg_295_1.var_.actorSpriteComps1034 == nil then
				arg_295_1.var_.actorSpriteComps1034 = arg_295_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1034"]) then
				if arg_295_1.var_.actorSpriteComps1034 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1034"]) and arg_295_1.var_.actorSpriteComps1034 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps1034 = nil
			end

			local var_298_2 = 0
			local var_298_3 = 0.775

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_295_1.callingController_:SetSelectedState("calling")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_4 = arg_295_1:GetWordFromCfg(417031071)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 31 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 31)

				if (31 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 31)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031071", "story_v_out_417031.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031071", "story_v_out_417031.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_out_417031", "417031071", "story_v_out_417031.awb")

						arg_295_1:RecordAudio("417031071", var_298_9)
						arg_295_1:RecordAudio("417031071", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417031", "417031071", "story_v_out_417031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417031", "417031071", "story_v_out_417031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play417031072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 417031072
		arg_299_1.duration_ = 3.87

		local var_299_0 = {
			zh = 2.433,
			ja = 3.866
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
				arg_299_0:Play417031073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1034"]) and arg_299_1.var_.actorSpriteComps1034 == nil then
				arg_299_1.var_.actorSpriteComps1034 = arg_299_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1034"]) then
				if arg_299_1.var_.actorSpriteComps1034 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								iter_302_1.color = Color.New(Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_0), Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_0), (Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_0)))
							else
								local var_302_1 = Mathf.Lerp(iter_302_1.color.r, 1, (arg_299_1.time_ - 0) / var_302_0)

								iter_302_1.color = Color.New(var_302_1, var_302_1, var_302_1)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1034"]) and arg_299_1.var_.actorSpriteComps1034 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps1034 = nil
			end

			local var_302_2 = arg_299_1.actors_["1034"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1034 = var_302_2.localPosition
				var_302_2.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1034", 3)

				for iter_302_4 = 0, var_302_2.childCount - 1 do
					local var_302_3 = var_302_2:GetChild(iter_302_4)

					if var_302_3.name == "split_6" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				var_302_2.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_299_1.time_ - 0) / var_302_4)
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				var_302_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_302_5 = 0
			local var_302_6 = 0.275

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(417031072)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 11 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 11)

				if (11 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 11)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031072", "story_v_out_417031.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031072", "story_v_out_417031.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_417031", "417031072", "story_v_out_417031.awb")

						arg_299_1:RecordAudio("417031072", var_302_12)
						arg_299_1:RecordAudio("417031072", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_417031", "417031072", "story_v_out_417031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_417031", "417031072", "story_v_out_417031.awb")
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
				actorName = "1034",
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
	Play417031073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 417031073
		arg_303_1.duration_ = 5.3

		local var_303_0 = {
			zh = 2.833,
			ja = 5.3
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
				arg_303_0:Play417031074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1034"]) and arg_303_1.var_.actorSpriteComps1034 == nil then
				arg_303_1.var_.actorSpriteComps1034 = arg_303_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1034"]) then
				if arg_303_1.var_.actorSpriteComps1034 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1034"]) and arg_303_1.var_.actorSpriteComps1034 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps1034 = nil
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_306_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_4 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_4

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_4
						arg_303_1.bgmTxt2_.text = var_306_4
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.5 < arg_303_1.time_ and arg_303_1.time_ <= 0.5 + arg_306_0 then
				arg_303_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_306_7 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_7 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_7

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_7
						arg_303_1.bgmTxt2_.text = var_306_7
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_8 = 0
			local var_306_9 = 0.325

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_303_1.callingController_:SetSelectedState("calling")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_10 = arg_303_1:GetWordFromCfg(417031073)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 13 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 13)

				if (13 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 13)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031073", "story_v_out_417031.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031073", "story_v_out_417031.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_417031", "417031073", "story_v_out_417031.awb")

						arg_303_1:RecordAudio("417031073", var_306_15)
						arg_303_1:RecordAudio("417031073", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_417031", "417031073", "story_v_out_417031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_417031", "417031073", "story_v_out_417031.awb")
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

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play417031074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 417031074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play417031075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1034 = arg_309_1.actors_["1034"].transform.localPosition
				arg_309_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1034", 7)

				for iter_312_0 = 0, arg_309_1.actors_["1034"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["1034"].transform:GetChild(iter_312_0)

					if var_312_0.name == "" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_312_2 = 0
			local var_312_3 = 0.7

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(417031074).content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 57 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 57)

				if (57 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 57)) > 0 and var_312_3 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_7 and arg_309_1.time_ < var_312_2 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play417031075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417031075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play417031076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 1.425

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(417031075).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 57 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 57)

				if (57 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 57)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play417031076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 417031076
		arg_317_1.duration_ = 5.8

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play417031077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 1.334 < arg_317_1.time_ and arg_317_1.time_ <= 1.334 + arg_320_0 then
				arg_317_1.cswbg_:SetActive(true)

				local var_320_0 = arg_317_1.cswt_:GetComponent("RectTransform")

				arg_317_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_320_0.offsetMin = Vector2.New(400, 105)
				var_320_0.offsetMax = Vector2.New(-400, -200)
				arg_317_1.cswt_.text = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(419096).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.cswt_)

				arg_317_1.cswt_.fontSize = 105
				arg_317_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_317_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.3 < arg_317_1.time_ and arg_317_1.time_ <= 1.3 + arg_320_0 then
				local var_320_1 = arg_317_1.fswbg_.transform:Find("textbox/adapt/content") or arg_317_1.fswbg_.transform:Find("textbox/content")
				local var_320_2 = arg_317_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_320_3 = var_320_1:GetComponent("RectTransform")

				var_320_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_320_3.offsetMin = Vector2.New(0, 0)
				var_320_3.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_317_1.time_ and arg_317_1.time_ <= 1.3 + arg_320_0 then
				arg_317_1.fswbg_:SetActive(true)
				arg_317_1.dialog_:SetActive(false)

				arg_317_1.fswtw_.percent = 0
				arg_317_1.fswt_.text = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(417031076).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.fswt_)

				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_317_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_317_1.fswtw_:SetDirty()

				arg_317_1.typewritterCharCountI18N = 0

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_4 = 1.93333333333333

			if 1.93333333333333 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.var_.oldValueTypewriter = arg_317_1.fswtw_.percent

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_5 = 15
			local var_320_6 = 1
			local var_320_7, var_320_8 = arg_317_1:GetPercentByPara(arg_317_1:FormatText(arg_317_1:GetWordFromCfg(417031076).content), 1)

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				local var_320_9 = var_320_5 <= 0 and var_320_6 or var_320_6 * ((var_320_8 - arg_317_1.typewritterCharCountI18N) / var_320_5)

				if (var_320_5 <= 0 and var_320_6 or var_320_6 * ((var_320_8 - arg_317_1.typewritterCharCountI18N) / var_320_5)) > 0 and var_320_6 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end
			end

			local var_320_10 = math.max(1, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_10 then
				arg_317_1.fswtw_.percent = Mathf.Lerp(arg_317_1.var_.oldValueTypewriter, var_320_7, (arg_317_1.time_ - var_320_4) / var_320_10)
				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.fswtw_:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_10 and arg_317_1.time_ < var_320_4 + var_320_10 + arg_320_0 then
				arg_317_1.fswtw_.percent = var_320_7

				arg_317_1.fswtw_:SetDirty()
				arg_317_1:ShowNextGo(true)

				arg_317_1.typewritterCharCountI18N = var_320_8
			end

			local var_320_11 = 0

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_12 = 1.3

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_12 then
				local var_320_13 = Color.New(0, 0, 0)

				var_320_13.a = Mathf.Lerp(0, 1, (arg_317_1.time_ - var_320_11) / var_320_12)
				arg_317_1.mask_.color = var_320_13
			end

			if arg_317_1.time_ >= var_320_11 + var_320_12 and arg_317_1.time_ < var_320_11 + var_320_12 + arg_320_0 then
				local var_320_14 = Color.New(0, 0, 0)

				var_320_14.a = 1
				arg_317_1.mask_.color = var_320_14
			end

			local var_320_15 = 1.3

			if 1.3 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_16 = 2

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_16 then
				local var_320_17 = Color.New(0, 0, 0)

				var_320_17.a = Mathf.Lerp(1, 0, (arg_317_1.time_ - var_320_15) / var_320_16)
				arg_317_1.mask_.color = var_320_17
			end

			if arg_317_1.time_ >= var_320_15 + var_320_16 and arg_317_1.time_ < var_320_15 + var_320_16 + arg_320_0 then
				local var_320_18 = Color.New(0, 0, 0)

				arg_317_1.mask_.enabled = false
				var_320_18.a = 0
				arg_317_1.mask_.color = var_320_18
			end

			if 1.3 < arg_317_1.time_ and arg_317_1.time_ <= 1.3 + arg_320_0 then
				local var_320_19 = arg_317_1.bgs_.STblack

				arg_317_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_320_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_20 = var_320_19:GetComponent("SpriteRenderer")

				if var_320_20 and var_320_20.sprite then
					local var_320_21 = 2 * (var_320_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_320_19.transform.localScale = Vector3.New(var_320_21 / var_320_20.sprite.bounds.size.y < var_320_21 * manager.ui.mainCameraCom_.aspect / var_320_20.sprite.bounds.size.x and var_320_21 * manager.ui.mainCameraCom_.aspect / var_320_20.sprite.bounds.size.x or var_320_21 / var_320_20.sprite.bounds.size.y, var_320_21 / var_320_20.sprite.bounds.size.y < var_320_21 * manager.ui.mainCameraCom_.aspect / var_320_20.sprite.bounds.size.x and var_320_21 * manager.ui.mainCameraCom_.aspect / var_320_20.sprite.bounds.size.x or var_320_21 / var_320_20.sprite.bounds.size.y, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "STblack" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.533333333333333 < arg_317_1.time_ and arg_317_1.time_ <= 0.533333333333333 + arg_320_0 then
				arg_317_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_320_23 = 1.93333333333333
			local var_320_24 = manager.audio:GetVoiceLength("story_v_out_417031", "417031076", "") / 1000

			if var_320_24 > 0 and 3.866 < var_320_24 and var_320_24 + var_320_23 > arg_317_1.duration_ then
				arg_317_1.duration_ = var_320_24 + var_320_23
			end

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 then
				arg_317_1:AudioAction("play", "voice", "story_v_out_417031", "417031076", "")
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play417031077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 417031077
		arg_321_1.duration_ = 3.9

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play417031078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.fswbg_:SetActive(true)
				arg_321_1.dialog_:SetActive(false)

				arg_321_1.fswtw_.percent = 0
				arg_321_1.fswt_.text = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(417031077).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.fswt_)

				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_321_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_321_1.fswtw_:SetDirty()

				arg_321_1.typewritterCharCountI18N = 0

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_0 = 0.566666666666667

			if 0.566666666666667 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_1 = 14
			local var_324_2 = 0.933333333333333
			local var_324_3, var_324_4 = arg_321_1:GetPercentByPara(arg_321_1:FormatText(arg_321_1:GetWordFromCfg(417031077).content), 1)

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_5 = var_324_1 <= 0 and var_324_2 or var_324_2 * ((var_324_4 - arg_321_1.typewritterCharCountI18N) / var_324_1)

				if (var_324_1 <= 0 and var_324_2 or var_324_2 * ((var_324_4 - arg_321_1.typewritterCharCountI18N) / var_324_1)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_0
					end
				end
			end

			local var_324_6 = math.max(0.933333333333333, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_6 then
				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_3, (arg_321_1.time_ - var_324_0) / var_324_6)
				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_6 and arg_321_1.time_ < var_324_0 + var_324_6 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_3

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_4
			end

			local var_324_7 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= var_324_7 + 0.566666666666667 and arg_321_1.time_ < var_324_7 + 0.566666666666667 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			local var_324_8 = 0.566666666666667
			local var_324_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031077", "") / 1000

			if var_324_9 > 0 and 3.333 < var_324_9 and var_324_9 + var_324_8 > arg_321_1.duration_ then
				arg_321_1.duration_ = var_324_9 + var_324_8
			end

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1:AudioAction("play", "voice", "story_v_out_417031", "417031077", "")
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play417031078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417031078
		arg_325_1.duration_ = 3.1

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play417031079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.fswbg_:SetActive(true)
				arg_325_1.dialog_:SetActive(false)

				arg_325_1.fswtw_.percent = 0
				arg_325_1.fswt_.text = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(417031078).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.fswt_)

				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_325_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_325_1.fswtw_:SetDirty()

				arg_325_1.typewritterCharCountI18N = 0

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_0 = 0.566666666666667

			if 0.566666666666667 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_1 = 10
			local var_328_2 = 0.666666666666667
			local var_328_3, var_328_4 = arg_325_1:GetPercentByPara(arg_325_1:FormatText(arg_325_1:GetWordFromCfg(417031078).content), 1)

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_5 = var_328_1 <= 0 and var_328_2 or var_328_2 * ((var_328_4 - arg_325_1.typewritterCharCountI18N) / var_328_1)

				if (var_328_1 <= 0 and var_328_2 or var_328_2 * ((var_328_4 - arg_325_1.typewritterCharCountI18N) / var_328_1)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_0
					end
				end
			end

			local var_328_6 = math.max(0.666666666666667, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_6 then
				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_3, (arg_325_1.time_ - var_328_0) / var_328_6)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_6 and arg_325_1.time_ < var_328_0 + var_328_6 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_3

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_4
			end

			local var_328_7 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_7 + 0.566666666666667 and arg_325_1.time_ < var_328_7 + 0.566666666666667 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_8 = 0.566666666666667
			local var_328_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031078", "") / 1000

			if var_328_9 > 0 and 2.533 < var_328_9 and var_328_9 + var_328_8 > arg_325_1.duration_ then
				arg_325_1.duration_ = var_328_9 + var_328_8
			end

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1:AudioAction("play", "voice", "story_v_out_417031", "417031078", "")
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417031079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 417031079
		arg_329_1.duration_ = 7.07

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play417031080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.fswbg_:SetActive(true)
				arg_329_1.dialog_:SetActive(false)

				arg_329_1.fswtw_.percent = 0
				arg_329_1.fswt_.text = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(417031079).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.fswt_)

				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_329_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_329_1.fswtw_:SetDirty()

				arg_329_1.typewritterCharCountI18N = 0

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_0 = 0.666666666666667

			if 0.666666666666667 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.var_.oldValueTypewriter = arg_329_1.fswtw_.percent

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_1 = 36
			local var_332_2 = 2.4
			local var_332_3, var_332_4 = arg_329_1:GetPercentByPara(arg_329_1:FormatText(arg_329_1:GetWordFromCfg(417031079).content), 1)

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				local var_332_5 = var_332_1 <= 0 and var_332_2 or var_332_2 * ((var_332_4 - arg_329_1.typewritterCharCountI18N) / var_332_1)

				if (var_332_1 <= 0 and var_332_2 or var_332_2 * ((var_332_4 - arg_329_1.typewritterCharCountI18N) / var_332_1)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_0
					end
				end
			end

			local var_332_6 = math.max(2.4, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_6 then
				arg_329_1.fswtw_.percent = Mathf.Lerp(arg_329_1.var_.oldValueTypewriter, var_332_3, (arg_329_1.time_ - var_332_0) / var_332_6)
				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_329_1.fswtw_:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_6 and arg_329_1.time_ < var_332_0 + var_332_6 + arg_332_0 then
				arg_329_1.fswtw_.percent = var_332_3

				arg_329_1.fswtw_:SetDirty()
				arg_329_1:ShowNextGo(true)

				arg_329_1.typewritterCharCountI18N = var_332_4
			end

			local var_332_7 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_7 + 0.666666666666667 and arg_329_1.time_ < var_332_7 + 0.666666666666667 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_8 = 0.666666666666667
			local var_332_9 = manager.audio:GetVoiceLength("story_v_out_417031", "417031079", "") / 1000

			if var_332_9 > 0 and 6.4 < var_332_9 and var_332_9 + var_332_8 > arg_329_1.duration_ then
				arg_329_1.duration_ = var_332_9 + var_332_8
			end

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1:AudioAction("play", "voice", "story_v_out_417031", "417031079", "")
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play417031080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 417031080
		arg_333_1.duration_ = 7.53

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play417031081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1034"]) and arg_333_1.var_.actorSpriteComps1034 == nil then
				arg_333_1.var_.actorSpriteComps1034 = arg_333_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1034"]) then
				if arg_333_1.var_.actorSpriteComps1034 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1034"]) and arg_333_1.var_.actorSpriteComps1034 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps1034 = nil
			end

			if 1.034 < arg_333_1.time_ and arg_333_1.time_ <= 1.034 + arg_336_0 then
				arg_333_1.cswbg_:SetActive(false)
			end

			if 1 < arg_333_1.time_ and arg_333_1.time_ <= 1 + arg_336_0 then
				arg_333_1.fswbg_:SetActive(false)
				arg_333_1.dialog_:SetActive(false)
				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_333_1:ShowNextGo(false)
			end

			if 1.034 < arg_333_1.time_ and arg_333_1.time_ <= 1.034 + arg_336_0 then
				arg_333_1.fswbg_:SetActive(false)
				arg_333_1.dialog_:SetActive(false)
				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_333_1:ShowNextGo(false)
			end

			local var_336_2 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_3 = 1

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_3 then
				local var_336_4 = Color.New(0, 0, 0)

				var_336_4.a = Mathf.Lerp(0, 1, (arg_333_1.time_ - var_336_2) / var_336_3)
				arg_333_1.mask_.color = var_336_4
			end

			if arg_333_1.time_ >= var_336_2 + var_336_3 and arg_333_1.time_ < var_336_2 + var_336_3 + arg_336_0 then
				local var_336_5 = Color.New(0, 0, 0)

				var_336_5.a = 1
				arg_333_1.mask_.color = var_336_5
			end

			local var_336_6 = 1

			if 1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_7 = 2

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_7 then
				local var_336_8 = Color.New(0, 0, 0)

				var_336_8.a = Mathf.Lerp(1, 0, (arg_333_1.time_ - var_336_6) / var_336_7)
				arg_333_1.mask_.color = var_336_8
			end

			if arg_333_1.time_ >= var_336_6 + var_336_7 and arg_333_1.time_ < var_336_6 + var_336_7 + arg_336_0 then
				local var_336_9 = Color.New(0, 0, 0)

				arg_333_1.mask_.enabled = false
				var_336_9.a = 0
				arg_333_1.mask_.color = var_336_9
			end

			if 1 < arg_333_1.time_ and arg_333_1.time_ <= 1 + arg_336_0 then
				local var_336_10 = arg_333_1.bgs_.ST04c

				arg_333_1.bgs_.ST04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_336_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_11 = var_336_10:GetComponent("SpriteRenderer")

				if var_336_11 and var_336_11.sprite then
					local var_336_12 = 2 * (var_336_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_336_10.transform.localScale = Vector3.New(var_336_12 / var_336_11.sprite.bounds.size.y < var_336_12 * manager.ui.mainCameraCom_.aspect / var_336_11.sprite.bounds.size.x and var_336_12 * manager.ui.mainCameraCom_.aspect / var_336_11.sprite.bounds.size.x or var_336_12 / var_336_11.sprite.bounds.size.y, var_336_12 / var_336_11.sprite.bounds.size.y < var_336_12 * manager.ui.mainCameraCom_.aspect / var_336_11.sprite.bounds.size.x and var_336_12 * manager.ui.mainCameraCom_.aspect / var_336_11.sprite.bounds.size.x or var_336_12 / var_336_11.sprite.bounds.size.y, 0)
				end

				for iter_336_4, iter_336_5 in pairs(arg_333_1.bgs_) do
					if iter_336_4 ~= "ST04c" then
						iter_336_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_333_1.time_ and arg_333_1.time_ <= 1 + arg_336_0 then
				arg_333_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_14 = 2.53333333333333
			local var_336_15 = 1.55

			if 2.53333333333333 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_16 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_16:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_17 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(417031080).content)

				arg_333_1.text_.text = var_336_17

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_19 = 62 <= 0 and var_336_15 or var_336_15 * (utf8.len(var_336_17) / 62)

				if (62 <= 0 and var_336_15 or var_336_15 * (utf8.len(var_336_17) / 62)) > 0 and var_336_15 < var_336_19 then
					arg_333_1.talkMaxDuration = var_336_19
					var_336_14 = var_336_14 + 0.3

					if var_336_19 + var_336_14 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_19 + var_336_14
					end
				end

				arg_333_1.text_.text = var_336_17
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_20 = var_336_14 + 0.3
			local var_336_21 = math.max(var_336_15, arg_333_1.talkMaxDuration)

			if var_336_14 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_20 + var_336_21 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_20) / var_336_21

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_20 + var_336_21 and arg_333_1.time_ < var_336_20 + var_336_21 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play417031081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 417031081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play417031082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0.5 < arg_339_1.time_ and arg_339_1.time_ <= 0.5 + arg_342_0 then
				arg_339_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_342_1 = 0
			local var_342_2 = 0.9

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(417031081).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 36 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 36)

				if (36 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 36)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play417031082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 417031082
		arg_343_1.duration_ = 7.67

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play417031083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.I05e == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05e")
				var_346_0.name = "I05e"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.I05e = var_346_0
			end

			if 1.33333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 1.33333333333333 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.I05e

				arg_343_1.bgs_.I05e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "I05e" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_4 + 0.3 and arg_343_1.time_ < var_346_4 + 0.3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_5 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_6 = 1.33333333333333

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_6 then
				local var_346_7 = Color.New(0, 0, 0)

				var_346_7.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_5) / var_346_6)
				arg_343_1.mask_.color = var_346_7
			end

			if arg_343_1.time_ >= var_346_5 + var_346_6 and arg_343_1.time_ < var_346_5 + var_346_6 + arg_346_0 then
				local var_346_8 = Color.New(0, 0, 0)

				var_346_8.a = 1
				arg_343_1.mask_.color = var_346_8
			end

			local var_346_9 = 1.33333333333333

			if 1.33333333333333 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_10 = 2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 then
				local var_346_11 = Color.New(0, 0, 0)

				var_346_11.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_9) / var_346_10)
				arg_343_1.mask_.color = var_346_11
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 then
				local var_346_12 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_12.a = 0
				arg_343_1.mask_.color = var_346_12
			end

			if 0.533333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 0.533333333333333 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_346_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_15 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_15

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_15
						arg_343_1.bgmTxt2_.text = var_346_15
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_16 = 2.67363524367102
			local var_346_17 = 1.075

			if 2.67363524367102 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_18 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_18:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_343_1.dialogCg_.alpha = arg_348_0
				end))
				var_346_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_19 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(417031082).content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 43 <= 0 and var_346_17 or var_346_17 * (utf8.len(var_346_19) / 43)

				if (43 <= 0 and var_346_17 or var_346_17 * (utf8.len(var_346_19) / 43)) > 0 and var_346_17 < var_346_21 then
					arg_343_1.talkMaxDuration = var_346_21
					var_346_16 = var_346_16 + 0.3

					if var_346_21 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_21 + var_346_16
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_22 = var_346_16 + 0.3
			local var_346_23 = math.max(var_346_17, arg_343_1.talkMaxDuration)

			if var_346_16 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_22 + var_346_23 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_22) / var_346_23

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_22 + var_346_23 and arg_343_1.time_ < var_346_22 + var_346_23 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play417031083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417031083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417031084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 1.1

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(417031083).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 44 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 44)

				if (44 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 44)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417031084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417031084
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417031085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.675

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(417031084).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 67 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 67)

				if (67 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 67)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417031085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417031085
		arg_358_1.duration_ = 8

		local var_358_0 = {
			zh = 8,
			ja = 7.633
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417031086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if arg_358_1.bgs_.ST17 == nil then
				local var_361_0 = Object.Instantiate(arg_358_1.paintGo_)

				var_361_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_361_0.name = "ST17"
				var_361_0.transform.parent = arg_358_1.stage_.transform
				var_361_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.bgs_.ST17 = var_361_0
			end

			if 1.4 < arg_358_1.time_ and arg_358_1.time_ <= 1.4 + arg_361_0 then
				local var_361_1 = arg_358_1.bgs_.ST17

				arg_358_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_361_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_361_2 = var_361_1:GetComponent("SpriteRenderer")

				if var_361_2 and var_361_2.sprite then
					local var_361_3 = 2 * (var_361_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_361_1.transform.localScale = Vector3.New(var_361_3 / var_361_2.sprite.bounds.size.y < var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x and var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x or var_361_3 / var_361_2.sprite.bounds.size.y, var_361_3 / var_361_2.sprite.bounds.size.y < var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x and var_361_3 * manager.ui.mainCameraCom_.aspect / var_361_2.sprite.bounds.size.x or var_361_3 / var_361_2.sprite.bounds.size.y, 0)
				end

				for iter_361_0, iter_361_1 in pairs(arg_358_1.bgs_) do
					if iter_361_0 ~= "ST17" then
						iter_361_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_361_4 = 0

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.allBtn_.enabled = false
			end

			if arg_358_1.time_ >= var_361_4 + 0.3 and arg_358_1.time_ < var_361_4 + 0.3 + arg_361_0 then
				arg_358_1.allBtn_.enabled = true
			end

			local var_361_5 = 0

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_6 = 1.4

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_6 then
				local var_361_7 = Color.New(0, 0, 0)

				var_361_7.a = Mathf.Lerp(0, 1, (arg_358_1.time_ - var_361_5) / var_361_6)
				arg_358_1.mask_.color = var_361_7
			end

			if arg_358_1.time_ >= var_361_5 + var_361_6 and arg_358_1.time_ < var_361_5 + var_361_6 + arg_361_0 then
				local var_361_8 = Color.New(0, 0, 0)

				var_361_8.a = 1
				arg_358_1.mask_.color = var_361_8
			end

			local var_361_9 = 1.4

			if 1.4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 then
				arg_358_1.mask_.enabled = true
				arg_358_1.mask_.raycastTarget = true

				arg_358_1:SetGaussion(false)
			end

			local var_361_10 = 2

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_10 then
				local var_361_11 = Color.New(0, 0, 0)

				var_361_11.a = Mathf.Lerp(1, 0, (arg_358_1.time_ - var_361_9) / var_361_10)
				arg_358_1.mask_.color = var_361_11
			end

			if arg_358_1.time_ >= var_361_9 + var_361_10 and arg_358_1.time_ < var_361_9 + var_361_10 + arg_361_0 then
				local var_361_12 = Color.New(0, 0, 0)

				arg_358_1.mask_.enabled = false
				var_361_12.a = 0
				arg_358_1.mask_.color = var_361_12
			end

			local var_361_13 = "1060"

			if arg_358_1.actors_["1060"] == nil then
				local var_361_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_361_14) then
					local var_361_15 = Object.Instantiate(var_361_14, arg_358_1.canvasGo_.transform)

					var_361_15.transform:SetSiblingIndex(1)

					var_361_15.name = var_361_13
					var_361_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_358_1.actors_[var_361_13] = var_361_15

					if arg_358_1.isInRecall_ then
						for iter_361_2, iter_361_3 in ipairs((var_361_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_361_16 = arg_358_1.actors_["1060"]

			if 3 < arg_358_1.time_ and arg_358_1.time_ <= 3 + arg_361_0 and not isNil(var_361_16) and arg_358_1.var_.actorSpriteComps1060 == nil then
				arg_358_1.var_.actorSpriteComps1060 = var_361_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_17 = 0.2

			if 3 <= arg_358_1.time_ and arg_358_1.time_ < 3 + var_361_17 and not isNil(var_361_16) then
				if arg_358_1.var_.actorSpriteComps1060 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								iter_361_5.color = Color.New(Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 3) / var_361_17), Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 3) / var_361_17), (Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 3) / var_361_17)))
							else
								local var_361_18 = Mathf.Lerp(iter_361_5.color.r, 1, (arg_358_1.time_ - 3) / var_361_17)

								iter_361_5.color = Color.New(var_361_18, var_361_18, var_361_18)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 3 + var_361_17 and arg_358_1.time_ < 3 + var_361_17 + arg_361_0 and not isNil(var_361_16) and arg_358_1.var_.actorSpriteComps1060 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_361_7 then
						iter_361_7.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps1060 = nil
			end

			local var_361_19 = arg_358_1.actors_["1060"].transform

			if 3 < arg_358_1.time_ and arg_358_1.time_ <= 3 + arg_361_0 then
				arg_358_1.var_.moveOldPos1060 = var_361_19.localPosition
				var_361_19.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1060", 3)

				for iter_361_8 = 0, var_361_19.childCount - 1 do
					local var_361_20 = var_361_19:GetChild(iter_361_8)

					if var_361_20.name == "split_1" or not string.find(var_361_20.name, "split") then
						var_361_20.gameObject:SetActive(true)
					else
						var_361_20.gameObject:SetActive(false)
					end
				end
			end

			local var_361_21 = 0.001

			if 3 <= arg_358_1.time_ and arg_358_1.time_ < 3 + var_361_21 then
				var_361_19.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_358_1.time_ - 3) / var_361_21)
			end

			if arg_358_1.time_ >= 3 + var_361_21 and arg_358_1.time_ < 3 + var_361_21 + arg_361_0 then
				var_361_19.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			if 3 < arg_358_1.time_ and arg_358_1.time_ <= 3 + arg_361_0 then
				local var_361_22 = arg_358_1.actors_["1060"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_361_22 then
					arg_358_1.var_.alphaOldValue1060 = var_361_22.alpha
					arg_358_1.var_.characterEffect1060 = var_361_22
				end

				arg_358_1.var_.alphaOldValue1060 = 0
			end

			local var_361_23 = 0.4

			if 3 <= arg_358_1.time_ and arg_358_1.time_ < 3 + var_361_23 then
				if arg_358_1.var_.characterEffect1060 then
					arg_358_1.var_.characterEffect1060.alpha = Mathf.Lerp(arg_358_1.var_.alphaOldValue1060, 1, (arg_358_1.time_ - 3) / var_361_23)
				end
			end

			if arg_358_1.time_ >= 3 + var_361_23 and arg_358_1.time_ < 3 + var_361_23 + arg_361_0 and arg_358_1.var_.characterEffect1060 then
				arg_358_1.var_.characterEffect1060.alpha = 1
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_361_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_358_1.bgmTxt_.text ~= var_361_26 and arg_358_1.bgmTxt_.text ~= "" then
						if arg_358_1.bgmTxt2_.text ~= "" then
							arg_358_1.bgmTxt_.text = arg_358_1.bgmTxt2_.text
						end

						arg_358_1.bgmTxt2_.text = var_361_26

						arg_358_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_358_1.bgmTxt_.text = var_361_26
						arg_358_1.bgmTxt2_.text = var_361_26
					end

					if arg_358_1.bgmTimer then
						arg_358_1.bgmTimer:Stop()

						arg_358_1.bgmTimer = nil
					end

					if arg_358_1.settingData.show_music_name == 1 then
						arg_358_1.musicController:SetSelectedState("show")
						arg_358_1.musicAnimator_:Play("open", 0, 0)

						if arg_358_1.settingData.music_time ~= 0 then
							arg_358_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_358_1.settingData.music_time), function()
								if arg_358_1 == nil or isNil(arg_358_1.bgmTxt_) then
									return
								end

								arg_358_1.musicController:SetSelectedState("hide")
								arg_358_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.2 < arg_358_1.time_ and arg_358_1.time_ <= 1.2 + arg_361_0 then
				arg_358_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_361_29 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_358_1.bgmTxt_.text ~= var_361_29 and arg_358_1.bgmTxt_.text ~= "" then
						if arg_358_1.bgmTxt2_.text ~= "" then
							arg_358_1.bgmTxt_.text = arg_358_1.bgmTxt2_.text
						end

						arg_358_1.bgmTxt2_.text = var_361_29

						arg_358_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_358_1.bgmTxt_.text = var_361_29
						arg_358_1.bgmTxt2_.text = var_361_29
					end

					if arg_358_1.bgmTimer then
						arg_358_1.bgmTimer:Stop()

						arg_358_1.bgmTimer = nil
					end

					if arg_358_1.settingData.show_music_name == 1 then
						arg_358_1.musicController:SetSelectedState("show")
						arg_358_1.musicAnimator_:Play("open", 0, 0)

						if arg_358_1.settingData.music_time ~= 0 then
							arg_358_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_358_1.settingData.music_time), function()
								if arg_358_1 == nil or isNil(arg_358_1.bgmTxt_) then
									return
								end

								arg_358_1.musicController:SetSelectedState("hide")
								arg_358_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_358_1.time_ and arg_358_1.time_ <= 0.2 + arg_361_0 then
				arg_358_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_358_1.frameCnt_ <= 1 then
				arg_358_1.dialog_:SetActive(false)
			end

			local var_361_31 = 3.4
			local var_361_32 = 0.6

			if 3.4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_31 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0

				arg_358_1.dialog_:SetActive(true)

				arg_358_1.dialogCg_.alpha = 0

				local var_361_33 = LeanTween.value(arg_358_1.dialog_, 0, 1, 0.3)

				var_361_33:setOnUpdate(LuaHelper.FloatAction(function(arg_364_0)
					arg_358_1.dialogCg_.alpha = arg_364_0
				end))
				var_361_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_358_1.dialog_)
					var_361_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_358_1.duration_ = arg_358_1.duration_ + 0.3

				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_34 = arg_358_1:GetWordFromCfg(417031085)
				local var_361_35 = arg_358_1:FormatText(var_361_34.content)

				arg_358_1.text_.text = var_361_35

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_37 = 24 <= 0 and var_361_32 or var_361_32 * (utf8.len(var_361_35) / 24)

				if (24 <= 0 and var_361_32 or var_361_32 * (utf8.len(var_361_35) / 24)) > 0 and var_361_32 < var_361_37 then
					arg_358_1.talkMaxDuration = var_361_37
					var_361_31 = var_361_31 + 0.3

					if var_361_37 + var_361_31 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_37 + var_361_31
					end
				end

				arg_358_1.text_.text = var_361_35
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031085", "story_v_out_417031.awb") ~= 0 then
					local var_361_38 = manager.audio:GetVoiceLength("story_v_out_417031", "417031085", "story_v_out_417031.awb") / 1000

					if var_361_38 + var_361_31 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_38 + var_361_31
					end

					if var_361_34.prefab_name ~= "" and arg_358_1.actors_[var_361_34.prefab_name] ~= nil then
						local var_361_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_34.prefab_name].transform, "story_v_out_417031", "417031085", "story_v_out_417031.awb")

						arg_358_1:RecordAudio("417031085", var_361_39)
						arg_358_1:RecordAudio("417031085", var_361_39)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417031", "417031085", "story_v_out_417031.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417031", "417031085", "story_v_out_417031.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_40 = var_361_31 + 0.3
			local var_361_41 = math.max(var_361_32, arg_358_1.talkMaxDuration)

			if var_361_31 + 0.3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_40 + var_361_41 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_40) / var_361_41

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_40 + var_361_41 and arg_358_1.time_ < var_361_40 + var_361_41 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play417031086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417031086
		arg_366_1.duration_ = 8.1

		local var_366_0 = {
			zh = 2.966,
			ja = 8.1
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
				arg_366_0:Play417031087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1034"]) and arg_366_1.var_.actorSpriteComps1034 == nil then
				arg_366_1.var_.actorSpriteComps1034 = arg_366_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1034"]) then
				if arg_366_1.var_.actorSpriteComps1034 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor1.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor1.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor1.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 1, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1034"]) and arg_366_1.var_.actorSpriteComps1034 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps1034 = nil
			end

			local var_369_2 = arg_366_1.actors_["1060"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1060 == nil then
				arg_366_1.var_.actorSpriteComps1060 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps1060 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								iter_369_5.color = Color.New(Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_5.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_5.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1060 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_369_7 then
						iter_369_7.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps1060 = nil
			end

			local var_369_5 = arg_366_1.actors_["1060"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1060 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1060", 7)

				for iter_369_8 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_8)

					if var_369_6.name == "" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_369_8 = arg_366_1.actors_["1034"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1034 = var_369_8.localPosition
				var_369_8.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1034", 3)

				for iter_369_9 = 0, var_369_8.childCount - 1 do
					local var_369_9 = var_369_8:GetChild(iter_369_9)

					if var_369_9.name == "" or not string.find(var_369_9.name, "split") then
						var_369_9.gameObject:SetActive(true)
					else
						var_369_9.gameObject:SetActive(false)
					end
				end
			end

			local var_369_10 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_10 then
				var_369_8.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_366_1.time_ - 0) / var_369_10)
			end

			if arg_366_1.time_ >= 0 + var_369_10 and arg_366_1.time_ < 0 + var_369_10 + arg_369_0 then
				var_369_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_369_11 = 0
			local var_369_12 = 0.375

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_11 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_13 = arg_366_1:GetWordFromCfg(417031086)
				local var_369_14 = arg_366_1:FormatText(var_369_13.content)

				arg_366_1.text_.text = var_369_14

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_16 = 15 <= 0 and var_369_12 or var_369_12 * (utf8.len(var_369_14) / 15)

				if (15 <= 0 and var_369_12 or var_369_12 * (utf8.len(var_369_14) / 15)) > 0 and var_369_12 < var_369_16 then
					arg_366_1.talkMaxDuration = var_369_16

					if var_369_16 + var_369_11 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_16 + var_369_11
					end
				end

				arg_366_1.text_.text = var_369_14
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031086", "story_v_out_417031.awb") ~= 0 then
					local var_369_17 = manager.audio:GetVoiceLength("story_v_out_417031", "417031086", "story_v_out_417031.awb") / 1000

					if var_369_17 + var_369_11 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_17 + var_369_11
					end

					if var_369_13.prefab_name ~= "" and arg_366_1.actors_[var_369_13.prefab_name] ~= nil then
						local var_369_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_13.prefab_name].transform, "story_v_out_417031", "417031086", "story_v_out_417031.awb")

						arg_366_1:RecordAudio("417031086", var_369_18)
						arg_366_1:RecordAudio("417031086", var_369_18)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417031", "417031086", "story_v_out_417031.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417031", "417031086", "story_v_out_417031.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_19 = math.max(var_369_12, arg_366_1.talkMaxDuration)

			if var_369_11 <= arg_366_1.time_ and arg_366_1.time_ < var_369_11 + var_369_19 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_11) / var_369_19

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_11 + var_369_19 and arg_366_1.time_ < var_369_11 + var_369_19 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_366_1:InitPlayNodeList()
	end,
	Play417031087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417031087
		arg_370_1.duration_ = 2

		local var_370_0 = {
			zh = 1.1,
			ja = 2
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
				arg_370_0:Play417031088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1060"]) and arg_370_1.var_.actorSpriteComps1060 == nil then
				arg_370_1.var_.actorSpriteComps1060 = arg_370_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1060"]) then
				if arg_370_1.var_.actorSpriteComps1060 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1060"]) and arg_370_1.var_.actorSpriteComps1060 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps1060 = nil
			end

			local var_373_2 = arg_370_1.actors_["1034"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1034 == nil then
				arg_370_1.var_.actorSpriteComps1034 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps1034 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								iter_373_5.color = Color.New(Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, (arg_370_1.time_ - 0) / var_373_3), Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, (arg_370_1.time_ - 0) / var_373_3), (Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, (arg_370_1.time_ - 0) / var_373_3)))
							else
								local var_373_4 = Mathf.Lerp(iter_373_5.color.r, 0.5, (arg_370_1.time_ - 0) / var_373_3)

								iter_373_5.color = Color.New(var_373_4, var_373_4, var_373_4)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1034 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps1034 = nil
			end

			local var_373_5 = arg_370_1.actors_["1034"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1034 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1034", 4)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "" or not string.find(var_373_6.name, "split") then
						var_373_6.gameObject:SetActive(true)
					else
						var_373_6.gameObject:SetActive(false)
					end
				end
			end

			local var_373_7 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_370_1.time_ - 0) / var_373_7)
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_373_8 = arg_370_1.actors_["1060"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1060 = var_373_8.localPosition
				var_373_8.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1060", 2)

				for iter_373_9 = 0, var_373_8.childCount - 1 do
					local var_373_9 = var_373_8:GetChild(iter_373_9)

					if var_373_9.name == "split_5" or not string.find(var_373_9.name, "split") then
						var_373_9.gameObject:SetActive(true)
					else
						var_373_9.gameObject:SetActive(false)
					end
				end
			end

			local var_373_10 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_10 then
				var_373_8.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_370_1.time_ - 0) / var_373_10)
			end

			if arg_370_1.time_ >= 0 + var_373_10 and arg_370_1.time_ < 0 + var_373_10 + arg_373_0 then
				var_373_8.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_373_11 = 0
			local var_373_12 = 0.05

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_11 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(417031087)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_16 = 2 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 2)

				if (2 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 2)) > 0 and var_373_12 < var_373_16 then
					arg_370_1.talkMaxDuration = var_373_16

					if var_373_16 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_16 + var_373_11
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031087", "story_v_out_417031.awb") ~= 0 then
					local var_373_17 = manager.audio:GetVoiceLength("story_v_out_417031", "417031087", "story_v_out_417031.awb") / 1000

					if var_373_17 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_11
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_417031", "417031087", "story_v_out_417031.awb")

						arg_370_1:RecordAudio("417031087", var_373_18)
						arg_370_1:RecordAudio("417031087", var_373_18)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417031", "417031087", "story_v_out_417031.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417031", "417031087", "story_v_out_417031.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_19 = math.max(var_373_12, arg_370_1.talkMaxDuration)

			if var_373_11 <= arg_370_1.time_ and arg_370_1.time_ < var_373_11 + var_373_19 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_11) / var_373_19

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_11 + var_373_19 and arg_370_1.time_ < var_373_11 + var_373_19 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	Play417031088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417031088
		arg_374_1.duration_ = 9.4

		local var_374_0 = {
			zh = 7.033,
			ja = 9.4
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417031089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1034"]) and arg_374_1.var_.actorSpriteComps1034 == nil then
				arg_374_1.var_.actorSpriteComps1034 = arg_374_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1034"]) then
				if arg_374_1.var_.actorSpriteComps1034 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor1.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor1.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor1.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 1, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1034"]) and arg_374_1.var_.actorSpriteComps1034 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps1034 = nil
			end

			local var_377_2 = arg_374_1.actors_["1060"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1060 == nil then
				arg_374_1.var_.actorSpriteComps1060 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps1060 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								iter_377_5.color = Color.New(Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_3), Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_3), (Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_3)))
							else
								local var_377_4 = Mathf.Lerp(iter_377_5.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_3)

								iter_377_5.color = Color.New(var_377_4, var_377_4, var_377_4)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1060 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps1060 = nil
			end

			local var_377_5 = arg_374_1.actors_["1034"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1034 = var_377_5.localPosition
				var_377_5.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1034", 4)

				for iter_377_8 = 0, var_377_5.childCount - 1 do
					local var_377_6 = var_377_5:GetChild(iter_377_8)

					if var_377_6.name == "" or not string.find(var_377_6.name, "split") then
						var_377_6.gameObject:SetActive(true)
					else
						var_377_6.gameObject:SetActive(false)
					end
				end
			end

			local var_377_7 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				var_377_5.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_374_1.time_ - 0) / var_377_7)
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				var_377_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_377_8 = 0
			local var_377_9 = 0.725

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_8 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_10 = arg_374_1:GetWordFromCfg(417031088)
				local var_377_11 = arg_374_1:FormatText(var_377_10.content)

				arg_374_1.text_.text = var_377_11

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_13 = 29 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 29)

				if (29 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 29)) > 0 and var_377_9 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_8
					end
				end

				arg_374_1.text_.text = var_377_11
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031088", "story_v_out_417031.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031088", "story_v_out_417031.awb") / 1000

					if var_377_14 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_8
					end

					if var_377_10.prefab_name ~= "" and arg_374_1.actors_[var_377_10.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_10.prefab_name].transform, "story_v_out_417031", "417031088", "story_v_out_417031.awb")

						arg_374_1:RecordAudio("417031088", var_377_15)
						arg_374_1:RecordAudio("417031088", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417031", "417031088", "story_v_out_417031.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417031", "417031088", "story_v_out_417031.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_9, arg_374_1.talkMaxDuration)

			if var_377_8 <= arg_374_1.time_ and arg_374_1.time_ < var_377_8 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_8) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_8 + var_377_16 and arg_374_1.time_ < var_377_8 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play417031089 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417031089
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play417031090(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1034"]) and arg_378_1.var_.actorSpriteComps1034 == nil then
				arg_378_1.var_.actorSpriteComps1034 = arg_378_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_0 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1034"]) then
				if arg_378_1.var_.actorSpriteComps1034 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								iter_381_1.color = Color.New(Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor2.r, (arg_378_1.time_ - 0) / var_381_0), Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor2.g, (arg_378_1.time_ - 0) / var_381_0), (Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor2.b, (arg_378_1.time_ - 0) / var_381_0)))
							else
								local var_381_1 = Mathf.Lerp(iter_381_1.color.r, 0.5, (arg_378_1.time_ - 0) / var_381_0)

								iter_381_1.color = Color.New(var_381_1, var_381_1, var_381_1)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1034"]) and arg_378_1.var_.actorSpriteComps1034 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_381_3 then
						iter_381_3.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_378_1.var_.actorSpriteComps1034 = nil
			end

			local var_381_2 = arg_378_1.actors_["1060"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1060 = var_381_2.localPosition
				var_381_2.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1060", 7)

				for iter_381_4 = 0, var_381_2.childCount - 1 do
					local var_381_3 = var_381_2:GetChild(iter_381_4)

					if var_381_3.name == "split_1" or not string.find(var_381_3.name, "split") then
						var_381_3.gameObject:SetActive(true)
					else
						var_381_3.gameObject:SetActive(false)
					end
				end
			end

			local var_381_4 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				var_381_2.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_378_1.time_ - 0) / var_381_4)
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				var_381_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_381_5 = arg_378_1.actors_["1034"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1034 = var_381_5.localPosition
				var_381_5.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1034", 7)

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
				var_381_5.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_378_1.time_ - 0) / var_381_7)
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				var_381_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_378_1.time_ and arg_378_1.time_ <= 0.05 + arg_381_0 then
				arg_378_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_coffeecup", "")
			end

			local var_381_9 = 0
			local var_381_10 = 1.55

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_11 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(417031089).content)

				arg_378_1.text_.text = var_381_11

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_13 = 62 <= 0 and var_381_10 or var_381_10 * (utf8.len(var_381_11) / 62)

				if (62 <= 0 and var_381_10 or var_381_10 * (utf8.len(var_381_11) / 62)) > 0 and var_381_10 < var_381_13 then
					arg_378_1.talkMaxDuration = var_381_13

					if var_381_13 + var_381_9 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_9
					end
				end

				arg_378_1.text_.text = var_381_11
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_10, arg_378_1.talkMaxDuration)

			if var_381_9 <= arg_378_1.time_ and arg_378_1.time_ < var_381_9 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_9) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_9 + var_381_14 and arg_378_1.time_ < var_381_9 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_378_1:InitPlayNodeList()
	end,
	Play417031090 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417031090
		arg_382_1.duration_ = 13.33

		local var_382_0 = {
			zh = 10.933,
			ja = 13.333
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
				arg_382_0:Play417031091(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1034"]) and arg_382_1.var_.actorSpriteComps1034 == nil then
				arg_382_1.var_.actorSpriteComps1034 = arg_382_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1034"]) then
				if arg_382_1.var_.actorSpriteComps1034 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1034"]) and arg_382_1.var_.actorSpriteComps1034 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps1034 = nil
			end

			local var_385_2 = arg_382_1.actors_["1034"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1034 = var_385_2.localPosition
				var_385_2.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1034", 3)

				for iter_385_4 = 0, var_385_2.childCount - 1 do
					local var_385_3 = var_385_2:GetChild(iter_385_4)

					if var_385_3.name == "" or not string.find(var_385_3.name, "split") then
						var_385_3.gameObject:SetActive(true)
					else
						var_385_3.gameObject:SetActive(false)
					end
				end
			end

			local var_385_4 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				var_385_2.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_382_1.time_ - 0) / var_385_4)
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				var_385_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_385_5 = 0
			local var_385_6 = 1.125

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_7 = arg_382_1:GetWordFromCfg(417031090)
				local var_385_8 = arg_382_1:FormatText(var_385_7.content)

				arg_382_1.text_.text = var_385_8

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 45 <= 0 and var_385_6 or var_385_6 * (utf8.len(var_385_8) / 45)

				if (45 <= 0 and var_385_6 or var_385_6 * (utf8.len(var_385_8) / 45)) > 0 and var_385_6 < var_385_10 then
					arg_382_1.talkMaxDuration = var_385_10

					if var_385_10 + var_385_5 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_5
					end
				end

				arg_382_1.text_.text = var_385_8
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031090", "story_v_out_417031.awb") ~= 0 then
					local var_385_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031090", "story_v_out_417031.awb") / 1000

					if var_385_11 + var_385_5 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_11 + var_385_5
					end

					if var_385_7.prefab_name ~= "" and arg_382_1.actors_[var_385_7.prefab_name] ~= nil then
						local var_385_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_7.prefab_name].transform, "story_v_out_417031", "417031090", "story_v_out_417031.awb")

						arg_382_1:RecordAudio("417031090", var_385_12)
						arg_382_1:RecordAudio("417031090", var_385_12)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_417031", "417031090", "story_v_out_417031.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_417031", "417031090", "story_v_out_417031.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_6, arg_382_1.talkMaxDuration)

			if var_385_5 <= arg_382_1.time_ and arg_382_1.time_ < var_385_5 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_5) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_5 + var_385_13 and arg_382_1.time_ < var_385_5 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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

		arg_382_1:InitPlayNodeList()
	end,
	Play417031091 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 417031091
		arg_386_1.duration_ = 11.3

		local var_386_0 = {
			zh = 8.066,
			ja = 11.3
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play417031092(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.975

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:GetWordFromCfg(417031091)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 39 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 39)

				if (39 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 39)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031091", "story_v_out_417031.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031091", "story_v_out_417031.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_out_417031", "417031091", "story_v_out_417031.awb")

						arg_386_1:RecordAudio("417031091", var_389_6)
						arg_386_1:RecordAudio("417031091", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_417031", "417031091", "story_v_out_417031.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_417031", "417031091", "story_v_out_417031.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play417031092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417031092
		arg_390_1.duration_ = 13

		local var_390_0 = {
			zh = 4.866,
			ja = 13
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
				arg_390_0:Play417031093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.55

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:GetWordFromCfg(417031092)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 22 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 22)

				if (22 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 22)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031092", "story_v_out_417031.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031092", "story_v_out_417031.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_417031", "417031092", "story_v_out_417031.awb")

						arg_390_1:RecordAudio("417031092", var_393_6)
						arg_390_1:RecordAudio("417031092", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_417031", "417031092", "story_v_out_417031.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_417031", "417031092", "story_v_out_417031.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play417031093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 417031093
		arg_394_1.duration_ = 7.8

		local var_394_0 = {
			zh = 2.8,
			ja = 7.8
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
				arg_394_0:Play417031094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1060"]) and arg_394_1.var_.actorSpriteComps1060 == nil then
				arg_394_1.var_.actorSpriteComps1060 = arg_394_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1060"]) then
				if arg_394_1.var_.actorSpriteComps1060 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 1, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1060"]) and arg_394_1.var_.actorSpriteComps1060 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_394_1.var_.actorSpriteComps1060 = nil
			end

			local var_397_2 = arg_394_1.actors_["1034"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps1034 == nil then
				arg_394_1.var_.actorSpriteComps1034 = var_397_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_3 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.actorSpriteComps1034 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								iter_397_5.color = Color.New(Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_3), Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_3), (Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_3)))
							else
								local var_397_4 = Mathf.Lerp(iter_397_5.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_3)

								iter_397_5.color = Color.New(var_397_4, var_397_4, var_397_4)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps1034 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_397_7 then
						iter_397_7.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps1034 = nil
			end

			local var_397_5 = arg_394_1.actors_["1060"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1060 = var_397_5.localPosition
				var_397_5.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1060", 2)

				for iter_397_8 = 0, var_397_5.childCount - 1 do
					local var_397_6 = var_397_5:GetChild(iter_397_8)

					if var_397_6.name == "" or not string.find(var_397_6.name, "split") then
						var_397_6.gameObject:SetActive(true)
					else
						var_397_6.gameObject:SetActive(false)
					end
				end
			end

			local var_397_7 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				var_397_5.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_394_1.time_ - 0) / var_397_7)
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				var_397_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_397_8 = arg_394_1.actors_["1034"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1034 = var_397_8.localPosition
				var_397_8.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("1034", 4)

				for iter_397_9 = 0, var_397_8.childCount - 1 do
					local var_397_9 = var_397_8:GetChild(iter_397_9)

					if var_397_9.name == "" or not string.find(var_397_9.name, "split") then
						var_397_9.gameObject:SetActive(true)
					else
						var_397_9.gameObject:SetActive(false)
					end
				end
			end

			local var_397_10 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_10 then
				var_397_8.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_394_1.time_ - 0) / var_397_10)
			end

			if arg_394_1.time_ >= 0 + var_397_10 and arg_394_1.time_ < 0 + var_397_10 + arg_397_0 then
				var_397_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_397_11 = 0
			local var_397_12 = 0.3

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_11 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_13 = arg_394_1:GetWordFromCfg(417031093)
				local var_397_14 = arg_394_1:FormatText(var_397_13.content)

				arg_394_1.text_.text = var_397_14

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_16 = 12 <= 0 and var_397_12 or var_397_12 * (utf8.len(var_397_14) / 12)

				if (12 <= 0 and var_397_12 or var_397_12 * (utf8.len(var_397_14) / 12)) > 0 and var_397_12 < var_397_16 then
					arg_394_1.talkMaxDuration = var_397_16

					if var_397_16 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_16 + var_397_11
					end
				end

				arg_394_1.text_.text = var_397_14
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031093", "story_v_out_417031.awb") ~= 0 then
					local var_397_17 = manager.audio:GetVoiceLength("story_v_out_417031", "417031093", "story_v_out_417031.awb") / 1000

					if var_397_17 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_17 + var_397_11
					end

					if var_397_13.prefab_name ~= "" and arg_394_1.actors_[var_397_13.prefab_name] ~= nil then
						local var_397_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_13.prefab_name].transform, "story_v_out_417031", "417031093", "story_v_out_417031.awb")

						arg_394_1:RecordAudio("417031093", var_397_18)
						arg_394_1:RecordAudio("417031093", var_397_18)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_417031", "417031093", "story_v_out_417031.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_417031", "417031093", "story_v_out_417031.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_19 = math.max(var_397_12, arg_394_1.talkMaxDuration)

			if var_397_11 <= arg_394_1.time_ and arg_394_1.time_ < var_397_11 + var_397_19 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_11) / var_397_19

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_11 + var_397_19 and arg_394_1.time_ < var_397_11 + var_397_19 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_394_1:InitPlayNodeList()
	end,
	Play417031094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 417031094
		arg_398_1.duration_ = 4.3

		local var_398_0 = {
			zh = 3.733,
			ja = 4.3
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
				arg_398_0:Play417031095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1034"]) and arg_398_1.var_.actorSpriteComps1034 == nil then
				arg_398_1.var_.actorSpriteComps1034 = arg_398_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_0 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1034"]) then
				if arg_398_1.var_.actorSpriteComps1034 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								iter_401_1.color = Color.New(Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor1.r, (arg_398_1.time_ - 0) / var_401_0), Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor1.g, (arg_398_1.time_ - 0) / var_401_0), (Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor1.b, (arg_398_1.time_ - 0) / var_401_0)))
							else
								local var_401_1 = Mathf.Lerp(iter_401_1.color.r, 1, (arg_398_1.time_ - 0) / var_401_0)

								iter_401_1.color = Color.New(var_401_1, var_401_1, var_401_1)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1034"]) and arg_398_1.var_.actorSpriteComps1034 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_401_3 then
						iter_401_3.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_398_1.var_.actorSpriteComps1034 = nil
			end

			local var_401_2 = arg_398_1.actors_["1060"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1060 == nil then
				arg_398_1.var_.actorSpriteComps1060 = var_401_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_3 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_3 and not isNil(var_401_2) then
				if arg_398_1.var_.actorSpriteComps1060 then
					for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_401_5 then
							if arg_398_1.isInRecall_ then
								iter_401_5.color = Color.New(Mathf.Lerp(iter_401_5.color.r, arg_398_1.hightColor2.r, (arg_398_1.time_ - 0) / var_401_3), Mathf.Lerp(iter_401_5.color.g, arg_398_1.hightColor2.g, (arg_398_1.time_ - 0) / var_401_3), (Mathf.Lerp(iter_401_5.color.b, arg_398_1.hightColor2.b, (arg_398_1.time_ - 0) / var_401_3)))
							else
								local var_401_4 = Mathf.Lerp(iter_401_5.color.r, 0.5, (arg_398_1.time_ - 0) / var_401_3)

								iter_401_5.color = Color.New(var_401_4, var_401_4, var_401_4)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_3 and arg_398_1.time_ < 0 + var_401_3 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps1060 then
				for iter_401_6, iter_401_7 in pairs(arg_398_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_401_7 then
						iter_401_7.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_398_1.var_.actorSpriteComps1060 = nil
			end

			local var_401_5 = arg_398_1.actors_["1034"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1034 = var_401_5.localPosition
				var_401_5.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("1034", 4)

				for iter_401_8 = 0, var_401_5.childCount - 1 do
					local var_401_6 = var_401_5:GetChild(iter_401_8)

					if var_401_6.name == "split_4" or not string.find(var_401_6.name, "split") then
						var_401_6.gameObject:SetActive(true)
					else
						var_401_6.gameObject:SetActive(false)
					end
				end
			end

			local var_401_7 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				var_401_5.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_398_1.time_ - 0) / var_401_7)
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				var_401_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_401_8 = 0
			local var_401_9 = 0.575

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_8 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_10 = arg_398_1:GetWordFromCfg(417031094)
				local var_401_11 = arg_398_1:FormatText(var_401_10.content)

				arg_398_1.text_.text = var_401_11

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_13 = 23 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 23)

				if (23 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 23)) > 0 and var_401_9 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_8
					end
				end

				arg_398_1.text_.text = var_401_11
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031094", "story_v_out_417031.awb") ~= 0 then
					local var_401_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031094", "story_v_out_417031.awb") / 1000

					if var_401_14 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_14 + var_401_8
					end

					if var_401_10.prefab_name ~= "" and arg_398_1.actors_[var_401_10.prefab_name] ~= nil then
						local var_401_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_10.prefab_name].transform, "story_v_out_417031", "417031094", "story_v_out_417031.awb")

						arg_398_1:RecordAudio("417031094", var_401_15)
						arg_398_1:RecordAudio("417031094", var_401_15)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_417031", "417031094", "story_v_out_417031.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_417031", "417031094", "story_v_out_417031.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_16 = math.max(var_401_9, arg_398_1.talkMaxDuration)

			if var_401_8 <= arg_398_1.time_ and arg_398_1.time_ < var_401_8 + var_401_16 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_8) / var_401_16

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_8 + var_401_16 and arg_398_1.time_ < var_401_8 + var_401_16 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
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

		arg_398_1:InitPlayNodeList()
	end,
	Play417031095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 417031095
		arg_402_1.duration_ = 12.97

		local var_402_0 = {
			zh = 11,
			ja = 12.966
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
				arg_402_0:Play417031096(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1060"]) and arg_402_1.var_.actorSpriteComps1060 == nil then
				arg_402_1.var_.actorSpriteComps1060 = arg_402_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1060"]) then
				if arg_402_1.var_.actorSpriteComps1060 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor1.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor1.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor1.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 1, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1060"]) and arg_402_1.var_.actorSpriteComps1060 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_402_1.var_.actorSpriteComps1060 = nil
			end

			local var_405_2 = arg_402_1.actors_["1034"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_2) and arg_402_1.var_.actorSpriteComps1034 == nil then
				arg_402_1.var_.actorSpriteComps1034 = var_405_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_3 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_3 and not isNil(var_405_2) then
				if arg_402_1.var_.actorSpriteComps1034 then
					for iter_405_4, iter_405_5 in pairs(arg_402_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_405_5 then
							if arg_402_1.isInRecall_ then
								iter_405_5.color = Color.New(Mathf.Lerp(iter_405_5.color.r, arg_402_1.hightColor2.r, (arg_402_1.time_ - 0) / var_405_3), Mathf.Lerp(iter_405_5.color.g, arg_402_1.hightColor2.g, (arg_402_1.time_ - 0) / var_405_3), (Mathf.Lerp(iter_405_5.color.b, arg_402_1.hightColor2.b, (arg_402_1.time_ - 0) / var_405_3)))
							else
								local var_405_4 = Mathf.Lerp(iter_405_5.color.r, 0.5, (arg_402_1.time_ - 0) / var_405_3)

								iter_405_5.color = Color.New(var_405_4, var_405_4, var_405_4)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_3 and arg_402_1.time_ < 0 + var_405_3 + arg_405_0 and not isNil(var_405_2) and arg_402_1.var_.actorSpriteComps1034 then
				for iter_405_6, iter_405_7 in pairs(arg_402_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_405_7 then
						iter_405_7.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_402_1.var_.actorSpriteComps1034 = nil
			end

			local var_405_5 = 0
			local var_405_6 = 1.375

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_5 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_7 = arg_402_1:GetWordFromCfg(417031095)
				local var_405_8 = arg_402_1:FormatText(var_405_7.content)

				arg_402_1.text_.text = var_405_8

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_10 = 55 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 55)

				if (55 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 55)) > 0 and var_405_6 < var_405_10 then
					arg_402_1.talkMaxDuration = var_405_10

					if var_405_10 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_5
					end
				end

				arg_402_1.text_.text = var_405_8
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031095", "story_v_out_417031.awb") ~= 0 then
					local var_405_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031095", "story_v_out_417031.awb") / 1000

					if var_405_11 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_11 + var_405_5
					end

					if var_405_7.prefab_name ~= "" and arg_402_1.actors_[var_405_7.prefab_name] ~= nil then
						local var_405_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_7.prefab_name].transform, "story_v_out_417031", "417031095", "story_v_out_417031.awb")

						arg_402_1:RecordAudio("417031095", var_405_12)
						arg_402_1:RecordAudio("417031095", var_405_12)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_417031", "417031095", "story_v_out_417031.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_417031", "417031095", "story_v_out_417031.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_13 = math.max(var_405_6, arg_402_1.talkMaxDuration)

			if var_405_5 <= arg_402_1.time_ and arg_402_1.time_ < var_405_5 + var_405_13 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_5) / var_405_13

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_5 + var_405_13 and arg_402_1.time_ < var_405_5 + var_405_13 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play417031096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 417031096
		arg_406_1.duration_ = 8.2

		local var_406_0 = {
			zh = 4.666,
			ja = 8.2
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play417031097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1060 = arg_406_1.actors_["1060"].transform.localPosition
				arg_406_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1060", 2)

				for iter_409_0 = 0, arg_406_1.actors_["1060"].transform.childCount - 1 do
					local var_409_0 = arg_406_1.actors_["1060"].transform:GetChild(iter_409_0)

					if var_409_0.name == "split_1" or not string.find(var_409_0.name, "split") then
						var_409_0.gameObject:SetActive(true)
					else
						var_409_0.gameObject:SetActive(false)
					end
				end
			end

			local var_409_1 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_1 then
				arg_406_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_406_1.time_ - 0) / var_409_1)
			end

			if arg_406_1.time_ >= 0 + var_409_1 and arg_406_1.time_ < 0 + var_409_1 + arg_409_0 then
				arg_406_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_409_2 = 0
			local var_409_3 = 0.7

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_2 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_4 = arg_406_1:GetWordFromCfg(417031096)
				local var_409_5 = arg_406_1:FormatText(var_409_4.content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 28 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 28)

				if (28 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 28)) > 0 and var_409_3 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_2
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031096", "story_v_out_417031.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031096", "story_v_out_417031.awb") / 1000

					if var_409_8 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_2
					end

					if var_409_4.prefab_name ~= "" and arg_406_1.actors_[var_409_4.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_4.prefab_name].transform, "story_v_out_417031", "417031096", "story_v_out_417031.awb")

						arg_406_1:RecordAudio("417031096", var_409_9)
						arg_406_1:RecordAudio("417031096", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_417031", "417031096", "story_v_out_417031.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_417031", "417031096", "story_v_out_417031.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_3, arg_406_1.talkMaxDuration)

			if var_409_2 <= arg_406_1.time_ and arg_406_1.time_ < var_409_2 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_2) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_2 + var_409_10 and arg_406_1.time_ < var_409_2 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play417031097 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417031097
		arg_410_1.duration_ = 5.13

		local var_410_0 = {
			zh = 3.2,
			ja = 5.133
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417031098(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1034"]) and arg_410_1.var_.actorSpriteComps1034 == nil then
				arg_410_1.var_.actorSpriteComps1034 = arg_410_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1034"]) then
				if arg_410_1.var_.actorSpriteComps1034 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								iter_413_1.color = Color.New(Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_0), Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_0), (Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_0)))
							else
								local var_413_1 = Mathf.Lerp(iter_413_1.color.r, 1, (arg_410_1.time_ - 0) / var_413_0)

								iter_413_1.color = Color.New(var_413_1, var_413_1, var_413_1)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1034"]) and arg_410_1.var_.actorSpriteComps1034 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_413_3 then
						iter_413_3.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps1034 = nil
			end

			local var_413_2 = arg_410_1.actors_["1060"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1060 == nil then
				arg_410_1.var_.actorSpriteComps1060 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps1060 then
					for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_413_5 then
							if arg_410_1.isInRecall_ then
								iter_413_5.color = Color.New(Mathf.Lerp(iter_413_5.color.r, arg_410_1.hightColor2.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_5.color.g, arg_410_1.hightColor2.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_5.color.b, arg_410_1.hightColor2.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_5.color.r, 0.5, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_5.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1060 then
				for iter_413_6, iter_413_7 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_413_7 then
						iter_413_7.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_410_1.var_.actorSpriteComps1060 = nil
			end

			local var_413_5 = arg_410_1.actors_["1034"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1034 = var_413_5.localPosition
				var_413_5.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1034", 4)

				for iter_413_8 = 0, var_413_5.childCount - 1 do
					local var_413_6 = var_413_5:GetChild(iter_413_8)

					if var_413_6.name == "split_5" or not string.find(var_413_6.name, "split") then
						var_413_6.gameObject:SetActive(true)
					else
						var_413_6.gameObject:SetActive(false)
					end
				end
			end

			local var_413_7 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				var_413_5.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_410_1.time_ - 0) / var_413_7)
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				var_413_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_413_8 = 0
			local var_413_9 = 0.4

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_10 = arg_410_1:GetWordFromCfg(417031097)
				local var_413_11 = arg_410_1:FormatText(var_413_10.content)

				arg_410_1.text_.text = var_413_11

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_13 = 16 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 16)

				if (16 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 16)) > 0 and var_413_9 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_8
					end
				end

				arg_410_1.text_.text = var_413_11
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031097", "story_v_out_417031.awb") ~= 0 then
					local var_413_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031097", "story_v_out_417031.awb") / 1000

					if var_413_14 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_14 + var_413_8
					end

					if var_413_10.prefab_name ~= "" and arg_410_1.actors_[var_413_10.prefab_name] ~= nil then
						local var_413_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_10.prefab_name].transform, "story_v_out_417031", "417031097", "story_v_out_417031.awb")

						arg_410_1:RecordAudio("417031097", var_413_15)
						arg_410_1:RecordAudio("417031097", var_413_15)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_417031", "417031097", "story_v_out_417031.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_417031", "417031097", "story_v_out_417031.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_16 = math.max(var_413_9, arg_410_1.talkMaxDuration)

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_16 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_8) / var_413_16

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_8 + var_413_16 and arg_410_1.time_ < var_413_8 + var_413_16 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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

		arg_410_1:InitPlayNodeList()
	end,
	Play417031098 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 417031098
		arg_414_1.duration_ = 11.83

		local var_414_0 = {
			zh = 7.3,
			ja = 11.833
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play417031099(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1060"]) and arg_414_1.var_.actorSpriteComps1060 == nil then
				arg_414_1.var_.actorSpriteComps1060 = arg_414_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1060"]) then
				if arg_414_1.var_.actorSpriteComps1060 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								iter_417_1.color = Color.New(Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor1.r, (arg_414_1.time_ - 0) / var_417_0), Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor1.g, (arg_414_1.time_ - 0) / var_417_0), (Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor1.b, (arg_414_1.time_ - 0) / var_417_0)))
							else
								local var_417_1 = Mathf.Lerp(iter_417_1.color.r, 1, (arg_414_1.time_ - 0) / var_417_0)

								iter_417_1.color = Color.New(var_417_1, var_417_1, var_417_1)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1060"]) and arg_414_1.var_.actorSpriteComps1060 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_417_3 then
						iter_417_3.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_414_1.var_.actorSpriteComps1060 = nil
			end

			local var_417_2 = arg_414_1.actors_["1034"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_2) and arg_414_1.var_.actorSpriteComps1034 == nil then
				arg_414_1.var_.actorSpriteComps1034 = var_417_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_3 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_3 and not isNil(var_417_2) then
				if arg_414_1.var_.actorSpriteComps1034 then
					for iter_417_4, iter_417_5 in pairs(arg_414_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_417_5 then
							if arg_414_1.isInRecall_ then
								iter_417_5.color = Color.New(Mathf.Lerp(iter_417_5.color.r, arg_414_1.hightColor2.r, (arg_414_1.time_ - 0) / var_417_3), Mathf.Lerp(iter_417_5.color.g, arg_414_1.hightColor2.g, (arg_414_1.time_ - 0) / var_417_3), (Mathf.Lerp(iter_417_5.color.b, arg_414_1.hightColor2.b, (arg_414_1.time_ - 0) / var_417_3)))
							else
								local var_417_4 = Mathf.Lerp(iter_417_5.color.r, 0.5, (arg_414_1.time_ - 0) / var_417_3)

								iter_417_5.color = Color.New(var_417_4, var_417_4, var_417_4)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_3 and arg_414_1.time_ < 0 + var_417_3 + arg_417_0 and not isNil(var_417_2) and arg_414_1.var_.actorSpriteComps1034 then
				for iter_417_6, iter_417_7 in pairs(arg_414_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_417_7 then
						iter_417_7.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_414_1.var_.actorSpriteComps1034 = nil
			end

			local var_417_5 = arg_414_1.actors_["1060"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1060 = var_417_5.localPosition
				var_417_5.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("1060", 2)

				for iter_417_8 = 0, var_417_5.childCount - 1 do
					local var_417_6 = var_417_5:GetChild(iter_417_8)

					if var_417_6.name == "split_4" or not string.find(var_417_6.name, "split") then
						var_417_6.gameObject:SetActive(true)
					else
						var_417_6.gameObject:SetActive(false)
					end
				end
			end

			local var_417_7 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				var_417_5.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_414_1.time_ - 0) / var_417_7)
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				var_417_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_417_8 = 0
			local var_417_9 = 0.925

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(417031098)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 37 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 37)

				if (37 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 37)) > 0 and var_417_9 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031098", "story_v_out_417031.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031098", "story_v_out_417031.awb") / 1000

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end

					if var_417_10.prefab_name ~= "" and arg_414_1.actors_[var_417_10.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_10.prefab_name].transform, "story_v_out_417031", "417031098", "story_v_out_417031.awb")

						arg_414_1:RecordAudio("417031098", var_417_15)
						arg_414_1:RecordAudio("417031098", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_417031", "417031098", "story_v_out_417031.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_417031", "417031098", "story_v_out_417031.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_16 and arg_414_1.time_ < var_417_8 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play417031099 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 417031099
		arg_418_1.duration_ = 6.83

		local var_418_0 = {
			zh = 5.4,
			ja = 6.833
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play417031100(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.8

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_1 = arg_418_1:GetWordFromCfg(417031099)
				local var_421_2 = arg_418_1:FormatText(var_421_1.content)

				arg_418_1.text_.text = var_421_2

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 32 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 32)

				if (32 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 32)) > 0 and var_421_0 < var_421_4 then
					arg_418_1.talkMaxDuration = var_421_4

					if var_421_4 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_4 + 0
					end
				end

				arg_418_1.text_.text = var_421_2
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031099", "story_v_out_417031.awb") ~= 0 then
					local var_421_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031099", "story_v_out_417031.awb") / 1000

					if var_421_5 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + 0
					end

					if var_421_1.prefab_name ~= "" and arg_418_1.actors_[var_421_1.prefab_name] ~= nil then
						local var_421_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_1.prefab_name].transform, "story_v_out_417031", "417031099", "story_v_out_417031.awb")

						arg_418_1:RecordAudio("417031099", var_421_6)
						arg_418_1:RecordAudio("417031099", var_421_6)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_417031", "417031099", "story_v_out_417031.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_417031", "417031099", "story_v_out_417031.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_7 and arg_418_1.time_ < 0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play417031100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 417031100
		arg_422_1.duration_ = 7.17

		local var_422_0 = {
			zh = 4.4,
			ja = 7.166
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play417031101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1034"]) and arg_422_1.var_.actorSpriteComps1034 == nil then
				arg_422_1.var_.actorSpriteComps1034 = arg_422_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1034"]) then
				if arg_422_1.var_.actorSpriteComps1034 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								iter_425_1.color = Color.New(Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, (arg_422_1.time_ - 0) / var_425_0), Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, (arg_422_1.time_ - 0) / var_425_0), (Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, (arg_422_1.time_ - 0) / var_425_0)))
							else
								local var_425_1 = Mathf.Lerp(iter_425_1.color.r, 1, (arg_422_1.time_ - 0) / var_425_0)

								iter_425_1.color = Color.New(var_425_1, var_425_1, var_425_1)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1034"]) and arg_422_1.var_.actorSpriteComps1034 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_425_3 then
						iter_425_3.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_422_1.var_.actorSpriteComps1034 = nil
			end

			local var_425_2 = arg_422_1.actors_["1060"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps1060 == nil then
				arg_422_1.var_.actorSpriteComps1060 = var_425_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_3 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_3 and not isNil(var_425_2) then
				if arg_422_1.var_.actorSpriteComps1060 then
					for iter_425_4, iter_425_5 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_425_5 then
							if arg_422_1.isInRecall_ then
								iter_425_5.color = Color.New(Mathf.Lerp(iter_425_5.color.r, arg_422_1.hightColor2.r, (arg_422_1.time_ - 0) / var_425_3), Mathf.Lerp(iter_425_5.color.g, arg_422_1.hightColor2.g, (arg_422_1.time_ - 0) / var_425_3), (Mathf.Lerp(iter_425_5.color.b, arg_422_1.hightColor2.b, (arg_422_1.time_ - 0) / var_425_3)))
							else
								local var_425_4 = Mathf.Lerp(iter_425_5.color.r, 0.5, (arg_422_1.time_ - 0) / var_425_3)

								iter_425_5.color = Color.New(var_425_4, var_425_4, var_425_4)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_3 and arg_422_1.time_ < 0 + var_425_3 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps1060 then
				for iter_425_6, iter_425_7 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_425_7 then
						iter_425_7.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_422_1.var_.actorSpriteComps1060 = nil
			end

			local var_425_5 = arg_422_1.actors_["1034"].transform

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1034 = var_425_5.localPosition
				var_425_5.localScale = Vector3.New(1, 1, 1)

				arg_422_1:CheckSpriteTmpPos("1034", 4)

				for iter_425_8 = 0, var_425_5.childCount - 1 do
					local var_425_6 = var_425_5:GetChild(iter_425_8)

					if var_425_6.name == "split_4" or not string.find(var_425_6.name, "split") then
						var_425_6.gameObject:SetActive(true)
					else
						var_425_6.gameObject:SetActive(false)
					end
				end
			end

			local var_425_7 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				var_425_5.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_422_1.time_ - 0) / var_425_7)
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				var_425_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_425_8 = 0
			local var_425_9 = 0.4

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_8 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_10 = arg_422_1:GetWordFromCfg(417031100)
				local var_425_11 = arg_422_1:FormatText(var_425_10.content)

				arg_422_1.text_.text = var_425_11

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_13 = 16 <= 0 and var_425_9 or var_425_9 * (utf8.len(var_425_11) / 16)

				if (16 <= 0 and var_425_9 or var_425_9 * (utf8.len(var_425_11) / 16)) > 0 and var_425_9 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_8 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_8
					end
				end

				arg_422_1.text_.text = var_425_11
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031100", "story_v_out_417031.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031100", "story_v_out_417031.awb") / 1000

					if var_425_14 + var_425_8 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_8
					end

					if var_425_10.prefab_name ~= "" and arg_422_1.actors_[var_425_10.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_10.prefab_name].transform, "story_v_out_417031", "417031100", "story_v_out_417031.awb")

						arg_422_1:RecordAudio("417031100", var_425_15)
						arg_422_1:RecordAudio("417031100", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_417031", "417031100", "story_v_out_417031.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_417031", "417031100", "story_v_out_417031.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_9, arg_422_1.talkMaxDuration)

			if var_425_8 <= arg_422_1.time_ and arg_422_1.time_ < var_425_8 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_8) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_8 + var_425_16 and arg_422_1.time_ < var_425_8 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
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

		arg_422_1:InitPlayNodeList()
	end,
	Play417031101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 417031101
		arg_426_1.duration_ = 12.33

		local var_426_0 = {
			zh = 9.933,
			ja = 12.333
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play417031102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1060"]) and arg_426_1.var_.actorSpriteComps1060 == nil then
				arg_426_1.var_.actorSpriteComps1060 = arg_426_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_0 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1060"]) then
				if arg_426_1.var_.actorSpriteComps1060 then
					for iter_429_0, iter_429_1 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_429_1 then
							if arg_426_1.isInRecall_ then
								iter_429_1.color = Color.New(Mathf.Lerp(iter_429_1.color.r, arg_426_1.hightColor1.r, (arg_426_1.time_ - 0) / var_429_0), Mathf.Lerp(iter_429_1.color.g, arg_426_1.hightColor1.g, (arg_426_1.time_ - 0) / var_429_0), (Mathf.Lerp(iter_429_1.color.b, arg_426_1.hightColor1.b, (arg_426_1.time_ - 0) / var_429_0)))
							else
								local var_429_1 = Mathf.Lerp(iter_429_1.color.r, 1, (arg_426_1.time_ - 0) / var_429_0)

								iter_429_1.color = Color.New(var_429_1, var_429_1, var_429_1)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1060"]) and arg_426_1.var_.actorSpriteComps1060 then
				for iter_429_2, iter_429_3 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_429_3 then
						iter_429_3.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_426_1.var_.actorSpriteComps1060 = nil
			end

			local var_429_2 = arg_426_1.actors_["1034"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps1034 == nil then
				arg_426_1.var_.actorSpriteComps1034 = var_429_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_3 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_3 and not isNil(var_429_2) then
				if arg_426_1.var_.actorSpriteComps1034 then
					for iter_429_4, iter_429_5 in pairs(arg_426_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_429_5 then
							if arg_426_1.isInRecall_ then
								iter_429_5.color = Color.New(Mathf.Lerp(iter_429_5.color.r, arg_426_1.hightColor2.r, (arg_426_1.time_ - 0) / var_429_3), Mathf.Lerp(iter_429_5.color.g, arg_426_1.hightColor2.g, (arg_426_1.time_ - 0) / var_429_3), (Mathf.Lerp(iter_429_5.color.b, arg_426_1.hightColor2.b, (arg_426_1.time_ - 0) / var_429_3)))
							else
								local var_429_4 = Mathf.Lerp(iter_429_5.color.r, 0.5, (arg_426_1.time_ - 0) / var_429_3)

								iter_429_5.color = Color.New(var_429_4, var_429_4, var_429_4)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_3 and arg_426_1.time_ < 0 + var_429_3 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps1034 then
				for iter_429_6, iter_429_7 in pairs(arg_426_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_429_7 then
						iter_429_7.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_426_1.var_.actorSpriteComps1034 = nil
			end

			local var_429_5 = arg_426_1.actors_["1060"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1060 = var_429_5.localPosition
				var_429_5.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("1060", 2)

				for iter_429_8 = 0, var_429_5.childCount - 1 do
					local var_429_6 = var_429_5:GetChild(iter_429_8)

					if var_429_6.name == "split_4" or not string.find(var_429_6.name, "split") then
						var_429_6.gameObject:SetActive(true)
					else
						var_429_6.gameObject:SetActive(false)
					end
				end
			end

			local var_429_7 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				var_429_5.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_426_1.time_ - 0) / var_429_7)
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				var_429_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_429_8 = 0
			local var_429_9 = 1.2

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_8 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_10 = arg_426_1:GetWordFromCfg(417031101)
				local var_429_11 = arg_426_1:FormatText(var_429_10.content)

				arg_426_1.text_.text = var_429_11

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_13 = 48 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 48)

				if (48 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 48)) > 0 and var_429_9 < var_429_13 then
					arg_426_1.talkMaxDuration = var_429_13

					if var_429_13 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_13 + var_429_8
					end
				end

				arg_426_1.text_.text = var_429_11
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031101", "story_v_out_417031.awb") ~= 0 then
					local var_429_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031101", "story_v_out_417031.awb") / 1000

					if var_429_14 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_14 + var_429_8
					end

					if var_429_10.prefab_name ~= "" and arg_426_1.actors_[var_429_10.prefab_name] ~= nil then
						local var_429_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_10.prefab_name].transform, "story_v_out_417031", "417031101", "story_v_out_417031.awb")

						arg_426_1:RecordAudio("417031101", var_429_15)
						arg_426_1:RecordAudio("417031101", var_429_15)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_417031", "417031101", "story_v_out_417031.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_417031", "417031101", "story_v_out_417031.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_16 = math.max(var_429_9, arg_426_1.talkMaxDuration)

			if var_429_8 <= arg_426_1.time_ and arg_426_1.time_ < var_429_8 + var_429_16 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_8) / var_429_16

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_8 + var_429_16 and arg_426_1.time_ < var_429_8 + var_429_16 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play417031102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 417031102
		arg_430_1.duration_ = 5.83

		local var_430_0 = {
			zh = 3.733,
			ja = 5.833
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play417031103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1034"]) and arg_430_1.var_.actorSpriteComps1034 == nil then
				arg_430_1.var_.actorSpriteComps1034 = arg_430_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_0 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1034"]) then
				if arg_430_1.var_.actorSpriteComps1034 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								iter_433_1.color = Color.New(Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor1.r, (arg_430_1.time_ - 0) / var_433_0), Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor1.g, (arg_430_1.time_ - 0) / var_433_0), (Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor1.b, (arg_430_1.time_ - 0) / var_433_0)))
							else
								local var_433_1 = Mathf.Lerp(iter_433_1.color.r, 1, (arg_430_1.time_ - 0) / var_433_0)

								iter_433_1.color = Color.New(var_433_1, var_433_1, var_433_1)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1034"]) and arg_430_1.var_.actorSpriteComps1034 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_433_3 then
						iter_433_3.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_430_1.var_.actorSpriteComps1034 = nil
			end

			local var_433_2 = arg_430_1.actors_["1060"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1060 == nil then
				arg_430_1.var_.actorSpriteComps1060 = var_433_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_3 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.actorSpriteComps1060 then
					for iter_433_4, iter_433_5 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_433_5 then
							if arg_430_1.isInRecall_ then
								iter_433_5.color = Color.New(Mathf.Lerp(iter_433_5.color.r, arg_430_1.hightColor2.r, (arg_430_1.time_ - 0) / var_433_3), Mathf.Lerp(iter_433_5.color.g, arg_430_1.hightColor2.g, (arg_430_1.time_ - 0) / var_433_3), (Mathf.Lerp(iter_433_5.color.b, arg_430_1.hightColor2.b, (arg_430_1.time_ - 0) / var_433_3)))
							else
								local var_433_4 = Mathf.Lerp(iter_433_5.color.r, 0.5, (arg_430_1.time_ - 0) / var_433_3)

								iter_433_5.color = Color.New(var_433_4, var_433_4, var_433_4)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1060 then
				for iter_433_6, iter_433_7 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_433_7 then
						iter_433_7.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_430_1.var_.actorSpriteComps1060 = nil
			end

			local var_433_5 = arg_430_1.actors_["1034"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1034 = var_433_5.localPosition
				var_433_5.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("1034", 4)

				for iter_433_8 = 0, var_433_5.childCount - 1 do
					local var_433_6 = var_433_5:GetChild(iter_433_8)

					if var_433_6.name == "split_7" or not string.find(var_433_6.name, "split") then
						var_433_6.gameObject:SetActive(true)
					else
						var_433_6.gameObject:SetActive(false)
					end
				end
			end

			local var_433_7 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				var_433_5.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_430_1.time_ - 0) / var_433_7)
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				var_433_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_433_8 = 0
			local var_433_9 = 0.5

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_8 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_10 = arg_430_1:GetWordFromCfg(417031102)
				local var_433_11 = arg_430_1:FormatText(var_433_10.content)

				arg_430_1.text_.text = var_433_11

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_13 = 20 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 20)

				if (20 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 20)) > 0 and var_433_9 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_8
					end
				end

				arg_430_1.text_.text = var_433_11
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031102", "story_v_out_417031.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031102", "story_v_out_417031.awb") / 1000

					if var_433_14 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_8
					end

					if var_433_10.prefab_name ~= "" and arg_430_1.actors_[var_433_10.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_10.prefab_name].transform, "story_v_out_417031", "417031102", "story_v_out_417031.awb")

						arg_430_1:RecordAudio("417031102", var_433_15)
						arg_430_1:RecordAudio("417031102", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_417031", "417031102", "story_v_out_417031.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_417031", "417031102", "story_v_out_417031.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_9, arg_430_1.talkMaxDuration)

			if var_433_8 <= arg_430_1.time_ and arg_430_1.time_ < var_433_8 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_8) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_8 + var_433_16 and arg_430_1.time_ < var_433_8 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
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

		arg_430_1:InitPlayNodeList()
	end,
	Play417031103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 417031103
		arg_434_1.duration_ = 11.73

		local var_434_0 = {
			zh = 10.7,
			ja = 11.733
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play417031104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1060"]) and arg_434_1.var_.actorSpriteComps1060 == nil then
				arg_434_1.var_.actorSpriteComps1060 = arg_434_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_0 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1060"]) then
				if arg_434_1.var_.actorSpriteComps1060 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_437_1 then
							if arg_434_1.isInRecall_ then
								iter_437_1.color = Color.New(Mathf.Lerp(iter_437_1.color.r, arg_434_1.hightColor1.r, (arg_434_1.time_ - 0) / var_437_0), Mathf.Lerp(iter_437_1.color.g, arg_434_1.hightColor1.g, (arg_434_1.time_ - 0) / var_437_0), (Mathf.Lerp(iter_437_1.color.b, arg_434_1.hightColor1.b, (arg_434_1.time_ - 0) / var_437_0)))
							else
								local var_437_1 = Mathf.Lerp(iter_437_1.color.r, 1, (arg_434_1.time_ - 0) / var_437_0)

								iter_437_1.color = Color.New(var_437_1, var_437_1, var_437_1)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1060"]) and arg_434_1.var_.actorSpriteComps1060 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_437_3 then
						iter_437_3.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_434_1.var_.actorSpriteComps1060 = nil
			end

			local var_437_2 = arg_434_1.actors_["1034"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_2) and arg_434_1.var_.actorSpriteComps1034 == nil then
				arg_434_1.var_.actorSpriteComps1034 = var_437_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_3 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_3 and not isNil(var_437_2) then
				if arg_434_1.var_.actorSpriteComps1034 then
					for iter_437_4, iter_437_5 in pairs(arg_434_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_437_5 then
							if arg_434_1.isInRecall_ then
								iter_437_5.color = Color.New(Mathf.Lerp(iter_437_5.color.r, arg_434_1.hightColor2.r, (arg_434_1.time_ - 0) / var_437_3), Mathf.Lerp(iter_437_5.color.g, arg_434_1.hightColor2.g, (arg_434_1.time_ - 0) / var_437_3), (Mathf.Lerp(iter_437_5.color.b, arg_434_1.hightColor2.b, (arg_434_1.time_ - 0) / var_437_3)))
							else
								local var_437_4 = Mathf.Lerp(iter_437_5.color.r, 0.5, (arg_434_1.time_ - 0) / var_437_3)

								iter_437_5.color = Color.New(var_437_4, var_437_4, var_437_4)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_3 and arg_434_1.time_ < 0 + var_437_3 + arg_437_0 and not isNil(var_437_2) and arg_434_1.var_.actorSpriteComps1034 then
				for iter_437_6, iter_437_7 in pairs(arg_434_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_437_7 then
						iter_437_7.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_434_1.var_.actorSpriteComps1034 = nil
			end

			local var_437_5 = arg_434_1.actors_["1060"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1060 = var_437_5.localPosition
				var_437_5.localScale = Vector3.New(1, 1, 1)

				arg_434_1:CheckSpriteTmpPos("1060", 2)

				for iter_437_8 = 0, var_437_5.childCount - 1 do
					local var_437_6 = var_437_5:GetChild(iter_437_8)

					if var_437_6.name == "" or not string.find(var_437_6.name, "split") then
						var_437_6.gameObject:SetActive(true)
					else
						var_437_6.gameObject:SetActive(false)
					end
				end
			end

			local var_437_7 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				var_437_5.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_434_1.time_ - 0) / var_437_7)
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				var_437_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_437_8 = 0
			local var_437_9 = 1.1

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_8 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_10 = arg_434_1:GetWordFromCfg(417031103)
				local var_437_11 = arg_434_1:FormatText(var_437_10.content)

				arg_434_1.text_.text = var_437_11

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 44 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 44)

				if (44 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 44)) > 0 and var_437_9 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_8
					end
				end

				arg_434_1.text_.text = var_437_11
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031103", "story_v_out_417031.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031103", "story_v_out_417031.awb") / 1000

					if var_437_14 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_8
					end

					if var_437_10.prefab_name ~= "" and arg_434_1.actors_[var_437_10.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_10.prefab_name].transform, "story_v_out_417031", "417031103", "story_v_out_417031.awb")

						arg_434_1:RecordAudio("417031103", var_437_15)
						arg_434_1:RecordAudio("417031103", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_417031", "417031103", "story_v_out_417031.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_417031", "417031103", "story_v_out_417031.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_9, arg_434_1.talkMaxDuration)

			if var_437_8 <= arg_434_1.time_ and arg_434_1.time_ < var_437_8 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_8) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_8 + var_437_16 and arg_434_1.time_ < var_437_8 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play417031104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 417031104
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play417031105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1060"]) and arg_438_1.var_.actorSpriteComps1060 == nil then
				arg_438_1.var_.actorSpriteComps1060 = arg_438_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1060"]) then
				if arg_438_1.var_.actorSpriteComps1060 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								iter_441_1.color = Color.New(Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor2.r, (arg_438_1.time_ - 0) / var_441_0), Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor2.g, (arg_438_1.time_ - 0) / var_441_0), (Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor2.b, (arg_438_1.time_ - 0) / var_441_0)))
							else
								local var_441_1 = Mathf.Lerp(iter_441_1.color.r, 0.5, (arg_438_1.time_ - 0) / var_441_0)

								iter_441_1.color = Color.New(var_441_1, var_441_1, var_441_1)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1060"]) and arg_438_1.var_.actorSpriteComps1060 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_441_3 then
						iter_441_3.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_438_1.var_.actorSpriteComps1060 = nil
			end

			local var_441_2 = 0
			local var_441_3 = 1.575

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(417031104).content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_6 = 63 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_4) / 63)

				if (63 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_4) / 63)) > 0 and var_441_3 < var_441_6 then
					arg_438_1.talkMaxDuration = var_441_6

					if var_441_6 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_6 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_7 and arg_438_1.time_ < var_441_2 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play417031105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 417031105
		arg_442_1.duration_ = 5.93

		local var_442_0 = {
			zh = 4.133,
			ja = 5.933
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play417031106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1034"]) and arg_442_1.var_.actorSpriteComps1034 == nil then
				arg_442_1.var_.actorSpriteComps1034 = arg_442_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_0 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1034"]) then
				if arg_442_1.var_.actorSpriteComps1034 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								iter_445_1.color = Color.New(Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, (arg_442_1.time_ - 0) / var_445_0), Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, (arg_442_1.time_ - 0) / var_445_0), (Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, (arg_442_1.time_ - 0) / var_445_0)))
							else
								local var_445_1 = Mathf.Lerp(iter_445_1.color.r, 1, (arg_442_1.time_ - 0) / var_445_0)

								iter_445_1.color = Color.New(var_445_1, var_445_1, var_445_1)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1034"]) and arg_442_1.var_.actorSpriteComps1034 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_445_3 then
						iter_445_3.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_442_1.var_.actorSpriteComps1034 = nil
			end

			local var_445_2 = arg_442_1.actors_["1034"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1034 = var_445_2.localPosition
				var_445_2.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1034", 4)

				for iter_445_4 = 0, var_445_2.childCount - 1 do
					local var_445_3 = var_445_2:GetChild(iter_445_4)

					if var_445_3.name == "split_7" or not string.find(var_445_3.name, "split") then
						var_445_3.gameObject:SetActive(true)
					else
						var_445_3.gameObject:SetActive(false)
					end
				end
			end

			local var_445_4 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_4 then
				var_445_2.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_442_1.time_ - 0) / var_445_4)
			end

			if arg_442_1.time_ >= 0 + var_445_4 and arg_442_1.time_ < 0 + var_445_4 + arg_445_0 then
				var_445_2.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_445_5 = 0
			local var_445_6 = 0.625

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_7 = arg_442_1:GetWordFromCfg(417031105)
				local var_445_8 = arg_442_1:FormatText(var_445_7.content)

				arg_442_1.text_.text = var_445_8

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_10 = 25 <= 0 and var_445_6 or var_445_6 * (utf8.len(var_445_8) / 25)

				if (25 <= 0 and var_445_6 or var_445_6 * (utf8.len(var_445_8) / 25)) > 0 and var_445_6 < var_445_10 then
					arg_442_1.talkMaxDuration = var_445_10

					if var_445_10 + var_445_5 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_5
					end
				end

				arg_442_1.text_.text = var_445_8
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031105", "story_v_out_417031.awb") ~= 0 then
					local var_445_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031105", "story_v_out_417031.awb") / 1000

					if var_445_11 + var_445_5 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_11 + var_445_5
					end

					if var_445_7.prefab_name ~= "" and arg_442_1.actors_[var_445_7.prefab_name] ~= nil then
						local var_445_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_7.prefab_name].transform, "story_v_out_417031", "417031105", "story_v_out_417031.awb")

						arg_442_1:RecordAudio("417031105", var_445_12)
						arg_442_1:RecordAudio("417031105", var_445_12)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_417031", "417031105", "story_v_out_417031.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_417031", "417031105", "story_v_out_417031.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_13 = math.max(var_445_6, arg_442_1.talkMaxDuration)

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_13 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_5) / var_445_13

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_5 + var_445_13 and arg_442_1.time_ < var_445_5 + var_445_13 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
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

		arg_442_1:InitPlayNodeList()
	end,
	Play417031106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 417031106
		arg_446_1.duration_ = 6.9

		local var_446_0 = {
			zh = 6.1,
			ja = 6.9
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play417031107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1060"]) and arg_446_1.var_.actorSpriteComps1060 == nil then
				arg_446_1.var_.actorSpriteComps1060 = arg_446_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_0 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1060"]) then
				if arg_446_1.var_.actorSpriteComps1060 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								iter_449_1.color = Color.New(Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, (arg_446_1.time_ - 0) / var_449_0), Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, (arg_446_1.time_ - 0) / var_449_0), (Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, (arg_446_1.time_ - 0) / var_449_0)))
							else
								local var_449_1 = Mathf.Lerp(iter_449_1.color.r, 1, (arg_446_1.time_ - 0) / var_449_0)

								iter_449_1.color = Color.New(var_449_1, var_449_1, var_449_1)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1060"]) and arg_446_1.var_.actorSpriteComps1060 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_449_3 then
						iter_449_3.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_446_1.var_.actorSpriteComps1060 = nil
			end

			local var_449_2 = arg_446_1.actors_["1034"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps1034 == nil then
				arg_446_1.var_.actorSpriteComps1034 = var_449_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_3 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 and not isNil(var_449_2) then
				if arg_446_1.var_.actorSpriteComps1034 then
					for iter_449_4, iter_449_5 in pairs(arg_446_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_449_5 then
							if arg_446_1.isInRecall_ then
								iter_449_5.color = Color.New(Mathf.Lerp(iter_449_5.color.r, arg_446_1.hightColor2.r, (arg_446_1.time_ - 0) / var_449_3), Mathf.Lerp(iter_449_5.color.g, arg_446_1.hightColor2.g, (arg_446_1.time_ - 0) / var_449_3), (Mathf.Lerp(iter_449_5.color.b, arg_446_1.hightColor2.b, (arg_446_1.time_ - 0) / var_449_3)))
							else
								local var_449_4 = Mathf.Lerp(iter_449_5.color.r, 0.5, (arg_446_1.time_ - 0) / var_449_3)

								iter_449_5.color = Color.New(var_449_4, var_449_4, var_449_4)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps1034 then
				for iter_449_6, iter_449_7 in pairs(arg_446_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_449_7 then
						iter_449_7.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_446_1.var_.actorSpriteComps1034 = nil
			end

			local var_449_5 = arg_446_1.actors_["1060"].transform

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos1060 = var_449_5.localPosition
				var_449_5.localScale = Vector3.New(1, 1, 1)

				arg_446_1:CheckSpriteTmpPos("1060", 2)

				for iter_449_8 = 0, var_449_5.childCount - 1 do
					local var_449_6 = var_449_5:GetChild(iter_449_8)

					if var_449_6.name == "split_2" or not string.find(var_449_6.name, "split") then
						var_449_6.gameObject:SetActive(true)
					else
						var_449_6.gameObject:SetActive(false)
					end
				end
			end

			local var_449_7 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				var_449_5.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_446_1.time_ - 0) / var_449_7)
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				var_449_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_449_8 = 0
			local var_449_9 = 0.65

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_10 = arg_446_1:GetWordFromCfg(417031106)
				local var_449_11 = arg_446_1:FormatText(var_449_10.content)

				arg_446_1.text_.text = var_449_11

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_13 = 26 <= 0 and var_449_9 or var_449_9 * (utf8.len(var_449_11) / 26)

				if (26 <= 0 and var_449_9 or var_449_9 * (utf8.len(var_449_11) / 26)) > 0 and var_449_9 < var_449_13 then
					arg_446_1.talkMaxDuration = var_449_13

					if var_449_13 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_13 + var_449_8
					end
				end

				arg_446_1.text_.text = var_449_11
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031106", "story_v_out_417031.awb") ~= 0 then
					local var_449_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031106", "story_v_out_417031.awb") / 1000

					if var_449_14 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_14 + var_449_8
					end

					if var_449_10.prefab_name ~= "" and arg_446_1.actors_[var_449_10.prefab_name] ~= nil then
						local var_449_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_10.prefab_name].transform, "story_v_out_417031", "417031106", "story_v_out_417031.awb")

						arg_446_1:RecordAudio("417031106", var_449_15)
						arg_446_1:RecordAudio("417031106", var_449_15)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_417031", "417031106", "story_v_out_417031.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_417031", "417031106", "story_v_out_417031.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_9, arg_446_1.talkMaxDuration)

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_8) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_8 + var_449_16 and arg_446_1.time_ < var_449_8 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play417031107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 417031107
		arg_450_1.duration_ = 7.23

		local var_450_0 = {
			zh = 4.7,
			ja = 7.233
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play417031108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1034"]) and arg_450_1.var_.actorSpriteComps1034 == nil then
				arg_450_1.var_.actorSpriteComps1034 = arg_450_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1034"]) then
				if arg_450_1.var_.actorSpriteComps1034 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor1.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor1.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor1.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 1, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1034"]) and arg_450_1.var_.actorSpriteComps1034 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_450_1.var_.actorSpriteComps1034 = nil
			end

			local var_453_2 = arg_450_1.actors_["1060"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_2) and arg_450_1.var_.actorSpriteComps1060 == nil then
				arg_450_1.var_.actorSpriteComps1060 = var_453_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_3 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_3 and not isNil(var_453_2) then
				if arg_450_1.var_.actorSpriteComps1060 then
					for iter_453_4, iter_453_5 in pairs(arg_450_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_453_5 then
							if arg_450_1.isInRecall_ then
								iter_453_5.color = Color.New(Mathf.Lerp(iter_453_5.color.r, arg_450_1.hightColor2.r, (arg_450_1.time_ - 0) / var_453_3), Mathf.Lerp(iter_453_5.color.g, arg_450_1.hightColor2.g, (arg_450_1.time_ - 0) / var_453_3), (Mathf.Lerp(iter_453_5.color.b, arg_450_1.hightColor2.b, (arg_450_1.time_ - 0) / var_453_3)))
							else
								local var_453_4 = Mathf.Lerp(iter_453_5.color.r, 0.5, (arg_450_1.time_ - 0) / var_453_3)

								iter_453_5.color = Color.New(var_453_4, var_453_4, var_453_4)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_3 and arg_450_1.time_ < 0 + var_453_3 + arg_453_0 and not isNil(var_453_2) and arg_450_1.var_.actorSpriteComps1060 then
				for iter_453_6, iter_453_7 in pairs(arg_450_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_453_7 then
						iter_453_7.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_450_1.var_.actorSpriteComps1060 = nil
			end

			local var_453_5 = arg_450_1.actors_["1034"].transform

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1034 = var_453_5.localPosition
				var_453_5.localScale = Vector3.New(1, 1, 1)

				arg_450_1:CheckSpriteTmpPos("1034", 4)

				for iter_453_8 = 0, var_453_5.childCount - 1 do
					local var_453_6 = var_453_5:GetChild(iter_453_8)

					if var_453_6.name == "split_6" or not string.find(var_453_6.name, "split") then
						var_453_6.gameObject:SetActive(true)
					else
						var_453_6.gameObject:SetActive(false)
					end
				end
			end

			local var_453_7 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				var_453_5.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_450_1.time_ - 0) / var_453_7)
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				var_453_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_453_8 = 0
			local var_453_9 = 0.4

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_10 = arg_450_1:GetWordFromCfg(417031107)
				local var_453_11 = arg_450_1:FormatText(var_453_10.content)

				arg_450_1.text_.text = var_453_11

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 16 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 16)

				if (16 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 16)) > 0 and var_453_9 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_11
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031107", "story_v_out_417031.awb") ~= 0 then
					local var_453_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031107", "story_v_out_417031.awb") / 1000

					if var_453_14 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_14 + var_453_8
					end

					if var_453_10.prefab_name ~= "" and arg_450_1.actors_[var_453_10.prefab_name] ~= nil then
						local var_453_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_10.prefab_name].transform, "story_v_out_417031", "417031107", "story_v_out_417031.awb")

						arg_450_1:RecordAudio("417031107", var_453_15)
						arg_450_1:RecordAudio("417031107", var_453_15)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_417031", "417031107", "story_v_out_417031.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_417031", "417031107", "story_v_out_417031.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_16 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_16 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_16

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_16 and arg_450_1.time_ < var_453_8 + var_453_16 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
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

		arg_450_1:InitPlayNodeList()
	end,
	Play417031108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 417031108
		arg_454_1.duration_ = 8.4

		local var_454_0 = {
			zh = 5.233,
			ja = 8.4
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play417031109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1060 = arg_454_1.actors_["1060"].transform.localPosition
				arg_454_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_454_1:CheckSpriteTmpPos("1060", 2)

				for iter_457_0 = 0, arg_454_1.actors_["1060"].transform.childCount - 1 do
					local var_457_0 = arg_454_1.actors_["1060"].transform:GetChild(iter_457_0)

					if var_457_0.name == "split_1" or not string.find(var_457_0.name, "split") then
						var_457_0.gameObject:SetActive(true)
					else
						var_457_0.gameObject:SetActive(false)
					end
				end
			end

			local var_457_1 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_1 then
				arg_454_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_454_1.time_ - 0) / var_457_1)
			end

			if arg_454_1.time_ >= 0 + var_457_1 and arg_454_1.time_ < 0 + var_457_1 + arg_457_0 then
				arg_454_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_457_2 = 0
			local var_457_3 = 0.65

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(417031108)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 26 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 26)

				if (26 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 26)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031108", "story_v_out_417031.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_417031", "417031108", "story_v_out_417031.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_out_417031", "417031108", "story_v_out_417031.awb")

						arg_454_1:RecordAudio("417031108", var_457_9)
						arg_454_1:RecordAudio("417031108", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_417031", "417031108", "story_v_out_417031.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_417031", "417031108", "story_v_out_417031.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play417031109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 417031109
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play417031110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1034"]) and arg_458_1.var_.actorSpriteComps1034 == nil then
				arg_458_1.var_.actorSpriteComps1034 = arg_458_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_461_0 = 0.2

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1034"]) then
				if arg_458_1.var_.actorSpriteComps1034 then
					for iter_461_0, iter_461_1 in pairs(arg_458_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_461_1 then
							if arg_458_1.isInRecall_ then
								iter_461_1.color = Color.New(Mathf.Lerp(iter_461_1.color.r, arg_458_1.hightColor2.r, (arg_458_1.time_ - 0) / var_461_0), Mathf.Lerp(iter_461_1.color.g, arg_458_1.hightColor2.g, (arg_458_1.time_ - 0) / var_461_0), (Mathf.Lerp(iter_461_1.color.b, arg_458_1.hightColor2.b, (arg_458_1.time_ - 0) / var_461_0)))
							else
								local var_461_1 = Mathf.Lerp(iter_461_1.color.r, 0.5, (arg_458_1.time_ - 0) / var_461_0)

								iter_461_1.color = Color.New(var_461_1, var_461_1, var_461_1)
							end
						end
					end
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1034"]) and arg_458_1.var_.actorSpriteComps1034 then
				for iter_461_2, iter_461_3 in pairs(arg_458_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_461_3 then
						iter_461_3.color = arg_458_1.isInRecall_ and (arg_458_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_458_1.var_.actorSpriteComps1034 = nil
			end

			local var_461_2 = arg_458_1.actors_["1034"].transform

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1034 = var_461_2.localPosition
				var_461_2.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1034", 7)

				for iter_461_4 = 0, var_461_2.childCount - 1 do
					local var_461_3 = var_461_2:GetChild(iter_461_4)

					if var_461_3.name == "" or not string.find(var_461_3.name, "split") then
						var_461_3.gameObject:SetActive(true)
					else
						var_461_3.gameObject:SetActive(false)
					end
				end
			end

			local var_461_4 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				var_461_2.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_458_1.time_ - 0) / var_461_4)
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				var_461_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_461_5 = arg_458_1.actors_["1060"].transform

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1060 = var_461_5.localPosition
				var_461_5.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1060", 7)

				for iter_461_5 = 0, var_461_5.childCount - 1 do
					local var_461_6 = var_461_5:GetChild(iter_461_5)

					if var_461_6.name == "split_1" or not string.find(var_461_6.name, "split") then
						var_461_6.gameObject:SetActive(true)
					else
						var_461_6.gameObject:SetActive(false)
					end
				end
			end

			local var_461_7 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_7 then
				var_461_5.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_458_1.time_ - 0) / var_461_7)
			end

			if arg_458_1.time_ >= 0 + var_461_7 and arg_458_1.time_ < 0 + var_461_7 + arg_461_0 then
				var_461_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_461_8 = 0
			local var_461_9 = 1.225

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_8 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_10 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(417031109).content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_12 = 49 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_10) / 49)

				if (49 <= 0 and var_461_9 or var_461_9 * (utf8.len(var_461_10) / 49)) > 0 and var_461_9 < var_461_12 then
					arg_458_1.talkMaxDuration = var_461_12

					if var_461_12 + var_461_8 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_8
					end
				end

				arg_458_1.text_.text = var_461_10
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_13 = math.max(var_461_9, arg_458_1.talkMaxDuration)

			if var_461_8 <= arg_458_1.time_ and arg_458_1.time_ < var_461_8 + var_461_13 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_8) / var_461_13

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_8 + var_461_13 and arg_458_1.time_ < var_461_8 + var_461_13 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play417031110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 417031110
		arg_462_1.duration_ = 6.53

		local var_462_0 = {
			zh = 5.566,
			ja = 6.533
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play417031111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1034"]) and arg_462_1.var_.actorSpriteComps1034 == nil then
				arg_462_1.var_.actorSpriteComps1034 = arg_462_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_0 = 0.2

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1034"]) then
				if arg_462_1.var_.actorSpriteComps1034 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								iter_465_1.color = Color.New(Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor1.r, (arg_462_1.time_ - 0) / var_465_0), Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor1.g, (arg_462_1.time_ - 0) / var_465_0), (Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor1.b, (arg_462_1.time_ - 0) / var_465_0)))
							else
								local var_465_1 = Mathf.Lerp(iter_465_1.color.r, 1, (arg_462_1.time_ - 0) / var_465_0)

								iter_465_1.color = Color.New(var_465_1, var_465_1, var_465_1)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1034"]) and arg_462_1.var_.actorSpriteComps1034 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_465_3 then
						iter_465_3.color = arg_462_1.isInRecall_ and (arg_462_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_462_1.var_.actorSpriteComps1034 = nil
			end

			local var_465_2 = arg_462_1.actors_["1034"].transform

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos1034 = var_465_2.localPosition
				var_465_2.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("1034", 4)

				for iter_465_4 = 0, var_465_2.childCount - 1 do
					local var_465_3 = var_465_2:GetChild(iter_465_4)

					if var_465_3.name == "split_6" or not string.find(var_465_3.name, "split") then
						var_465_3.gameObject:SetActive(true)
					else
						var_465_3.gameObject:SetActive(false)
					end
				end
			end

			local var_465_4 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				var_465_2.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_462_1.time_ - 0) / var_465_4)
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				var_465_2.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_465_5 = 0
			local var_465_6 = 0.5

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_5 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_7 = arg_462_1:GetWordFromCfg(417031110)
				local var_465_8 = arg_462_1:FormatText(var_465_7.content)

				arg_462_1.text_.text = var_465_8

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_10 = 20 <= 0 and var_465_6 or var_465_6 * (utf8.len(var_465_8) / 20)

				if (20 <= 0 and var_465_6 or var_465_6 * (utf8.len(var_465_8) / 20)) > 0 and var_465_6 < var_465_10 then
					arg_462_1.talkMaxDuration = var_465_10

					if var_465_10 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_5
					end
				end

				arg_462_1.text_.text = var_465_8
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031110", "story_v_out_417031.awb") ~= 0 then
					local var_465_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031110", "story_v_out_417031.awb") / 1000

					if var_465_11 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_11 + var_465_5
					end

					if var_465_7.prefab_name ~= "" and arg_462_1.actors_[var_465_7.prefab_name] ~= nil then
						local var_465_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_7.prefab_name].transform, "story_v_out_417031", "417031110", "story_v_out_417031.awb")

						arg_462_1:RecordAudio("417031110", var_465_12)
						arg_462_1:RecordAudio("417031110", var_465_12)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_417031", "417031110", "story_v_out_417031.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_417031", "417031110", "story_v_out_417031.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_13 = math.max(var_465_6, arg_462_1.talkMaxDuration)

			if var_465_5 <= arg_462_1.time_ and arg_462_1.time_ < var_465_5 + var_465_13 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_5) / var_465_13

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_5 + var_465_13 and arg_462_1.time_ < var_465_5 + var_465_13 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	Play417031111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 417031111
		arg_466_1.duration_ = 5.6

		local var_466_0 = {
			zh = 5.233,
			ja = 5.6
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play417031112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1060"]) and arg_466_1.var_.actorSpriteComps1060 == nil then
				arg_466_1.var_.actorSpriteComps1060 = arg_466_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_0 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1060"]) then
				if arg_466_1.var_.actorSpriteComps1060 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_469_1 then
							if arg_466_1.isInRecall_ then
								iter_469_1.color = Color.New(Mathf.Lerp(iter_469_1.color.r, arg_466_1.hightColor1.r, (arg_466_1.time_ - 0) / var_469_0), Mathf.Lerp(iter_469_1.color.g, arg_466_1.hightColor1.g, (arg_466_1.time_ - 0) / var_469_0), (Mathf.Lerp(iter_469_1.color.b, arg_466_1.hightColor1.b, (arg_466_1.time_ - 0) / var_469_0)))
							else
								local var_469_1 = Mathf.Lerp(iter_469_1.color.r, 1, (arg_466_1.time_ - 0) / var_469_0)

								iter_469_1.color = Color.New(var_469_1, var_469_1, var_469_1)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1060"]) and arg_466_1.var_.actorSpriteComps1060 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_469_3 then
						iter_469_3.color = arg_466_1.isInRecall_ and (arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_466_1.var_.actorSpriteComps1060 = nil
			end

			local var_469_2 = arg_466_1.actors_["1034"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.actorSpriteComps1034 == nil then
				arg_466_1.var_.actorSpriteComps1034 = var_469_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_3 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_3 and not isNil(var_469_2) then
				if arg_466_1.var_.actorSpriteComps1034 then
					for iter_469_4, iter_469_5 in pairs(arg_466_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_469_5 then
							if arg_466_1.isInRecall_ then
								iter_469_5.color = Color.New(Mathf.Lerp(iter_469_5.color.r, arg_466_1.hightColor2.r, (arg_466_1.time_ - 0) / var_469_3), Mathf.Lerp(iter_469_5.color.g, arg_466_1.hightColor2.g, (arg_466_1.time_ - 0) / var_469_3), (Mathf.Lerp(iter_469_5.color.b, arg_466_1.hightColor2.b, (arg_466_1.time_ - 0) / var_469_3)))
							else
								local var_469_4 = Mathf.Lerp(iter_469_5.color.r, 0.5, (arg_466_1.time_ - 0) / var_469_3)

								iter_469_5.color = Color.New(var_469_4, var_469_4, var_469_4)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= 0 + var_469_3 and arg_466_1.time_ < 0 + var_469_3 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.actorSpriteComps1034 then
				for iter_469_6, iter_469_7 in pairs(arg_466_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_469_7 then
						iter_469_7.color = arg_466_1.isInRecall_ and (arg_466_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_466_1.var_.actorSpriteComps1034 = nil
			end

			local var_469_5 = arg_466_1.actors_["1060"].transform

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos1060 = var_469_5.localPosition
				var_469_5.localScale = Vector3.New(1, 1, 1)

				arg_466_1:CheckSpriteTmpPos("1060", 2)

				for iter_469_8 = 0, var_469_5.childCount - 1 do
					local var_469_6 = var_469_5:GetChild(iter_469_8)

					if var_469_6.name == "split_1" or not string.find(var_469_6.name, "split") then
						var_469_6.gameObject:SetActive(true)
					else
						var_469_6.gameObject:SetActive(false)
					end
				end
			end

			local var_469_7 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				var_469_5.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_466_1.time_ - 0) / var_469_7)
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				var_469_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_469_8 = 0
			local var_469_9 = 0.575

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_8 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_10 = arg_466_1:GetWordFromCfg(417031111)
				local var_469_11 = arg_466_1:FormatText(var_469_10.content)

				arg_466_1.text_.text = var_469_11

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_13 = 23 <= 0 and var_469_9 or var_469_9 * (utf8.len(var_469_11) / 23)

				if (23 <= 0 and var_469_9 or var_469_9 * (utf8.len(var_469_11) / 23)) > 0 and var_469_9 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_8 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_8
					end
				end

				arg_466_1.text_.text = var_469_11
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031111", "story_v_out_417031.awb") ~= 0 then
					local var_469_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031111", "story_v_out_417031.awb") / 1000

					if var_469_14 + var_469_8 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_14 + var_469_8
					end

					if var_469_10.prefab_name ~= "" and arg_466_1.actors_[var_469_10.prefab_name] ~= nil then
						local var_469_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_10.prefab_name].transform, "story_v_out_417031", "417031111", "story_v_out_417031.awb")

						arg_466_1:RecordAudio("417031111", var_469_15)
						arg_466_1:RecordAudio("417031111", var_469_15)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_417031", "417031111", "story_v_out_417031.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_417031", "417031111", "story_v_out_417031.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_9, arg_466_1.talkMaxDuration)

			if var_469_8 <= arg_466_1.time_ and arg_466_1.time_ < var_469_8 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_8) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_8 + var_469_16 and arg_466_1.time_ < var_469_8 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play417031112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 417031112
		arg_470_1.duration_ = 12.97

		local var_470_0 = {
			zh = 9.366,
			ja = 12.966
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play417031113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["1034"]) and arg_470_1.var_.actorSpriteComps1034 == nil then
				arg_470_1.var_.actorSpriteComps1034 = arg_470_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_473_0 = 0.2

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["1034"]) then
				if arg_470_1.var_.actorSpriteComps1034 then
					for iter_473_0, iter_473_1 in pairs(arg_470_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_473_1 then
							if arg_470_1.isInRecall_ then
								iter_473_1.color = Color.New(Mathf.Lerp(iter_473_1.color.r, arg_470_1.hightColor1.r, (arg_470_1.time_ - 0) / var_473_0), Mathf.Lerp(iter_473_1.color.g, arg_470_1.hightColor1.g, (arg_470_1.time_ - 0) / var_473_0), (Mathf.Lerp(iter_473_1.color.b, arg_470_1.hightColor1.b, (arg_470_1.time_ - 0) / var_473_0)))
							else
								local var_473_1 = Mathf.Lerp(iter_473_1.color.r, 1, (arg_470_1.time_ - 0) / var_473_0)

								iter_473_1.color = Color.New(var_473_1, var_473_1, var_473_1)
							end
						end
					end
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["1034"]) and arg_470_1.var_.actorSpriteComps1034 then
				for iter_473_2, iter_473_3 in pairs(arg_470_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_473_3 then
						iter_473_3.color = arg_470_1.isInRecall_ and (arg_470_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_470_1.var_.actorSpriteComps1034 = nil
			end

			local var_473_2 = arg_470_1.actors_["1060"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_2) and arg_470_1.var_.actorSpriteComps1060 == nil then
				arg_470_1.var_.actorSpriteComps1060 = var_473_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_473_3 = 0.2

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_3 and not isNil(var_473_2) then
				if arg_470_1.var_.actorSpriteComps1060 then
					for iter_473_4, iter_473_5 in pairs(arg_470_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_473_5 then
							if arg_470_1.isInRecall_ then
								iter_473_5.color = Color.New(Mathf.Lerp(iter_473_5.color.r, arg_470_1.hightColor2.r, (arg_470_1.time_ - 0) / var_473_3), Mathf.Lerp(iter_473_5.color.g, arg_470_1.hightColor2.g, (arg_470_1.time_ - 0) / var_473_3), (Mathf.Lerp(iter_473_5.color.b, arg_470_1.hightColor2.b, (arg_470_1.time_ - 0) / var_473_3)))
							else
								local var_473_4 = Mathf.Lerp(iter_473_5.color.r, 0.5, (arg_470_1.time_ - 0) / var_473_3)

								iter_473_5.color = Color.New(var_473_4, var_473_4, var_473_4)
							end
						end
					end
				end
			end

			if arg_470_1.time_ >= 0 + var_473_3 and arg_470_1.time_ < 0 + var_473_3 + arg_473_0 and not isNil(var_473_2) and arg_470_1.var_.actorSpriteComps1060 then
				for iter_473_6, iter_473_7 in pairs(arg_470_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_473_7 then
						iter_473_7.color = arg_470_1.isInRecall_ and (arg_470_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_470_1.var_.actorSpriteComps1060 = nil
			end

			local var_473_5 = 0
			local var_473_6 = 1.075

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_5 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_7 = arg_470_1:GetWordFromCfg(417031112)
				local var_473_8 = arg_470_1:FormatText(var_473_7.content)

				arg_470_1.text_.text = var_473_8

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_10 = 43 <= 0 and var_473_6 or var_473_6 * (utf8.len(var_473_8) / 43)

				if (43 <= 0 and var_473_6 or var_473_6 * (utf8.len(var_473_8) / 43)) > 0 and var_473_6 < var_473_10 then
					arg_470_1.talkMaxDuration = var_473_10

					if var_473_10 + var_473_5 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_10 + var_473_5
					end
				end

				arg_470_1.text_.text = var_473_8
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031112", "story_v_out_417031.awb") ~= 0 then
					local var_473_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031112", "story_v_out_417031.awb") / 1000

					if var_473_11 + var_473_5 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_11 + var_473_5
					end

					if var_473_7.prefab_name ~= "" and arg_470_1.actors_[var_473_7.prefab_name] ~= nil then
						local var_473_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_7.prefab_name].transform, "story_v_out_417031", "417031112", "story_v_out_417031.awb")

						arg_470_1:RecordAudio("417031112", var_473_12)
						arg_470_1:RecordAudio("417031112", var_473_12)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_417031", "417031112", "story_v_out_417031.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_417031", "417031112", "story_v_out_417031.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_13 = math.max(var_473_6, arg_470_1.talkMaxDuration)

			if var_473_5 <= arg_470_1.time_ and arg_470_1.time_ < var_473_5 + var_473_13 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_5) / var_473_13

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_5 + var_473_13 and arg_470_1.time_ < var_473_5 + var_473_13 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play417031113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 417031113
		arg_474_1.duration_ = 7.27

		local var_474_0 = {
			zh = 2.8,
			ja = 7.266
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play417031114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["1060"]) and arg_474_1.var_.actorSpriteComps1060 == nil then
				arg_474_1.var_.actorSpriteComps1060 = arg_474_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_477_0 = 0.2

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["1060"]) then
				if arg_474_1.var_.actorSpriteComps1060 then
					for iter_477_0, iter_477_1 in pairs(arg_474_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_477_1 then
							if arg_474_1.isInRecall_ then
								iter_477_1.color = Color.New(Mathf.Lerp(iter_477_1.color.r, arg_474_1.hightColor1.r, (arg_474_1.time_ - 0) / var_477_0), Mathf.Lerp(iter_477_1.color.g, arg_474_1.hightColor1.g, (arg_474_1.time_ - 0) / var_477_0), (Mathf.Lerp(iter_477_1.color.b, arg_474_1.hightColor1.b, (arg_474_1.time_ - 0) / var_477_0)))
							else
								local var_477_1 = Mathf.Lerp(iter_477_1.color.r, 1, (arg_474_1.time_ - 0) / var_477_0)

								iter_477_1.color = Color.New(var_477_1, var_477_1, var_477_1)
							end
						end
					end
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["1060"]) and arg_474_1.var_.actorSpriteComps1060 then
				for iter_477_2, iter_477_3 in pairs(arg_474_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_477_3 then
						iter_477_3.color = arg_474_1.isInRecall_ and (arg_474_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_474_1.var_.actorSpriteComps1060 = nil
			end

			local var_477_2 = arg_474_1.actors_["1034"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_2) and arg_474_1.var_.actorSpriteComps1034 == nil then
				arg_474_1.var_.actorSpriteComps1034 = var_477_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_477_3 = 0.2

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_3 and not isNil(var_477_2) then
				if arg_474_1.var_.actorSpriteComps1034 then
					for iter_477_4, iter_477_5 in pairs(arg_474_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_477_5 then
							if arg_474_1.isInRecall_ then
								iter_477_5.color = Color.New(Mathf.Lerp(iter_477_5.color.r, arg_474_1.hightColor2.r, (arg_474_1.time_ - 0) / var_477_3), Mathf.Lerp(iter_477_5.color.g, arg_474_1.hightColor2.g, (arg_474_1.time_ - 0) / var_477_3), (Mathf.Lerp(iter_477_5.color.b, arg_474_1.hightColor2.b, (arg_474_1.time_ - 0) / var_477_3)))
							else
								local var_477_4 = Mathf.Lerp(iter_477_5.color.r, 0.5, (arg_474_1.time_ - 0) / var_477_3)

								iter_477_5.color = Color.New(var_477_4, var_477_4, var_477_4)
							end
						end
					end
				end
			end

			if arg_474_1.time_ >= 0 + var_477_3 and arg_474_1.time_ < 0 + var_477_3 + arg_477_0 and not isNil(var_477_2) and arg_474_1.var_.actorSpriteComps1034 then
				for iter_477_6, iter_477_7 in pairs(arg_474_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_477_7 then
						iter_477_7.color = arg_474_1.isInRecall_ and (arg_474_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_474_1.var_.actorSpriteComps1034 = nil
			end

			local var_477_5 = arg_474_1.actors_["1060"].transform

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1060 = var_477_5.localPosition
				var_477_5.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("1060", 2)

				for iter_477_8 = 0, var_477_5.childCount - 1 do
					local var_477_6 = var_477_5:GetChild(iter_477_8)

					if var_477_6.name == "" or not string.find(var_477_6.name, "split") then
						var_477_6.gameObject:SetActive(true)
					else
						var_477_6.gameObject:SetActive(false)
					end
				end
			end

			local var_477_7 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_7 then
				var_477_5.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_474_1.time_ - 0) / var_477_7)
			end

			if arg_474_1.time_ >= 0 + var_477_7 and arg_474_1.time_ < 0 + var_477_7 + arg_477_0 then
				var_477_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_477_8 = 0
			local var_477_9 = 0.375

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_10 = arg_474_1:GetWordFromCfg(417031113)
				local var_477_11 = arg_474_1:FormatText(var_477_10.content)

				arg_474_1.text_.text = var_477_11

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_13 = 15 <= 0 and var_477_9 or var_477_9 * (utf8.len(var_477_11) / 15)

				if (15 <= 0 and var_477_9 or var_477_9 * (utf8.len(var_477_11) / 15)) > 0 and var_477_9 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_8 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_8
					end
				end

				arg_474_1.text_.text = var_477_11
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031113", "story_v_out_417031.awb") ~= 0 then
					local var_477_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031113", "story_v_out_417031.awb") / 1000

					if var_477_14 + var_477_8 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_14 + var_477_8
					end

					if var_477_10.prefab_name ~= "" and arg_474_1.actors_[var_477_10.prefab_name] ~= nil then
						local var_477_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_10.prefab_name].transform, "story_v_out_417031", "417031113", "story_v_out_417031.awb")

						arg_474_1:RecordAudio("417031113", var_477_15)
						arg_474_1:RecordAudio("417031113", var_477_15)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_417031", "417031113", "story_v_out_417031.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_417031", "417031113", "story_v_out_417031.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_16 = math.max(var_477_9, arg_474_1.talkMaxDuration)

			if var_477_8 <= arg_474_1.time_ and arg_474_1.time_ < var_477_8 + var_477_16 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_8) / var_477_16

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_8 + var_477_16 and arg_474_1.time_ < var_477_8 + var_477_16 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play417031114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 417031114
		arg_478_1.duration_ = 2.8

		local var_478_0 = {
			zh = 2.8,
			ja = 1.733
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play417031115(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["1034"]) and arg_478_1.var_.actorSpriteComps1034 == nil then
				arg_478_1.var_.actorSpriteComps1034 = arg_478_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_0 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["1034"]) then
				if arg_478_1.var_.actorSpriteComps1034 then
					for iter_481_0, iter_481_1 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_481_1 then
							if arg_478_1.isInRecall_ then
								iter_481_1.color = Color.New(Mathf.Lerp(iter_481_1.color.r, arg_478_1.hightColor1.r, (arg_478_1.time_ - 0) / var_481_0), Mathf.Lerp(iter_481_1.color.g, arg_478_1.hightColor1.g, (arg_478_1.time_ - 0) / var_481_0), (Mathf.Lerp(iter_481_1.color.b, arg_478_1.hightColor1.b, (arg_478_1.time_ - 0) / var_481_0)))
							else
								local var_481_1 = Mathf.Lerp(iter_481_1.color.r, 1, (arg_478_1.time_ - 0) / var_481_0)

								iter_481_1.color = Color.New(var_481_1, var_481_1, var_481_1)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["1034"]) and arg_478_1.var_.actorSpriteComps1034 then
				for iter_481_2, iter_481_3 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_481_3 then
						iter_481_3.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_478_1.var_.actorSpriteComps1034 = nil
			end

			local var_481_2 = arg_478_1.actors_["1060"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps1060 == nil then
				arg_478_1.var_.actorSpriteComps1060 = var_481_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_3 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_3 and not isNil(var_481_2) then
				if arg_478_1.var_.actorSpriteComps1060 then
					for iter_481_4, iter_481_5 in pairs(arg_478_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_481_5 then
							if arg_478_1.isInRecall_ then
								iter_481_5.color = Color.New(Mathf.Lerp(iter_481_5.color.r, arg_478_1.hightColor2.r, (arg_478_1.time_ - 0) / var_481_3), Mathf.Lerp(iter_481_5.color.g, arg_478_1.hightColor2.g, (arg_478_1.time_ - 0) / var_481_3), (Mathf.Lerp(iter_481_5.color.b, arg_478_1.hightColor2.b, (arg_478_1.time_ - 0) / var_481_3)))
							else
								local var_481_4 = Mathf.Lerp(iter_481_5.color.r, 0.5, (arg_478_1.time_ - 0) / var_481_3)

								iter_481_5.color = Color.New(var_481_4, var_481_4, var_481_4)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_3 and arg_478_1.time_ < 0 + var_481_3 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps1060 then
				for iter_481_6, iter_481_7 in pairs(arg_478_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_481_7 then
						iter_481_7.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_478_1.var_.actorSpriteComps1060 = nil
			end

			local var_481_5 = arg_478_1.actors_["1034"].transform

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1034 = var_481_5.localPosition
				var_481_5.localScale = Vector3.New(1, 1, 1)

				arg_478_1:CheckSpriteTmpPos("1034", 4)

				for iter_481_8 = 0, var_481_5.childCount - 1 do
					local var_481_6 = var_481_5:GetChild(iter_481_8)

					if var_481_6.name == "split_6" or not string.find(var_481_6.name, "split") then
						var_481_6.gameObject:SetActive(true)
					else
						var_481_6.gameObject:SetActive(false)
					end
				end
			end

			local var_481_7 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				var_481_5.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_478_1.time_ - 0) / var_481_7)
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
				var_481_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_481_8 = 0
			local var_481_9 = 0.2

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_10 = arg_478_1:GetWordFromCfg(417031114)
				local var_481_11 = arg_478_1:FormatText(var_481_10.content)

				arg_478_1.text_.text = var_481_11

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_13 = 8 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 8)

				if (8 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_11) / 8)) > 0 and var_481_9 < var_481_13 then
					arg_478_1.talkMaxDuration = var_481_13

					if var_481_13 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_13 + var_481_8
					end
				end

				arg_478_1.text_.text = var_481_11
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031114", "story_v_out_417031.awb") ~= 0 then
					local var_481_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031114", "story_v_out_417031.awb") / 1000

					if var_481_14 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_14 + var_481_8
					end

					if var_481_10.prefab_name ~= "" and arg_478_1.actors_[var_481_10.prefab_name] ~= nil then
						local var_481_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_10.prefab_name].transform, "story_v_out_417031", "417031114", "story_v_out_417031.awb")

						arg_478_1:RecordAudio("417031114", var_481_15)
						arg_478_1:RecordAudio("417031114", var_481_15)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_417031", "417031114", "story_v_out_417031.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_417031", "417031114", "story_v_out_417031.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_16 = math.max(var_481_9, arg_478_1.talkMaxDuration)

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_16 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_8) / var_481_16

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_8 + var_481_16 and arg_478_1.time_ < var_481_8 + var_481_16 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
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

		arg_478_1:InitPlayNodeList()
	end,
	Play417031115 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 417031115
		arg_482_1.duration_ = 5.1

		local var_482_0 = {
			zh = 2.7,
			ja = 5.1
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play417031116(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.325

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:GetWordFromCfg(417031115)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 13 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 13)

				if (13 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 13)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031115", "story_v_out_417031.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031115", "story_v_out_417031.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_out_417031", "417031115", "story_v_out_417031.awb")

						arg_482_1:RecordAudio("417031115", var_485_6)
						arg_482_1:RecordAudio("417031115", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_417031", "417031115", "story_v_out_417031.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_417031", "417031115", "story_v_out_417031.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play417031116 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 417031116
		arg_486_1.duration_ = 6.83

		local var_486_0 = {
			zh = 3.533,
			ja = 6.833
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play417031117(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["1060"]) and arg_486_1.var_.actorSpriteComps1060 == nil then
				arg_486_1.var_.actorSpriteComps1060 = arg_486_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_0 = 0.2

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["1060"]) then
				if arg_486_1.var_.actorSpriteComps1060 then
					for iter_489_0, iter_489_1 in pairs(arg_486_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_489_1 then
							if arg_486_1.isInRecall_ then
								iter_489_1.color = Color.New(Mathf.Lerp(iter_489_1.color.r, arg_486_1.hightColor1.r, (arg_486_1.time_ - 0) / var_489_0), Mathf.Lerp(iter_489_1.color.g, arg_486_1.hightColor1.g, (arg_486_1.time_ - 0) / var_489_0), (Mathf.Lerp(iter_489_1.color.b, arg_486_1.hightColor1.b, (arg_486_1.time_ - 0) / var_489_0)))
							else
								local var_489_1 = Mathf.Lerp(iter_489_1.color.r, 1, (arg_486_1.time_ - 0) / var_489_0)

								iter_489_1.color = Color.New(var_489_1, var_489_1, var_489_1)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["1060"]) and arg_486_1.var_.actorSpriteComps1060 then
				for iter_489_2, iter_489_3 in pairs(arg_486_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_489_3 then
						iter_489_3.color = arg_486_1.isInRecall_ and (arg_486_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_486_1.var_.actorSpriteComps1060 = nil
			end

			local var_489_2 = arg_486_1.actors_["1034"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.actorSpriteComps1034 == nil then
				arg_486_1.var_.actorSpriteComps1034 = var_489_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_3 = 0.2

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_3 and not isNil(var_489_2) then
				if arg_486_1.var_.actorSpriteComps1034 then
					for iter_489_4, iter_489_5 in pairs(arg_486_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_489_5 then
							if arg_486_1.isInRecall_ then
								iter_489_5.color = Color.New(Mathf.Lerp(iter_489_5.color.r, arg_486_1.hightColor2.r, (arg_486_1.time_ - 0) / var_489_3), Mathf.Lerp(iter_489_5.color.g, arg_486_1.hightColor2.g, (arg_486_1.time_ - 0) / var_489_3), (Mathf.Lerp(iter_489_5.color.b, arg_486_1.hightColor2.b, (arg_486_1.time_ - 0) / var_489_3)))
							else
								local var_489_4 = Mathf.Lerp(iter_489_5.color.r, 0.5, (arg_486_1.time_ - 0) / var_489_3)

								iter_489_5.color = Color.New(var_489_4, var_489_4, var_489_4)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= 0 + var_489_3 and arg_486_1.time_ < 0 + var_489_3 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.actorSpriteComps1034 then
				for iter_489_6, iter_489_7 in pairs(arg_486_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_489_7 then
						iter_489_7.color = arg_486_1.isInRecall_ and (arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_486_1.var_.actorSpriteComps1034 = nil
			end

			local var_489_5 = 0
			local var_489_6 = 0.375

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_5 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_7 = arg_486_1:GetWordFromCfg(417031116)
				local var_489_8 = arg_486_1:FormatText(var_489_7.content)

				arg_486_1.text_.text = var_489_8

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_10 = 15 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_8) / 15)

				if (15 <= 0 and var_489_6 or var_489_6 * (utf8.len(var_489_8) / 15)) > 0 and var_489_6 < var_489_10 then
					arg_486_1.talkMaxDuration = var_489_10

					if var_489_10 + var_489_5 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_10 + var_489_5
					end
				end

				arg_486_1.text_.text = var_489_8
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031116", "story_v_out_417031.awb") ~= 0 then
					local var_489_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031116", "story_v_out_417031.awb") / 1000

					if var_489_11 + var_489_5 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_11 + var_489_5
					end

					if var_489_7.prefab_name ~= "" and arg_486_1.actors_[var_489_7.prefab_name] ~= nil then
						local var_489_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_7.prefab_name].transform, "story_v_out_417031", "417031116", "story_v_out_417031.awb")

						arg_486_1:RecordAudio("417031116", var_489_12)
						arg_486_1:RecordAudio("417031116", var_489_12)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_417031", "417031116", "story_v_out_417031.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_417031", "417031116", "story_v_out_417031.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_13 = math.max(var_489_6, arg_486_1.talkMaxDuration)

			if var_489_5 <= arg_486_1.time_ and arg_486_1.time_ < var_489_5 + var_489_13 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_5) / var_489_13

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_5 + var_489_13 and arg_486_1.time_ < var_489_5 + var_489_13 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play417031117 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 417031117
		arg_490_1.duration_ = 4.3

		local var_490_0 = {
			zh = 1.3,
			ja = 4.3
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play417031118(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1034"]) and arg_490_1.var_.actorSpriteComps1034 == nil then
				arg_490_1.var_.actorSpriteComps1034 = arg_490_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_0 = 0.2

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1034"]) then
				if arg_490_1.var_.actorSpriteComps1034 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								iter_493_1.color = Color.New(Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, (arg_490_1.time_ - 0) / var_493_0), Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, (arg_490_1.time_ - 0) / var_493_0), (Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, (arg_490_1.time_ - 0) / var_493_0)))
							else
								local var_493_1 = Mathf.Lerp(iter_493_1.color.r, 1, (arg_490_1.time_ - 0) / var_493_0)

								iter_493_1.color = Color.New(var_493_1, var_493_1, var_493_1)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1034"]) and arg_490_1.var_.actorSpriteComps1034 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_493_3 then
						iter_493_3.color = arg_490_1.isInRecall_ and (arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_490_1.var_.actorSpriteComps1034 = nil
			end

			local var_493_2 = arg_490_1.actors_["1060"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_2) and arg_490_1.var_.actorSpriteComps1060 == nil then
				arg_490_1.var_.actorSpriteComps1060 = var_493_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_3 = 0.2

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_3 and not isNil(var_493_2) then
				if arg_490_1.var_.actorSpriteComps1060 then
					for iter_493_4, iter_493_5 in pairs(arg_490_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_493_5 then
							if arg_490_1.isInRecall_ then
								iter_493_5.color = Color.New(Mathf.Lerp(iter_493_5.color.r, arg_490_1.hightColor2.r, (arg_490_1.time_ - 0) / var_493_3), Mathf.Lerp(iter_493_5.color.g, arg_490_1.hightColor2.g, (arg_490_1.time_ - 0) / var_493_3), (Mathf.Lerp(iter_493_5.color.b, arg_490_1.hightColor2.b, (arg_490_1.time_ - 0) / var_493_3)))
							else
								local var_493_4 = Mathf.Lerp(iter_493_5.color.r, 0.5, (arg_490_1.time_ - 0) / var_493_3)

								iter_493_5.color = Color.New(var_493_4, var_493_4, var_493_4)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= 0 + var_493_3 and arg_490_1.time_ < 0 + var_493_3 + arg_493_0 and not isNil(var_493_2) and arg_490_1.var_.actorSpriteComps1060 then
				for iter_493_6, iter_493_7 in pairs(arg_490_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_493_7 then
						iter_493_7.color = arg_490_1.isInRecall_ and (arg_490_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_490_1.var_.actorSpriteComps1060 = nil
			end

			local var_493_5 = arg_490_1.actors_["1034"].transform

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1034 = var_493_5.localPosition
				var_493_5.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("1034", 4)

				for iter_493_8 = 0, var_493_5.childCount - 1 do
					local var_493_6 = var_493_5:GetChild(iter_493_8)

					if var_493_6.name == "split_1" or not string.find(var_493_6.name, "split") then
						var_493_6.gameObject:SetActive(true)
					else
						var_493_6.gameObject:SetActive(false)
					end
				end
			end

			local var_493_7 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				var_493_5.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_490_1.time_ - 0) / var_493_7)
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				var_493_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_493_8 = 0
			local var_493_9 = 0.1

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_8 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_10 = arg_490_1:GetWordFromCfg(417031117)
				local var_493_11 = arg_490_1:FormatText(var_493_10.content)

				arg_490_1.text_.text = var_493_11

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_13 = 4 <= 0 and var_493_9 or var_493_9 * (utf8.len(var_493_11) / 4)

				if (4 <= 0 and var_493_9 or var_493_9 * (utf8.len(var_493_11) / 4)) > 0 and var_493_9 < var_493_13 then
					arg_490_1.talkMaxDuration = var_493_13

					if var_493_13 + var_493_8 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_13 + var_493_8
					end
				end

				arg_490_1.text_.text = var_493_11
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031117", "story_v_out_417031.awb") ~= 0 then
					local var_493_14 = manager.audio:GetVoiceLength("story_v_out_417031", "417031117", "story_v_out_417031.awb") / 1000

					if var_493_14 + var_493_8 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_14 + var_493_8
					end

					if var_493_10.prefab_name ~= "" and arg_490_1.actors_[var_493_10.prefab_name] ~= nil then
						local var_493_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_10.prefab_name].transform, "story_v_out_417031", "417031117", "story_v_out_417031.awb")

						arg_490_1:RecordAudio("417031117", var_493_15)
						arg_490_1:RecordAudio("417031117", var_493_15)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_417031", "417031117", "story_v_out_417031.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_417031", "417031117", "story_v_out_417031.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_16 = math.max(var_493_9, arg_490_1.talkMaxDuration)

			if var_493_8 <= arg_490_1.time_ and arg_490_1.time_ < var_493_8 + var_493_16 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_8) / var_493_16

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_8 + var_493_16 and arg_490_1.time_ < var_493_8 + var_493_16 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
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

		arg_490_1:InitPlayNodeList()
	end,
	Play417031118 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 417031118
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play417031119(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1034"]) and arg_494_1.var_.actorSpriteComps1034 == nil then
				arg_494_1.var_.actorSpriteComps1034 = arg_494_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_0 = 0.2

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1034"]) then
				if arg_494_1.var_.actorSpriteComps1034 then
					for iter_497_0, iter_497_1 in pairs(arg_494_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_497_1 then
							if arg_494_1.isInRecall_ then
								iter_497_1.color = Color.New(Mathf.Lerp(iter_497_1.color.r, arg_494_1.hightColor2.r, (arg_494_1.time_ - 0) / var_497_0), Mathf.Lerp(iter_497_1.color.g, arg_494_1.hightColor2.g, (arg_494_1.time_ - 0) / var_497_0), (Mathf.Lerp(iter_497_1.color.b, arg_494_1.hightColor2.b, (arg_494_1.time_ - 0) / var_497_0)))
							else
								local var_497_1 = Mathf.Lerp(iter_497_1.color.r, 0.5, (arg_494_1.time_ - 0) / var_497_0)

								iter_497_1.color = Color.New(var_497_1, var_497_1, var_497_1)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1034"]) and arg_494_1.var_.actorSpriteComps1034 then
				for iter_497_2, iter_497_3 in pairs(arg_494_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_497_3 then
						iter_497_3.color = arg_494_1.isInRecall_ and (arg_494_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_494_1.var_.actorSpriteComps1034 = nil
			end

			local var_497_2 = arg_494_1.actors_["1060"].transform

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1060 = var_497_2.localPosition
				var_497_2.localScale = Vector3.New(1, 1, 1)

				arg_494_1:CheckSpriteTmpPos("1060", 7)

				for iter_497_4 = 0, var_497_2.childCount - 1 do
					local var_497_3 = var_497_2:GetChild(iter_497_4)

					if var_497_3.name == "" or not string.find(var_497_3.name, "split") then
						var_497_3.gameObject:SetActive(true)
					else
						var_497_3.gameObject:SetActive(false)
					end
				end
			end

			local var_497_4 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				var_497_2.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_494_1.time_ - 0) / var_497_4)
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				var_497_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_497_5 = arg_494_1.actors_["1034"].transform

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1034 = var_497_5.localPosition
				var_497_5.localScale = Vector3.New(1, 1, 1)

				arg_494_1:CheckSpriteTmpPos("1034", 7)

				for iter_497_5 = 0, var_497_5.childCount - 1 do
					local var_497_6 = var_497_5:GetChild(iter_497_5)

					if var_497_6.name == "" or not string.find(var_497_6.name, "split") then
						var_497_6.gameObject:SetActive(true)
					else
						var_497_6.gameObject:SetActive(false)
					end
				end
			end

			local var_497_7 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				var_497_5.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_494_1.time_ - 0) / var_497_7)
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				var_497_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_497_8 = 0
			local var_497_9 = 0.6

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_8 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_10 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(417031118).content)

				arg_494_1.text_.text = var_497_10

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_12 = 24 <= 0 and var_497_9 or var_497_9 * (utf8.len(var_497_10) / 24)

				if (24 <= 0 and var_497_9 or var_497_9 * (utf8.len(var_497_10) / 24)) > 0 and var_497_9 < var_497_12 then
					arg_494_1.talkMaxDuration = var_497_12

					if var_497_12 + var_497_8 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_12 + var_497_8
					end
				end

				arg_494_1.text_.text = var_497_10
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_13 = math.max(var_497_9, arg_494_1.talkMaxDuration)

			if var_497_8 <= arg_494_1.time_ and arg_494_1.time_ < var_497_8 + var_497_13 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_8) / var_497_13

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_8 + var_497_13 and arg_494_1.time_ < var_497_8 + var_497_13 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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

		arg_494_1:InitPlayNodeList()
	end,
	Play417031119 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 417031119
		arg_498_1.duration_ = 6.2

		local var_498_0 = {
			zh = 6.2,
			ja = 5.5
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play417031120(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1034"]) and arg_498_1.var_.actorSpriteComps1034 == nil then
				arg_498_1.var_.actorSpriteComps1034 = arg_498_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_0 = 0.2

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1034"]) then
				if arg_498_1.var_.actorSpriteComps1034 then
					for iter_501_0, iter_501_1 in pairs(arg_498_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_501_1 then
							if arg_498_1.isInRecall_ then
								iter_501_1.color = Color.New(Mathf.Lerp(iter_501_1.color.r, arg_498_1.hightColor1.r, (arg_498_1.time_ - 0) / var_501_0), Mathf.Lerp(iter_501_1.color.g, arg_498_1.hightColor1.g, (arg_498_1.time_ - 0) / var_501_0), (Mathf.Lerp(iter_501_1.color.b, arg_498_1.hightColor1.b, (arg_498_1.time_ - 0) / var_501_0)))
							else
								local var_501_1 = Mathf.Lerp(iter_501_1.color.r, 1, (arg_498_1.time_ - 0) / var_501_0)

								iter_501_1.color = Color.New(var_501_1, var_501_1, var_501_1)
							end
						end
					end
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1034"]) and arg_498_1.var_.actorSpriteComps1034 then
				for iter_501_2, iter_501_3 in pairs(arg_498_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_501_3 then
						iter_501_3.color = arg_498_1.isInRecall_ and (arg_498_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_498_1.var_.actorSpriteComps1034 = nil
			end

			local var_501_2 = arg_498_1.actors_["1034"].transform

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1034 = var_501_2.localPosition
				var_501_2.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("1034", 3)

				for iter_501_4 = 0, var_501_2.childCount - 1 do
					local var_501_3 = var_501_2:GetChild(iter_501_4)

					if var_501_3.name == "" or not string.find(var_501_3.name, "split") then
						var_501_3.gameObject:SetActive(true)
					else
						var_501_3.gameObject:SetActive(false)
					end
				end
			end

			local var_501_4 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_4 then
				var_501_2.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_498_1.time_ - 0) / var_501_4)
			end

			if arg_498_1.time_ >= 0 + var_501_4 and arg_498_1.time_ < 0 + var_501_4 + arg_501_0 then
				var_501_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_501_5 = 0
			local var_501_6 = 0.775

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_5 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_7 = arg_498_1:GetWordFromCfg(417031119)
				local var_501_8 = arg_498_1:FormatText(var_501_7.content)

				arg_498_1.text_.text = var_501_8

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_10 = 31 <= 0 and var_501_6 or var_501_6 * (utf8.len(var_501_8) / 31)

				if (31 <= 0 and var_501_6 or var_501_6 * (utf8.len(var_501_8) / 31)) > 0 and var_501_6 < var_501_10 then
					arg_498_1.talkMaxDuration = var_501_10

					if var_501_10 + var_501_5 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_5
					end
				end

				arg_498_1.text_.text = var_501_8
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031119", "story_v_out_417031.awb") ~= 0 then
					local var_501_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031119", "story_v_out_417031.awb") / 1000

					if var_501_11 + var_501_5 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_11 + var_501_5
					end

					if var_501_7.prefab_name ~= "" and arg_498_1.actors_[var_501_7.prefab_name] ~= nil then
						local var_501_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_7.prefab_name].transform, "story_v_out_417031", "417031119", "story_v_out_417031.awb")

						arg_498_1:RecordAudio("417031119", var_501_12)
						arg_498_1:RecordAudio("417031119", var_501_12)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_417031", "417031119", "story_v_out_417031.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_417031", "417031119", "story_v_out_417031.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_13 = math.max(var_501_6, arg_498_1.talkMaxDuration)

			if var_501_5 <= arg_498_1.time_ and arg_498_1.time_ < var_501_5 + var_501_13 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_5) / var_501_13

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_5 + var_501_13 and arg_498_1.time_ < var_501_5 + var_501_13 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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

		arg_498_1:InitPlayNodeList()
	end,
	Play417031120 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 417031120
		arg_502_1.duration_ = 1.67

		local var_502_0 = {
			zh = 0.999999999999,
			ja = 1.666
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play417031121(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1060"]) and arg_502_1.var_.actorSpriteComps1060 == nil then
				arg_502_1.var_.actorSpriteComps1060 = arg_502_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_0 = 0.2

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1060"]) then
				if arg_502_1.var_.actorSpriteComps1060 then
					for iter_505_0, iter_505_1 in pairs(arg_502_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_505_1 then
							if arg_502_1.isInRecall_ then
								iter_505_1.color = Color.New(Mathf.Lerp(iter_505_1.color.r, arg_502_1.hightColor1.r, (arg_502_1.time_ - 0) / var_505_0), Mathf.Lerp(iter_505_1.color.g, arg_502_1.hightColor1.g, (arg_502_1.time_ - 0) / var_505_0), (Mathf.Lerp(iter_505_1.color.b, arg_502_1.hightColor1.b, (arg_502_1.time_ - 0) / var_505_0)))
							else
								local var_505_1 = Mathf.Lerp(iter_505_1.color.r, 1, (arg_502_1.time_ - 0) / var_505_0)

								iter_505_1.color = Color.New(var_505_1, var_505_1, var_505_1)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1060"]) and arg_502_1.var_.actorSpriteComps1060 then
				for iter_505_2, iter_505_3 in pairs(arg_502_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_505_3 then
						iter_505_3.color = arg_502_1.isInRecall_ and (arg_502_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_502_1.var_.actorSpriteComps1060 = nil
			end

			local var_505_2 = arg_502_1.actors_["1034"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.actorSpriteComps1034 == nil then
				arg_502_1.var_.actorSpriteComps1034 = var_505_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_3 = 0.2

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_3 and not isNil(var_505_2) then
				if arg_502_1.var_.actorSpriteComps1034 then
					for iter_505_4, iter_505_5 in pairs(arg_502_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_505_5 then
							if arg_502_1.isInRecall_ then
								iter_505_5.color = Color.New(Mathf.Lerp(iter_505_5.color.r, arg_502_1.hightColor2.r, (arg_502_1.time_ - 0) / var_505_3), Mathf.Lerp(iter_505_5.color.g, arg_502_1.hightColor2.g, (arg_502_1.time_ - 0) / var_505_3), (Mathf.Lerp(iter_505_5.color.b, arg_502_1.hightColor2.b, (arg_502_1.time_ - 0) / var_505_3)))
							else
								local var_505_4 = Mathf.Lerp(iter_505_5.color.r, 0.5, (arg_502_1.time_ - 0) / var_505_3)

								iter_505_5.color = Color.New(var_505_4, var_505_4, var_505_4)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= 0 + var_505_3 and arg_502_1.time_ < 0 + var_505_3 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.actorSpriteComps1034 then
				for iter_505_6, iter_505_7 in pairs(arg_502_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_505_7 then
						iter_505_7.color = arg_502_1.isInRecall_ and (arg_502_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_502_1.var_.actorSpriteComps1034 = nil
			end

			local var_505_5 = 0
			local var_505_6 = 0.075

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_5 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1060_split_1_1")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_7 = arg_502_1:GetWordFromCfg(417031120)
				local var_505_8 = arg_502_1:FormatText(var_505_7.content)

				arg_502_1.text_.text = var_505_8

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_10 = 3 <= 0 and var_505_6 or var_505_6 * (utf8.len(var_505_8) / 3)

				if (3 <= 0 and var_505_6 or var_505_6 * (utf8.len(var_505_8) / 3)) > 0 and var_505_6 < var_505_10 then
					arg_502_1.talkMaxDuration = var_505_10

					if var_505_10 + var_505_5 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_5
					end
				end

				arg_502_1.text_.text = var_505_8
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031120", "story_v_out_417031.awb") ~= 0 then
					local var_505_11 = manager.audio:GetVoiceLength("story_v_out_417031", "417031120", "story_v_out_417031.awb") / 1000

					if var_505_11 + var_505_5 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_11 + var_505_5
					end

					if var_505_7.prefab_name ~= "" and arg_502_1.actors_[var_505_7.prefab_name] ~= nil then
						local var_505_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_7.prefab_name].transform, "story_v_out_417031", "417031120", "story_v_out_417031.awb")

						arg_502_1:RecordAudio("417031120", var_505_12)
						arg_502_1:RecordAudio("417031120", var_505_12)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_417031", "417031120", "story_v_out_417031.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_417031", "417031120", "story_v_out_417031.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_13 = math.max(var_505_6, arg_502_1.talkMaxDuration)

			if var_505_5 <= arg_502_1.time_ and arg_502_1.time_ < var_505_5 + var_505_13 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_5) / var_505_13

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_5 + var_505_13 and arg_502_1.time_ < var_505_5 + var_505_13 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play417031121 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 417031121
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play417031122(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos1034 = arg_506_1.actors_["1034"].transform.localPosition
				arg_506_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_506_1:CheckSpriteTmpPos("1034", 7)

				for iter_509_0 = 0, arg_506_1.actors_["1034"].transform.childCount - 1 do
					local var_509_0 = arg_506_1.actors_["1034"].transform:GetChild(iter_509_0)

					if var_509_0.name == "" or not string.find(var_509_0.name, "split") then
						var_509_0.gameObject:SetActive(true)
					else
						var_509_0.gameObject:SetActive(false)
					end
				end
			end

			local var_509_1 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_1 then
				arg_506_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_506_1.time_ - 0) / var_509_1)
			end

			if arg_506_1.time_ >= 0 + var_509_1 and arg_506_1.time_ < 0 + var_509_1 + arg_509_0 then
				arg_506_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.225 < arg_506_1.time_ and arg_506_1.time_ <= 0.225 + arg_509_0 then
				arg_506_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_509_3 = 0
			local var_509_4 = 1.225

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_3 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_5 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(417031121).content)

				arg_506_1.text_.text = var_509_5

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_7 = 49 <= 0 and var_509_4 or var_509_4 * (utf8.len(var_509_5) / 49)

				if (49 <= 0 and var_509_4 or var_509_4 * (utf8.len(var_509_5) / 49)) > 0 and var_509_4 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_3 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_3
					end
				end

				arg_506_1.text_.text = var_509_5
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_4, arg_506_1.talkMaxDuration)

			if var_509_3 <= arg_506_1.time_ and arg_506_1.time_ < var_509_3 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_3) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_3 + var_509_8 and arg_506_1.time_ < var_509_3 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
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

		arg_506_1:InitPlayNodeList()
	end,
	Play417031122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 417031122
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play417031123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.875

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(417031122).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)

				if (35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play417031123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 417031123
		arg_514_1.duration_ = 5.1

		local var_514_0 = {
			zh = 5.1,
			ja = 5
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play417031124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.475

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_1 = arg_514_1:GetWordFromCfg(417031123)
				local var_517_2 = arg_514_1:FormatText(var_517_1.content)

				arg_514_1.text_.text = var_517_2

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_4 = 19 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 19)

				if (19 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 19)) > 0 and var_517_0 < var_517_4 then
					arg_514_1.talkMaxDuration = var_517_4

					if var_517_4 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_4 + 0
					end
				end

				arg_514_1.text_.text = var_517_2
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031123", "story_v_out_417031.awb") ~= 0 then
					local var_517_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031123", "story_v_out_417031.awb") / 1000

					if var_517_5 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + 0
					end

					if var_517_1.prefab_name ~= "" and arg_514_1.actors_[var_517_1.prefab_name] ~= nil then
						local var_517_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_1.prefab_name].transform, "story_v_out_417031", "417031123", "story_v_out_417031.awb")

						arg_514_1:RecordAudio("417031123", var_517_6)
						arg_514_1:RecordAudio("417031123", var_517_6)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_417031", "417031123", "story_v_out_417031.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_417031", "417031123", "story_v_out_417031.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_7 = math.max(var_517_0, arg_514_1.talkMaxDuration)

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_7 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - 0) / var_517_7

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= 0 + var_517_7 and arg_514_1.time_ < 0 + var_517_7 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play417031124 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 417031124
		arg_518_1.duration_ = 8.1

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play417031125(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 1.53333333333333 < arg_518_1.time_ and arg_518_1.time_ <= 1.53333333333333 + arg_521_0 then
				local var_521_0 = arg_518_1.bgs_.ST77a

				arg_518_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_521_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_521_1 = var_521_0:GetComponent("SpriteRenderer")

				if var_521_1 and var_521_1.sprite then
					local var_521_2 = 2 * (var_521_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_521_0.transform.localScale = Vector3.New(var_521_2 / var_521_1.sprite.bounds.size.y < var_521_2 * manager.ui.mainCameraCom_.aspect / var_521_1.sprite.bounds.size.x and var_521_2 * manager.ui.mainCameraCom_.aspect / var_521_1.sprite.bounds.size.x or var_521_2 / var_521_1.sprite.bounds.size.y, var_521_2 / var_521_1.sprite.bounds.size.y < var_521_2 * manager.ui.mainCameraCom_.aspect / var_521_1.sprite.bounds.size.x and var_521_2 * manager.ui.mainCameraCom_.aspect / var_521_1.sprite.bounds.size.x or var_521_2 / var_521_1.sprite.bounds.size.y, 0)
				end

				for iter_521_0, iter_521_1 in pairs(arg_518_1.bgs_) do
					if iter_521_0 ~= "ST77a" then
						iter_521_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_521_3 = 0

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_3 + arg_521_0 then
				arg_518_1.allBtn_.enabled = false
			end

			if arg_518_1.time_ >= var_521_3 + 0.3 and arg_518_1.time_ < var_521_3 + 0.3 + arg_521_0 then
				arg_518_1.allBtn_.enabled = true
			end

			local var_521_4 = 0

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = true

				arg_518_1:SetGaussion(false)
			end

			local var_521_5 = 1.53333333333333

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_5 then
				local var_521_6 = Color.New(0, 0, 0)

				var_521_6.a = Mathf.Lerp(0, 1, (arg_518_1.time_ - var_521_4) / var_521_5)
				arg_518_1.mask_.color = var_521_6
			end

			if arg_518_1.time_ >= var_521_4 + var_521_5 and arg_518_1.time_ < var_521_4 + var_521_5 + arg_521_0 then
				local var_521_7 = Color.New(0, 0, 0)

				var_521_7.a = 1
				arg_518_1.mask_.color = var_521_7
			end

			local var_521_8 = 1.53333333333333

			if 1.53333333333333 < arg_518_1.time_ and arg_518_1.time_ <= var_521_8 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = true

				arg_518_1:SetGaussion(false)
			end

			local var_521_9 = 2

			if var_521_8 <= arg_518_1.time_ and arg_518_1.time_ < var_521_8 + var_521_9 then
				local var_521_10 = Color.New(0, 0, 0)

				var_521_10.a = Mathf.Lerp(1, 0, (arg_518_1.time_ - var_521_8) / var_521_9)
				arg_518_1.mask_.color = var_521_10
			end

			if arg_518_1.time_ >= var_521_8 + var_521_9 and arg_518_1.time_ < var_521_8 + var_521_9 + arg_521_0 then
				local var_521_11 = Color.New(0, 0, 0)

				arg_518_1.mask_.enabled = false
				var_521_11.a = 0
				arg_518_1.mask_.color = var_521_11
			end

			if 3.2 < arg_518_1.time_ and arg_518_1.time_ <= 3.2 + arg_521_0 then
				arg_518_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_coin01", "")
			end

			if arg_518_1.frameCnt_ <= 1 then
				arg_518_1.dialog_:SetActive(false)
			end

			local var_521_13 = 3.1
			local var_521_14 = 0.775

			if 3.1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_13 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0

				arg_518_1.dialog_:SetActive(true)

				arg_518_1.dialogCg_.alpha = 0

				local var_521_15 = LeanTween.value(arg_518_1.dialog_, 0, 1, 0.3)

				var_521_15:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_518_1.dialogCg_.alpha = arg_522_0
				end))
				var_521_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_518_1.dialog_)
					var_521_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_518_1.duration_ = arg_518_1.duration_ + 0.3

				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_16 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(417031124).content)

				arg_518_1.text_.text = var_521_16

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_18 = 31 <= 0 and var_521_14 or var_521_14 * (utf8.len(var_521_16) / 31)

				if (31 <= 0 and var_521_14 or var_521_14 * (utf8.len(var_521_16) / 31)) > 0 and var_521_14 < var_521_18 then
					arg_518_1.talkMaxDuration = var_521_18
					var_521_13 = var_521_13 + 0.3

					if var_521_18 + var_521_13 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_18 + var_521_13
					end
				end

				arg_518_1.text_.text = var_521_16
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_19 = var_521_13 + 0.3
			local var_521_20 = math.max(var_521_14, arg_518_1.talkMaxDuration)

			if var_521_13 + 0.3 <= arg_518_1.time_ and arg_518_1.time_ < var_521_19 + var_521_20 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_19) / var_521_20

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_19 + var_521_20 and arg_518_1.time_ < var_521_19 + var_521_20 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play417031125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 417031125
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play417031126(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 1.275

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(417031125).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 51 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 51)

				if (51 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 51)) > 0 and var_527_0 < var_527_3 then
					arg_524_1.talkMaxDuration = var_527_3

					if var_527_3 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_3 + 0
					end
				end

				arg_524_1.text_.text = var_527_1
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_4 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_4

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play417031126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 417031126
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play417031127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 1.16666666666667 < arg_528_1.time_ and arg_528_1.time_ <= 1.16666666666667 + arg_531_0 then
				arg_528_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_coin02", "")
			end

			local var_531_1 = 0
			local var_531_2 = 1.45

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_3 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(417031126).content)

				arg_528_1.text_.text = var_531_3

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 58 <= 0 and var_531_2 or var_531_2 * (utf8.len(var_531_3) / 58)

				if (58 <= 0 and var_531_2 or var_531_2 * (utf8.len(var_531_3) / 58)) > 0 and var_531_2 < var_531_5 then
					arg_528_1.talkMaxDuration = var_531_5

					if var_531_5 + var_531_1 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + var_531_1
					end
				end

				arg_528_1.text_.text = var_531_3
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_6 = math.max(var_531_2, arg_528_1.talkMaxDuration)

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_6 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_1) / var_531_6

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_1 + var_531_6 and arg_528_1.time_ < var_531_1 + var_531_6 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play417031127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 417031127
		arg_532_1.duration_ = 8.23

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play417031128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if arg_532_1.bgs_.SS1702 == nil then
				local var_535_0 = Object.Instantiate(arg_532_1.paintGo_)

				var_535_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1702")
				var_535_0.name = "SS1702"
				var_535_0.transform.parent = arg_532_1.stage_.transform
				var_535_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_532_1.bgs_.SS1702 = var_535_0
			end

			if 1.56666666666667 < arg_532_1.time_ and arg_532_1.time_ <= 1.56666666666667 + arg_535_0 then
				local var_535_1 = arg_532_1.bgs_.SS1702

				arg_532_1.bgs_.SS1702.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_535_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_535_2 = var_535_1:GetComponent("SpriteRenderer")

				if var_535_2 and var_535_2.sprite then
					local var_535_3 = 2 * (var_535_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_535_1.transform.localScale = Vector3.New(var_535_3 / var_535_2.sprite.bounds.size.y < var_535_3 * manager.ui.mainCameraCom_.aspect / var_535_2.sprite.bounds.size.x and var_535_3 * manager.ui.mainCameraCom_.aspect / var_535_2.sprite.bounds.size.x or var_535_3 / var_535_2.sprite.bounds.size.y, var_535_3 / var_535_2.sprite.bounds.size.y < var_535_3 * manager.ui.mainCameraCom_.aspect / var_535_2.sprite.bounds.size.x and var_535_3 * manager.ui.mainCameraCom_.aspect / var_535_2.sprite.bounds.size.x or var_535_3 / var_535_2.sprite.bounds.size.y, 0)
				end

				for iter_535_0, iter_535_1 in pairs(arg_532_1.bgs_) do
					if iter_535_0 ~= "SS1702" then
						iter_535_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_535_4 = 0

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_4 + arg_535_0 then
				arg_532_1.allBtn_.enabled = false
			end

			if arg_532_1.time_ >= var_535_4 + 0.3 and arg_532_1.time_ < var_535_4 + 0.3 + arg_535_0 then
				arg_532_1.allBtn_.enabled = true
			end

			local var_535_5 = 0

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_5 + arg_535_0 then
				arg_532_1.mask_.enabled = true
				arg_532_1.mask_.raycastTarget = true

				arg_532_1:SetGaussion(false)
			end

			local var_535_6 = 1.56666666666667

			if var_535_5 <= arg_532_1.time_ and arg_532_1.time_ < var_535_5 + var_535_6 then
				local var_535_7 = Color.New(0, 0, 0)

				var_535_7.a = Mathf.Lerp(0, 1, (arg_532_1.time_ - var_535_5) / var_535_6)
				arg_532_1.mask_.color = var_535_7
			end

			if arg_532_1.time_ >= var_535_5 + var_535_6 and arg_532_1.time_ < var_535_5 + var_535_6 + arg_535_0 then
				local var_535_8 = Color.New(0, 0, 0)

				var_535_8.a = 1
				arg_532_1.mask_.color = var_535_8
			end

			local var_535_9 = 1.56666666666667

			if 1.56666666666667 < arg_532_1.time_ and arg_532_1.time_ <= var_535_9 + arg_535_0 then
				arg_532_1.mask_.enabled = true
				arg_532_1.mask_.raycastTarget = true

				arg_532_1:SetGaussion(false)
			end

			local var_535_10 = 1.99999999999867

			if var_535_9 <= arg_532_1.time_ and arg_532_1.time_ < var_535_9 + var_535_10 then
				local var_535_11 = Color.New(0, 0, 0)

				var_535_11.a = Mathf.Lerp(1, 0, (arg_532_1.time_ - var_535_9) / var_535_10)
				arg_532_1.mask_.color = var_535_11
			end

			if arg_532_1.time_ >= var_535_9 + var_535_10 and arg_532_1.time_ < var_535_9 + var_535_10 + arg_535_0 then
				local var_535_12 = Color.New(0, 0, 0)

				arg_532_1.mask_.enabled = false
				var_535_12.a = 0
				arg_532_1.mask_.color = var_535_12
			end

			local var_535_13 = 1.56666666666667

			arg_532_1.isInRecall_ = true

			if var_535_13 < arg_532_1.time_ and arg_532_1.time_ <= var_535_13 + arg_535_0 then
				arg_532_1.screenFilterGo_:SetActive(true)

				arg_532_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_532_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_532_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_535_2, iter_535_3 in pairs(arg_532_1.actors_) do
					for iter_535_4, iter_535_5 in ipairs((iter_535_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_535_5.color = iter_535_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_535_14 = 0.0166666666666667

			if var_535_13 <= arg_532_1.time_ and arg_532_1.time_ < var_535_13 + var_535_14 then
				arg_532_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_532_1.time_ - var_535_13) / var_535_14)
			end

			if arg_532_1.time_ >= var_535_13 + var_535_14 and arg_532_1.time_ < var_535_13 + var_535_14 + arg_535_0 then
				arg_532_1.screenFilterEffect_.weight = 1
			end

			if arg_532_1.frameCnt_ <= 1 then
				arg_532_1.dialog_:SetActive(false)
			end

			local var_535_15 = 3.23333333333333
			local var_535_16 = 1.375

			if 3.23333333333333 < arg_532_1.time_ and arg_532_1.time_ <= var_535_15 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0

				arg_532_1.dialog_:SetActive(true)

				arg_532_1.dialogCg_.alpha = 0

				local var_535_17 = LeanTween.value(arg_532_1.dialog_, 0, 1, 0.3)

				var_535_17:setOnUpdate(LuaHelper.FloatAction(function(arg_536_0)
					arg_532_1.dialogCg_.alpha = arg_536_0
				end))
				var_535_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_532_1.dialog_)
					var_535_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_532_1.duration_ = arg_532_1.duration_ + 0.3

				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_18 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(417031127).content)

				arg_532_1.text_.text = var_535_18

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_20 = 55 <= 0 and var_535_16 or var_535_16 * (utf8.len(var_535_18) / 55)

				if (55 <= 0 and var_535_16 or var_535_16 * (utf8.len(var_535_18) / 55)) > 0 and var_535_16 < var_535_20 then
					arg_532_1.talkMaxDuration = var_535_20
					var_535_15 = var_535_15 + 0.3

					if var_535_20 + var_535_15 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_20 + var_535_15
					end
				end

				arg_532_1.text_.text = var_535_18
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_21 = var_535_15 + 0.3
			local var_535_22 = math.max(var_535_16, arg_532_1.talkMaxDuration)

			if var_535_15 + 0.3 <= arg_532_1.time_ and arg_532_1.time_ < var_535_21 + var_535_22 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_21) / var_535_22

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_21 + var_535_22 and arg_532_1.time_ < var_535_21 + var_535_22 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play417031128 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 417031128
		arg_538_1.duration_ = 1.3

		local var_538_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play417031129(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0.125

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_1 = arg_538_1:GetWordFromCfg(417031128)
				local var_541_2 = arg_538_1:FormatText(var_541_1.content)

				arg_538_1.text_.text = var_541_2

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_4 = 5 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_2) / 5)

				if (5 <= 0 and var_541_0 or var_541_0 * (utf8.len(var_541_2) / 5)) > 0 and var_541_0 < var_541_4 then
					arg_538_1.talkMaxDuration = var_541_4

					if var_541_4 + 0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_4 + 0
					end
				end

				arg_538_1.text_.text = var_541_2
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031128", "story_v_out_417031.awb") ~= 0 then
					local var_541_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031128", "story_v_out_417031.awb") / 1000

					if var_541_5 + 0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_5 + 0
					end

					if var_541_1.prefab_name ~= "" and arg_538_1.actors_[var_541_1.prefab_name] ~= nil then
						local var_541_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_1.prefab_name].transform, "story_v_out_417031", "417031128", "story_v_out_417031.awb")

						arg_538_1:RecordAudio("417031128", var_541_6)
						arg_538_1:RecordAudio("417031128", var_541_6)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_417031", "417031128", "story_v_out_417031.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_417031", "417031128", "story_v_out_417031.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_7 = math.max(var_541_0, arg_538_1.talkMaxDuration)

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_7 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - 0) / var_541_7

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= 0 + var_541_7 and arg_538_1.time_ < 0 + var_541_7 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play417031129 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 417031129
		arg_542_1.duration_ = 2.33

		local var_542_0 = {
			zh = 0.999999999999,
			ja = 2.333
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play417031130(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0.075

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_1 = arg_542_1:GetWordFromCfg(417031129)
				local var_545_2 = arg_542_1:FormatText(var_545_1.content)

				arg_542_1.text_.text = var_545_2

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_4 = 3 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_2) / 3)

				if (3 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_2) / 3)) > 0 and var_545_0 < var_545_4 then
					arg_542_1.talkMaxDuration = var_545_4

					if var_545_4 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_4 + 0
					end
				end

				arg_542_1.text_.text = var_545_2
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031129", "story_v_out_417031.awb") ~= 0 then
					local var_545_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031129", "story_v_out_417031.awb") / 1000

					if var_545_5 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + 0
					end

					if var_545_1.prefab_name ~= "" and arg_542_1.actors_[var_545_1.prefab_name] ~= nil then
						local var_545_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_1.prefab_name].transform, "story_v_out_417031", "417031129", "story_v_out_417031.awb")

						arg_542_1:RecordAudio("417031129", var_545_6)
						arg_542_1:RecordAudio("417031129", var_545_6)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_417031", "417031129", "story_v_out_417031.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_417031", "417031129", "story_v_out_417031.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_7 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_7 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_7

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_7 and arg_542_1.time_ < 0 + var_545_7 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play417031130 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 417031130
		arg_546_1.duration_ = 5.63

		local var_546_0 = {
			zh = 5.233,
			ja = 5.633
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play417031131(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.7

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_1 = arg_546_1:GetWordFromCfg(417031130)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 28 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 28)

				if (28 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 28)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031130", "story_v_out_417031.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031130", "story_v_out_417031.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_out_417031", "417031130", "story_v_out_417031.awb")

						arg_546_1:RecordAudio("417031130", var_549_6)
						arg_546_1:RecordAudio("417031130", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_417031", "417031130", "story_v_out_417031.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_417031", "417031130", "story_v_out_417031.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play417031131 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 417031131
		arg_550_1.duration_ = 5.3

		local var_550_0 = {
			zh = 2.9,
			ja = 5.3
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play417031132(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.45

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_1 = arg_550_1:GetWordFromCfg(417031131)
				local var_553_2 = arg_550_1:FormatText(var_553_1.content)

				arg_550_1.text_.text = var_553_2

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 18 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 18)

				if (18 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_2) / 18)) > 0 and var_553_0 < var_553_4 then
					arg_550_1.talkMaxDuration = var_553_4

					if var_553_4 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_4 + 0
					end
				end

				arg_550_1.text_.text = var_553_2
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031131", "story_v_out_417031.awb") ~= 0 then
					local var_553_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031131", "story_v_out_417031.awb") / 1000

					if var_553_5 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + 0
					end

					if var_553_1.prefab_name ~= "" and arg_550_1.actors_[var_553_1.prefab_name] ~= nil then
						local var_553_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_1.prefab_name].transform, "story_v_out_417031", "417031131", "story_v_out_417031.awb")

						arg_550_1:RecordAudio("417031131", var_553_6)
						arg_550_1:RecordAudio("417031131", var_553_6)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_417031", "417031131", "story_v_out_417031.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_417031", "417031131", "story_v_out_417031.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_7 and arg_550_1.time_ < 0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play417031132 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 417031132
		arg_554_1.duration_ = 5.4

		local var_554_0 = {
			zh = 4.9,
			ja = 5.4
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play417031133(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0.675

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_1 = arg_554_1:GetWordFromCfg(417031132)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 27 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 27)

				if (27 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 27)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031132", "story_v_out_417031.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031132", "story_v_out_417031.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_out_417031", "417031132", "story_v_out_417031.awb")

						arg_554_1:RecordAudio("417031132", var_557_6)
						arg_554_1:RecordAudio("417031132", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_417031", "417031132", "story_v_out_417031.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_417031", "417031132", "story_v_out_417031.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play417031133 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 417031133
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play417031134(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.05

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_1 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(417031133).content)

				arg_558_1.text_.text = var_561_1

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_3 = 2 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 2)

				if (2 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 2)) > 0 and var_561_0 < var_561_3 then
					arg_558_1.talkMaxDuration = var_561_3

					if var_561_3 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_3 + 0
					end
				end

				arg_558_1.text_.text = var_561_1
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_4 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_4

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play417031134 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 417031134
		arg_562_1.duration_ = 3.7

		local var_562_0 = {
			zh = 2.8,
			ja = 3.7
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play417031135(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0.3

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_1 = arg_562_1:GetWordFromCfg(417031134)
				local var_565_2 = arg_562_1:FormatText(var_565_1.content)

				arg_562_1.text_.text = var_565_2

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 12 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 12)

				if (12 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 12)) > 0 and var_565_0 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + 0
					end
				end

				arg_562_1.text_.text = var_565_2
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031134", "story_v_out_417031.awb") ~= 0 then
					local var_565_5 = manager.audio:GetVoiceLength("story_v_out_417031", "417031134", "story_v_out_417031.awb") / 1000

					if var_565_5 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + 0
					end

					if var_565_1.prefab_name ~= "" and arg_562_1.actors_[var_565_1.prefab_name] ~= nil then
						local var_565_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_1.prefab_name].transform, "story_v_out_417031", "417031134", "story_v_out_417031.awb")

						arg_562_1:RecordAudio("417031134", var_565_6)
						arg_562_1:RecordAudio("417031134", var_565_6)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_417031", "417031134", "story_v_out_417031.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_417031", "417031134", "story_v_out_417031.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_7 and arg_562_1.time_ < 0 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play417031135 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 417031135
		arg_566_1.duration_ = 8.3

		local var_566_0 = {
			zh = 6.56633333333333,
			ja = 8.29933333333333
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play417031136(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 1.63333333333333 < arg_566_1.time_ and arg_566_1.time_ <= 1.63333333333333 + arg_569_0 then
				local var_569_0 = arg_566_1.bgs_.ST77a

				arg_566_1.bgs_.ST77a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_569_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_1 = var_569_0:GetComponent("SpriteRenderer")

				if var_569_1 and var_569_1.sprite then
					local var_569_2 = 2 * (var_569_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_569_0.transform.localScale = Vector3.New(var_569_2 / var_569_1.sprite.bounds.size.y < var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x and var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x or var_569_2 / var_569_1.sprite.bounds.size.y, var_569_2 / var_569_1.sprite.bounds.size.y < var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x and var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x or var_569_2 / var_569_1.sprite.bounds.size.y, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "ST77a" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_3 = 0

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_3 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_4 = 1.63333333333333

			if var_569_3 <= arg_566_1.time_ and arg_566_1.time_ < var_569_3 + var_569_4 then
				local var_569_5 = Color.New(0, 0, 0)

				var_569_5.a = Mathf.Lerp(0, 1, (arg_566_1.time_ - var_569_3) / var_569_4)
				arg_566_1.mask_.color = var_569_5
			end

			if arg_566_1.time_ >= var_569_3 + var_569_4 and arg_566_1.time_ < var_569_3 + var_569_4 + arg_569_0 then
				local var_569_6 = Color.New(0, 0, 0)

				var_569_6.a = 1
				arg_566_1.mask_.color = var_569_6
			end

			local var_569_7 = 1.63333333333333

			if 1.63333333333333 < arg_566_1.time_ and arg_566_1.time_ <= var_569_7 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_8 = 2

			if var_569_7 <= arg_566_1.time_ and arg_566_1.time_ < var_569_7 + var_569_8 then
				local var_569_9 = Color.New(0, 0, 0)

				var_569_9.a = Mathf.Lerp(1, 0, (arg_566_1.time_ - var_569_7) / var_569_8)
				arg_566_1.mask_.color = var_569_9
			end

			if arg_566_1.time_ >= var_569_7 + var_569_8 and arg_566_1.time_ < var_569_7 + var_569_8 + arg_569_0 then
				local var_569_10 = Color.New(0, 0, 0)

				arg_566_1.mask_.enabled = false
				var_569_10.a = 0
				arg_566_1.mask_.color = var_569_10
			end

			local var_569_11 = arg_566_1.actors_["1034"]

			if 3.23333333333333 < arg_566_1.time_ and arg_566_1.time_ <= 3.23333333333333 + arg_569_0 and not isNil(var_569_11) and arg_566_1.var_.actorSpriteComps1034 == nil then
				arg_566_1.var_.actorSpriteComps1034 = var_569_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_12 = 0.2

			if 3.23333333333333 <= arg_566_1.time_ and arg_566_1.time_ < 3.23333333333333 + var_569_12 and not isNil(var_569_11) then
				if arg_566_1.var_.actorSpriteComps1034 then
					for iter_569_2, iter_569_3 in pairs(arg_566_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_569_3 then
							if arg_566_1.isInRecall_ then
								iter_569_3.color = Color.New(Mathf.Lerp(iter_569_3.color.r, arg_566_1.hightColor1.r, (arg_566_1.time_ - 3.23333333333333) / var_569_12), Mathf.Lerp(iter_569_3.color.g, arg_566_1.hightColor1.g, (arg_566_1.time_ - 3.23333333333333) / var_569_12), (Mathf.Lerp(iter_569_3.color.b, arg_566_1.hightColor1.b, (arg_566_1.time_ - 3.23333333333333) / var_569_12)))
							else
								local var_569_13 = Mathf.Lerp(iter_569_3.color.r, 1, (arg_566_1.time_ - 3.23333333333333) / var_569_12)

								iter_569_3.color = Color.New(var_569_13, var_569_13, var_569_13)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= 3.23333333333333 + var_569_12 and arg_566_1.time_ < 3.23333333333333 + var_569_12 + arg_569_0 and not isNil(var_569_11) and arg_566_1.var_.actorSpriteComps1034 then
				for iter_569_4, iter_569_5 in pairs(arg_566_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_569_5 then
						iter_569_5.color = arg_566_1.isInRecall_ and (arg_566_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_566_1.var_.actorSpriteComps1034 = nil
			end

			local var_569_14 = arg_566_1.actors_["1034"].transform

			if 3.23333333333333 < arg_566_1.time_ and arg_566_1.time_ <= 3.23333333333333 + arg_569_0 then
				arg_566_1.var_.moveOldPos1034 = var_569_14.localPosition
				var_569_14.localScale = Vector3.New(1, 1, 1)

				arg_566_1:CheckSpriteTmpPos("1034", 3)

				for iter_569_6 = 0, var_569_14.childCount - 1 do
					local var_569_15 = var_569_14:GetChild(iter_569_6)

					if var_569_15.name == "" or not string.find(var_569_15.name, "split") then
						var_569_15.gameObject:SetActive(true)
					else
						var_569_15.gameObject:SetActive(false)
					end
				end
			end

			local var_569_16 = 0.001

			if 3.23333333333333 <= arg_566_1.time_ and arg_566_1.time_ < 3.23333333333333 + var_569_16 then
				var_569_14.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_566_1.time_ - 3.23333333333333) / var_569_16)
			end

			if arg_566_1.time_ >= 3.23333333333333 + var_569_16 and arg_566_1.time_ < 3.23333333333333 + var_569_16 + arg_569_0 then
				var_569_14.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_569_17 = 1.63333333333333

			arg_566_1.isInRecall_ = false

			if var_569_17 < arg_566_1.time_ and arg_566_1.time_ <= var_569_17 + arg_569_0 then
				arg_566_1.screenFilterGo_:SetActive(false)

				for iter_569_7, iter_569_8 in pairs(arg_566_1.actors_) do
					for iter_569_9, iter_569_10 in ipairs((iter_569_8:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_569_10.color = iter_569_10.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_569_18 = 0.0166666666666667

			if var_569_17 <= arg_566_1.time_ and arg_566_1.time_ < var_569_17 + var_569_18 then
				arg_566_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_566_1.time_ - var_569_17) / var_569_18)
			end

			if arg_566_1.time_ >= var_569_17 + var_569_18 and arg_566_1.time_ < var_569_17 + var_569_18 + arg_569_0 then
				arg_566_1.screenFilterEffect_.weight = 0
			end

			if 3.23333333333333 < arg_566_1.time_ and arg_566_1.time_ <= 3.23333333333333 + arg_569_0 then
				local var_569_19 = arg_566_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_569_19 then
					arg_566_1.var_.alphaOldValue1034 = var_569_19.alpha
					arg_566_1.var_.characterEffect1034 = var_569_19
				end

				arg_566_1.var_.alphaOldValue1034 = 0
			end

			local var_569_20 = 0.3

			if 3.23333333333333 <= arg_566_1.time_ and arg_566_1.time_ < 3.23333333333333 + var_569_20 then
				if arg_566_1.var_.characterEffect1034 then
					arg_566_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_566_1.var_.alphaOldValue1034, 1, (arg_566_1.time_ - 3.23333333333333) / var_569_20)
				end
			end

			if arg_566_1.time_ >= 3.23333333333333 + var_569_20 and arg_566_1.time_ < 3.23333333333333 + var_569_20 + arg_569_0 and arg_566_1.var_.characterEffect1034 then
				arg_566_1.var_.characterEffect1034.alpha = 1
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_21 = 3.63333333333333
			local var_569_22 = 0.3

			if 3.63333333333333 < arg_566_1.time_ and arg_566_1.time_ <= var_569_21 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_23 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_23:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_24 = arg_566_1:GetWordFromCfg(417031135)
				local var_569_25 = arg_566_1:FormatText(var_569_24.content)

				arg_566_1.text_.text = var_569_25

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_27 = 12 <= 0 and var_569_22 or var_569_22 * (utf8.len(var_569_25) / 12)

				if (12 <= 0 and var_569_22 or var_569_22 * (utf8.len(var_569_25) / 12)) > 0 and var_569_22 < var_569_27 then
					arg_566_1.talkMaxDuration = var_569_27
					var_569_21 = var_569_21 + 0.3

					if var_569_27 + var_569_21 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_27 + var_569_21
					end
				end

				arg_566_1.text_.text = var_569_25
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417031", "417031135", "story_v_out_417031.awb") ~= 0 then
					local var_569_28 = manager.audio:GetVoiceLength("story_v_out_417031", "417031135", "story_v_out_417031.awb") / 1000

					if var_569_28 + var_569_21 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_28 + var_569_21
					end

					if var_569_24.prefab_name ~= "" and arg_566_1.actors_[var_569_24.prefab_name] ~= nil then
						local var_569_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_24.prefab_name].transform, "story_v_out_417031", "417031135", "story_v_out_417031.awb")

						arg_566_1:RecordAudio("417031135", var_569_29)
						arg_566_1:RecordAudio("417031135", var_569_29)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_417031", "417031135", "story_v_out_417031.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_417031", "417031135", "story_v_out_417031.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_30 = var_569_21 + 0.3
			local var_569_31 = math.max(var_569_22, arg_566_1.talkMaxDuration)

			if var_569_21 + 0.3 <= arg_566_1.time_ and arg_566_1.time_ < var_569_30 + var_569_31 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_30) / var_569_31

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_30 + var_569_31 and arg_566_1.time_ < var_569_30 + var_569_31 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play417031136 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 417031136
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play417031137(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(arg_572_1.actors_["1034"]) and arg_572_1.var_.actorSpriteComps1034 == nil then
				arg_572_1.var_.actorSpriteComps1034 = arg_572_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_0 = 0.2

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 and not isNil(arg_572_1.actors_["1034"]) then
				if arg_572_1.var_.actorSpriteComps1034 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								iter_575_1.color = Color.New(Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor2.r, (arg_572_1.time_ - 0) / var_575_0), Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor2.g, (arg_572_1.time_ - 0) / var_575_0), (Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor2.b, (arg_572_1.time_ - 0) / var_575_0)))
							else
								local var_575_1 = Mathf.Lerp(iter_575_1.color.r, 0.5, (arg_572_1.time_ - 0) / var_575_0)

								iter_575_1.color = Color.New(var_575_1, var_575_1, var_575_1)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 and not isNil(arg_572_1.actors_["1034"]) and arg_572_1.var_.actorSpriteComps1034 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_575_3 then
						iter_575_3.color = arg_572_1.isInRecall_ and (arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_572_1.var_.actorSpriteComps1034 = nil
			end

			local var_575_2 = 0
			local var_575_3 = 0.675

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_2 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_4 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(417031136).content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_6 = 27 <= 0 and var_575_3 or var_575_3 * (utf8.len(var_575_4) / 27)

				if (27 <= 0 and var_575_3 or var_575_3 * (utf8.len(var_575_4) / 27)) > 0 and var_575_3 < var_575_6 then
					arg_572_1.talkMaxDuration = var_575_6

					if var_575_6 + var_575_2 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_6 + var_575_2
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_3, arg_572_1.talkMaxDuration)

			if var_575_2 <= arg_572_1.time_ and arg_572_1.time_ < var_575_2 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_2) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_2 + var_575_7 and arg_572_1.time_ < var_575_2 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play417031137 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 417031137
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play417031138(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 1.125

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_1 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(417031137).content)

				arg_576_1.text_.text = var_579_1

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_3 = 45 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 45)

				if (45 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 45)) > 0 and var_579_0 < var_579_3 then
					arg_576_1.talkMaxDuration = var_579_3

					if var_579_3 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_3 + 0
					end
				end

				arg_576_1.text_.text = var_579_1
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_4 = math.max(var_579_0, arg_576_1.talkMaxDuration)

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_4 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - 0) / var_579_4

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= 0 + var_579_4 and arg_576_1.time_ < 0 + var_579_4 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play417031138 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 417031138
		arg_580_1.duration_ = 4.6

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
			arg_580_1.auto_ = false
		end

		function arg_580_1.playNext_(arg_582_0)
			arg_580_1.onStoryFinished_()
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 1.266 < arg_580_1.time_ and arg_580_1.time_ <= 1.266 + arg_583_0 then
				arg_580_1.var_.moveOldPos1034 = arg_580_1.actors_["1034"].transform.localPosition
				arg_580_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_580_1:CheckSpriteTmpPos("1034", 7)

				for iter_583_0 = 0, arg_580_1.actors_["1034"].transform.childCount - 1 do
					local var_583_0 = arg_580_1.actors_["1034"].transform:GetChild(iter_583_0)

					if var_583_0.name == "" or not string.find(var_583_0.name, "split") then
						var_583_0.gameObject:SetActive(true)
					else
						var_583_0.gameObject:SetActive(false)
					end
				end
			end

			local var_583_1 = 0.001

			if 1.266 <= arg_580_1.time_ and arg_580_1.time_ < 1.266 + var_583_1 then
				arg_580_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_580_1.time_ - 1.266) / var_583_1)
			end

			if arg_580_1.time_ >= 1.266 + var_583_1 and arg_580_1.time_ < 1.266 + var_583_1 + arg_583_0 then
				arg_580_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.334 < arg_580_1.time_ and arg_580_1.time_ <= 1.334 + arg_583_0 then
				arg_580_1.cswbg_:SetActive(true)

				local var_583_2 = arg_580_1.cswt_:GetComponent("RectTransform")

				arg_580_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_583_2.offsetMin = Vector2.New(400, 105)
				var_583_2.offsetMax = Vector2.New(-400, -200)
				arg_580_1.cswt_.text = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(419097).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.cswt_)

				arg_580_1.cswt_.fontSize = 72
				arg_580_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_580_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_580_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.3 < arg_580_1.time_ and arg_580_1.time_ <= 1.3 + arg_583_0 then
				arg_580_1.fswbg_:SetActive(true)
				arg_580_1.dialog_:SetActive(false)

				arg_580_1.fswtw_.percent = 0
				arg_580_1.fswt_.text = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(417031138).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.fswt_)

				arg_580_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_580_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_580_1.fswtw_:SetDirty()

				arg_580_1.typewritterCharCountI18N = 0

				SetActive(arg_580_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_580_1:ShowNextGo(false)
			end

			local var_583_3 = 1.93333333333333

			if 1.93333333333333 < arg_580_1.time_ and arg_580_1.time_ <= var_583_3 + arg_583_0 then
				arg_580_1.var_.oldValueTypewriter = arg_580_1.fswtw_.percent

				SetActive(arg_580_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_580_1:ShowNextGo(false)
			end

			local var_583_4 = 11
			local var_583_5 = 0.733333333333333
			local var_583_6, var_583_7 = arg_580_1:GetPercentByPara(arg_580_1:FormatText(arg_580_1:GetWordFromCfg(417031138).content), 1)

			if var_583_3 < arg_580_1.time_ and arg_580_1.time_ <= var_583_3 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0

				local var_583_8 = var_583_4 <= 0 and var_583_5 or var_583_5 * ((var_583_7 - arg_580_1.typewritterCharCountI18N) / var_583_4)

				if (var_583_4 <= 0 and var_583_5 or var_583_5 * ((var_583_7 - arg_580_1.typewritterCharCountI18N) / var_583_4)) > 0 and var_583_5 < var_583_8 then
					arg_580_1.talkMaxDuration = var_583_8

					if var_583_8 + var_583_3 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_8 + var_583_3
					end
				end
			end

			local var_583_9 = math.max(0.733333333333333, arg_580_1.talkMaxDuration)

			if var_583_3 <= arg_580_1.time_ and arg_580_1.time_ < var_583_3 + var_583_9 then
				arg_580_1.fswtw_.percent = Mathf.Lerp(arg_580_1.var_.oldValueTypewriter, var_583_6, (arg_580_1.time_ - var_583_3) / var_583_9)
				arg_580_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_580_1.fswtw_:SetDirty()
			end

			if arg_580_1.time_ >= var_583_3 + var_583_9 and arg_580_1.time_ < var_583_3 + var_583_9 + arg_583_0 then
				arg_580_1.fswtw_.percent = var_583_6

				arg_580_1.fswtw_:SetDirty()
				arg_580_1:ShowNextGo(true)

				arg_580_1.typewritterCharCountI18N = var_583_7
			end

			if 1.3 < arg_580_1.time_ and arg_580_1.time_ <= 1.3 + arg_583_0 then
				local var_583_10 = arg_580_1.bgs_.STblack

				arg_580_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_583_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_583_11 = var_583_10:GetComponent("SpriteRenderer")

				if var_583_11 and var_583_11.sprite then
					local var_583_12 = 2 * (var_583_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_583_10.transform.localScale = Vector3.New(var_583_12 / var_583_11.sprite.bounds.size.y < var_583_12 * manager.ui.mainCameraCom_.aspect / var_583_11.sprite.bounds.size.x and var_583_12 * manager.ui.mainCameraCom_.aspect / var_583_11.sprite.bounds.size.x or var_583_12 / var_583_11.sprite.bounds.size.y, var_583_12 / var_583_11.sprite.bounds.size.y < var_583_12 * manager.ui.mainCameraCom_.aspect / var_583_11.sprite.bounds.size.x and var_583_12 * manager.ui.mainCameraCom_.aspect / var_583_11.sprite.bounds.size.x or var_583_12 / var_583_11.sprite.bounds.size.y, 0)
				end

				for iter_583_1, iter_583_2 in pairs(arg_580_1.bgs_) do
					if iter_583_1 ~= "STblack" then
						iter_583_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.3 < arg_580_1.time_ and arg_580_1.time_ <= 1.3 + arg_583_0 then
				local var_583_13 = arg_580_1.fswbg_.transform:Find("textbox/adapt/content") or arg_580_1.fswbg_.transform:Find("textbox/content")
				local var_583_14 = arg_580_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_583_15 = var_583_13:GetComponent("RectTransform")

				var_583_13:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_583_15.offsetMin = Vector2.New(0, 0)
				var_583_15.offsetMax = Vector2.New(0, 0)
			end

			local var_583_16 = 0

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_16 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_17 = 1.3

			if var_583_16 <= arg_580_1.time_ and arg_580_1.time_ < var_583_16 + var_583_17 then
				local var_583_18 = Color.New(0, 0, 0)

				var_583_18.a = Mathf.Lerp(0, 1, (arg_580_1.time_ - var_583_16) / var_583_17)
				arg_580_1.mask_.color = var_583_18
			end

			if arg_580_1.time_ >= var_583_16 + var_583_17 and arg_580_1.time_ < var_583_16 + var_583_17 + arg_583_0 then
				local var_583_19 = Color.New(0, 0, 0)

				var_583_19.a = 1
				arg_580_1.mask_.color = var_583_19
			end

			local var_583_20 = 1.3

			if 1.3 < arg_580_1.time_ and arg_580_1.time_ <= var_583_20 + arg_583_0 then
				arg_580_1.mask_.enabled = true
				arg_580_1.mask_.raycastTarget = true

				arg_580_1:SetGaussion(false)
			end

			local var_583_21 = 2

			if var_583_20 <= arg_580_1.time_ and arg_580_1.time_ < var_583_20 + var_583_21 then
				local var_583_22 = Color.New(0, 0, 0)

				var_583_22.a = Mathf.Lerp(1, 0, (arg_580_1.time_ - var_583_20) / var_583_21)
				arg_580_1.mask_.color = var_583_22
			end

			if arg_580_1.time_ >= var_583_20 + var_583_21 and arg_580_1.time_ < var_583_20 + var_583_21 + arg_583_0 then
				local var_583_23 = Color.New(0, 0, 0)

				arg_580_1.mask_.enabled = false
				var_583_23.a = 0
				arg_580_1.mask_.color = var_583_23
			end

			local var_583_24 = 1.93333333333333
			local var_583_25 = manager.audio:GetVoiceLength("story_v_out_417031", "417031138", "") / 1000

			if var_583_25 > 0 and 2.666 < var_583_25 and var_583_25 + var_583_24 > arg_580_1.duration_ then
				arg_580_1.duration_ = var_583_25 + var_583_24
			end

			if var_583_24 < arg_580_1.time_ and arg_580_1.time_ <= var_583_24 + arg_583_0 then
				arg_580_1:AudioAction("play", "voice", "story_v_out_417031", "417031138", "")
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0340000000000009,
				className = "StoryMoveNode",
				startTime = 1.266,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST77a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST04c",
		"TextureConfig/Background/I05e",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/SS1702"
	},
	voices = {
		"story_v_out_417031.awb"
	}
}
