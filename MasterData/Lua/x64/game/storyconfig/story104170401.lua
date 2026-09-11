return {
	Play417041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417041001
		arg_1_1.duration_ = 12.47

		local var_1_0 = {
			zh = 9.7,
			ja = 12.466
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
				arg_1_0:Play417041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST27 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27")
				var_4_0.name = "ST27"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST27 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST27

				arg_1_1.bgs_.ST27.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST27" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 5.4

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_7 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_7

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_7
						arg_1_1.bgmTxt2_.text = var_4_7
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

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

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27")

				arg_1_1.timestampColorController_:SetSelectedState("hot")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501011).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501012).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_11 + 3 and arg_1_1.time_ < var_4_11 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_12 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_13 = 1.2

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				local var_4_14 = Color.New(0, 0, 0)

				var_4_14.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_12) / var_4_13)
				arg_1_1.mask_.color = var_4_14
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				local var_4_15 = Color.New(0, 0, 0)

				var_4_15.a = 1
				arg_1_1.mask_.color = var_4_15
			end

			local var_4_16 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 1.2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = Color.New(0, 0, 0)

				var_4_18.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_16) / var_4_17)
				arg_1_1.mask_.color = var_4_18
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_19 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_19.a = 0
				arg_1_1.mask_.color = var_4_19
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_21 = 1

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_20) / var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_23.a = 0
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_24 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_24 + 3 and arg_1_1.time_ < var_4_24 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 5.4
			local var_4_26 = 0.475

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1119].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:GetWordFromCfg(417041001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 19 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 19)

				if (19 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 19)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041001", "story_v_out_417041.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_417041", "417041001", "story_v_out_417041.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_417041", "417041001", "story_v_out_417041.awb")

						arg_1_1:RecordAudio("417041001", var_4_33)
						arg_1_1:RecordAudio("417041001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417041", "417041001", "story_v_out_417041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417041", "417041001", "story_v_out_417041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417041002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417041002
		arg_10_1.duration_ = 4.07

		local var_10_0 = {
			zh = 1.866,
			ja = 4.066
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
				arg_10_0:Play417041003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["1034"] == nil then
				local var_13_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_13_0) then
					local var_13_1 = Object.Instantiate(var_13_0, arg_10_1.canvasGo_.transform)

					var_13_1.transform:SetSiblingIndex(1)

					var_13_1.name = "1034"
					var_13_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_["1034"] = var_13_1

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs((var_13_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_2 = arg_10_1.actors_["1034"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_3 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_3 and not isNil(var_13_2) then
				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_10_1.time_ >= 0 + var_13_3 and arg_10_1.time_ < 0 + var_13_3 + arg_13_0 and not isNil(var_13_2) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_5 then
						iter_13_5.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_5 = arg_10_1.actors_["1034"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1034 = var_13_5.localPosition
				var_13_5.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1034", 3)

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
				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_10_1.time_ - 0) / var_13_7)
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_13_8 = 0
			local var_13_9 = 0.175

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:GetWordFromCfg(417041002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 7 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 7)

				if (7 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 7)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041002", "story_v_out_417041.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041002", "story_v_out_417041.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_417041", "417041002", "story_v_out_417041.awb")

						arg_10_1:RecordAudio("417041002", var_13_15)
						arg_10_1:RecordAudio("417041002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417041", "417041002", "story_v_out_417041.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417041", "417041002", "story_v_out_417041.awb")
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
				actorName = "1034",
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
	Play417041003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417041003
		arg_14_1.duration_ = 7.33

		local var_14_0 = {
			zh = 1.733,
			ja = 7.333
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
				arg_14_0:Play417041004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["1034"]) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = arg_14_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["1034"]) then
				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								iter_17_1.color = Color.New(Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor2.r, (arg_14_1.time_ - 0) / var_17_0), Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor2.g, (arg_14_1.time_ - 0) / var_17_0), (Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor2.b, (arg_14_1.time_ - 0) / var_17_0)))
							else
								local var_17_1 = Mathf.Lerp(iter_17_1.color.r, 0.5, (arg_14_1.time_ - 0) / var_17_0)

								iter_17_1.color = Color.New(var_17_1, var_17_1, var_17_1)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["1034"]) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_3 then
						iter_17_3.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_2 = 0
			local var_17_3 = 0.225

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1119].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_4 = arg_14_1:GetWordFromCfg(417041003)
				local var_17_5 = arg_14_1:FormatText(var_17_4.content)

				arg_14_1.text_.text = var_17_5

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 9 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_5) / 9)

				if (9 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_5) / 9)) > 0 and var_17_3 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_2
					end
				end

				arg_14_1.text_.text = var_17_5
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041003", "story_v_out_417041.awb") ~= 0 then
					local var_17_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041003", "story_v_out_417041.awb") / 1000

					if var_17_8 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_8 + var_17_2
					end

					if var_17_4.prefab_name ~= "" and arg_14_1.actors_[var_17_4.prefab_name] ~= nil then
						local var_17_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_4.prefab_name].transform, "story_v_out_417041", "417041003", "story_v_out_417041.awb")

						arg_14_1:RecordAudio("417041003", var_17_9)
						arg_14_1:RecordAudio("417041003", var_17_9)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417041", "417041003", "story_v_out_417041.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417041", "417041003", "story_v_out_417041.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_3, arg_14_1.talkMaxDuration)

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_2) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_2 + var_17_10 and arg_14_1.time_ < var_17_2 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417041004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417041004
		arg_18_1.duration_ = 7.2

		local var_18_0 = {
			zh = 5.4,
			ja = 7.2
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
				arg_18_0:Play417041005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = arg_18_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1034"]) then
				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								iter_21_1.color = Color.New(Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, (arg_18_1.time_ - 0) / var_21_0), Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, (arg_18_1.time_ - 0) / var_21_0), (Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, (arg_18_1.time_ - 0) / var_21_0)))
							else
								local var_21_1 = Mathf.Lerp(iter_21_1.color.r, 1, (arg_18_1.time_ - 0) / var_21_0)

								iter_21_1.color = Color.New(var_21_1, var_21_1, var_21_1)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_2 = arg_18_1.actors_["1034"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1034 = var_21_2.localPosition
				var_21_2.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1034", 3)

				for iter_21_4 = 0, var_21_2.childCount - 1 do
					local var_21_3 = var_21_2:GetChild(iter_21_4)

					if var_21_3.name == "" or not string.find(var_21_3.name, "split") then
						var_21_3.gameObject:SetActive(true)
					else
						var_21_3.gameObject:SetActive(false)
					end
				end
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_2.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_18_1.time_ - 0) / var_21_4)
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_21_5 = 0
			local var_21_6 = 0.625

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_7 = arg_18_1:GetWordFromCfg(417041004)
				local var_21_8 = arg_18_1:FormatText(var_21_7.content)

				arg_18_1.text_.text = var_21_8

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_10 = 25 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 25)

				if (25 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 25)) > 0 and var_21_6 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_5
					end
				end

				arg_18_1.text_.text = var_21_8
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041004", "story_v_out_417041.awb") ~= 0 then
					local var_21_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041004", "story_v_out_417041.awb") / 1000

					if var_21_11 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_5
					end

					if var_21_7.prefab_name ~= "" and arg_18_1.actors_[var_21_7.prefab_name] ~= nil then
						local var_21_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_7.prefab_name].transform, "story_v_out_417041", "417041004", "story_v_out_417041.awb")

						arg_18_1:RecordAudio("417041004", var_21_12)
						arg_18_1:RecordAudio("417041004", var_21_12)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417041", "417041004", "story_v_out_417041.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417041", "417041004", "story_v_out_417041.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_13 = math.max(var_21_6, arg_18_1.talkMaxDuration)

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_13 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_5) / var_21_13

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_5 + var_21_13 and arg_18_1.time_ < var_21_5 + var_21_13 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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

		arg_18_1:InitPlayNodeList()
	end,
	Play417041005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417041005
		arg_22_1.duration_ = 6.7

		local var_22_0 = {
			zh = 4.233,
			ja = 6.7
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
				arg_22_0:Play417041006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["1034"]) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = arg_22_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["1034"]) then
				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 0.5, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1034"]) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_2 = 0
			local var_25_3 = 0.45

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1119].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_4 = arg_22_1:GetWordFromCfg(417041005)
				local var_25_5 = arg_22_1:FormatText(var_25_4.content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 18 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 18)

				if (18 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 18)) > 0 and var_25_3 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041005", "story_v_out_417041.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041005", "story_v_out_417041.awb") / 1000

					if var_25_8 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_2
					end

					if var_25_4.prefab_name ~= "" and arg_22_1.actors_[var_25_4.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_4.prefab_name].transform, "story_v_out_417041", "417041005", "story_v_out_417041.awb")

						arg_22_1:RecordAudio("417041005", var_25_9)
						arg_22_1:RecordAudio("417041005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417041", "417041005", "story_v_out_417041.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417041", "417041005", "story_v_out_417041.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_3, arg_22_1.talkMaxDuration)

			if var_25_2 <= arg_22_1.time_ and arg_22_1.time_ < var_25_2 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_2) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_2 + var_25_10 and arg_22_1.time_ < var_25_2 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417041006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417041006
		arg_26_1.duration_ = 1.13

		local var_26_0 = {
			zh = 0.999999999999,
			ja = 1.133
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
				arg_26_0:Play417041007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.actors_["10128"] == nil then
				local var_29_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_29_0) then
					local var_29_1 = Object.Instantiate(var_29_0, arg_26_1.canvasGo_.transform)

					var_29_1.transform:SetSiblingIndex(1)

					var_29_1.name = "10128"
					var_29_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_26_1.actors_["10128"] = var_29_1

					if arg_26_1.isInRecall_ then
						for iter_29_0, iter_29_1 in ipairs((var_29_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_29_1.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_29_2 = arg_26_1.actors_["10128"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps10128 == nil then
				arg_26_1.var_.actorSpriteComps10128 = var_29_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_3 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.actorSpriteComps10128 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_29_3 then
							if arg_26_1.isInRecall_ then
								iter_29_3.color = Color.New(Mathf.Lerp(iter_29_3.color.r, arg_26_1.hightColor1.r, (arg_26_1.time_ - 0) / var_29_3), Mathf.Lerp(iter_29_3.color.g, arg_26_1.hightColor1.g, (arg_26_1.time_ - 0) / var_29_3), (Mathf.Lerp(iter_29_3.color.b, arg_26_1.hightColor1.b, (arg_26_1.time_ - 0) / var_29_3)))
							else
								local var_29_4 = Mathf.Lerp(iter_29_3.color.r, 1, (arg_26_1.time_ - 0) / var_29_3)

								iter_29_3.color = Color.New(var_29_4, var_29_4, var_29_4)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps10128 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_29_5 then
						iter_29_5.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps10128 = nil
			end

			local var_29_5 = arg_26_1.actors_["1034"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1034 = var_29_5.localPosition
				var_29_5.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1034", 7)

				for iter_29_6 = 0, var_29_5.childCount - 1 do
					local var_29_6 = var_29_5:GetChild(iter_29_6)

					if var_29_6.name == "" or not string.find(var_29_6.name, "split") then
						var_29_6.gameObject:SetActive(true)
					else
						var_29_6.gameObject:SetActive(false)
					end
				end
			end

			local var_29_7 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_26_1.time_ - 0) / var_29_7)
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_29_8 = arg_26_1.actors_["10128"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10128 = var_29_8.localPosition
				var_29_8.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10128", 3)

				for iter_29_7 = 0, var_29_8.childCount - 1 do
					local var_29_9 = var_29_8:GetChild(iter_29_7)

					if var_29_9.name == "" or not string.find(var_29_9.name, "split") then
						var_29_9.gameObject:SetActive(true)
					else
						var_29_9.gameObject:SetActive(false)
					end
				end
			end

			local var_29_10 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_10 then
				var_29_8.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_26_1.time_ - 0) / var_29_10)
			end

			if arg_26_1.time_ >= 0 + var_29_10 and arg_26_1.time_ < 0 + var_29_10 + arg_29_0 then
				var_29_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_29_11 = 0
			local var_29_12 = 0.05

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_13 = arg_26_1:GetWordFromCfg(417041006)
				local var_29_14 = arg_26_1:FormatText(var_29_13.content)

				arg_26_1.text_.text = var_29_14

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_16 = 2 <= 0 and var_29_12 or var_29_12 * (utf8.len(var_29_14) / 2)

				if (2 <= 0 and var_29_12 or var_29_12 * (utf8.len(var_29_14) / 2)) > 0 and var_29_12 < var_29_16 then
					arg_26_1.talkMaxDuration = var_29_16

					if var_29_16 + var_29_11 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_16 + var_29_11
					end
				end

				arg_26_1.text_.text = var_29_14
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041006", "story_v_out_417041.awb") ~= 0 then
					local var_29_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041006", "story_v_out_417041.awb") / 1000

					if var_29_17 + var_29_11 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_17 + var_29_11
					end

					if var_29_13.prefab_name ~= "" and arg_26_1.actors_[var_29_13.prefab_name] ~= nil then
						local var_29_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_13.prefab_name].transform, "story_v_out_417041", "417041006", "story_v_out_417041.awb")

						arg_26_1:RecordAudio("417041006", var_29_18)
						arg_26_1:RecordAudio("417041006", var_29_18)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417041", "417041006", "story_v_out_417041.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417041", "417041006", "story_v_out_417041.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_19 = math.max(var_29_12, arg_26_1.talkMaxDuration)

			if var_29_11 <= arg_26_1.time_ and arg_26_1.time_ < var_29_11 + var_29_19 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_11) / var_29_19

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_11 + var_29_19 and arg_26_1.time_ < var_29_11 + var_29_19 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
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

		arg_26_1:InitPlayNodeList()
	end,
	Play417041007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417041007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417041008(arg_30_1)
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
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 0.5, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_2 = arg_30_1.actors_["10128"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 7)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_33_5 = 0
			local var_33_6 = 1.275

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(417041007).content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 51 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_7) / 51)

				if (51 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_7) / 51)) > 0 and var_33_6 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_6, arg_30_1.talkMaxDuration)

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_5) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_5 + var_33_10 and arg_30_1.time_ < var_33_5 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417041008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417041008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417041009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 1.7

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417041008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 68 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 68)

				if (68 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 68)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417041009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417041009
		arg_38_1.duration_ = 10.23

		local var_38_0 = {
			zh = 6.566,
			ja = 10.233
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
				arg_38_0:Play417041010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.825

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1119].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowotis")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:GetWordFromCfg(417041009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 33 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 33)

				if (33 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 33)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041009", "story_v_out_417041.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041009", "story_v_out_417041.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_417041", "417041009", "story_v_out_417041.awb")

						arg_38_1:RecordAudio("417041009", var_41_6)
						arg_38_1:RecordAudio("417041009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417041", "417041009", "story_v_out_417041.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417041", "417041009", "story_v_out_417041.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417041010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417041010
		arg_42_1.duration_ = 8.23

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417041011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 1.5 < arg_42_1.time_ and arg_42_1.time_ <= 1.5 + arg_45_0 then
				local var_45_0 = arg_42_1.bgs_.ST27

				arg_42_1.bgs_.ST27.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_1 = var_45_0:GetComponent("SpriteRenderer")

				if var_45_1 and var_45_1.sprite then
					local var_45_2 = 2 * (var_45_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_0.transform.localScale = Vector3.New(var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "ST27" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_3 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 0.3 and arg_42_1.time_ < var_45_3 + 0.3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_4 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_5 = 1.5

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_5 then
				local var_45_6 = Color.New(0, 0, 0)

				var_45_6.a = Mathf.Lerp(0, 1, (arg_42_1.time_ - var_45_4) / var_45_5)
				arg_42_1.mask_.color = var_45_6
			end

			if arg_42_1.time_ >= var_45_4 + var_45_5 and arg_42_1.time_ < var_45_4 + var_45_5 + arg_45_0 then
				local var_45_7 = Color.New(0, 0, 0)

				var_45_7.a = 1
				arg_42_1.mask_.color = var_45_7
			end

			local var_45_8 = 1.5

			if 1.5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_9 = 2

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_9 then
				local var_45_10 = Color.New(0, 0, 0)

				var_45_10.a = Mathf.Lerp(1, 0, (arg_42_1.time_ - var_45_8) / var_45_9)
				arg_42_1.mask_.color = var_45_10
			end

			if arg_42_1.time_ >= var_45_8 + var_45_9 and arg_42_1.time_ < var_45_8 + var_45_9 + arg_45_0 then
				local var_45_11 = Color.New(0, 0, 0)

				arg_42_1.mask_.enabled = false
				var_45_11.a = 0
				arg_42_1.mask_.color = var_45_11
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_12 = 3.23333333333333
			local var_45_13 = 0.875

			if 3.23333333333333 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_14 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_14:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_15 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(417041010).content)

				arg_42_1.text_.text = var_45_15

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 35 <= 0 and var_45_13 or var_45_13 * (utf8.len(var_45_15) / 35)

				if (35 <= 0 and var_45_13 or var_45_13 * (utf8.len(var_45_15) / 35)) > 0 and var_45_13 < var_45_17 then
					arg_42_1.talkMaxDuration = var_45_17
					var_45_12 = var_45_12 + 0.3

					if var_45_17 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_12
					end
				end

				arg_42_1.text_.text = var_45_15
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = var_45_12 + 0.3
			local var_45_19 = math.max(var_45_13, arg_42_1.talkMaxDuration)

			if var_45_12 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_18 + var_45_19 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_18) / var_45_19

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_18 + var_45_19 and arg_42_1.time_ < var_45_18 + var_45_19 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417041011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417041011
		arg_48_1.duration_ = 9.23

		local var_48_0 = {
			zh = 9.233,
			ja = 8.766
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play417041012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1034"]) and arg_48_1.var_.actorSpriteComps1034 == nil then
				arg_48_1.var_.actorSpriteComps1034 = arg_48_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1034"]) then
				if arg_48_1.var_.actorSpriteComps1034 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 1, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1034"]) and arg_48_1.var_.actorSpriteComps1034 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps1034 = nil
			end

			local var_51_2 = arg_48_1.actors_["1034"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1034 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1034", 2)

				for iter_51_4 = 0, var_51_2.childCount - 1 do
					local var_51_3 = var_51_2:GetChild(iter_51_4)

					if var_51_3.name == "" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_51_5 = 0
			local var_51_6 = 1.05

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(417041011)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 42 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 42)

				if (42 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 42)) > 0 and var_51_6 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041011", "story_v_out_417041.awb") ~= 0 then
					local var_51_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041011", "story_v_out_417041.awb") / 1000

					if var_51_11 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_5
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_out_417041", "417041011", "story_v_out_417041.awb")

						arg_48_1:RecordAudio("417041011", var_51_12)
						arg_48_1:RecordAudio("417041011", var_51_12)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_417041", "417041011", "story_v_out_417041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_417041", "417041011", "story_v_out_417041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_13 and arg_48_1.time_ < var_51_5 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play417041012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417041012
		arg_52_1.duration_ = 8.07

		local var_52_0 = {
			zh = 4.866,
			ja = 8.066
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play417041013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10128"]) and arg_52_1.var_.actorSpriteComps10128 == nil then
				arg_52_1.var_.actorSpriteComps10128 = arg_52_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10128"]) then
				if arg_52_1.var_.actorSpriteComps10128 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 1, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10128"]) and arg_52_1.var_.actorSpriteComps10128 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps10128 = nil
			end

			local var_55_2 = arg_52_1.actors_["1034"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1034 == nil then
				arg_52_1.var_.actorSpriteComps1034 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps1034 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								iter_55_5.color = Color.New(Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, (arg_52_1.time_ - 0) / var_55_3), Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, (arg_52_1.time_ - 0) / var_55_3), (Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, (arg_52_1.time_ - 0) / var_55_3)))
							else
								local var_55_4 = Mathf.Lerp(iter_55_5.color.r, 0.5, (arg_52_1.time_ - 0) / var_55_3)

								iter_55_5.color = Color.New(var_55_4, var_55_4, var_55_4)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1034 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps1034 = nil
			end

			local var_55_5 = arg_52_1.actors_["10128"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10128 = var_55_5.localPosition
				var_55_5.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10128", 4)

				for iter_55_8 = 0, var_55_5.childCount - 1 do
					local var_55_6 = var_55_5:GetChild(iter_55_8)

					if var_55_6.name == "" or not string.find(var_55_6.name, "split") then
						var_55_6.gameObject:SetActive(true)
					else
						var_55_6.gameObject:SetActive(false)
					end
				end
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_52_1.time_ - 0) / var_55_7)
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_55_8 = 0
			local var_55_9 = 0.65

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(417041012)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 26 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 26)

				if (26 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 26)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041012", "story_v_out_417041.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041012", "story_v_out_417041.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_417041", "417041012", "story_v_out_417041.awb")

						arg_52_1:RecordAudio("417041012", var_55_15)
						arg_52_1:RecordAudio("417041012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417041", "417041012", "story_v_out_417041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417041", "417041012", "story_v_out_417041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play417041013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417041013
		arg_56_1.duration_ = 10.53

		local var_56_0 = {
			zh = 7.8,
			ja = 10.533
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play417041014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1034"]) and arg_56_1.var_.actorSpriteComps1034 == nil then
				arg_56_1.var_.actorSpriteComps1034 = arg_56_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1034"]) then
				if arg_56_1.var_.actorSpriteComps1034 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 1, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1034"]) and arg_56_1.var_.actorSpriteComps1034 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1034 = nil
			end

			local var_59_2 = arg_56_1.actors_["10128"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps10128 == nil then
				arg_56_1.var_.actorSpriteComps10128 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps10128 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								iter_59_5.color = Color.New(Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_3), Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_3), (Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_3)))
							else
								local var_59_4 = Mathf.Lerp(iter_59_5.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_3)

								iter_59_5.color = Color.New(var_59_4, var_59_4, var_59_4)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps10128 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_59_7 then
						iter_59_7.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps10128 = nil
			end

			local var_59_5 = 0
			local var_59_6 = 0.775

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:GetWordFromCfg(417041013)
				local var_59_8 = arg_56_1:FormatText(var_59_7.content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 31 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 31)

				if (31 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 31)) > 0 and var_59_6 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041013", "story_v_out_417041.awb") ~= 0 then
					local var_59_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041013", "story_v_out_417041.awb") / 1000

					if var_59_11 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_5
					end

					if var_59_7.prefab_name ~= "" and arg_56_1.actors_[var_59_7.prefab_name] ~= nil then
						local var_59_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_7.prefab_name].transform, "story_v_out_417041", "417041013", "story_v_out_417041.awb")

						arg_56_1:RecordAudio("417041013", var_59_12)
						arg_56_1:RecordAudio("417041013", var_59_12)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_417041", "417041013", "story_v_out_417041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_417041", "417041013", "story_v_out_417041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_13 and arg_56_1.time_ < var_59_5 + var_59_13 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417041014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417041014
		arg_60_1.duration_ = 8.73

		local var_60_0 = {
			zh = 6.566,
			ja = 8.733
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417041015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1034 = arg_60_1.actors_["1034"].transform.localPosition
				arg_60_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1034", 2)

				for iter_63_0 = 0, arg_60_1.actors_["1034"].transform.childCount - 1 do
					local var_63_0 = arg_60_1.actors_["1034"].transform:GetChild(iter_63_0)

					if var_63_0.name == "split_4" or not string.find(var_63_0.name, "split") then
						var_63_0.gameObject:SetActive(true)
					else
						var_63_0.gameObject:SetActive(false)
					end
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_60_1.time_ - 0) / var_63_1)
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["1034"].transform.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_63_2 = 0
			local var_63_3 = 0.85

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(417041014)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 34 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 34)

				if (34 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 34)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041014", "story_v_out_417041.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041014", "story_v_out_417041.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_417041", "417041014", "story_v_out_417041.awb")

						arg_60_1:RecordAudio("417041014", var_63_9)
						arg_60_1:RecordAudio("417041014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_417041", "417041014", "story_v_out_417041.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_417041", "417041014", "story_v_out_417041.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play417041015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417041015
		arg_64_1.duration_ = 6.93

		local var_64_0 = {
			zh = 4.633,
			ja = 6.933
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417041016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10128"]) and arg_64_1.var_.actorSpriteComps10128 == nil then
				arg_64_1.var_.actorSpriteComps10128 = arg_64_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10128"]) then
				if arg_64_1.var_.actorSpriteComps10128 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 1, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10128"]) and arg_64_1.var_.actorSpriteComps10128 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps10128 = nil
			end

			local var_67_2 = arg_64_1.actors_["1034"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1034 == nil then
				arg_64_1.var_.actorSpriteComps1034 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps1034 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								iter_67_5.color = Color.New(Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_3), Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_3), (Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_3)))
							else
								local var_67_4 = Mathf.Lerp(iter_67_5.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_3)

								iter_67_5.color = Color.New(var_67_4, var_67_4, var_67_4)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1034 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps1034 = nil
			end

			local var_67_5 = 0
			local var_67_6 = 0.625

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:GetWordFromCfg(417041015)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 25 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 25)

				if (25 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 25)) > 0 and var_67_6 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041015", "story_v_out_417041.awb") ~= 0 then
					local var_67_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041015", "story_v_out_417041.awb") / 1000

					if var_67_11 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_5
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_out_417041", "417041015", "story_v_out_417041.awb")

						arg_64_1:RecordAudio("417041015", var_67_12)
						arg_64_1:RecordAudio("417041015", var_67_12)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417041", "417041015", "story_v_out_417041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417041", "417041015", "story_v_out_417041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_13 and arg_64_1.time_ < var_67_5 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417041016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417041016
		arg_68_1.duration_ = 8.27

		local var_68_0 = {
			zh = 5.3,
			ja = 8.266
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417041017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10128 = arg_68_1.actors_["10128"].transform.localPosition
				arg_68_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10128", 4)

				for iter_71_0 = 0, arg_68_1.actors_["10128"].transform.childCount - 1 do
					local var_71_0 = arg_68_1.actors_["10128"].transform:GetChild(iter_71_0)

					if var_71_0.name == "" or not string.find(var_71_0.name, "split") then
						var_71_0.gameObject:SetActive(true)
					else
						var_71_0.gameObject:SetActive(false)
					end
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_68_1.time_ - 0) / var_71_1)
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["10128"].transform.localPosition = Vector3.New(390, -347, -300)
			end

			local var_71_2 = 0
			local var_71_3 = 0.725

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(417041016)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 29 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 29)

				if (29 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 29)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041016", "story_v_out_417041.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041016", "story_v_out_417041.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_417041", "417041016", "story_v_out_417041.awb")

						arg_68_1:RecordAudio("417041016", var_71_9)
						arg_68_1:RecordAudio("417041016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417041", "417041016", "story_v_out_417041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417041", "417041016", "story_v_out_417041.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play417041017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417041017
		arg_72_1.duration_ = 4.97

		local var_72_0 = {
			zh = 3.333,
			ja = 4.966
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417041018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 == nil then
				arg_72_1.var_.actorSpriteComps1034 = arg_72_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1034"]) then
				if arg_72_1.var_.actorSpriteComps1034 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1034 = nil
			end

			local var_75_2 = arg_72_1.actors_["10128"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10128 == nil then
				arg_72_1.var_.actorSpriteComps10128 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps10128 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_5.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_5.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10128 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps10128 = nil
			end

			local var_75_5 = arg_72_1.actors_["1034"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1034 = var_75_5.localPosition
				var_75_5.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1034", 2)

				for iter_75_8 = 0, var_75_5.childCount - 1 do
					local var_75_6 = var_75_5:GetChild(iter_75_8)

					if var_75_6.name == "split_4" or not string.find(var_75_6.name, "split") then
						var_75_6.gameObject:SetActive(true)
					else
						var_75_6.gameObject:SetActive(false)
					end
				end
			end

			local var_75_7 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_72_1.time_ - 0) / var_75_7)
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_75_8 = 0
			local var_75_9 = 0.425

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(417041017)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 16 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 16)

				if (16 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 16)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041017", "story_v_out_417041.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041017", "story_v_out_417041.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_417041", "417041017", "story_v_out_417041.awb")

						arg_72_1:RecordAudio("417041017", var_75_15)
						arg_72_1:RecordAudio("417041017", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417041", "417041017", "story_v_out_417041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417041", "417041017", "story_v_out_417041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play417041018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417041018
		arg_76_1.duration_ = 8.5

		local var_76_0 = {
			zh = 8.5,
			ja = 8.1
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417041019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10128"]) and arg_76_1.var_.actorSpriteComps10128 == nil then
				arg_76_1.var_.actorSpriteComps10128 = arg_76_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10128"]) then
				if arg_76_1.var_.actorSpriteComps10128 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 1, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10128"]) and arg_76_1.var_.actorSpriteComps10128 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps10128 = nil
			end

			local var_79_2 = arg_76_1.actors_["1034"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1034 == nil then
				arg_76_1.var_.actorSpriteComps1034 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1034 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1034 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1034 = nil
			end

			local var_79_5 = arg_76_1.actors_["10128"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 4)

				for iter_79_8 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_8)

					if var_79_6.name == "split_2" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_79_8 = 0
			local var_79_9 = 1.025

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(417041018)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 41 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 41)

				if (41 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 41)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041018", "story_v_out_417041.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041018", "story_v_out_417041.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_out_417041", "417041018", "story_v_out_417041.awb")

						arg_76_1:RecordAudio("417041018", var_79_15)
						arg_76_1:RecordAudio("417041018", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417041", "417041018", "story_v_out_417041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417041", "417041018", "story_v_out_417041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_16 and arg_76_1.time_ < var_79_8 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play417041019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417041019
		arg_80_1.duration_ = 11.8

		local var_80_0 = {
			zh = 9.533,
			ja = 11.8
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play417041020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.275

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(417041019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 51 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 51)

				if (51 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 51)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041019", "story_v_out_417041.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041019", "story_v_out_417041.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_417041", "417041019", "story_v_out_417041.awb")

						arg_80_1:RecordAudio("417041019", var_83_6)
						arg_80_1:RecordAudio("417041019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417041", "417041019", "story_v_out_417041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417041", "417041019", "story_v_out_417041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play417041020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417041020
		arg_84_1.duration_ = 9.63

		local var_84_0 = {
			zh = 6.933,
			ja = 9.633
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417041021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.925

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(417041020)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 37)

				if (37 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 37)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041020", "story_v_out_417041.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041020", "story_v_out_417041.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_417041", "417041020", "story_v_out_417041.awb")

						arg_84_1:RecordAudio("417041020", var_87_6)
						arg_84_1:RecordAudio("417041020", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417041", "417041020", "story_v_out_417041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417041", "417041020", "story_v_out_417041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417041021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417041021
		arg_88_1.duration_ = 10.37

		local var_88_0 = {
			zh = 7.3,
			ja = 10.366
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417041022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10128 = arg_88_1.actors_["10128"].transform.localPosition
				arg_88_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10128", 4)

				for iter_91_0 = 0, arg_88_1.actors_["10128"].transform.childCount - 1 do
					local var_91_0 = arg_88_1.actors_["10128"].transform:GetChild(iter_91_0)

					if var_91_0.name == "" or not string.find(var_91_0.name, "split") then
						var_91_0.gameObject:SetActive(true)
					else
						var_91_0.gameObject:SetActive(false)
					end
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_88_1.time_ - 0) / var_91_1)
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["10128"].transform.localPosition = Vector3.New(390, -347, -300)
			end

			local var_91_2 = 0
			local var_91_3 = 0.85

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(417041021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 34 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 34)

				if (34 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 34)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041021", "story_v_out_417041.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041021", "story_v_out_417041.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_417041", "417041021", "story_v_out_417041.awb")

						arg_88_1:RecordAudio("417041021", var_91_9)
						arg_88_1:RecordAudio("417041021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417041", "417041021", "story_v_out_417041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417041", "417041021", "story_v_out_417041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play417041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417041022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play417041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10128"]) and arg_92_1.var_.actorSpriteComps10128 == nil then
				arg_92_1.var_.actorSpriteComps10128 = arg_92_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10128"]) then
				if arg_92_1.var_.actorSpriteComps10128 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10128"]) and arg_92_1.var_.actorSpriteComps10128 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps10128 = nil
			end

			local var_95_2 = arg_92_1.actors_["1034"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1034 = var_95_2.localPosition
				var_95_2.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1034", 7)

				for iter_95_4 = 0, var_95_2.childCount - 1 do
					local var_95_3 = var_95_2:GetChild(iter_95_4)

					if var_95_3.name == "" or not string.find(var_95_3.name, "split") then
						var_95_3.gameObject:SetActive(true)
					else
						var_95_3.gameObject:SetActive(false)
					end
				end
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_2.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_92_1.time_ - 0) / var_95_4)
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_5 = arg_92_1.actors_["10128"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10128 = var_95_5.localPosition
				var_95_5.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10128", 7)

				for iter_95_5 = 0, var_95_5.childCount - 1 do
					local var_95_6 = var_95_5:GetChild(iter_95_5)

					if var_95_6.name == "" or not string.find(var_95_6.name, "split") then
						var_95_6.gameObject:SetActive(true)
					else
						var_95_6.gameObject:SetActive(false)
					end
				end
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_92_1.time_ - 0) / var_95_7)
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.2 < arg_92_1.time_ and arg_92_1.time_ <= 0.2 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_door", "")
			end

			local var_95_9 = 0
			local var_95_10 = 1.775

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_11 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(417041022).content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 71 <= 0 and var_95_10 or var_95_10 * (utf8.len(var_95_11) / 71)

				if (71 <= 0 and var_95_10 or var_95_10 * (utf8.len(var_95_11) / 71)) > 0 and var_95_10 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_9 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_9
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_10, arg_92_1.talkMaxDuration)

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_9) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_9 + var_95_14 and arg_92_1.time_ < var_95_9 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play417041023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417041023
		arg_96_1.duration_ = 5.47

		local var_96_0 = {
			zh = 1.866,
			ja = 5.466
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play417041024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1034"]) and arg_96_1.var_.actorSpriteComps1034 == nil then
				arg_96_1.var_.actorSpriteComps1034 = arg_96_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1034"]) then
				if arg_96_1.var_.actorSpriteComps1034 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 1, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1034"]) and arg_96_1.var_.actorSpriteComps1034 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps1034 = nil
			end

			local var_99_2 = arg_96_1.actors_["1034"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1034 = var_99_2.localPosition
				var_99_2.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1034", 2)

				for iter_99_4 = 0, var_99_2.childCount - 1 do
					local var_99_3 = var_99_2:GetChild(iter_99_4)

					if var_99_3.name == "split_4" or not string.find(var_99_3.name, "split") then
						var_99_3.gameObject:SetActive(true)
					else
						var_99_3.gameObject:SetActive(false)
					end
				end
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_2.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_96_1.time_ - 0) / var_99_4)
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_99_5 = 0
			local var_99_6 = 0.25

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:GetWordFromCfg(417041023)
				local var_99_8 = arg_96_1:FormatText(var_99_7.content)

				arg_96_1.text_.text = var_99_8

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 10 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_8) / 10)

				if (10 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_8) / 10)) > 0 and var_99_6 < var_99_10 then
					arg_96_1.talkMaxDuration = var_99_10

					if var_99_10 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_8
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041023", "story_v_out_417041.awb") ~= 0 then
					local var_99_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041023", "story_v_out_417041.awb") / 1000

					if var_99_11 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_5
					end

					if var_99_7.prefab_name ~= "" and arg_96_1.actors_[var_99_7.prefab_name] ~= nil then
						local var_99_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_7.prefab_name].transform, "story_v_out_417041", "417041023", "story_v_out_417041.awb")

						arg_96_1:RecordAudio("417041023", var_99_12)
						arg_96_1:RecordAudio("417041023", var_99_12)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417041", "417041023", "story_v_out_417041.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417041", "417041023", "story_v_out_417041.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_13 and arg_96_1.time_ < var_99_5 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play417041024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417041024
		arg_100_1.duration_ = 11.67

		local var_100_0 = {
			zh = 4.566,
			ja = 11.666
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417041025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1034"]) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = arg_100_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1034"]) then
				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 0.5, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1034"]) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_2 = arg_100_1.actors_["10128"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10128 = var_103_2.localPosition
				var_103_2.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10128", 4)

				for iter_103_4 = 0, var_103_2.childCount - 1 do
					local var_103_3 = var_103_2:GetChild(iter_103_4)

					if var_103_3.name == "" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_100_1.time_ - 0) / var_103_4)
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(390, -347, -300)
			end

			local var_103_5 = arg_100_1.actors_["10128"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.actorSpriteComps10128 == nil then
				arg_100_1.var_.actorSpriteComps10128 = var_103_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_6 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 and not isNil(var_103_5) then
				if arg_100_1.var_.actorSpriteComps10128 then
					for iter_103_5, iter_103_6 in pairs(arg_100_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_103_6 then
							if arg_100_1.isInRecall_ then
								iter_103_6.color = Color.New(Mathf.Lerp(iter_103_6.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_6), Mathf.Lerp(iter_103_6.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_6), (Mathf.Lerp(iter_103_6.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_6)))
							else
								local var_103_7 = Mathf.Lerp(iter_103_6.color.r, 1, (arg_100_1.time_ - 0) / var_103_6)

								iter_103_6.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.actorSpriteComps10128 then
				for iter_103_7, iter_103_8 in pairs(arg_100_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_103_8 then
						iter_103_8.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps10128 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 0.475

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(417041024)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 19 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 19)

				if (19 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 19)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041024", "story_v_out_417041.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041024", "story_v_out_417041.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_417041", "417041024", "story_v_out_417041.awb")

						arg_100_1:RecordAudio("417041024", var_103_15)
						arg_100_1:RecordAudio("417041024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417041", "417041024", "story_v_out_417041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417041", "417041024", "story_v_out_417041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play417041025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417041025
		arg_104_1.duration_ = 6.73

		local var_104_0 = {
			zh = 6.733,
			ja = 4.933
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417041026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1034"]) and arg_104_1.var_.actorSpriteComps1034 == nil then
				arg_104_1.var_.actorSpriteComps1034 = arg_104_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1034"]) then
				if arg_104_1.var_.actorSpriteComps1034 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 1, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1034"]) and arg_104_1.var_.actorSpriteComps1034 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps1034 = nil
			end

			local var_107_2 = arg_104_1.actors_["10128"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps10128 == nil then
				arg_104_1.var_.actorSpriteComps10128 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps10128 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_5.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_5.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps10128 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps10128 = nil
			end

			local var_107_5 = 0
			local var_107_6 = 0.725

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:GetWordFromCfg(417041025)
				local var_107_8 = arg_104_1:FormatText(var_107_7.content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 29 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_8) / 29)

				if (29 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_8) / 29)) > 0 and var_107_6 < var_107_10 then
					arg_104_1.talkMaxDuration = var_107_10

					if var_107_10 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_5
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041025", "story_v_out_417041.awb") ~= 0 then
					local var_107_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041025", "story_v_out_417041.awb") / 1000

					if var_107_11 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_5
					end

					if var_107_7.prefab_name ~= "" and arg_104_1.actors_[var_107_7.prefab_name] ~= nil then
						local var_107_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_7.prefab_name].transform, "story_v_out_417041", "417041025", "story_v_out_417041.awb")

						arg_104_1:RecordAudio("417041025", var_107_12)
						arg_104_1:RecordAudio("417041025", var_107_12)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417041", "417041025", "story_v_out_417041.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417041", "417041025", "story_v_out_417041.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_6, arg_104_1.talkMaxDuration)

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_5) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_5 + var_107_13 and arg_104_1.time_ < var_107_5 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417041026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417041026
		arg_108_1.duration_ = 5.87

		local var_108_0 = {
			zh = 2.9,
			ja = 5.866
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play417041027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10128"]) and arg_108_1.var_.actorSpriteComps10128 == nil then
				arg_108_1.var_.actorSpriteComps10128 = arg_108_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10128"]) then
				if arg_108_1.var_.actorSpriteComps10128 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10128"]) and arg_108_1.var_.actorSpriteComps10128 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps10128 = nil
			end

			local var_111_2 = arg_108_1.actors_["1034"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								iter_111_5.color = Color.New(Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_5.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_5.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_7 then
						iter_111_7.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_5 = 0
			local var_111_6 = 0.35

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(417041026)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 14 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 14)

				if (14 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 14)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041026", "story_v_out_417041.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041026", "story_v_out_417041.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_417041", "417041026", "story_v_out_417041.awb")

						arg_108_1:RecordAudio("417041026", var_111_12)
						arg_108_1:RecordAudio("417041026", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417041", "417041026", "story_v_out_417041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417041", "417041026", "story_v_out_417041.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play417041027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417041027
		arg_112_1.duration_ = 10.17

		local var_112_0 = {
			zh = 5.766,
			ja = 10.166
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
				arg_112_0:Play417041028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10128 = arg_112_1.actors_["10128"].transform.localPosition
				arg_112_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10128", 4)

				for iter_115_0 = 0, arg_112_1.actors_["10128"].transform.childCount - 1 do
					local var_115_0 = arg_112_1.actors_["10128"].transform:GetChild(iter_115_0)

					if var_115_0.name == "split_2" or not string.find(var_115_0.name, "split") then
						var_115_0.gameObject:SetActive(true)
					else
						var_115_0.gameObject:SetActive(false)
					end
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_112_1.time_ - 0) / var_115_1)
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["10128"].transform.localPosition = Vector3.New(390, -347, -300)
			end

			local var_115_2 = 0
			local var_115_3 = 0.7

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(417041027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 28 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 28)

				if (28 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 28)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041027", "story_v_out_417041.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041027", "story_v_out_417041.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_417041", "417041027", "story_v_out_417041.awb")

						arg_112_1:RecordAudio("417041027", var_115_9)
						arg_112_1:RecordAudio("417041027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417041", "417041027", "story_v_out_417041.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417041", "417041027", "story_v_out_417041.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417041028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417041028
		arg_116_1.duration_ = 10.87

		local var_116_0 = {
			zh = 8.9,
			ja = 10.866
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
				arg_116_0:Play417041029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = arg_116_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1034"]) then
				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_2 = arg_116_1.actors_["10128"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10128 == nil then
				arg_116_1.var_.actorSpriteComps10128 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps10128 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10128 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps10128 = nil
			end

			local var_119_5 = 0
			local var_119_6 = 1.075

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_7 = arg_116_1:GetWordFromCfg(417041028)
				local var_119_8 = arg_116_1:FormatText(var_119_7.content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 43 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 43)

				if (43 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 43)) > 0 and var_119_6 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041028", "story_v_out_417041.awb") ~= 0 then
					local var_119_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041028", "story_v_out_417041.awb") / 1000

					if var_119_11 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_5
					end

					if var_119_7.prefab_name ~= "" and arg_116_1.actors_[var_119_7.prefab_name] ~= nil then
						local var_119_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_7.prefab_name].transform, "story_v_out_417041", "417041028", "story_v_out_417041.awb")

						arg_116_1:RecordAudio("417041028", var_119_12)
						arg_116_1:RecordAudio("417041028", var_119_12)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417041", "417041028", "story_v_out_417041.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417041", "417041028", "story_v_out_417041.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_13 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_13 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_13

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_13 and arg_116_1.time_ < var_119_5 + var_119_13 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417041029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417041029
		arg_120_1.duration_ = 12.6

		local var_120_0 = {
			zh = 11,
			ja = 12.6
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
				arg_120_0:Play417041030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1034 = arg_120_1.actors_["1034"].transform.localPosition
				arg_120_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1034", 2)

				for iter_123_0 = 0, arg_120_1.actors_["1034"].transform.childCount - 1 do
					local var_123_0 = arg_120_1.actors_["1034"].transform:GetChild(iter_123_0)

					if var_123_0.name == "split_6" or not string.find(var_123_0.name, "split") then
						var_123_0.gameObject:SetActive(true)
					else
						var_123_0.gameObject:SetActive(false)
					end
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_120_1.time_ - 0) / var_123_1)
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["1034"].transform.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_123_2 = 0
			local var_123_3 = 1.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
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

				local var_123_4 = arg_120_1:GetWordFromCfg(417041029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 47 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 47)

				if (47 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 47)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041029", "story_v_out_417041.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041029", "story_v_out_417041.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_417041", "417041029", "story_v_out_417041.awb")

						arg_120_1:RecordAudio("417041029", var_123_9)
						arg_120_1:RecordAudio("417041029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417041", "417041029", "story_v_out_417041.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417041", "417041029", "story_v_out_417041.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play417041030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417041030
		arg_124_1.duration_ = 5.97

		local var_124_0 = {
			zh = 5.1,
			ja = 5.966
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417041031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10128"]) and arg_124_1.var_.actorSpriteComps10128 == nil then
				arg_124_1.var_.actorSpriteComps10128 = arg_124_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10128"]) then
				if arg_124_1.var_.actorSpriteComps10128 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 1, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10128"]) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_2 = arg_124_1.actors_["1034"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_5 = arg_124_1.actors_["10128"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10128 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10128", 4)

				for iter_127_8 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_8)

					if var_127_6.name == "" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_127_8 = 0
			local var_127_9 = 0.65

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(417041030)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 26 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 26)

				if (26 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 26)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041030", "story_v_out_417041.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041030", "story_v_out_417041.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_out_417041", "417041030", "story_v_out_417041.awb")

						arg_124_1:RecordAudio("417041030", var_127_15)
						arg_124_1:RecordAudio("417041030", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417041", "417041030", "story_v_out_417041.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417041", "417041030", "story_v_out_417041.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417041031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417041031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417041032(arg_128_1)
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
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10128"]) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_2 = arg_128_1.actors_["1034"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1034 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1034", 7)

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
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_5 = arg_128_1.actors_["10128"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10128 = var_131_5.localPosition
				var_131_5.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10128", 7)

				for iter_131_5 = 0, var_131_5.childCount - 1 do
					local var_131_6 = var_131_5:GetChild(iter_131_5)

					if var_131_6.name == "" or not string.find(var_131_6.name, "split") then
						var_131_6.gameObject:SetActive(true)
					else
						var_131_6.gameObject:SetActive(false)
					end
				end
			end

			local var_131_7 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				var_131_5.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_128_1.time_ - 0) / var_131_7)
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				var_131_5.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.05 < arg_128_1.time_ and arg_128_1.time_ <= 0.05 + arg_131_0 then
				arg_128_1:AudioAction("play", "effect", "se_story_side_1199", "se_story_1199_shock", "")
			end

			local var_131_9 = 0
			local var_131_10 = 1.075

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_11 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(417041031).content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 43 <= 0 and var_131_10 or var_131_10 * (utf8.len(var_131_11) / 43)

				if (43 <= 0 and var_131_10 or var_131_10 * (utf8.len(var_131_11) / 43)) > 0 and var_131_10 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_9 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_9
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_10, arg_128_1.talkMaxDuration)

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_9) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_9 + var_131_14 and arg_128_1.time_ < var_131_9 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play417041032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417041032
		arg_132_1.duration_ = 3.17

		local var_132_0 = {
			zh = 1.766,
			ja = 3.166
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
				arg_132_0:Play417041033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10128"]) and arg_132_1.var_.actorSpriteComps10128 == nil then
				arg_132_1.var_.actorSpriteComps10128 = arg_132_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10128"]) then
				if arg_132_1.var_.actorSpriteComps10128 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10128"]) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_2 = arg_132_1.actors_["10128"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10128 = var_135_2.localPosition
				var_135_2.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10128", 3)

				for iter_135_4 = 0, var_135_2.childCount - 1 do
					local var_135_3 = var_135_2:GetChild(iter_135_4)

					if var_135_3.name == "" or not string.find(var_135_3.name, "split") then
						var_135_3.gameObject:SetActive(true)
					else
						var_135_3.gameObject:SetActive(false)
					end
				end
			end

			local var_135_4 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				var_135_2.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_132_1.time_ - 0) / var_135_4)
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				var_135_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_135_5 = 0
			local var_135_6 = 0.2

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(417041032)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 8 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 8)

				if (8 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 8)) > 0 and var_135_6 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041032", "story_v_out_417041.awb") ~= 0 then
					local var_135_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041032", "story_v_out_417041.awb") / 1000

					if var_135_11 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_5
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_417041", "417041032", "story_v_out_417041.awb")

						arg_132_1:RecordAudio("417041032", var_135_12)
						arg_132_1:RecordAudio("417041032", var_135_12)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417041", "417041032", "story_v_out_417041.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417041", "417041032", "story_v_out_417041.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_13 and arg_132_1.time_ < var_135_5 + var_135_13 + arg_135_0 then
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
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play417041033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417041033
		arg_136_1.duration_ = 5.1

		local var_136_0 = {
			zh = 3.1,
			ja = 5.1
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
				arg_136_0:Play417041034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1034"]) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = arg_136_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1034"]) then
				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1034"]) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_2 = arg_136_1.actors_["10128"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps10128 == nil then
				arg_136_1.var_.actorSpriteComps10128 = var_139_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_3 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.actorSpriteComps10128 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps10128 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_139_7 then
						iter_139_7.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps10128 = nil
			end

			local var_139_5 = arg_136_1.actors_["1034"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_5.localPosition
				var_139_5.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 3)

				for iter_139_8 = 0, var_139_5.childCount - 1 do
					local var_139_6 = var_139_5:GetChild(iter_139_8)

					if var_139_6.name == "" or not string.find(var_139_6.name, "split") then
						var_139_6.gameObject:SetActive(true)
					else
						var_139_6.gameObject:SetActive(false)
					end
				end
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_5.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_136_1.time_ - 0) / var_139_7)
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_139_8 = arg_136_1.actors_["10128"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10128 = var_139_8.localPosition
				var_139_8.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("10128", 7)

				for iter_139_9 = 0, var_139_8.childCount - 1 do
					local var_139_9 = var_139_8:GetChild(iter_139_9)

					if var_139_9.name == "" or not string.find(var_139_9.name, "split") then
						var_139_9.gameObject:SetActive(true)
					else
						var_139_9.gameObject:SetActive(false)
					end
				end
			end

			local var_139_10 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_10 then
				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_136_1.time_ - 0) / var_139_10)
			end

			if arg_136_1.time_ >= 0 + var_139_10 and arg_136_1.time_ < 0 + var_139_10 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_139_11 = 0
			local var_139_12 = 0.4

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_13 = arg_136_1:GetWordFromCfg(417041033)
				local var_139_14 = arg_136_1:FormatText(var_139_13.content)

				arg_136_1.text_.text = var_139_14

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_16 = 16 <= 0 and var_139_12 or var_139_12 * (utf8.len(var_139_14) / 16)

				if (16 <= 0 and var_139_12 or var_139_12 * (utf8.len(var_139_14) / 16)) > 0 and var_139_12 < var_139_16 then
					arg_136_1.talkMaxDuration = var_139_16

					if var_139_16 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_11
					end
				end

				arg_136_1.text_.text = var_139_14
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041033", "story_v_out_417041.awb") ~= 0 then
					local var_139_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041033", "story_v_out_417041.awb") / 1000

					if var_139_17 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_11
					end

					if var_139_13.prefab_name ~= "" and arg_136_1.actors_[var_139_13.prefab_name] ~= nil then
						local var_139_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_13.prefab_name].transform, "story_v_out_417041", "417041033", "story_v_out_417041.awb")

						arg_136_1:RecordAudio("417041033", var_139_18)
						arg_136_1:RecordAudio("417041033", var_139_18)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417041", "417041033", "story_v_out_417041.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417041", "417041033", "story_v_out_417041.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_19 = math.max(var_139_12, arg_136_1.talkMaxDuration)

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_19 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_11) / var_139_19

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_11 + var_139_19 and arg_136_1.time_ < var_139_11 + var_139_19 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play417041034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417041034
		arg_140_1.duration_ = 12.13

		local var_140_0 = {
			zh = 10.3666666666667,
			ja = 12.1326666666667
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
				arg_140_0:Play417041035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if arg_140_1.bgs_.I07 == nil then
				local var_143_0 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_143_0.name = "I07"
				var_143_0.transform.parent = arg_140_1.stage_.transform
				var_143_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_.I07 = var_143_0
			end

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= 2 + arg_143_0 then
				local var_143_1 = arg_140_1.bgs_.I07

				arg_140_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_2 = var_143_1:GetComponent("SpriteRenderer")

				if var_143_2 and var_143_2.sprite then
					local var_143_3 = 2 * (var_143_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_1.transform.localScale = Vector3.New(var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "I07" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_4 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			if arg_140_1.time_ >= var_143_4 + 0.3 and arg_140_1.time_ < var_143_4 + 0.3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_5 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_6 = 2

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 then
				local var_143_7 = Color.New(0, 0, 0)

				var_143_7.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_5) / var_143_6)
				arg_140_1.mask_.color = var_143_7
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 then
				local var_143_8 = Color.New(0, 0, 0)

				var_143_8.a = 1
				arg_140_1.mask_.color = var_143_8
			end

			local var_143_9 = 2

			if 2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_10 = 2

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_10 then
				local var_143_11 = Color.New(0, 0, 0)

				var_143_11.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_9) / var_143_10)
				arg_140_1.mask_.color = var_143_11
			end

			if arg_140_1.time_ >= var_143_9 + var_143_10 and arg_140_1.time_ < var_143_9 + var_143_10 + arg_143_0 then
				local var_143_12 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_12.a = 0
				arg_140_1.mask_.color = var_143_12
			end

			local var_143_13 = arg_140_1.actors_["1034"].transform

			if 1.966 < arg_140_1.time_ and arg_140_1.time_ <= 1.966 + arg_143_0 then
				arg_140_1.var_.moveOldPos1034 = var_143_13.localPosition
				var_143_13.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1034", 7)

				for iter_143_2 = 0, var_143_13.childCount - 1 do
					local var_143_14 = var_143_13:GetChild(iter_143_2)

					if var_143_14.name == "" or not string.find(var_143_14.name, "split") then
						var_143_14.gameObject:SetActive(true)
					else
						var_143_14.gameObject:SetActive(false)
					end
				end
			end

			local var_143_15 = 0.001

			if 1.966 <= arg_140_1.time_ and arg_140_1.time_ < 1.966 + var_143_15 then
				var_143_13.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_140_1.time_ - 1.966) / var_143_15)
			end

			if arg_140_1.time_ >= 1.966 + var_143_15 and arg_140_1.time_ < 1.966 + var_143_15 + arg_143_0 then
				var_143_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_16 = 3.86666666666667
			local var_143_17 = 0.875

			if 3.86666666666667 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_18 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_18:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_19 = arg_140_1:GetWordFromCfg(417041034)
				local var_143_20 = arg_140_1:FormatText(var_143_19.content)

				arg_140_1.text_.text = var_143_20

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_22 = 35 <= 0 and var_143_17 or var_143_17 * (utf8.len(var_143_20) / 35)

				if (35 <= 0 and var_143_17 or var_143_17 * (utf8.len(var_143_20) / 35)) > 0 and var_143_17 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22
					var_143_16 = var_143_16 + 0.3

					if var_143_22 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_16
					end
				end

				arg_140_1.text_.text = var_143_20
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041034", "story_v_out_417041.awb") ~= 0 then
					local var_143_23 = manager.audio:GetVoiceLength("story_v_out_417041", "417041034", "story_v_out_417041.awb") / 1000

					if var_143_23 + var_143_16 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_16
					end

					if var_143_19.prefab_name ~= "" and arg_140_1.actors_[var_143_19.prefab_name] ~= nil then
						local var_143_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_19.prefab_name].transform, "story_v_out_417041", "417041034", "story_v_out_417041.awb")

						arg_140_1:RecordAudio("417041034", var_143_24)
						arg_140_1:RecordAudio("417041034", var_143_24)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417041", "417041034", "story_v_out_417041.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417041", "417041034", "story_v_out_417041.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_25 = var_143_16 + 0.3
			local var_143_26 = math.max(var_143_17, arg_140_1.talkMaxDuration)

			if var_143_16 + 0.3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_25 + var_143_26 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_25) / var_143_26

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_25 + var_143_26 and arg_140_1.time_ < var_143_25 + var_143_26 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play417041035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417041035
		arg_146_1.duration_ = 3.67

		local var_146_0 = {
			zh = 2.3,
			ja = 3.666
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417041036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.3

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:GetWordFromCfg(417041035)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 12 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 12)

				if (12 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 12)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041035", "story_v_out_417041.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041035", "story_v_out_417041.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_417041", "417041035", "story_v_out_417041.awb")

						arg_146_1:RecordAudio("417041035", var_149_6)
						arg_146_1:RecordAudio("417041035", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417041", "417041035", "story_v_out_417041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417041", "417041035", "story_v_out_417041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417041036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417041036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417041037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.85

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(417041036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 34 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 34)

				if (34 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 34)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417041037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417041037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417041038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0.01 < arg_154_1.time_ and arg_154_1.time_ <= 0.01 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_Metal", "")
			end

			local var_157_1 = 0
			local var_157_2 = 1.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(417041037).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 50 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 50)

				if (50 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 50)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play417041038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417041038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417041039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.725

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(417041038).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 69 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 69)

				if (69 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 69)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417041039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417041039
		arg_162_1.duration_ = 2.97

		local var_162_0 = {
			zh = 1.3,
			ja = 2.966
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417041040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1034"]) and arg_162_1.var_.actorSpriteComps1034 == nil then
				arg_162_1.var_.actorSpriteComps1034 = arg_162_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1034"]) then
				if arg_162_1.var_.actorSpriteComps1034 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 1, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1034"]) and arg_162_1.var_.actorSpriteComps1034 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps1034 = nil
			end

			local var_165_2 = arg_162_1.actors_["1034"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1034 = var_165_2.localPosition
				var_165_2.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1034", 2)

				for iter_165_4 = 0, var_165_2.childCount - 1 do
					local var_165_3 = var_165_2:GetChild(iter_165_4)

					if var_165_3.name == "split_1" or not string.find(var_165_3.name, "split") then
						var_165_3.gameObject:SetActive(true)
					else
						var_165_3.gameObject:SetActive(false)
					end
				end
			end

			local var_165_4 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				var_165_2.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_162_1.time_ - 0) / var_165_4)
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				var_165_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_165_5 = 0
			local var_165_6 = 0.15

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(417041039)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_10 = 6 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_8) / 6)

				if (6 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_8) / 6)) > 0 and var_165_6 < var_165_10 then
					arg_162_1.talkMaxDuration = var_165_10

					if var_165_10 + var_165_5 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_5
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041039", "story_v_out_417041.awb") ~= 0 then
					local var_165_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041039", "story_v_out_417041.awb") / 1000

					if var_165_11 + var_165_5 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_5
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_417041", "417041039", "story_v_out_417041.awb")

						arg_162_1:RecordAudio("417041039", var_165_12)
						arg_162_1:RecordAudio("417041039", var_165_12)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417041", "417041039", "story_v_out_417041.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417041", "417041039", "story_v_out_417041.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_13 = math.max(var_165_6, arg_162_1.talkMaxDuration)

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_13 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_5) / var_165_13

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_5 + var_165_13 and arg_162_1.time_ < var_165_5 + var_165_13 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play417041040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417041040
		arg_166_1.duration_ = 5.67

		local var_166_0 = {
			zh = 4.033,
			ja = 5.666
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417041041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10128"]) and arg_166_1.var_.actorSpriteComps10128 == nil then
				arg_166_1.var_.actorSpriteComps10128 = arg_166_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10128"]) then
				if arg_166_1.var_.actorSpriteComps10128 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 1, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10128"]) and arg_166_1.var_.actorSpriteComps10128 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10128 = nil
			end

			local var_169_2 = arg_166_1.actors_["1034"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1034 == nil then
				arg_166_1.var_.actorSpriteComps1034 = var_169_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_3 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.actorSpriteComps1034 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								iter_169_5.color = Color.New(Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_3), Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_3), (Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_3)))
							else
								local var_169_4 = Mathf.Lerp(iter_169_5.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_3)

								iter_169_5.color = Color.New(var_169_4, var_169_4, var_169_4)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1034 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_169_7 then
						iter_169_7.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps1034 = nil
			end

			local var_169_5 = arg_166_1.actors_["10128"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10128 = var_169_5.localPosition
				var_169_5.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10128", 4)

				for iter_169_8 = 0, var_169_5.childCount - 1 do
					local var_169_6 = var_169_5:GetChild(iter_169_8)

					if var_169_6.name == "" or not string.find(var_169_6.name, "split") then
						var_169_6.gameObject:SetActive(true)
					else
						var_169_6.gameObject:SetActive(false)
					end
				end
			end

			local var_169_7 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_166_1.time_ - 0) / var_169_7)
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_169_8 = 0
			local var_169_9 = 0.525

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:GetWordFromCfg(417041040)
				local var_169_11 = arg_166_1:FormatText(var_169_10.content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 21 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 21)

				if (21 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 21)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041040", "story_v_out_417041.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041040", "story_v_out_417041.awb") / 1000

					if var_169_14 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_8
					end

					if var_169_10.prefab_name ~= "" and arg_166_1.actors_[var_169_10.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_10.prefab_name].transform, "story_v_out_417041", "417041040", "story_v_out_417041.awb")

						arg_166_1:RecordAudio("417041040", var_169_15)
						arg_166_1:RecordAudio("417041040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417041", "417041040", "story_v_out_417041.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417041", "417041040", "story_v_out_417041.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play417041041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417041041
		arg_170_1.duration_ = 14

		local var_170_0 = {
			zh = 11.7,
			ja = 14
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417041042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 1.475

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(417041041)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 59 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 59)

				if (59 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 59)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041041", "story_v_out_417041.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041041", "story_v_out_417041.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_417041", "417041041", "story_v_out_417041.awb")

						arg_170_1:RecordAudio("417041041", var_173_6)
						arg_170_1:RecordAudio("417041041", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417041", "417041041", "story_v_out_417041.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417041", "417041041", "story_v_out_417041.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417041042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417041042
		arg_174_1.duration_ = 3.03

		local var_174_0 = {
			zh = 2.4,
			ja = 3.033
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417041043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1034"]) and arg_174_1.var_.actorSpriteComps1034 == nil then
				arg_174_1.var_.actorSpriteComps1034 = arg_174_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1034"]) then
				if arg_174_1.var_.actorSpriteComps1034 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1034"]) and arg_174_1.var_.actorSpriteComps1034 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps1034 = nil
			end

			local var_177_2 = arg_174_1.actors_["10128"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10128 == nil then
				arg_174_1.var_.actorSpriteComps10128 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps10128 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								iter_177_5.color = Color.New(Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_5.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_5.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10128 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_177_7 then
						iter_177_7.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_5 = arg_174_1.actors_["1034"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1034 = var_177_5.localPosition
				var_177_5.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1034", 2)

				for iter_177_8 = 0, var_177_5.childCount - 1 do
					local var_177_6 = var_177_5:GetChild(iter_177_8)

					if var_177_6.name == "split_6" or not string.find(var_177_6.name, "split") then
						var_177_6.gameObject:SetActive(true)
					else
						var_177_6.gameObject:SetActive(false)
					end
				end
			end

			local var_177_7 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_174_1.time_ - 0) / var_177_7)
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_177_8 = 0
			local var_177_9 = 0.225

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(417041042)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 9 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 9)

				if (9 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 9)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041042", "story_v_out_417041.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041042", "story_v_out_417041.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_417041", "417041042", "story_v_out_417041.awb")

						arg_174_1:RecordAudio("417041042", var_177_15)
						arg_174_1:RecordAudio("417041042", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417041", "417041042", "story_v_out_417041.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417041", "417041042", "story_v_out_417041.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play417041043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417041043
		arg_178_1.duration_ = 12.13

		local var_178_0 = {
			zh = 12.133,
			ja = 11.5
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417041044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10128"]) and arg_178_1.var_.actorSpriteComps10128 == nil then
				arg_178_1.var_.actorSpriteComps10128 = arg_178_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10128"]) then
				if arg_178_1.var_.actorSpriteComps10128 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10128"]) and arg_178_1.var_.actorSpriteComps10128 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps10128 = nil
			end

			local var_181_2 = arg_178_1.actors_["1034"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps1034 == nil then
				arg_178_1.var_.actorSpriteComps1034 = var_181_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_3 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.actorSpriteComps1034 then
					for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_181_5 then
							if arg_178_1.isInRecall_ then
								iter_181_5.color = Color.New(Mathf.Lerp(iter_181_5.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_3), Mathf.Lerp(iter_181_5.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_3), (Mathf.Lerp(iter_181_5.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_3)))
							else
								local var_181_4 = Mathf.Lerp(iter_181_5.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_3)

								iter_181_5.color = Color.New(var_181_4, var_181_4, var_181_4)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps1034 then
				for iter_181_6, iter_181_7 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_181_7 then
						iter_181_7.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps1034 = nil
			end

			local var_181_5 = 0
			local var_181_6 = 1.425

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_7 = arg_178_1:GetWordFromCfg(417041043)
				local var_181_8 = arg_178_1:FormatText(var_181_7.content)

				arg_178_1.text_.text = var_181_8

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_10 = 57 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_8) / 57)

				if (57 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_8) / 57)) > 0 and var_181_6 < var_181_10 then
					arg_178_1.talkMaxDuration = var_181_10

					if var_181_10 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_5
					end
				end

				arg_178_1.text_.text = var_181_8
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041043", "story_v_out_417041.awb") ~= 0 then
					local var_181_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041043", "story_v_out_417041.awb") / 1000

					if var_181_11 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_5
					end

					if var_181_7.prefab_name ~= "" and arg_178_1.actors_[var_181_7.prefab_name] ~= nil then
						local var_181_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_7.prefab_name].transform, "story_v_out_417041", "417041043", "story_v_out_417041.awb")

						arg_178_1:RecordAudio("417041043", var_181_12)
						arg_178_1:RecordAudio("417041043", var_181_12)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417041", "417041043", "story_v_out_417041.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417041", "417041043", "story_v_out_417041.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_13 = math.max(var_181_6, arg_178_1.talkMaxDuration)

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_13 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_5) / var_181_13

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_5 + var_181_13 and arg_178_1.time_ < var_181_5 + var_181_13 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play417041044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417041044
		arg_182_1.duration_ = 7.57

		local var_182_0 = {
			zh = 4.833,
			ja = 7.566
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play417041045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10128 = arg_182_1.actors_["10128"].transform.localPosition
				arg_182_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10128", 4)

				for iter_185_0 = 0, arg_182_1.actors_["10128"].transform.childCount - 1 do
					local var_185_0 = arg_182_1.actors_["10128"].transform:GetChild(iter_185_0)

					if var_185_0.name == "split_2" or not string.find(var_185_0.name, "split") then
						var_185_0.gameObject:SetActive(true)
					else
						var_185_0.gameObject:SetActive(false)
					end
				end
			end

			local var_185_1 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_1 then
				arg_182_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_182_1.time_ - 0) / var_185_1)
			end

			if arg_182_1.time_ >= 0 + var_185_1 and arg_182_1.time_ < 0 + var_185_1 + arg_185_0 then
				arg_182_1.actors_["10128"].transform.localPosition = Vector3.New(390, -347, -300)
			end

			local var_185_2 = 0
			local var_185_3 = 0.575

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(417041044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 23 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 23)

				if (23 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 23)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041044", "story_v_out_417041.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041044", "story_v_out_417041.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_417041", "417041044", "story_v_out_417041.awb")

						arg_182_1:RecordAudio("417041044", var_185_9)
						arg_182_1:RecordAudio("417041044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417041", "417041044", "story_v_out_417041.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417041", "417041044", "story_v_out_417041.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play417041045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417041045
		arg_186_1.duration_ = 2.5

		local var_186_0 = {
			zh = 2.5,
			ja = 2.333
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play417041046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10128"]) and arg_186_1.var_.actorSpriteComps10128 == nil then
				arg_186_1.var_.actorSpriteComps10128 = arg_186_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10128"]) then
				if arg_186_1.var_.actorSpriteComps10128 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10128"]) and arg_186_1.var_.actorSpriteComps10128 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps10128 = nil
			end

			local var_189_2 = arg_186_1.actors_["1034"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1034 = var_189_2.localPosition
				var_189_2.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1034", 7)

				for iter_189_4 = 0, var_189_2.childCount - 1 do
					local var_189_3 = var_189_2:GetChild(iter_189_4)

					if var_189_3.name == "split_7" or not string.find(var_189_3.name, "split") then
						var_189_3.gameObject:SetActive(true)
					else
						var_189_3.gameObject:SetActive(false)
					end
				end
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_2.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_186_1.time_ - 0) / var_189_4)
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_189_5 = arg_186_1.actors_["10128"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10128 = var_189_5.localPosition
				var_189_5.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10128", 7)

				for iter_189_5 = 0, var_189_5.childCount - 1 do
					local var_189_6 = var_189_5:GetChild(iter_189_5)

					if var_189_6.name == "split_2" or not string.find(var_189_6.name, "split") then
						var_189_6.gameObject:SetActive(true)
					else
						var_189_6.gameObject:SetActive(false)
					end
				end
			end

			local var_189_7 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_186_1.time_ - 0) / var_189_7)
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_189_8 = 0
			local var_189_9 = 0.25

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_10 = arg_186_1:GetWordFromCfg(417041045)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 10 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 10)

				if (10 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 10)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041045", "story_v_out_417041.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041045", "story_v_out_417041.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_out_417041", "417041045", "story_v_out_417041.awb")

						arg_186_1:RecordAudio("417041045", var_189_15)
						arg_186_1:RecordAudio("417041045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417041", "417041045", "story_v_out_417041.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417041", "417041045", "story_v_out_417041.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play417041046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417041046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417041047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 1.45

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(417041046).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 58 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 58)

				if (58 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 58)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417041047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417041047
		arg_194_1.duration_ = 5.33

		local var_194_0 = {
			zh = 2.533,
			ja = 5.333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417041048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1034"]) and arg_194_1.var_.actorSpriteComps1034 == nil then
				arg_194_1.var_.actorSpriteComps1034 = arg_194_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1034"]) then
				if arg_194_1.var_.actorSpriteComps1034 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 1, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1034"]) and arg_194_1.var_.actorSpriteComps1034 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps1034 = nil
			end

			local var_197_2 = arg_194_1.actors_["1034"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034 = var_197_2.localPosition
				var_197_2.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1034", 2)

				for iter_197_4 = 0, var_197_2.childCount - 1 do
					local var_197_3 = var_197_2:GetChild(iter_197_4)

					if var_197_3.name == "split_7" or not string.find(var_197_3.name, "split") then
						var_197_3.gameObject:SetActive(true)
					else
						var_197_3.gameObject:SetActive(false)
					end
				end
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_2.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_194_1.time_ - 0) / var_197_4)
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_197_5 = 0
			local var_197_6 = 0.35

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:GetWordFromCfg(417041047)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 14 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 14)

				if (14 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 14)) > 0 and var_197_6 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10

					if var_197_10 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041047", "story_v_out_417041.awb") ~= 0 then
					local var_197_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041047", "story_v_out_417041.awb") / 1000

					if var_197_11 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_5
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_out_417041", "417041047", "story_v_out_417041.awb")

						arg_194_1:RecordAudio("417041047", var_197_12)
						arg_194_1:RecordAudio("417041047", var_197_12)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417041", "417041047", "story_v_out_417041.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417041", "417041047", "story_v_out_417041.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_13 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_13 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_13

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_13 and arg_194_1.time_ < var_197_5 + var_197_13 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play417041048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417041048
		arg_198_1.duration_ = 9.83

		local var_198_0 = {
			zh = 8.3,
			ja = 9.833
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417041049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10128"]) and arg_198_1.var_.actorSpriteComps10128 == nil then
				arg_198_1.var_.actorSpriteComps10128 = arg_198_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10128"]) then
				if arg_198_1.var_.actorSpriteComps10128 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10128"]) and arg_198_1.var_.actorSpriteComps10128 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps10128 = nil
			end

			local var_201_2 = arg_198_1.actors_["1034"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								iter_201_5.color = Color.New(Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_5.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_5.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_7 then
						iter_201_7.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_5 = arg_198_1.actors_["10128"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10128 = var_201_5.localPosition
				var_201_5.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10128", 4)

				for iter_201_8 = 0, var_201_5.childCount - 1 do
					local var_201_6 = var_201_5:GetChild(iter_201_8)

					if var_201_6.name == "split_2" or not string.find(var_201_6.name, "split") then
						var_201_6.gameObject:SetActive(true)
					else
						var_201_6.gameObject:SetActive(false)
					end
				end
			end

			local var_201_7 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				var_201_5.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_198_1.time_ - 0) / var_201_7)
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				var_201_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_201_8 = 0
			local var_201_9 = 0.975

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(417041048)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 39 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 39)

				if (39 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 39)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041048", "story_v_out_417041.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041048", "story_v_out_417041.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_417041", "417041048", "story_v_out_417041.awb")

						arg_198_1:RecordAudio("417041048", var_201_15)
						arg_198_1:RecordAudio("417041048", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417041", "417041048", "story_v_out_417041.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417041", "417041048", "story_v_out_417041.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play417041049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417041049
		arg_202_1.duration_ = 3.5

		local var_202_0 = {
			zh = 3.266,
			ja = 3.5
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
				arg_202_0:Play417041050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10128"]) and arg_202_1.var_.actorSpriteComps10128 == nil then
				arg_202_1.var_.actorSpriteComps10128 = arg_202_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10128"]) then
				if arg_202_1.var_.actorSpriteComps10128 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10128"]) and arg_202_1.var_.actorSpriteComps10128 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps10128 = nil
			end

			local var_205_2 = 0
			local var_205_3 = 0.35

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_4 = arg_202_1:GetWordFromCfg(417041049)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 14 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 14)

				if (14 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 14)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041049", "story_v_out_417041.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041049", "story_v_out_417041.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_out_417041", "417041049", "story_v_out_417041.awb")

						arg_202_1:RecordAudio("417041049", var_205_9)
						arg_202_1:RecordAudio("417041049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417041", "417041049", "story_v_out_417041.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417041", "417041049", "story_v_out_417041.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417041050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417041050
		arg_206_1.duration_ = 6.2

		local var_206_0 = {
			zh = 2.2,
			ja = 6.2
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
				arg_206_0:Play417041051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1034"]) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = arg_206_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1034"]) then
				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1034"]) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_2 = arg_206_1.actors_["1034"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_2.localPosition
				var_209_2.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 2)

				for iter_209_4 = 0, var_209_2.childCount - 1 do
					local var_209_3 = var_209_2:GetChild(iter_209_4)

					if var_209_3.name == "split_4" or not string.find(var_209_3.name, "split") then
						var_209_3.gameObject:SetActive(true)
					else
						var_209_3.gameObject:SetActive(false)
					end
				end
			end

			local var_209_4 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				var_209_2.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_206_1.time_ - 0) / var_209_4)
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				var_209_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_209_5 = 0
			local var_209_6 = 0.3

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_7 = arg_206_1:GetWordFromCfg(417041050)
				local var_209_8 = arg_206_1:FormatText(var_209_7.content)

				arg_206_1.text_.text = var_209_8

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_10 = 12 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 12)

				if (12 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 12)) > 0 and var_209_6 < var_209_10 then
					arg_206_1.talkMaxDuration = var_209_10

					if var_209_10 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_8
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041050", "story_v_out_417041.awb") ~= 0 then
					local var_209_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041050", "story_v_out_417041.awb") / 1000

					if var_209_11 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_5
					end

					if var_209_7.prefab_name ~= "" and arg_206_1.actors_[var_209_7.prefab_name] ~= nil then
						local var_209_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_7.prefab_name].transform, "story_v_out_417041", "417041050", "story_v_out_417041.awb")

						arg_206_1:RecordAudio("417041050", var_209_12)
						arg_206_1:RecordAudio("417041050", var_209_12)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417041", "417041050", "story_v_out_417041.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417041", "417041050", "story_v_out_417041.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_13 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_13 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_13

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_13 and arg_206_1.time_ < var_209_5 + var_209_13 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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
	Play417041051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417041051
		arg_210_1.duration_ = 5.4

		local var_210_0 = {
			zh = 5.4,
			ja = 4.7
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
				arg_210_0:Play417041052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10128"]) and arg_210_1.var_.actorSpriteComps10128 == nil then
				arg_210_1.var_.actorSpriteComps10128 = arg_210_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10128"]) then
				if arg_210_1.var_.actorSpriteComps10128 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10128"]) and arg_210_1.var_.actorSpriteComps10128 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10128 = nil
			end

			local var_213_2 = arg_210_1.actors_["1034"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_5 = 0
			local var_213_6 = 0.625

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:GetWordFromCfg(417041051)
				local var_213_8 = arg_210_1:FormatText(var_213_7.content)

				arg_210_1.text_.text = var_213_8

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 25 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 25)

				if (25 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 25)) > 0 and var_213_6 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_8
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041051", "story_v_out_417041.awb") ~= 0 then
					local var_213_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041051", "story_v_out_417041.awb") / 1000

					if var_213_11 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_11 + var_213_5
					end

					if var_213_7.prefab_name ~= "" and arg_210_1.actors_[var_213_7.prefab_name] ~= nil then
						local var_213_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_7.prefab_name].transform, "story_v_out_417041", "417041051", "story_v_out_417041.awb")

						arg_210_1:RecordAudio("417041051", var_213_12)
						arg_210_1:RecordAudio("417041051", var_213_12)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417041", "417041051", "story_v_out_417041.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417041", "417041051", "story_v_out_417041.awb")
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
	Play417041052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417041052
		arg_214_1.duration_ = 10.33

		local var_214_0 = {
			zh = 6.533,
			ja = 10.333
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
				arg_214_0:Play417041053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.825

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:GetWordFromCfg(417041052)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 33 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 33)

				if (33 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 33)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041052", "story_v_out_417041.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041052", "story_v_out_417041.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_417041", "417041052", "story_v_out_417041.awb")

						arg_214_1:RecordAudio("417041052", var_217_6)
						arg_214_1:RecordAudio("417041052", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417041", "417041052", "story_v_out_417041.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417041", "417041052", "story_v_out_417041.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417041053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417041053
		arg_218_1.duration_ = 3.6

		local var_218_0 = {
			zh = 2.833,
			ja = 3.6
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
				arg_218_0:Play417041054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10128"]) and arg_218_1.var_.actorSpriteComps10128 == nil then
				arg_218_1.var_.actorSpriteComps10128 = arg_218_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10128"]) then
				if arg_218_1.var_.actorSpriteComps10128 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10128"]) and arg_218_1.var_.actorSpriteComps10128 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps10128 = nil
			end

			if 0.325 < arg_218_1.time_ and arg_218_1.time_ <= 0.325 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun_load", "")
			end

			local var_221_3 = 0
			local var_221_4 = 0.325

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_3 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_5 = arg_218_1:GetWordFromCfg(417041053)
				local var_221_6 = arg_218_1:FormatText(var_221_5.content)

				arg_218_1.text_.text = var_221_6

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_8 = 13 <= 0 and var_221_4 or var_221_4 * (utf8.len(var_221_6) / 13)

				if (13 <= 0 and var_221_4 or var_221_4 * (utf8.len(var_221_6) / 13)) > 0 and var_221_4 < var_221_8 then
					arg_218_1.talkMaxDuration = var_221_8

					if var_221_8 + var_221_3 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_3
					end
				end

				arg_218_1.text_.text = var_221_6
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041053", "story_v_out_417041.awb") ~= 0 then
					local var_221_9 = manager.audio:GetVoiceLength("story_v_out_417041", "417041053", "story_v_out_417041.awb") / 1000

					if var_221_9 + var_221_3 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_3
					end

					if var_221_5.prefab_name ~= "" and arg_218_1.actors_[var_221_5.prefab_name] ~= nil then
						local var_221_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_5.prefab_name].transform, "story_v_out_417041", "417041053", "story_v_out_417041.awb")

						arg_218_1:RecordAudio("417041053", var_221_10)
						arg_218_1:RecordAudio("417041053", var_221_10)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417041", "417041053", "story_v_out_417041.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417041", "417041053", "story_v_out_417041.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_11 = math.max(var_221_4, arg_218_1.talkMaxDuration)

			if var_221_3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_3 + var_221_11 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_3) / var_221_11

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_3 + var_221_11 and arg_218_1.time_ < var_221_3 + var_221_11 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417041054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417041054
		arg_222_1.duration_ = 5.5

		local var_222_0 = {
			zh = 2.333,
			ja = 5.5
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
				arg_222_0:Play417041055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1034"]) and arg_222_1.var_.actorSpriteComps1034 == nil then
				arg_222_1.var_.actorSpriteComps1034 = arg_222_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1034"]) then
				if arg_222_1.var_.actorSpriteComps1034 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1034"]) and arg_222_1.var_.actorSpriteComps1034 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps1034 = nil
			end

			local var_225_2 = arg_222_1.actors_["1034"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1034 = var_225_2.localPosition
				var_225_2.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1034", 2)

				for iter_225_4 = 0, var_225_2.childCount - 1 do
					local var_225_3 = var_225_2:GetChild(iter_225_4)

					if var_225_3.name == "split_6" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_2.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_222_1.time_ - 0) / var_225_4)
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_225_5 = 0
			local var_225_6 = 0.325

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:GetWordFromCfg(417041054)
				local var_225_8 = arg_222_1:FormatText(var_225_7.content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 13 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 13)

				if (13 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 13)) > 0 and var_225_6 < var_225_10 then
					arg_222_1.talkMaxDuration = var_225_10

					if var_225_10 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041054", "story_v_out_417041.awb") ~= 0 then
					local var_225_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041054", "story_v_out_417041.awb") / 1000

					if var_225_11 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_5
					end

					if var_225_7.prefab_name ~= "" and arg_222_1.actors_[var_225_7.prefab_name] ~= nil then
						local var_225_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_7.prefab_name].transform, "story_v_out_417041", "417041054", "story_v_out_417041.awb")

						arg_222_1:RecordAudio("417041054", var_225_12)
						arg_222_1:RecordAudio("417041054", var_225_12)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417041", "417041054", "story_v_out_417041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417041", "417041054", "story_v_out_417041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_13 and arg_222_1.time_ < var_225_5 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play417041055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417041055
		arg_226_1.duration_ = 5.5

		local var_226_0 = {
			zh = 4.133,
			ja = 5.5
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
				arg_226_0:Play417041056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10128"]) and arg_226_1.var_.actorSpriteComps10128 == nil then
				arg_226_1.var_.actorSpriteComps10128 = arg_226_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10128"]) then
				if arg_226_1.var_.actorSpriteComps10128 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10128"]) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_2 = arg_226_1.actors_["1034"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1034 == nil then
				arg_226_1.var_.actorSpriteComps1034 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps1034 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								iter_229_5.color = Color.New(Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_5.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_5.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1034 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps1034 = nil
			end

			local var_229_5 = 0
			local var_229_6 = 0.5

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_7 = arg_226_1:GetWordFromCfg(417041055)
				local var_229_8 = arg_226_1:FormatText(var_229_7.content)

				arg_226_1.text_.text = var_229_8

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 20 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 20)

				if (20 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 20)) > 0 and var_229_6 < var_229_10 then
					arg_226_1.talkMaxDuration = var_229_10

					if var_229_10 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_8
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041055", "story_v_out_417041.awb") ~= 0 then
					local var_229_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041055", "story_v_out_417041.awb") / 1000

					if var_229_11 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_5
					end

					if var_229_7.prefab_name ~= "" and arg_226_1.actors_[var_229_7.prefab_name] ~= nil then
						local var_229_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_7.prefab_name].transform, "story_v_out_417041", "417041055", "story_v_out_417041.awb")

						arg_226_1:RecordAudio("417041055", var_229_12)
						arg_226_1:RecordAudio("417041055", var_229_12)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417041", "417041055", "story_v_out_417041.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417041", "417041055", "story_v_out_417041.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_13 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_13 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_13

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_13 and arg_226_1.time_ < var_229_5 + var_229_13 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417041056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417041056
		arg_230_1.duration_ = 5.77

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417041057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_9001
			local var_233_9000

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10128"]) and arg_230_1.var_.actorSpriteComps10128 == nil then
				arg_230_1.var_.actorSpriteComps10128 = arg_230_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10128"]) then
				if arg_230_1.var_.actorSpriteComps10128 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10128"]) and arg_230_1.var_.actorSpriteComps10128 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10128 = nil
			end

			local var_233_2 = arg_230_1.actors_["1034"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1034 = var_233_2.localPosition
				var_233_2.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1034", 7)

				for iter_233_4 = 0, var_233_2.childCount - 1 do
					local var_233_3 = var_233_2:GetChild(iter_233_4)

					if var_233_3.name == "" or not string.find(var_233_3.name, "split") then
						var_233_3.gameObject:SetActive(true)
					else
						var_233_3.gameObject:SetActive(false)
					end
				end
			end

			local var_233_4 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				var_233_2.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_230_1.time_ - 0) / var_233_4)
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				var_233_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_233_5 = arg_230_1.actors_["10128"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10128 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10128", 7)

				for iter_233_5 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_5)

					if var_233_6.name == "" or not string.find(var_233_6.name, "split") then
						var_233_6.gameObject:SetActive(true)
					else
						var_233_6.gameObject:SetActive(false)
					end
				end
			end

			local var_233_7 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_230_1.time_ - 0) / var_233_7)
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				local var_233_8 = arg_230_1.var_.effect744

				if not arg_230_1.var_.effect744 then
					var_233_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_233_8.name = "744"
					arg_230_1.var_.effect744 = var_233_8
				else
					var_233_8.transform:SetParent(var_233_9001)
				end

				var_233_8.transform.localPosition = Vector3.New(0, -0.1, 0)
				var_233_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_233_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_233_6, iter_233_7 in ipairs((var_233_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_233_7.transform.localScale = Vector3.New(iter_233_7.transform.localScale.x / var_233_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_233_7.transform.localScale.y / var_233_10, iter_233_7.transform.localScale.z)
				end
			end

			if 0.3 < arg_230_1.time_ and arg_230_1.time_ <= 0.3 + arg_233_0 then
				if arg_230_1.var_.effect744 then
					Object.Destroy(arg_230_1.var_.effect744)

					arg_230_1.var_.effect744 = nil
				end
			end

			if 0.2 < arg_230_1.time_ and arg_230_1.time_ <= 0.2 + arg_233_0 then
				local var_233_13 = arg_230_1.var_.effect498

				if not arg_230_1.var_.effect498 then
					var_233_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_233_13.name = "498"
					arg_230_1.var_.effect498 = var_233_13
				else
					var_233_13.transform:SetParent(var_233_9000)
				end

				var_233_13.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_233_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_233_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_233_8, iter_233_9 in ipairs((var_233_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_233_9.transform.localScale = Vector3.New(iter_233_9.transform.localScale.x / var_233_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_233_9.transform.localScale.y / var_233_15, iter_233_9.transform.localScale.z)
				end
			end

			if 0.0333333333333333 < arg_230_1.time_ and arg_230_1.time_ <= 0.0333333333333333 + arg_233_0 then
				arg_230_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_attact02", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_18 = 0.766666666666667
			local var_233_19 = 1.575

			if 0.766666666666667 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_20 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_20:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_21 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(417041056).content)

				arg_230_1.text_.text = var_233_21

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_23 = 63 <= 0 and var_233_19 or var_233_19 * (utf8.len(var_233_21) / 63)

				if (63 <= 0 and var_233_19 or var_233_19 * (utf8.len(var_233_21) / 63)) > 0 and var_233_19 < var_233_23 then
					arg_230_1.talkMaxDuration = var_233_23
					var_233_18 = var_233_18 + 0.3

					if var_233_23 + var_233_18 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_23 + var_233_18
					end
				end

				arg_230_1.text_.text = var_233_21
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_24 = var_233_18 + 0.3
			local var_233_25 = math.max(var_233_19, arg_230_1.talkMaxDuration)

			if var_233_18 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_24 + var_233_25 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_24) / var_233_25

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_24 + var_233_25 and arg_230_1.time_ < var_233_24 + var_233_25 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play417041057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417041057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417041058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				if arg_236_1.var_.effect498 then
					Object.Destroy(arg_236_1.var_.effect498)

					arg_236_1.var_.effect498 = nil
				end
			end

			if 1.4 < arg_236_1.time_ and arg_236_1.time_ <= 1.4 + arg_239_0 then
				arg_236_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_hit02", "")
			end

			local var_239_2 = 0
			local var_239_3 = 1.675

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_4 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(417041057).content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_6 = 67 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 67)

				if (67 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 67)) > 0 and var_239_3 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_7 and arg_236_1.time_ < var_239_2 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417041058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417041058
		arg_240_1.duration_ = 5.68

		local var_240_0 = {
			zh = 4.75,
			ja = 5.683
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
				arg_240_0:Play417041059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if arg_240_1.bgs_.D10 == nil then
				local var_243_0 = Object.Instantiate(arg_240_1.paintGo_)

				var_243_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_243_0.name = "D10"
				var_243_0.transform.parent = arg_240_1.stage_.transform
				var_243_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.bgs_.D10 = var_243_0
			end

			if 1.8 < arg_240_1.time_ and arg_240_1.time_ <= 1.8 + arg_243_0 then
				local var_243_1 = arg_240_1.bgs_.D10

				arg_240_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_243_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_243_2 = var_243_1:GetComponent("SpriteRenderer")

				if var_243_2 and var_243_2.sprite then
					local var_243_3 = 2 * (var_243_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_243_1.transform.localScale = Vector3.New(var_243_3 / var_243_2.sprite.bounds.size.y < var_243_3 * manager.ui.mainCameraCom_.aspect / var_243_2.sprite.bounds.size.x and var_243_3 * manager.ui.mainCameraCom_.aspect / var_243_2.sprite.bounds.size.x or var_243_3 / var_243_2.sprite.bounds.size.y, var_243_3 / var_243_2.sprite.bounds.size.y < var_243_3 * manager.ui.mainCameraCom_.aspect / var_243_2.sprite.bounds.size.x and var_243_3 * manager.ui.mainCameraCom_.aspect / var_243_2.sprite.bounds.size.x or var_243_3 / var_243_2.sprite.bounds.size.y, 0)
				end

				for iter_243_0, iter_243_1 in pairs(arg_240_1.bgs_) do
					if iter_243_0 ~= "D10" then
						iter_243_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_243_4 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			if arg_240_1.time_ >= var_243_4 + 0.3 and arg_240_1.time_ < var_243_4 + 0.3 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			local var_243_5 = 0

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_6 = 1.8

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_6 then
				local var_243_7 = Color.New(0, 0, 0)

				var_243_7.a = Mathf.Lerp(0, 1, (arg_240_1.time_ - var_243_5) / var_243_6)
				arg_240_1.mask_.color = var_243_7
			end

			if arg_240_1.time_ >= var_243_5 + var_243_6 and arg_240_1.time_ < var_243_5 + var_243_6 + arg_243_0 then
				local var_243_8 = Color.New(0, 0, 0)

				var_243_8.a = 1
				arg_240_1.mask_.color = var_243_8
			end

			local var_243_9 = 1.8

			if 1.8 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_10 = 1.8

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_10 then
				local var_243_11 = Color.New(0, 0, 0)

				var_243_11.a = Mathf.Lerp(1, 0, (arg_240_1.time_ - var_243_9) / var_243_10)
				arg_240_1.mask_.color = var_243_11
			end

			if arg_240_1.time_ >= var_243_9 + var_243_10 and arg_240_1.time_ < var_243_9 + var_243_10 + arg_243_0 then
				local var_243_12 = Color.New(0, 0, 0)

				arg_240_1.mask_.enabled = false
				var_243_12.a = 0
				arg_240_1.mask_.color = var_243_12
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_13 = 3.45
			local var_243_14 = 0.15

			if 3.45 < arg_240_1.time_ and arg_240_1.time_ <= var_243_13 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_15 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_15:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_16 = arg_240_1:GetWordFromCfg(417041058)
				local var_243_17 = arg_240_1:FormatText(var_243_16.content)

				arg_240_1.text_.text = var_243_17

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_19 = 6 <= 0 and var_243_14 or var_243_14 * (utf8.len(var_243_17) / 6)

				if (6 <= 0 and var_243_14 or var_243_14 * (utf8.len(var_243_17) / 6)) > 0 and var_243_14 < var_243_19 then
					arg_240_1.talkMaxDuration = var_243_19
					var_243_13 = var_243_13 + 0.3

					if var_243_19 + var_243_13 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_19 + var_243_13
					end
				end

				arg_240_1.text_.text = var_243_17
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041058", "story_v_out_417041.awb") ~= 0 then
					local var_243_20 = manager.audio:GetVoiceLength("story_v_out_417041", "417041058", "story_v_out_417041.awb") / 1000

					if var_243_20 + var_243_13 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_20 + var_243_13
					end

					if var_243_16.prefab_name ~= "" and arg_240_1.actors_[var_243_16.prefab_name] ~= nil then
						local var_243_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_16.prefab_name].transform, "story_v_out_417041", "417041058", "story_v_out_417041.awb")

						arg_240_1:RecordAudio("417041058", var_243_21)
						arg_240_1:RecordAudio("417041058", var_243_21)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417041", "417041058", "story_v_out_417041.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417041", "417041058", "story_v_out_417041.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_22 = var_243_13 + 0.3
			local var_243_23 = math.max(var_243_14, arg_240_1.talkMaxDuration)

			if var_243_13 + 0.3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_22 + var_243_23 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_22) / var_243_23

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_22 + var_243_23 and arg_240_1.time_ < var_243_22 + var_243_23 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417041059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417041059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417041060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1034"]) and arg_246_1.var_.actorSpriteComps1034 == nil then
				arg_246_1.var_.actorSpriteComps1034 = arg_246_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1034"]) then
				if arg_246_1.var_.actorSpriteComps1034 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1034"]) and arg_246_1.var_.actorSpriteComps1034 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps1034 = nil
			end

			local var_249_2 = 0
			local var_249_3 = 0.9

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(417041059).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 36 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 36)

				if (36 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 36)) > 0 and var_249_3 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_7 and arg_246_1.time_ < var_249_2 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417041060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417041060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417041061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 1.65

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(417041060).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 66 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 66)

				if (66 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 66)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play417041061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417041061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417041062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0.233333333333333 < arg_254_1.time_ and arg_254_1.time_ <= 0.233333333333333 + arg_257_0 then
				arg_254_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_machine01", "")
			end

			local var_257_1 = 0
			local var_257_2 = 1.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(417041061).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 56 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 56)

				if (56 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 56)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417041062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417041062
		arg_258_1.duration_ = 4

		local var_258_0 = {
			zh = 2.266,
			ja = 4
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417041063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.25

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_5")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:GetWordFromCfg(417041062)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 10 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 10)

				if (10 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 10)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041062", "story_v_out_417041.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041062", "story_v_out_417041.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_417041", "417041062", "story_v_out_417041.awb")

						arg_258_1:RecordAudio("417041062", var_261_6)
						arg_258_1:RecordAudio("417041062", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417041", "417041062", "story_v_out_417041.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417041", "417041062", "story_v_out_417041.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play417041063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 417041063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play417041064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.525

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(417041063).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 61 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 61)

				if (61 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 61)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play417041064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 417041064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play417041065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0.05 < arg_266_1.time_ and arg_266_1.time_ <= 0.05 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_scan", "")
			end

			local var_269_1 = 0
			local var_269_2 = 1.175

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(417041064).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 47 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 47)

				if (47 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 47)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play417041065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417041065
		arg_270_1.duration_ = 5.53

		local var_270_0 = {
			zh = 5.1,
			ja = 5.533
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417041066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.55

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1121].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:GetWordFromCfg(417041065)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 22 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 22)

				if (22 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 22)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041065", "story_v_out_417041.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041065", "story_v_out_417041.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_417041", "417041065", "story_v_out_417041.awb")

						arg_270_1:RecordAudio("417041065", var_273_6)
						arg_270_1:RecordAudio("417041065", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417041", "417041065", "story_v_out_417041.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417041", "417041065", "story_v_out_417041.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play417041066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417041066
		arg_274_1.duration_ = 2

		local var_274_0 = {
			zh = 1.633,
			ja = 2
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417041067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.125

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:GetWordFromCfg(417041066)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 5 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 5)

				if (5 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 5)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041066", "story_v_out_417041.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041066", "story_v_out_417041.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_417041", "417041066", "story_v_out_417041.awb")

						arg_274_1:RecordAudio("417041066", var_277_6)
						arg_274_1:RecordAudio("417041066", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_417041", "417041066", "story_v_out_417041.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_417041", "417041066", "story_v_out_417041.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417041067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417041067
		arg_278_1.duration_ = 5.8

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417041068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_9000

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_0 = 0.266666666666667

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				local var_281_1 = Color.New(1, 1, 1)

				var_281_1.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.mask_.color = var_281_1
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				local var_281_2 = Color.New(1, 1, 1)

				arg_278_1.mask_.enabled = false
				var_281_2.a = 0
				arg_278_1.mask_.color = var_281_2
			end

			if 0.166666666666667 < arg_278_1.time_ and arg_278_1.time_ <= 0.166666666666667 + arg_281_0 then
				local var_281_3 = arg_278_1.var_.effect321

				if not arg_278_1.var_.effect321 then
					var_281_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_281_3.name = "321"
					arg_278_1.var_.effect321 = var_281_3
				else
					var_281_3.transform:SetParent(var_281_9000)
				end

				var_281_3.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_281_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_281_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_281_0, iter_281_1 in ipairs((var_281_3.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_281_1.transform.localScale = Vector3.New(iter_281_1.transform.localScale.x / var_281_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_281_1.transform.localScale.y / var_281_5, iter_281_1.transform.localScale.z)
				end
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_machine02", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_8 = 0.8
			local var_281_9 = 1.4

			if 0.8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_10 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_10:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_11 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(417041067).content)

				arg_278_1.text_.text = var_281_11

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 56 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 56)

				if (56 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 56)) > 0 and var_281_9 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13
					var_281_8 = var_281_8 + 0.3

					if var_281_13 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_11
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_14 = var_281_8 + 0.3
			local var_281_15 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_14 + var_281_15 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_14) / var_281_15

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_14 + var_281_15 and arg_278_1.time_ < var_281_14 + var_281_15 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play417041068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417041068
		arg_284_1.duration_ = 5.67

		local var_284_0 = {
			zh = 4.2,
			ja = 5.666
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
				arg_284_0:Play417041069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.275

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1121].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(417041068)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 11 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 11)

				if (11 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 11)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041068", "story_v_out_417041.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041068", "story_v_out_417041.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_417041", "417041068", "story_v_out_417041.awb")

						arg_284_1:RecordAudio("417041068", var_287_6)
						arg_284_1:RecordAudio("417041068", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_417041", "417041068", "story_v_out_417041.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_417041", "417041068", "story_v_out_417041.awb")
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
	Play417041069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417041069
		arg_288_1.duration_ = 2.97

		local var_288_0 = {
			zh = 2.9,
			ja = 2.966
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
				arg_288_0:Play417041070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1034"]) and arg_288_1.var_.actorSpriteComps1034 == nil then
				arg_288_1.var_.actorSpriteComps1034 = arg_288_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_0 = 0.2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1034"]) then
				if arg_288_1.var_.actorSpriteComps1034 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								iter_291_1.color = Color.New(Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor1.r, (arg_288_1.time_ - 0) / var_291_0), Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor1.g, (arg_288_1.time_ - 0) / var_291_0), (Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor1.b, (arg_288_1.time_ - 0) / var_291_0)))
							else
								local var_291_1 = Mathf.Lerp(iter_291_1.color.r, 1, (arg_288_1.time_ - 0) / var_291_0)

								iter_291_1.color = Color.New(var_291_1, var_291_1, var_291_1)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1034"]) and arg_288_1.var_.actorSpriteComps1034 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_291_3 then
						iter_291_3.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps1034 = nil
			end

			local var_291_2 = 0
			local var_291_3 = 0.05

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_4 = arg_288_1:GetWordFromCfg(417041069)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 2 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 2)

				if (2 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 2)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041069", "story_v_out_417041.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041069", "story_v_out_417041.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_out_417041", "417041069", "story_v_out_417041.awb")

						arg_288_1:RecordAudio("417041069", var_291_9)
						arg_288_1:RecordAudio("417041069", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_417041", "417041069", "story_v_out_417041.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_417041", "417041069", "story_v_out_417041.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417041070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417041070
		arg_292_1.duration_ = 5.63

		local var_292_0 = {
			zh = 5.26666666666667,
			ja = 5.63266666666667
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417041071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_9000

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1034"]) and arg_292_1.var_.actorSpriteComps1034 == nil then
				arg_292_1.var_.actorSpriteComps1034 = arg_292_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1034"]) then
				if arg_292_1.var_.actorSpriteComps1034 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1034"]) and arg_292_1.var_.actorSpriteComps1034 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_292_1.var_.actorSpriteComps1034 = nil
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				local var_295_2 = arg_292_1.var_.effect777

				if not arg_292_1.var_.effect777 then
					var_295_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_295_2.name = "777"
					arg_292_1.var_.effect777 = var_295_2
				else
					var_295_2.transform:SetParent(var_295_9000)
				end

				var_295_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_295_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_295_4 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_295_4, iter_295_5 in ipairs((var_295_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_295_5.transform.localScale = Vector3.New(iter_295_5.transform.localScale.x / var_295_4 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_295_5.transform.localScale.y / var_295_4, iter_295_5.transform.localScale.z)
				end
			end

			if 1.16666666666667 < arg_292_1.time_ and arg_292_1.time_ <= 1.16666666666667 + arg_295_0 then
				if arg_292_1.var_.effect777 then
					Object.Destroy(arg_292_1.var_.effect777)

					arg_292_1.var_.effect777 = nil
				end
			end

			if 0.05 < arg_292_1.time_ and arg_292_1.time_ <= 0.05 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_8 = 0.466666666666667
			local var_295_9 = 0.3

			if 0.466666666666667 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_10 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_10:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1121].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_11 = arg_292_1:GetWordFromCfg(417041070)
				local var_295_12 = arg_292_1:FormatText(var_295_11.content)

				arg_292_1.text_.text = var_295_12

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_14 = 12 <= 0 and var_295_9 or var_295_9 * (utf8.len(var_295_12) / 12)

				if (12 <= 0 and var_295_9 or var_295_9 * (utf8.len(var_295_12) / 12)) > 0 and var_295_9 < var_295_14 then
					arg_292_1.talkMaxDuration = var_295_14
					var_295_8 = var_295_8 + 0.3

					if var_295_14 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_14 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_12
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041070", "story_v_out_417041.awb") ~= 0 then
					local var_295_15 = manager.audio:GetVoiceLength("story_v_out_417041", "417041070", "story_v_out_417041.awb") / 1000

					if var_295_15 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_15 + var_295_8
					end

					if var_295_11.prefab_name ~= "" and arg_292_1.actors_[var_295_11.prefab_name] ~= nil then
						local var_295_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_11.prefab_name].transform, "story_v_out_417041", "417041070", "story_v_out_417041.awb")

						arg_292_1:RecordAudio("417041070", var_295_16)
						arg_292_1:RecordAudio("417041070", var_295_16)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_417041", "417041070", "story_v_out_417041.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_417041", "417041070", "story_v_out_417041.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_17 = var_295_8 + 0.3
			local var_295_18 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 + 0.3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_17 + var_295_18 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_17) / var_295_18

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_17 + var_295_18 and arg_292_1.time_ < var_295_17 + var_295_18 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417041071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417041071
		arg_298_1.duration_ = 4.23

		local var_298_0 = {
			zh = 4.06633333333333,
			ja = 4.23333333333333
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417041072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_0 = 1.16666666666667

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				local var_301_1 = Color.New(0, 0, 0)

				var_301_1.a = Mathf.Lerp(0, 1, (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.mask_.color = var_301_1
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				local var_301_2 = Color.New(0, 0, 0)

				var_301_2.a = 1
				arg_298_1.mask_.color = var_301_2
			end

			local var_301_3 = 1.16666666666667

			if 1.16666666666667 < arg_298_1.time_ and arg_298_1.time_ <= var_301_3 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_4 = 1.46666666666667

			if var_301_3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_3 + var_301_4 then
				local var_301_5 = Color.New(0, 0, 0)

				var_301_5.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_3) / var_301_4)
				arg_298_1.mask_.color = var_301_5
			end

			if arg_298_1.time_ >= var_301_3 + var_301_4 and arg_298_1.time_ < var_301_3 + var_301_4 + arg_301_0 then
				local var_301_6 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_6.a = 0
				arg_298_1.mask_.color = var_301_6
			end

			local var_301_7 = "STblack"

			if arg_298_1.bgs_.STblack == nil then
				local var_301_8 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_301_7)
				var_301_8.name = var_301_7
				var_301_8.transform.parent = arg_298_1.stage_.transform
				var_301_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_[var_301_7] = var_301_8
			end

			if 1.16666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 1.16666666666667 + arg_301_0 then
				local var_301_9 = arg_298_1.bgs_.STblack

				arg_298_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_301_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_10 = var_301_9:GetComponent("SpriteRenderer")

				if var_301_10 and var_301_10.sprite then
					local var_301_11 = 2 * (var_301_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_301_9.transform.localScale = Vector3.New(var_301_11 / var_301_10.sprite.bounds.size.y < var_301_11 * manager.ui.mainCameraCom_.aspect / var_301_10.sprite.bounds.size.x and var_301_11 * manager.ui.mainCameraCom_.aspect / var_301_10.sprite.bounds.size.x or var_301_11 / var_301_10.sprite.bounds.size.y, var_301_11 / var_301_10.sprite.bounds.size.y < var_301_11 * manager.ui.mainCameraCom_.aspect / var_301_10.sprite.bounds.size.x and var_301_11 * manager.ui.mainCameraCom_.aspect / var_301_10.sprite.bounds.size.x or var_301_11 / var_301_10.sprite.bounds.size.y, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "STblack" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.166666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 0.166666666666667 + arg_301_0 then
				arg_298_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_machine02", "")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_301_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_15 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_15

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_15
						arg_298_1.bgmTxt2_.text = var_301_15
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_298_1.time_ and arg_298_1.time_ <= 0.333333333333333 + arg_301_0 then
				arg_298_1:AudioAction("stop", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_301_18 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_18 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_18

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_18
						arg_298_1.bgmTxt2_.text = var_301_18
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_19 = 2.63333333333333
			local var_301_20 = 0.125

			if 2.63333333333333 < arg_298_1.time_ and arg_298_1.time_ <= var_301_19 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_21 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_21:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_298_1.dialogCg_.alpha = arg_304_0
				end))
				var_301_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_22 = arg_298_1:GetWordFromCfg(417041071)
				local var_301_23 = arg_298_1:FormatText(var_301_22.content)

				arg_298_1.text_.text = var_301_23

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_25 = 5 <= 0 and var_301_20 or var_301_20 * (utf8.len(var_301_23) / 5)

				if (5 <= 0 and var_301_20 or var_301_20 * (utf8.len(var_301_23) / 5)) > 0 and var_301_20 < var_301_25 then
					arg_298_1.talkMaxDuration = var_301_25
					var_301_19 = var_301_19 + 0.3

					if var_301_25 + var_301_19 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_25 + var_301_19
					end
				end

				arg_298_1.text_.text = var_301_23
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041071", "story_v_out_417041.awb") ~= 0 then
					local var_301_26 = manager.audio:GetVoiceLength("story_v_out_417041", "417041071", "story_v_out_417041.awb") / 1000

					if var_301_26 + var_301_19 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_26 + var_301_19
					end

					if var_301_22.prefab_name ~= "" and arg_298_1.actors_[var_301_22.prefab_name] ~= nil then
						local var_301_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_22.prefab_name].transform, "story_v_out_417041", "417041071", "story_v_out_417041.awb")

						arg_298_1:RecordAudio("417041071", var_301_27)
						arg_298_1:RecordAudio("417041071", var_301_27)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417041", "417041071", "story_v_out_417041.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417041", "417041071", "story_v_out_417041.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_28 = var_301_19 + 0.3
			local var_301_29 = math.max(var_301_20, arg_298_1.talkMaxDuration)

			if var_301_19 + 0.3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_28 + var_301_29 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_28) / var_301_29

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_28 + var_301_29 and arg_298_1.time_ < var_301_28 + var_301_29 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play417041072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417041072
		arg_306_1.duration_ = 2.5

		local var_306_0 = {
			zh = 2.2,
			ja = 2.5
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417041073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			if arg_306_1.time_ >= 0 + 0.3 and arg_306_1.time_ < 0 + 0.3 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			if 0.034 < arg_306_1.time_ and arg_306_1.time_ <= 0.034 + arg_309_0 then
				if arg_306_1.var_.effect321 then
					Object.Destroy(arg_306_1.var_.effect321)

					arg_306_1.var_.effect321 = nil
				end
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_309_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_3 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_3

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_3
						arg_306_1.bgmTxt2_.text = var_309_3
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_4 = 0
			local var_309_5 = 0.225

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_6 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_6:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_306_1.dialogCg_.alpha = arg_311_0
				end))
				var_309_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(417041072)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 9 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_8) / 9)

				if (9 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_8) / 9)) > 0 and var_309_5 < var_309_10 then
					arg_306_1.talkMaxDuration = var_309_10
					var_309_4 = var_309_4 + 0.3

					if var_309_10 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041072", "story_v_out_417041.awb") ~= 0 then
					local var_309_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041072", "story_v_out_417041.awb") / 1000

					if var_309_11 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_4
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_417041", "417041072", "story_v_out_417041.awb")

						arg_306_1:RecordAudio("417041072", var_309_12)
						arg_306_1:RecordAudio("417041072", var_309_12)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417041", "417041072", "story_v_out_417041.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417041", "417041072", "story_v_out_417041.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = var_309_4 + 0.3
			local var_309_14 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 + 0.3 <= arg_306_1.time_ and arg_306_1.time_ < var_309_13 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_13) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_13 + var_309_14 and arg_306_1.time_ < var_309_13 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play417041073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417041073
		arg_313_1.duration_ = 3.6

		local var_313_0 = {
			zh = 3.1,
			ja = 3.6
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
				arg_313_0:Play417041074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			if arg_313_1.time_ >= 0 + 1 and arg_313_1.time_ < 0 + 1 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_0 = 0.8
			local var_316_1 = 0.2

			if 0.8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_2 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_2:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(417041073)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 8 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_4) / 8)

				if (8 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_4) / 8)) > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6
					var_316_0 = var_316_0 + 0.3

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041073", "story_v_out_417041.awb") ~= 0 then
					local var_316_7 = manager.audio:GetVoiceLength("story_v_out_417041", "417041073", "story_v_out_417041.awb") / 1000

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_417041", "417041073", "story_v_out_417041.awb")

						arg_313_1:RecordAudio("417041073", var_316_8)
						arg_313_1:RecordAudio("417041073", var_316_8)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_417041", "417041073", "story_v_out_417041.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_417041", "417041073", "story_v_out_417041.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_9 = var_316_0 + 0.3
			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 + 0.3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_9 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_9) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_9 + var_316_10 and arg_313_1.time_ < var_316_9 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play417041074 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 417041074
		arg_319_1.duration_ = 5.23

		local var_319_0 = {
			zh = 5.166,
			ja = 5.233
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play417041075(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_9000

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			if arg_319_1.time_ >= 0 + 1 and arg_319_1.time_ < 0 + 1 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				local var_322_0 = arg_319_1.var_.effect798

				if not arg_319_1.var_.effect798 then
					var_322_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng02_in_keep"), manager.ui.mainCamera.transform)
					var_322_0.name = "798"
					arg_319_1.var_.effect798 = var_322_0
				else
					var_322_0.transform:SetParent(var_322_9000)
				end

				var_322_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_322_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_322_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_322_0, iter_322_1 in ipairs((var_322_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_322_1.transform.localScale = Vector3.New(iter_322_1.transform.localScale.x / var_322_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_322_1.transform.localScale.y / var_322_2, iter_322_1.transform.localScale.z)
				end
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_4 = 1
			local var_322_5 = 0.45

			if 1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_6 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_6:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_7 = arg_319_1:GetWordFromCfg(417041074)
				local var_322_8 = arg_319_1:FormatText(var_322_7.content)

				arg_319_1.text_.text = var_322_8

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_10 = 18 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_8) / 18)

				if (18 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_8) / 18)) > 0 and var_322_5 < var_322_10 then
					arg_319_1.talkMaxDuration = var_322_10
					var_322_4 = var_322_4 + 0.3

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_8
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041074", "story_v_out_417041.awb") ~= 0 then
					local var_322_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041074", "story_v_out_417041.awb") / 1000

					if var_322_11 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_4
					end

					if var_322_7.prefab_name ~= "" and arg_319_1.actors_[var_322_7.prefab_name] ~= nil then
						local var_322_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_7.prefab_name].transform, "story_v_out_417041", "417041074", "story_v_out_417041.awb")

						arg_319_1:RecordAudio("417041074", var_322_12)
						arg_319_1:RecordAudio("417041074", var_322_12)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_417041", "417041074", "story_v_out_417041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_417041", "417041074", "story_v_out_417041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_13 = var_322_4 + 0.3
			local var_322_14 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 + 0.3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_13 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_13) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_13 + var_322_14 and arg_319_1.time_ < var_322_13 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play417041075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417041075
		arg_325_1.duration_ = 11.92

		local var_325_0 = {
			zh = 9.383,
			ja = 11.916
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play417041076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if arg_325_1.bgs_.I07a == nil then
				local var_328_0 = Object.Instantiate(arg_325_1.paintGo_)

				var_328_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_328_0.name = "I07a"
				var_328_0.transform.parent = arg_325_1.stage_.transform
				var_328_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.bgs_.I07a = var_328_0
			end

			if 2.03333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.03333333333333 + arg_328_0 then
				local var_328_1 = arg_325_1.bgs_.I07a

				arg_325_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_2 = var_328_1:GetComponent("SpriteRenderer")

				if var_328_2 and var_328_2.sprite then
					local var_328_3 = 2 * (var_328_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_1.transform.localScale = Vector3.New(var_328_3 / var_328_2.sprite.bounds.size.y < var_328_3 * manager.ui.mainCameraCom_.aspect / var_328_2.sprite.bounds.size.x and var_328_3 * manager.ui.mainCameraCom_.aspect / var_328_2.sprite.bounds.size.x or var_328_3 / var_328_2.sprite.bounds.size.y, var_328_3 / var_328_2.sprite.bounds.size.y < var_328_3 * manager.ui.mainCameraCom_.aspect / var_328_2.sprite.bounds.size.x and var_328_3 * manager.ui.mainCameraCom_.aspect / var_328_2.sprite.bounds.size.x or var_328_3 / var_328_2.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "I07a" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_4 = 7.45

			if 7.45 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_4 + 0.3 and arg_325_1.time_ < var_328_4 + 0.3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if 2.03333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.03333333333333 + arg_328_0 then
				if arg_325_1.var_.effect798 then
					Object.Destroy(arg_325_1.var_.effect798)

					arg_325_1.var_.effect798 = nil
				end
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_328_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_8 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_8

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_8
						arg_325_1.bgmTxt2_.text = var_328_8
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 1.63333333333333 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_328_11 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_11 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_11

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_11
						arg_325_1.bgmTxt2_.text = var_328_11
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_12 = 2.05

			if 2.05 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				arg_325_1.timestampController_:SetSelectedState("show")
				arg_325_1.timestampAni_:Play("in")

				arg_325_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")

				arg_325_1.timestampColorController_:SetSelectedState("cold")
				arg_325_1.timeColdImg_:SetAlpha(0.031)

				arg_325_1.text_timeText_.text = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(501013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_timeText_)

				arg_325_1.text_siteText_.text = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(501014).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_siteText_)
			end

			if arg_325_1.time_ >= var_328_12 + 3 and arg_325_1.time_ < var_328_12 + 3 + arg_328_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_325_1.timestampAni_, "out", function()
					arg_325_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_328_13 = 5.04999999999999

			if 5.04999999999999 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_14 = 1.2

			if var_328_13 <= arg_325_1.time_ and arg_325_1.time_ < var_328_13 + var_328_14 then
				local var_328_15 = Color.New(0, 0, 0)

				var_328_15.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_13) / var_328_14)
				arg_325_1.mask_.color = var_328_15
			end

			if arg_325_1.time_ >= var_328_13 + var_328_14 and arg_325_1.time_ < var_328_13 + var_328_14 + arg_328_0 then
				local var_328_16 = Color.New(0, 0, 0)

				var_328_16.a = 1
				arg_325_1.mask_.color = var_328_16
			end

			local var_328_17 = 6.25

			if 6.25 < arg_325_1.time_ and arg_325_1.time_ <= var_328_17 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_18 = 1.2

			if var_328_17 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_18 then
				local var_328_19 = Color.New(0, 0, 0)

				var_328_19.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_17) / var_328_18)
				arg_325_1.mask_.color = var_328_19
			end

			if arg_325_1.time_ >= var_328_17 + var_328_18 and arg_325_1.time_ < var_328_17 + var_328_18 + arg_328_0 then
				local var_328_20 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_20.a = 0
				arg_325_1.mask_.color = var_328_20
			end

			local var_328_21 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_22 = 2.05

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_22 then
				local var_328_23 = Color.New(0, 0, 0)

				var_328_23.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_21) / var_328_22)
				arg_325_1.mask_.color = var_328_23
			end

			if arg_325_1.time_ >= var_328_21 + var_328_22 and arg_325_1.time_ < var_328_21 + var_328_22 + arg_328_0 then
				local var_328_24 = Color.New(0, 0, 0)

				var_328_24.a = 1
				arg_325_1.mask_.color = var_328_24
			end

			local var_328_25 = 2.05

			if 2.05 < arg_325_1.time_ and arg_325_1.time_ <= var_328_25 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = false

				arg_325_1:SetGaussion(false)
			end

			local var_328_26 = 1

			if var_328_25 <= arg_325_1.time_ and arg_325_1.time_ < var_328_25 + var_328_26 then
				local var_328_27 = Color.New(0, 0, 0)

				var_328_27.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_25) / var_328_26)
				arg_325_1.mask_.color = var_328_27
			end

			if arg_325_1.time_ >= var_328_25 + var_328_26 and arg_325_1.time_ < var_328_25 + var_328_26 + arg_328_0 then
				local var_328_28 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_28.a = 0
				arg_325_1.mask_.color = var_328_28
			end

			local var_328_29 = 2.05

			arg_325_1.isInRecall_ = true

			if var_328_29 < arg_325_1.time_ and arg_325_1.time_ <= var_328_29 + arg_328_0 then
				arg_325_1.screenFilterGo_:SetActive(true)

				arg_325_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_325_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_325_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_328_2, iter_328_3 in pairs(arg_325_1.actors_) do
					for iter_328_4, iter_328_5 in ipairs((iter_328_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_328_5.color = iter_328_5.color.r > 0.51 and Color.New(0.8980392, 0.8980392, 0.8980392) or Color.New(0.3411765, 0.3411765, 0.3411765)
					end
				end
			end

			local var_328_30 = 0.0833333333333333

			if var_328_29 <= arg_325_1.time_ and arg_325_1.time_ < var_328_29 + var_328_30 then
				arg_325_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_29) / var_328_30)
			end

			if arg_325_1.time_ >= var_328_29 + var_328_30 and arg_325_1.time_ < var_328_29 + var_328_30 + arg_328_0 then
				arg_325_1.screenFilterEffect_.weight = 1
			end

			local var_328_31 = 2.04999999999999

			if 2.04999999999999 < arg_325_1.time_ and arg_325_1.time_ <= var_328_31 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_31 + 3 and arg_325_1.time_ < var_328_31 + 3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_32 = 7.45
			local var_328_33 = 0.175

			if 7.45 < arg_325_1.time_ and arg_325_1.time_ <= var_328_32 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_34 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_34:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_325_1.dialogCg_.alpha = arg_332_0
				end))
				var_328_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_35 = arg_325_1:GetWordFromCfg(417041075)
				local var_328_36 = arg_325_1:FormatText(var_328_35.content)

				arg_325_1.text_.text = var_328_36

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_38 = 7 <= 0 and var_328_33 or var_328_33 * (utf8.len(var_328_36) / 7)

				if (7 <= 0 and var_328_33 or var_328_33 * (utf8.len(var_328_36) / 7)) > 0 and var_328_33 < var_328_38 then
					arg_325_1.talkMaxDuration = var_328_38
					var_328_32 = var_328_32 + 0.3

					if var_328_38 + var_328_32 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_38 + var_328_32
					end
				end

				arg_325_1.text_.text = var_328_36
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041075", "story_v_out_417041.awb") ~= 0 then
					local var_328_39 = manager.audio:GetVoiceLength("story_v_out_417041", "417041075", "story_v_out_417041.awb") / 1000

					if var_328_39 + var_328_32 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_39 + var_328_32
					end

					if var_328_35.prefab_name ~= "" and arg_325_1.actors_[var_328_35.prefab_name] ~= nil then
						local var_328_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_35.prefab_name].transform, "story_v_out_417041", "417041075", "story_v_out_417041.awb")

						arg_325_1:RecordAudio("417041075", var_328_40)
						arg_325_1:RecordAudio("417041075", var_328_40)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_417041", "417041075", "story_v_out_417041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_417041", "417041075", "story_v_out_417041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_41 = var_328_32 + 0.3
			local var_328_42 = math.max(var_328_33, arg_325_1.talkMaxDuration)

			if var_328_32 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_41 + var_328_42 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_41) / var_328_42

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_41 + var_328_42 and arg_325_1.time_ < var_328_41 + var_328_42 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417041076 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417041076
		arg_334_1.duration_ = 8.57

		local var_334_0 = {
			zh = 6.266,
			ja = 8.566
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417041077(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0.0666666666666667 < arg_334_1.time_ and arg_334_1.time_ <= 0.0666666666666667 + arg_337_0 then
				arg_334_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_handcuffs", "")
			end

			local var_337_1 = 0
			local var_337_2 = 0.675

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1122].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(417041076)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 27 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 27)

				if (27 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 27)) > 0 and var_337_2 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041076", "story_v_out_417041.awb") ~= 0 then
					local var_337_7 = manager.audio:GetVoiceLength("story_v_out_417041", "417041076", "story_v_out_417041.awb") / 1000

					if var_337_7 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_1
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_417041", "417041076", "story_v_out_417041.awb")

						arg_334_1:RecordAudio("417041076", var_337_8)
						arg_334_1:RecordAudio("417041076", var_337_8)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417041", "417041076", "story_v_out_417041.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417041", "417041076", "story_v_out_417041.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_9 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_9 and arg_334_1.time_ < var_337_1 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417041077 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417041077
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417041078(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 1.1

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(417041077).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 44 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 44)

				if (44 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 44)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417041078 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417041078
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417041079(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 1.15

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(417041078).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 46 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 46)

				if (46 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 46)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417041079 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417041079
		arg_346_1.duration_ = 6.87

		local var_346_0 = {
			zh = 6.866,
			ja = 6.633
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play417041080(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.825

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1122].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:GetWordFromCfg(417041079)
				local var_349_2 = arg_346_1:FormatText(var_349_1.content)

				arg_346_1.text_.text = var_349_2

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 33 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 33)

				if (33 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 33)) > 0 and var_349_0 < var_349_4 then
					arg_346_1.talkMaxDuration = var_349_4

					if var_349_4 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_4 + 0
					end
				end

				arg_346_1.text_.text = var_349_2
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041079", "story_v_out_417041.awb") ~= 0 then
					local var_349_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041079", "story_v_out_417041.awb") / 1000

					if var_349_5 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + 0
					end

					if var_349_1.prefab_name ~= "" and arg_346_1.actors_[var_349_1.prefab_name] ~= nil then
						local var_349_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_1.prefab_name].transform, "story_v_out_417041", "417041079", "story_v_out_417041.awb")

						arg_346_1:RecordAudio("417041079", var_349_6)
						arg_346_1:RecordAudio("417041079", var_349_6)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417041", "417041079", "story_v_out_417041.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417041", "417041079", "story_v_out_417041.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play417041080 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417041080
		arg_350_1.duration_ = 7.93

		local var_350_0 = {
			zh = 5.4,
			ja = 7.933
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417041081(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.675

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1122].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:GetWordFromCfg(417041080)
				local var_353_2 = arg_350_1:FormatText(var_353_1.content)

				arg_350_1.text_.text = var_353_2

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 27 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 27)

				if (27 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 27)) > 0 and var_353_0 < var_353_4 then
					arg_350_1.talkMaxDuration = var_353_4

					if var_353_4 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_4 + 0
					end
				end

				arg_350_1.text_.text = var_353_2
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041080", "story_v_out_417041.awb") ~= 0 then
					local var_353_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041080", "story_v_out_417041.awb") / 1000

					if var_353_5 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + 0
					end

					if var_353_1.prefab_name ~= "" and arg_350_1.actors_[var_353_1.prefab_name] ~= nil then
						local var_353_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_1.prefab_name].transform, "story_v_out_417041", "417041080", "story_v_out_417041.awb")

						arg_350_1:RecordAudio("417041080", var_353_6)
						arg_350_1:RecordAudio("417041080", var_353_6)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417041", "417041080", "story_v_out_417041.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417041", "417041080", "story_v_out_417041.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417041081 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417041081
		arg_354_1.duration_ = 2.33

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417041082(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1034"]) and arg_354_1.var_.actorSpriteComps1034 == nil then
				arg_354_1.var_.actorSpriteComps1034 = arg_354_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1034"]) then
				if arg_354_1.var_.actorSpriteComps1034 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								iter_357_1.color = Color.New(Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, (arg_354_1.time_ - 0) / var_357_0), Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, (arg_354_1.time_ - 0) / var_357_0), (Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, (arg_354_1.time_ - 0) / var_357_0)))
							else
								local var_357_1 = Mathf.Lerp(iter_357_1.color.r, 1, (arg_354_1.time_ - 0) / var_357_0)

								iter_357_1.color = Color.New(var_357_1, var_357_1, var_357_1)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1034"]) and arg_354_1.var_.actorSpriteComps1034 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_354_1.var_.actorSpriteComps1034 = nil
			end

			local var_357_2 = arg_354_1.actors_["1034"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1034 = var_357_2.localPosition
				var_357_2.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1034", 3)

				for iter_357_4 = 0, var_357_2.childCount - 1 do
					local var_357_3 = var_357_2:GetChild(iter_357_4)

					if var_357_3.name == "split_6" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_354_1.time_ - 0) / var_357_4)
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_357_5 = 0
			local var_357_6 = 0.175

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_7 = arg_354_1:GetWordFromCfg(417041081)
				local var_357_8 = arg_354_1:FormatText(var_357_7.content)

				arg_354_1.text_.text = var_357_8

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 7 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 7)

				if (7 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 7)) > 0 and var_357_6 < var_357_10 then
					arg_354_1.talkMaxDuration = var_357_10

					if var_357_10 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_5
					end
				end

				arg_354_1.text_.text = var_357_8
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041081", "story_v_out_417041.awb") ~= 0 then
					local var_357_11 = manager.audio:GetVoiceLength("story_v_out_417041", "417041081", "story_v_out_417041.awb") / 1000

					if var_357_11 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_5
					end

					if var_357_7.prefab_name ~= "" and arg_354_1.actors_[var_357_7.prefab_name] ~= nil then
						local var_357_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_7.prefab_name].transform, "story_v_out_417041", "417041081", "story_v_out_417041.awb")

						arg_354_1:RecordAudio("417041081", var_357_12)
						arg_354_1:RecordAudio("417041081", var_357_12)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417041", "417041081", "story_v_out_417041.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417041", "417041081", "story_v_out_417041.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_13 = math.max(var_357_6, arg_354_1.talkMaxDuration)

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_13 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_5) / var_357_13

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_5 + var_357_13 and arg_354_1.time_ < var_357_5 + var_357_13 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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

		arg_354_1:InitPlayNodeList()
	end,
	Play417041082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417041082
		arg_358_1.duration_ = 5.37

		local var_358_0 = {
			zh = 4.066,
			ja = 5.366
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
				arg_358_0:Play417041083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1034"]) and arg_358_1.var_.actorSpriteComps1034 == nil then
				arg_358_1.var_.actorSpriteComps1034 = arg_358_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1034"]) then
				if arg_358_1.var_.actorSpriteComps1034 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor2.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor2.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor2.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 0.5, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1034"]) and arg_358_1.var_.actorSpriteComps1034 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_358_1.var_.actorSpriteComps1034 = nil
			end

			local var_361_2 = 0
			local var_361_3 = 0.425

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1122].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_4 = arg_358_1:GetWordFromCfg(417041082)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 17 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 17)

				if (17 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 17)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041082", "story_v_out_417041.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_417041", "417041082", "story_v_out_417041.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_out_417041", "417041082", "story_v_out_417041.awb")

						arg_358_1:RecordAudio("417041082", var_361_9)
						arg_358_1:RecordAudio("417041082", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417041", "417041082", "story_v_out_417041.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417041", "417041082", "story_v_out_417041.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417041083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417041083
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417041084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1034 = arg_362_1.actors_["1034"].transform.localPosition
				arg_362_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1034", 7)

				for iter_365_0 = 0, arg_362_1.actors_["1034"].transform.childCount - 1 do
					local var_365_0 = arg_362_1.actors_["1034"].transform:GetChild(iter_365_0)

					if var_365_0.name == "" or not string.find(var_365_0.name, "split") then
						var_365_0.gameObject:SetActive(true)
					else
						var_365_0.gameObject:SetActive(false)
					end
				end
			end

			local var_365_1 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_1 then
				arg_362_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_362_1.time_ - 0) / var_365_1)
			end

			if arg_362_1.time_ >= 0 + var_365_1 and arg_362_1.time_ < 0 + var_365_1 + arg_365_0 then
				arg_362_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_365_2 = 0
			local var_365_3 = 0.95

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(417041083).content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_6 = 38 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_4) / 38)

				if (38 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_4) / 38)) > 0 and var_365_3 < var_365_6 then
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
				actorName = "1034",
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
	Play417041084 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417041084
		arg_366_1.duration_ = 2.4

		local var_366_0 = {
			zh = 2.1,
			ja = 2.4
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
				arg_366_0:Play417041085(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if arg_366_1.actors_["10113"] == nil then
				local var_369_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_369_0) then
					local var_369_1 = Object.Instantiate(var_369_0, arg_366_1.canvasGo_.transform)

					var_369_1.transform:SetSiblingIndex(1)

					var_369_1.name = "10113"
					var_369_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_366_1.actors_["10113"] = var_369_1

					if arg_366_1.isInRecall_ then
						for iter_369_0, iter_369_1 in ipairs((var_369_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_369_1.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_369_2 = arg_366_1.actors_["10113"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10113 == nil then
				arg_366_1.var_.actorSpriteComps10113 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps10113 then
					for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_369_3 then
							if arg_366_1.isInRecall_ then
								iter_369_3.color = Color.New(Mathf.Lerp(iter_369_3.color.r, arg_366_1.hightColor1.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_3.color.g, arg_366_1.hightColor1.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_3.color.b, arg_366_1.hightColor1.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_3.color.r, 1, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_3.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10113 then
				for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_369_5 then
						iter_369_5.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps10113 = nil
			end

			local var_369_5 = arg_366_1.actors_["10113"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10113 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10113", 3)

				for iter_369_6 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_6)

					if var_369_6.name == "" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_369_8 = 0
			local var_369_9 = 0.25

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(417041084)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 10 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 10)

				if (10 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 10)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041084", "story_v_out_417041.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_417041", "417041084", "story_v_out_417041.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_417041", "417041084", "story_v_out_417041.awb")

						arg_366_1:RecordAudio("417041084", var_369_15)
						arg_366_1:RecordAudio("417041084", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417041", "417041084", "story_v_out_417041.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417041", "417041084", "story_v_out_417041.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417041085 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417041085
		arg_370_1.duration_ = 2.07

		local var_370_0 = {
			zh = 1.666,
			ja = 2.066
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
				arg_370_0:Play417041086(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1034"]) and arg_370_1.var_.actorSpriteComps1034 == nil then
				arg_370_1.var_.actorSpriteComps1034 = arg_370_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1034"]) then
				if arg_370_1.var_.actorSpriteComps1034 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1034"]) and arg_370_1.var_.actorSpriteComps1034 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps1034 = nil
			end

			local var_373_2 = arg_370_1.actors_["10113"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10113 == nil then
				arg_370_1.var_.actorSpriteComps10113 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps10113 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10113 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps10113 = nil
			end

			local var_373_5 = arg_370_1.actors_["1034"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1034 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1034", 3)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "split_6" or not string.find(var_373_6.name, "split") then
						var_373_6.gameObject:SetActive(true)
					else
						var_373_6.gameObject:SetActive(false)
					end
				end
			end

			local var_373_7 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_370_1.time_ - 0) / var_373_7)
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_373_8 = arg_370_1.actors_["10113"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos10113 = var_373_8.localPosition
				var_373_8.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10113", 7)

				for iter_373_9 = 0, var_373_8.childCount - 1 do
					local var_373_9 = var_373_8:GetChild(iter_373_9)

					if var_373_9.name == "" or not string.find(var_373_9.name, "split") then
						var_373_9.gameObject:SetActive(true)
					else
						var_373_9.gameObject:SetActive(false)
					end
				end
			end

			local var_373_10 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_10 then
				var_373_8.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_370_1.time_ - 0) / var_373_10)
			end

			if arg_370_1.time_ >= 0 + var_373_10 and arg_370_1.time_ < 0 + var_373_10 + arg_373_0 then
				var_373_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_373_11 = 0
			local var_373_12 = 0.175

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_11 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(417041085)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_16 = 7 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 7)

				if (7 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 7)) > 0 and var_373_12 < var_373_16 then
					arg_370_1.talkMaxDuration = var_373_16

					if var_373_16 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_16 + var_373_11
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041085", "story_v_out_417041.awb") ~= 0 then
					local var_373_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041085", "story_v_out_417041.awb") / 1000

					if var_373_17 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_11
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_417041", "417041085", "story_v_out_417041.awb")

						arg_370_1:RecordAudio("417041085", var_373_18)
						arg_370_1:RecordAudio("417041085", var_373_18)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417041", "417041085", "story_v_out_417041.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417041", "417041085", "story_v_out_417041.awb")
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
				actorName = "10113",
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
	Play417041086 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417041086
		arg_374_1.duration_ = 7.57

		local var_374_0 = {
			zh = 5.5,
			ja = 7.566
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
				arg_374_0:Play417041087(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10113"]) and arg_374_1.var_.actorSpriteComps10113 == nil then
				arg_374_1.var_.actorSpriteComps10113 = arg_374_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10113"]) then
				if arg_374_1.var_.actorSpriteComps10113 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10113"]) and arg_374_1.var_.actorSpriteComps10113 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps10113 = nil
			end

			local var_377_2 = arg_374_1.actors_["1034"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1034 == nil then
				arg_374_1.var_.actorSpriteComps1034 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps1034 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1034 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps1034 = nil
			end

			local var_377_5 = arg_374_1.actors_["10113"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos10113 = var_377_5.localPosition
				var_377_5.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10113", 3)

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
				var_377_5.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_374_1.time_ - 0) / var_377_7)
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				var_377_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_377_8 = arg_374_1.actors_["1034"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1034 = var_377_8.localPosition
				var_377_8.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1034", 7)

				for iter_377_9 = 0, var_377_8.childCount - 1 do
					local var_377_9 = var_377_8:GetChild(iter_377_9)

					if var_377_9.name == "" or not string.find(var_377_9.name, "split") then
						var_377_9.gameObject:SetActive(true)
					else
						var_377_9.gameObject:SetActive(false)
					end
				end
			end

			local var_377_10 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_10 then
				var_377_8.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_374_1.time_ - 0) / var_377_10)
			end

			if arg_374_1.time_ >= 0 + var_377_10 and arg_374_1.time_ < 0 + var_377_10 + arg_377_0 then
				var_377_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_11 = 0
			local var_377_12 = 0.625

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_11 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_13 = arg_374_1:GetWordFromCfg(417041086)
				local var_377_14 = arg_374_1:FormatText(var_377_13.content)

				arg_374_1.text_.text = var_377_14

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_16 = 25 <= 0 and var_377_12 or var_377_12 * (utf8.len(var_377_14) / 25)

				if (25 <= 0 and var_377_12 or var_377_12 * (utf8.len(var_377_14) / 25)) > 0 and var_377_12 < var_377_16 then
					arg_374_1.talkMaxDuration = var_377_16

					if var_377_16 + var_377_11 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_16 + var_377_11
					end
				end

				arg_374_1.text_.text = var_377_14
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041086", "story_v_out_417041.awb") ~= 0 then
					local var_377_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041086", "story_v_out_417041.awb") / 1000

					if var_377_17 + var_377_11 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_17 + var_377_11
					end

					if var_377_13.prefab_name ~= "" and arg_374_1.actors_[var_377_13.prefab_name] ~= nil then
						local var_377_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_13.prefab_name].transform, "story_v_out_417041", "417041086", "story_v_out_417041.awb")

						arg_374_1:RecordAudio("417041086", var_377_18)
						arg_374_1:RecordAudio("417041086", var_377_18)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417041", "417041086", "story_v_out_417041.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417041", "417041086", "story_v_out_417041.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_19 = math.max(var_377_12, arg_374_1.talkMaxDuration)

			if var_377_11 <= arg_374_1.time_ and arg_374_1.time_ < var_377_11 + var_377_19 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_11) / var_377_19

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_11 + var_377_19 and arg_374_1.time_ < var_377_11 + var_377_19 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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

		arg_374_1:InitPlayNodeList()
	end,
	Play417041087 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417041087
		arg_378_1.duration_ = 3.5

		local var_378_0 = {
			zh = 1.466,
			ja = 3.5
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
				arg_378_0:Play417041088(arg_378_1)
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
								iter_381_1.color = Color.New(Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor1.r, (arg_378_1.time_ - 0) / var_381_0), Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor1.g, (arg_378_1.time_ - 0) / var_381_0), (Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor1.b, (arg_378_1.time_ - 0) / var_381_0)))
							else
								local var_381_1 = Mathf.Lerp(iter_381_1.color.r, 1, (arg_378_1.time_ - 0) / var_381_0)

								iter_381_1.color = Color.New(var_381_1, var_381_1, var_381_1)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1034"]) and arg_378_1.var_.actorSpriteComps1034 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_381_3 then
						iter_381_3.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_378_1.var_.actorSpriteComps1034 = nil
			end

			local var_381_2 = arg_378_1.actors_["10113"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.actorSpriteComps10113 == nil then
				arg_378_1.var_.actorSpriteComps10113 = var_381_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_3 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_3 and not isNil(var_381_2) then
				if arg_378_1.var_.actorSpriteComps10113 then
					for iter_381_4, iter_381_5 in pairs(arg_378_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_381_5 then
							if arg_378_1.isInRecall_ then
								iter_381_5.color = Color.New(Mathf.Lerp(iter_381_5.color.r, arg_378_1.hightColor2.r, (arg_378_1.time_ - 0) / var_381_3), Mathf.Lerp(iter_381_5.color.g, arg_378_1.hightColor2.g, (arg_378_1.time_ - 0) / var_381_3), (Mathf.Lerp(iter_381_5.color.b, arg_378_1.hightColor2.b, (arg_378_1.time_ - 0) / var_381_3)))
							else
								local var_381_4 = Mathf.Lerp(iter_381_5.color.r, 0.5, (arg_378_1.time_ - 0) / var_381_3)

								iter_381_5.color = Color.New(var_381_4, var_381_4, var_381_4)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 0 + var_381_3 and arg_378_1.time_ < 0 + var_381_3 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.actorSpriteComps10113 then
				for iter_381_6, iter_381_7 in pairs(arg_378_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_381_7 then
						iter_381_7.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_378_1.var_.actorSpriteComps10113 = nil
			end

			local var_381_5 = arg_378_1.actors_["1034"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1034 = var_381_5.localPosition
				var_381_5.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("1034", 3)

				for iter_381_8 = 0, var_381_5.childCount - 1 do
					local var_381_6 = var_381_5:GetChild(iter_381_8)

					if var_381_6.name == "split_6" or not string.find(var_381_6.name, "split") then
						var_381_6.gameObject:SetActive(true)
					else
						var_381_6.gameObject:SetActive(false)
					end
				end
			end

			local var_381_7 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				var_381_5.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_378_1.time_ - 0) / var_381_7)
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				var_381_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_381_8 = arg_378_1.actors_["10113"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos10113 = var_381_8.localPosition
				var_381_8.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10113", 7)

				for iter_381_9 = 0, var_381_8.childCount - 1 do
					local var_381_9 = var_381_8:GetChild(iter_381_9)

					if var_381_9.name == "" or not string.find(var_381_9.name, "split") then
						var_381_9.gameObject:SetActive(true)
					else
						var_381_9.gameObject:SetActive(false)
					end
				end
			end

			local var_381_10 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_10 then
				var_381_8.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_378_1.time_ - 0) / var_381_10)
			end

			if arg_378_1.time_ >= 0 + var_381_10 and arg_378_1.time_ < 0 + var_381_10 + arg_381_0 then
				var_381_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_381_11 = 0
			local var_381_12 = 0.175

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_11 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_13 = arg_378_1:GetWordFromCfg(417041087)
				local var_381_14 = arg_378_1:FormatText(var_381_13.content)

				arg_378_1.text_.text = var_381_14

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_16 = 7 <= 0 and var_381_12 or var_381_12 * (utf8.len(var_381_14) / 7)

				if (7 <= 0 and var_381_12 or var_381_12 * (utf8.len(var_381_14) / 7)) > 0 and var_381_12 < var_381_16 then
					arg_378_1.talkMaxDuration = var_381_16

					if var_381_16 + var_381_11 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_16 + var_381_11
					end
				end

				arg_378_1.text_.text = var_381_14
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041087", "story_v_out_417041.awb") ~= 0 then
					local var_381_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041087", "story_v_out_417041.awb") / 1000

					if var_381_17 + var_381_11 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_17 + var_381_11
					end

					if var_381_13.prefab_name ~= "" and arg_378_1.actors_[var_381_13.prefab_name] ~= nil then
						local var_381_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_13.prefab_name].transform, "story_v_out_417041", "417041087", "story_v_out_417041.awb")

						arg_378_1:RecordAudio("417041087", var_381_18)
						arg_378_1:RecordAudio("417041087", var_381_18)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_417041", "417041087", "story_v_out_417041.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_417041", "417041087", "story_v_out_417041.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_19 = math.max(var_381_12, arg_378_1.talkMaxDuration)

			if var_381_11 <= arg_378_1.time_ and arg_378_1.time_ < var_381_11 + var_381_19 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_11) / var_381_19

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_11 + var_381_19 and arg_378_1.time_ < var_381_11 + var_381_19 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
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
				actorName = "10113",
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
	Play417041088 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417041088
		arg_382_1.duration_ = 4.07

		local var_382_0 = {
			zh = 3,
			ja = 4.066
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
				arg_382_0:Play417041089(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["10113"]) and arg_382_1.var_.actorSpriteComps10113 == nil then
				arg_382_1.var_.actorSpriteComps10113 = arg_382_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["10113"]) then
				if arg_382_1.var_.actorSpriteComps10113 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["10113"]) and arg_382_1.var_.actorSpriteComps10113 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps10113 = nil
			end

			local var_385_2 = arg_382_1.actors_["1034"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps1034 == nil then
				arg_382_1.var_.actorSpriteComps1034 = var_385_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_3 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.actorSpriteComps1034 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps1034 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_385_7 then
						iter_385_7.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_382_1.var_.actorSpriteComps1034 = nil
			end

			local var_385_5 = arg_382_1.actors_["10113"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos10113 = var_385_5.localPosition
				var_385_5.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("10113", 3)

				for iter_385_8 = 0, var_385_5.childCount - 1 do
					local var_385_6 = var_385_5:GetChild(iter_385_8)

					if var_385_6.name == "split_6" or not string.find(var_385_6.name, "split") then
						var_385_6.gameObject:SetActive(true)
					else
						var_385_6.gameObject:SetActive(false)
					end
				end
			end

			local var_385_7 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				var_385_5.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_382_1.time_ - 0) / var_385_7)
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				var_385_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_385_8 = arg_382_1.actors_["1034"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1034 = var_385_8.localPosition
				var_385_8.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1034", 7)

				for iter_385_9 = 0, var_385_8.childCount - 1 do
					local var_385_9 = var_385_8:GetChild(iter_385_9)

					if var_385_9.name == "" or not string.find(var_385_9.name, "split") then
						var_385_9.gameObject:SetActive(true)
					else
						var_385_9.gameObject:SetActive(false)
					end
				end
			end

			local var_385_10 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_10 then
				var_385_8.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_382_1.time_ - 0) / var_385_10)
			end

			if arg_382_1.time_ >= 0 + var_385_10 and arg_382_1.time_ < 0 + var_385_10 + arg_385_0 then
				var_385_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_385_11 = 0
			local var_385_12 = 0.325

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_11 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_13 = arg_382_1:GetWordFromCfg(417041088)
				local var_385_14 = arg_382_1:FormatText(var_385_13.content)

				arg_382_1.text_.text = var_385_14

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_16 = 13 <= 0 and var_385_12 or var_385_12 * (utf8.len(var_385_14) / 13)

				if (13 <= 0 and var_385_12 or var_385_12 * (utf8.len(var_385_14) / 13)) > 0 and var_385_12 < var_385_16 then
					arg_382_1.talkMaxDuration = var_385_16

					if var_385_16 + var_385_11 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_16 + var_385_11
					end
				end

				arg_382_1.text_.text = var_385_14
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041088", "story_v_out_417041.awb") ~= 0 then
					local var_385_17 = manager.audio:GetVoiceLength("story_v_out_417041", "417041088", "story_v_out_417041.awb") / 1000

					if var_385_17 + var_385_11 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_17 + var_385_11
					end

					if var_385_13.prefab_name ~= "" and arg_382_1.actors_[var_385_13.prefab_name] ~= nil then
						local var_385_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_13.prefab_name].transform, "story_v_out_417041", "417041088", "story_v_out_417041.awb")

						arg_382_1:RecordAudio("417041088", var_385_18)
						arg_382_1:RecordAudio("417041088", var_385_18)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_417041", "417041088", "story_v_out_417041.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_417041", "417041088", "story_v_out_417041.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_19 = math.max(var_385_12, arg_382_1.talkMaxDuration)

			if var_385_11 <= arg_382_1.time_ and arg_382_1.time_ < var_385_11 + var_385_19 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_11) / var_385_19

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_11 + var_385_19 and arg_382_1.time_ < var_385_11 + var_385_19 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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

		arg_382_1:InitPlayNodeList()
	end,
	Play417041089 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 417041089
		arg_386_1.duration_ = 8.83

		local var_386_0 = {
			zh = 8.833,
			ja = 8.7
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
				arg_386_0:Play417041090(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 1.125

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:GetWordFromCfg(417041089)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 45 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 45)

				if (45 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 45)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041089", "story_v_out_417041.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041089", "story_v_out_417041.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_out_417041", "417041089", "story_v_out_417041.awb")

						arg_386_1:RecordAudio("417041089", var_389_6)
						arg_386_1:RecordAudio("417041089", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_417041", "417041089", "story_v_out_417041.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_417041", "417041089", "story_v_out_417041.awb")
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
	Play417041090 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417041090
		arg_390_1.duration_ = 9.47

		local var_390_0 = {
			zh = 4.9,
			ja = 9.466
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
			arg_390_1.auto_ = false
		end

		function arg_390_1.playNext_(arg_392_0)
			arg_390_1.onStoryFinished_()
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.475

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:GetWordFromCfg(417041090)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 19 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 19)

				if (19 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 19)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417041", "417041090", "story_v_out_417041.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_417041", "417041090", "story_v_out_417041.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_417041", "417041090", "story_v_out_417041.awb")

						arg_390_1:RecordAudio("417041090", var_393_6)
						arg_390_1:RecordAudio("417041090", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_417041", "417041090", "story_v_out_417041.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_417041", "417041090", "story_v_out_417041.awb")
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
	assets = {
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a"
	},
	voices = {
		"story_v_out_417041.awb"
	}
}
