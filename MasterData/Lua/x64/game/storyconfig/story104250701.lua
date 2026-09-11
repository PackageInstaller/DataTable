return {
	Play425071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425071001
		arg_1_1.duration_ = 13.9

		local var_1_0 = {
			zh = 13.9,
			ja = 13.3
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
				arg_1_0:Play425071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 4.4 < arg_1_1.time_ and arg_1_1.time_ <= 4.4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 4.4 + 0.833333333333335 and arg_1_1.time_ < 4.4 + 0.833333333333335 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "1066"

			if arg_1_1.actors_["1066"] == nil then
				local var_4_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(var_4_1, arg_1_1.canvasGo_.transform)

					var_4_2.transform:SetSiblingIndex(1)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs((var_4_2:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_3 = arg_1_1.actors_["1066"]

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= 4.2 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.actorSpriteComps1066 == nil then
				arg_1_1.var_.actorSpriteComps1066 = var_4_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_4 = 0.2

			if 4.2 <= arg_1_1.time_ and arg_1_1.time_ < 4.2 + var_4_4 and not isNil(var_4_3) then
				if arg_1_1.var_.actorSpriteComps1066 then
					for iter_4_2, iter_4_3 in pairs(arg_1_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_4_3 then
							if arg_1_1.isInRecall_ then
								iter_4_3.color = Color.New(Mathf.Lerp(iter_4_3.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 4.2) / var_4_4), Mathf.Lerp(iter_4_3.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 4.2) / var_4_4), (Mathf.Lerp(iter_4_3.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 4.2) / var_4_4)))
							else
								local var_4_5 = Mathf.Lerp(iter_4_3.color.r, 1, (arg_1_1.time_ - 4.2) / var_4_4)

								iter_4_3.color = Color.New(var_4_5, var_4_5, var_4_5)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 4.2 + var_4_4 and arg_1_1.time_ < 4.2 + var_4_4 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.actorSpriteComps1066 then
				for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_4_5 then
						iter_4_5.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1066 = nil
			end

			local var_4_6 = arg_1_1.actors_["1066"].transform

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= 4.2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066 = var_4_6.localPosition
				var_4_6.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1066", 3)

				for iter_4_6 = 0, var_4_6.childCount - 1 do
					local var_4_7 = var_4_6:GetChild(iter_4_6)

					if var_4_7.name == "" or not string.find(var_4_7.name, "split") then
						var_4_7.gameObject:SetActive(true)
					else
						var_4_7.gameObject:SetActive(false)
					end
				end
			end

			local var_4_8 = 0.001

			if 4.2 <= arg_1_1.time_ and arg_1_1.time_ < 4.2 + var_4_8 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066, Vector3.New(-77.5, -399.1, -303.3), (arg_1_1.time_ - 4.2) / var_4_8)
			end

			if arg_1_1.time_ >= 4.2 + var_4_8 and arg_1_1.time_ < 4.2 + var_4_8 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501112).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501113).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_9 + 1.999999999999 and arg_1_1.time_ < var_4_9 + 1.999999999999 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_10 = 2.00000033333333

			if 2.00000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 1.2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = 1
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = 3.20000033333333

			if 3.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1.2

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

			local var_4_18 = "ST10"

			if arg_1_1.bgs_.ST10 == nil then
				local var_4_19 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_18)
				var_4_19.name = var_4_18
				var_4_19.transform.parent = arg_1_1.stage_.transform
				var_4_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_18] = var_4_19
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_20 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = 2 * (var_4_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_20.transform.localScale = Vector3.New(var_4_22 / var_4_21.sprite.bounds.size.y < var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x and var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x or var_4_22 / var_4_21.sprite.bounds.size.y, var_4_22 / var_4_21.sprite.bounds.size.y < var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x and var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x or var_4_22 / var_4_21.sprite.bounds.size.y, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST10" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 2.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.83333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_28 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			if 2.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 2.83333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 4.4
			local var_4_31 = 1.05

			if 4.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(425071001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 42 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 42)

				if (42 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 42)) > 0 and var_4_31 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_30 = var_4_30 + 0.3

					if var_4_36 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071001", "story_v_out_425071.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_425071", "425071001", "story_v_out_425071.awb") / 1000

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end

					if var_4_33.prefab_name ~= "" and arg_1_1.actors_[var_4_33.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_33.prefab_name].transform, "story_v_out_425071", "425071001", "story_v_out_425071.awb")

						arg_1_1:RecordAudio("425071001", var_4_38)
						arg_1_1:RecordAudio("425071001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425071", "425071001", "story_v_out_425071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425071", "425071001", "story_v_out_425071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_30 + 0.3
			local var_4_40 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_30 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425071002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1066 = arg_10_1.actors_["1066"].transform.localPosition
				arg_10_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1066", 7)

				for iter_13_0 = 0, arg_10_1.actors_["1066"].transform.childCount - 1 do
					local var_13_0 = arg_10_1.actors_["1066"].transform:GetChild(iter_13_0)

					if var_13_0.name == "" or not string.find(var_13_0.name, "split") then
						var_13_0.gameObject:SetActive(true)
					else
						var_13_0.gameObject:SetActive(false)
					end
				end
			end

			local var_13_1 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_1 then
				arg_10_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_10_1.time_ - 0) / var_13_1)
			end

			if arg_10_1.time_ >= 0 + var_13_1 and arg_10_1.time_ < 0 + var_13_1 + arg_13_0 then
				arg_10_1.actors_["1066"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_13_2 = 0
			local var_13_3 = 0.725

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_2 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_4 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(425071002).content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_6 = 29 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 29)

				if (29 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 29)) > 0 and var_13_3 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_2
					end
				end

				arg_10_1.text_.text = var_13_4
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_3, arg_10_1.talkMaxDuration)

			if var_13_2 <= arg_10_1.time_ and arg_10_1.time_ < var_13_2 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_2) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_2 + var_13_7 and arg_10_1.time_ < var_13_2 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.375

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(425071003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 15 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 15)

				if (15 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 15)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play425071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425071004
		arg_18_1.duration_ = 9.3

		local var_18_0 = {
			zh = 9.3,
			ja = 8.633
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
				arg_18_0:Play425071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1066"]) and arg_18_1.var_.actorSpriteComps1066 == nil then
				arg_18_1.var_.actorSpriteComps1066 = arg_18_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1066"]) then
				if arg_18_1.var_.actorSpriteComps1066 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1066"]) and arg_18_1.var_.actorSpriteComps1066 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_18_1.var_.actorSpriteComps1066 = nil
			end

			local var_21_2 = arg_18_1.actors_["1066"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1066 = var_21_2.localPosition
				var_21_2.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1066", 3)

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
				var_21_2.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1066, Vector3.New(-77.5, -399.1, -303.3), (arg_18_1.time_ - 0) / var_21_4)
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_21_5 = 0
			local var_21_6 = 1.125

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_7 = arg_18_1:GetWordFromCfg(425071004)
				local var_21_8 = arg_18_1:FormatText(var_21_7.content)

				arg_18_1.text_.text = var_21_8

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_10 = 45 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 45)

				if (45 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 45)) > 0 and var_21_6 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_5
					end
				end

				arg_18_1.text_.text = var_21_8
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071004", "story_v_out_425071.awb") ~= 0 then
					local var_21_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071004", "story_v_out_425071.awb") / 1000

					if var_21_11 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_5
					end

					if var_21_7.prefab_name ~= "" and arg_18_1.actors_[var_21_7.prefab_name] ~= nil then
						local var_21_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_7.prefab_name].transform, "story_v_out_425071", "425071004", "story_v_out_425071.awb")

						arg_18_1:RecordAudio("425071004", var_21_12)
						arg_18_1:RecordAudio("425071004", var_21_12)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425071", "425071004", "story_v_out_425071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425071", "425071004", "story_v_out_425071.awb")
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
				actorName = "1066",
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
	Play425071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425071005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1066 = arg_22_1.actors_["1066"].transform.localPosition
				arg_22_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1066", 7)

				for iter_25_0 = 0, arg_22_1.actors_["1066"].transform.childCount - 1 do
					local var_25_0 = arg_22_1.actors_["1066"].transform:GetChild(iter_25_0)

					if var_25_0.name == "" or not string.find(var_25_0.name, "split") then
						var_25_0.gameObject:SetActive(true)
					else
						var_25_0.gameObject:SetActive(false)
					end
				end
			end

			local var_25_1 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_1 then
				arg_22_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_22_1.time_ - 0) / var_25_1)
			end

			if arg_22_1.time_ >= 0 + var_25_1 and arg_22_1.time_ < 0 + var_25_1 + arg_25_0 then
				arg_22_1.actors_["1066"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_25_2 = 0
			local var_25_3 = 0.85

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_4 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(425071005).content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_6 = 34 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_4) / 34)

				if (34 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_4) / 34)) > 0 and var_25_3 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_3, arg_22_1.talkMaxDuration)

			if var_25_2 <= arg_22_1.time_ and arg_22_1.time_ < var_25_2 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_2) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_2 + var_25_7 and arg_22_1.time_ < var_25_2 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425071006
		arg_26_1.duration_ = 6.73

		local var_26_0 = {
			zh = 4.666,
			ja = 6.733
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
				arg_26_0:Play425071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.actors_["1037"] == nil then
				local var_29_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_29_0) then
					local var_29_1 = Object.Instantiate(var_29_0, arg_26_1.canvasGo_.transform)

					var_29_1.transform:SetSiblingIndex(1)

					var_29_1.name = "1037"
					var_29_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_26_1.actors_["1037"] = var_29_1

					if arg_26_1.isInRecall_ then
						for iter_29_0, iter_29_1 in ipairs((var_29_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_29_1.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_29_2 = arg_26_1.actors_["1037"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps1037 == nil then
				arg_26_1.var_.actorSpriteComps1037 = var_29_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_3 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.actorSpriteComps1037 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps1037 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_29_5 then
						iter_29_5.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps1037 = nil
			end

			local var_29_5 = arg_26_1.actors_["1037"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1037 = var_29_5.localPosition
				var_29_5.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1037", 2)

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
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_26_1.time_ - 0) / var_29_7)
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_29_8 = 0
			local var_29_9 = 0.6

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_10 = arg_26_1:GetWordFromCfg(425071006)
				local var_29_11 = arg_26_1:FormatText(var_29_10.content)

				arg_26_1.text_.text = var_29_11

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 24 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 24)

				if (24 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 24)) > 0 and var_29_9 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_11
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071006", "story_v_out_425071.awb") ~= 0 then
					local var_29_14 = manager.audio:GetVoiceLength("story_v_out_425071", "425071006", "story_v_out_425071.awb") / 1000

					if var_29_14 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_14 + var_29_8
					end

					if var_29_10.prefab_name ~= "" and arg_26_1.actors_[var_29_10.prefab_name] ~= nil then
						local var_29_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_10.prefab_name].transform, "story_v_out_425071", "425071006", "story_v_out_425071.awb")

						arg_26_1:RecordAudio("425071006", var_29_15)
						arg_26_1:RecordAudio("425071006", var_29_15)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425071", "425071006", "story_v_out_425071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425071", "425071006", "story_v_out_425071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_9, arg_26_1.talkMaxDuration)

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_8) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_8 + var_29_16 and arg_26_1.time_ < var_29_8 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425071007
		arg_30_1.duration_ = 9.4

		local var_30_0 = {
			zh = 9.4,
			ja = 8.833
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
				arg_30_0:Play425071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1066"]) and arg_30_1.var_.actorSpriteComps1066 == nil then
				arg_30_1.var_.actorSpriteComps1066 = arg_30_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1066"]) then
				if arg_30_1.var_.actorSpriteComps1066 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1066"]) and arg_30_1.var_.actorSpriteComps1066 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps1066 = nil
			end

			local var_33_2 = arg_30_1.actors_["1037"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.actorSpriteComps1037 == nil then
				arg_30_1.var_.actorSpriteComps1037 = var_33_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_3 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 and not isNil(var_33_2) then
				if arg_30_1.var_.actorSpriteComps1037 then
					for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_33_5 then
							if arg_30_1.isInRecall_ then
								iter_33_5.color = Color.New(Mathf.Lerp(iter_33_5.color.r, arg_30_1.hightColor2.r, (arg_30_1.time_ - 0) / var_33_3), Mathf.Lerp(iter_33_5.color.g, arg_30_1.hightColor2.g, (arg_30_1.time_ - 0) / var_33_3), (Mathf.Lerp(iter_33_5.color.b, arg_30_1.hightColor2.b, (arg_30_1.time_ - 0) / var_33_3)))
							else
								local var_33_4 = Mathf.Lerp(iter_33_5.color.r, 0.5, (arg_30_1.time_ - 0) / var_33_3)

								iter_33_5.color = Color.New(var_33_4, var_33_4, var_33_4)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.actorSpriteComps1037 then
				for iter_33_6, iter_33_7 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_33_7 then
						iter_33_7.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps1037 = nil
			end

			local var_33_5 = arg_30_1.actors_["1066"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1066 = var_33_5.localPosition
				var_33_5.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1066", 4)

				for iter_33_8 = 0, var_33_5.childCount - 1 do
					local var_33_6 = var_33_5:GetChild(iter_33_8)

					if var_33_6.name == "" or not string.find(var_33_6.name, "split") then
						var_33_6.gameObject:SetActive(true)
					else
						var_33_6.gameObject:SetActive(false)
					end
				end
			end

			local var_33_7 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				var_33_5.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1066, Vector3.New(453.9, -399.1, -303.3), (arg_30_1.time_ - 0) / var_33_7)
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				var_33_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_33_8 = 0
			local var_33_9 = 1.1

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_10 = arg_30_1:GetWordFromCfg(425071007)
				local var_33_11 = arg_30_1:FormatText(var_33_10.content)

				arg_30_1.text_.text = var_33_11

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 44 <= 0 and var_33_9 or var_33_9 * (utf8.len(var_33_11) / 44)

				if (44 <= 0 and var_33_9 or var_33_9 * (utf8.len(var_33_11) / 44)) > 0 and var_33_9 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_11
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071007", "story_v_out_425071.awb") ~= 0 then
					local var_33_14 = manager.audio:GetVoiceLength("story_v_out_425071", "425071007", "story_v_out_425071.awb") / 1000

					if var_33_14 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_8
					end

					if var_33_10.prefab_name ~= "" and arg_30_1.actors_[var_33_10.prefab_name] ~= nil then
						local var_33_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_10.prefab_name].transform, "story_v_out_425071", "425071007", "story_v_out_425071.awb")

						arg_30_1:RecordAudio("425071007", var_33_15)
						arg_30_1:RecordAudio("425071007", var_33_15)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_425071", "425071007", "story_v_out_425071.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_425071", "425071007", "story_v_out_425071.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_16 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_16 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_16

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_16 and arg_30_1.time_ < var_33_8 + var_33_16 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425071008
		arg_34_1.duration_ = 7.03

		local var_34_0 = {
			zh = 7.033,
			ja = 6.4
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
				arg_34_0:Play425071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.85

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(425071008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 34 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 34)

				if (34 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 34)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071008", "story_v_out_425071.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071008", "story_v_out_425071.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_425071", "425071008", "story_v_out_425071.awb")

						arg_34_1:RecordAudio("425071008", var_37_6)
						arg_34_1:RecordAudio("425071008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425071", "425071008", "story_v_out_425071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425071", "425071008", "story_v_out_425071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play425071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425071009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play425071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1066"]) and arg_38_1.var_.actorSpriteComps1066 == nil then
				arg_38_1.var_.actorSpriteComps1066 = arg_38_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1066"]) then
				if arg_38_1.var_.actorSpriteComps1066 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1066"]) and arg_38_1.var_.actorSpriteComps1066 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps1066 = nil
			end

			local var_41_2 = 0
			local var_41_3 = 0.625

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_4 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(425071009).content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_6 = 25 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_4) / 25)

				if (25 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_4) / 25)) > 0 and var_41_3 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_7 and arg_38_1.time_ < var_41_2 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425071010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play425071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.175

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(425071010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)

				if (47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play425071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425071011
		arg_46_1.duration_ = 5

		local var_46_0 = {
			zh = 2.833,
			ja = 5
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
				arg_46_0:Play425071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1037"]) and arg_46_1.var_.actorSpriteComps1037 == nil then
				arg_46_1.var_.actorSpriteComps1037 = arg_46_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1037"]) then
				if arg_46_1.var_.actorSpriteComps1037 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 1, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1037"]) and arg_46_1.var_.actorSpriteComps1037 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps1037 = nil
			end

			local var_49_2 = arg_46_1.actors_["1037"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1037 = var_49_2.localPosition
				var_49_2.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1037", 2)

				for iter_49_4 = 0, var_49_2.childCount - 1 do
					local var_49_3 = var_49_2:GetChild(iter_49_4)

					if var_49_3.name == "split_6" then
						var_49_3:SetAsLastSibling()
						var_49_3.gameObject:SetActive(true)

						arg_46_1.var_.actorSpriteSplit1037 = var_49_3.gameObject:GetComponent(typeof(Image))

						arg_46_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_49_4 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_2.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_46_1.time_ - 0) / var_49_4)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha((arg_46_1.time_ - 0) / var_49_4)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_2.localPosition = Vector3.New(-390, -430, -55)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_49_5 = 0
			local var_49_6 = 0.375

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(425071011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 15 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 15)

				if (15 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 15)) > 0 and var_49_6 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071011", "story_v_out_425071.awb") ~= 0 then
					local var_49_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071011", "story_v_out_425071.awb") / 1000

					if var_49_11 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_5
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_425071", "425071011", "story_v_out_425071.awb")

						arg_46_1:RecordAudio("425071011", var_49_12)
						arg_46_1:RecordAudio("425071011", var_49_12)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425071", "425071011", "story_v_out_425071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425071", "425071011", "story_v_out_425071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_13 and arg_46_1.time_ < var_49_5 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play425071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425071012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play425071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1037 = arg_50_1.actors_["1037"].transform.localPosition
				arg_50_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1037", 7)

				for iter_53_0 = 0, arg_50_1.actors_["1037"].transform.childCount - 1 do
					local var_53_0 = arg_50_1.actors_["1037"].transform:GetChild(iter_53_0)

					if var_53_0.name == "" or not string.find(var_53_0.name, "split") then
						var_53_0.gameObject:SetActive(true)
					else
						var_53_0.gameObject:SetActive(false)
					end
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_50_1.time_ - 0) / var_53_1)
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_53_2 = arg_50_1.actors_["1066"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1066 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1066", 7)

				for iter_53_1 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_1)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_5 = 0
			local var_53_6 = 0.65

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(425071012).content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 26 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 26)

				if (26 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 26)) > 0 and var_53_6 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_10 and arg_50_1.time_ < var_53_5 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425071013
		arg_54_1.duration_ = 7.97

		local var_54_0 = {
			zh = 7.966,
			ja = 7.4
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
				arg_54_0:Play425071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1066"]) and arg_54_1.var_.actorSpriteComps1066 == nil then
				arg_54_1.var_.actorSpriteComps1066 = arg_54_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1066"]) then
				if arg_54_1.var_.actorSpriteComps1066 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1066"]) and arg_54_1.var_.actorSpriteComps1066 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps1066 = nil
			end

			local var_57_2 = arg_54_1.actors_["1066"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1066 = var_57_2.localPosition
				var_57_2.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1066", 3)

				for iter_57_4 = 0, var_57_2.childCount - 1 do
					local var_57_3 = var_57_2:GetChild(iter_57_4)

					if var_57_3.name == "" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1066, Vector3.New(-77.5, -399.1, -303.3), (arg_54_1.time_ - 0) / var_57_4)
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_57_5 = 0
			local var_57_6 = 0.875

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(425071013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 35 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 35)

				if (35 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 35)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071013", "story_v_out_425071.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071013", "story_v_out_425071.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_425071", "425071013", "story_v_out_425071.awb")

						arg_54_1:RecordAudio("425071013", var_57_12)
						arg_54_1:RecordAudio("425071013", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425071", "425071013", "story_v_out_425071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425071", "425071013", "story_v_out_425071.awb")
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
				actorName = "1066",
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
	Play425071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425071014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play425071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1066"]) and arg_58_1.var_.actorSpriteComps1066 == nil then
				arg_58_1.var_.actorSpriteComps1066 = arg_58_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1066"]) then
				if arg_58_1.var_.actorSpriteComps1066 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1066"]) and arg_58_1.var_.actorSpriteComps1066 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1066 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 0.75

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_4 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(425071014).content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 30 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 30)

				if (30 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 30)) > 0 and var_61_3 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_7 and arg_58_1.time_ < var_61_2 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play425071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425071015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play425071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1066 = arg_62_1.actors_["1066"].transform.localPosition
				arg_62_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1066", 7)

				for iter_65_0 = 0, arg_62_1.actors_["1066"].transform.childCount - 1 do
					local var_65_0 = arg_62_1.actors_["1066"].transform:GetChild(iter_65_0)

					if var_65_0.name == "" or not string.find(var_65_0.name, "split") then
						var_65_0.gameObject:SetActive(true)
					else
						var_65_0.gameObject:SetActive(false)
					end
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_62_1.time_ - 0) / var_65_1)
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["1066"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_65_2 = 0
			local var_65_3 = 1.325

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(425071015).content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 53 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 53)

				if (53 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 53)) > 0 and var_65_3 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_7 and arg_62_1.time_ < var_65_2 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425071016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play425071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.1

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(425071016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 4 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 4)

				if (4 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 4)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play425071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425071017
		arg_70_1.duration_ = 4.67

		local var_70_0 = {
			zh = 1.9,
			ja = 4.666
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
				arg_70_0:Play425071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1037"]) and arg_70_1.var_.actorSpriteComps1037 == nil then
				arg_70_1.var_.actorSpriteComps1037 = arg_70_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1037"]) then
				if arg_70_1.var_.actorSpriteComps1037 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1037"]) and arg_70_1.var_.actorSpriteComps1037 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps1037 = nil
			end

			local var_73_2 = arg_70_1.actors_["1037"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1037 = var_73_2.localPosition
				var_73_2.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1037", 3)

				for iter_73_4 = 0, var_73_2.childCount - 1 do
					local var_73_3 = var_73_2:GetChild(iter_73_4)

					if var_73_3.name == "split_6" or not string.find(var_73_3.name, "split") then
						var_73_3.gameObject:SetActive(true)
					else
						var_73_3.gameObject:SetActive(false)
					end
				end
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_70_1.time_ - 0) / var_73_4)
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_73_5 = 0
			local var_73_6 = 0.2

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(425071017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 8 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 8)

				if (8 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 8)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071017", "story_v_out_425071.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071017", "story_v_out_425071.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_425071", "425071017", "story_v_out_425071.awb")

						arg_70_1:RecordAudio("425071017", var_73_12)
						arg_70_1:RecordAudio("425071017", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_425071", "425071017", "story_v_out_425071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_425071", "425071017", "story_v_out_425071.awb")
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

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play425071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425071018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play425071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1037"]) and arg_74_1.var_.actorSpriteComps1037 == nil then
				arg_74_1.var_.actorSpriteComps1037 = arg_74_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1037"]) then
				if arg_74_1.var_.actorSpriteComps1037 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1037"]) and arg_74_1.var_.actorSpriteComps1037 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps1037 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 0.25

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(425071018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 10)

				if (10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 10)) > 0 and var_77_3 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_7 and arg_74_1.time_ < var_77_2 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play425071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425071019
		arg_78_1.duration_ = 7.83

		local var_78_0 = {
			zh = 5.8,
			ja = 7.833
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
				arg_78_0:Play425071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1037"]) and arg_78_1.var_.actorSpriteComps1037 == nil then
				arg_78_1.var_.actorSpriteComps1037 = arg_78_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1037"]) then
				if arg_78_1.var_.actorSpriteComps1037 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 1, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1037"]) and arg_78_1.var_.actorSpriteComps1037 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps1037 = nil
			end

			local var_81_2 = arg_78_1.actors_["1037"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1037 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1037", 3)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "split_4" then
						var_81_3:SetAsLastSibling()
						var_81_3.gameObject:SetActive(true)

						arg_78_1.var_.actorSpriteSplit1037 = var_81_3.gameObject:GetComponent(typeof(Image))

						arg_78_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_81_4 = 0.5

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_78_1.time_ - 0) / var_81_4)

				if arg_78_1.var_.actorSpriteSplit1037 ~= nil then
					arg_78_1.var_.actorSpriteSplit1037:SetAlpha((arg_78_1.time_ - 0) / var_81_4)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -430, -55)

				if arg_78_1.var_.actorSpriteSplit1037 ~= nil then
					arg_78_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_81_5 = 0
			local var_81_6 = 0.575

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(425071019)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 23 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 23)

				if (23 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 23)) > 0 and var_81_6 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071019", "story_v_out_425071.awb") ~= 0 then
					local var_81_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071019", "story_v_out_425071.awb") / 1000

					if var_81_11 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_5
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_425071", "425071019", "story_v_out_425071.awb")

						arg_78_1:RecordAudio("425071019", var_81_12)
						arg_78_1:RecordAudio("425071019", var_81_12)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_425071", "425071019", "story_v_out_425071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_425071", "425071019", "story_v_out_425071.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_13 and arg_78_1.time_ < var_81_5 + var_81_13 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play425071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 425071020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play425071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1037 = arg_82_1.actors_["1037"].transform.localPosition
				arg_82_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1037", 7)

				for iter_85_0 = 0, arg_82_1.actors_["1037"].transform.childCount - 1 do
					local var_85_0 = arg_82_1.actors_["1037"].transform:GetChild(iter_85_0)

					if var_85_0.name == "" or not string.find(var_85_0.name, "split") then
						var_85_0.gameObject:SetActive(true)
					else
						var_85_0.gameObject:SetActive(false)
					end
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_82_1.time_ - 0) / var_85_1)
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.1 < arg_82_1.time_ and arg_82_1.time_ <= 0.1 + arg_85_0 then
				arg_82_1:AudioAction("play", "effect", "se_story_10", "se_story_10_energy_loop", "")
			end

			local var_85_3 = 0
			local var_85_4 = 1.125

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(425071020).content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 45 <= 0 and var_85_4 or var_85_4 * (utf8.len(var_85_5) / 45)

				if (45 <= 0 and var_85_4 or var_85_4 * (utf8.len(var_85_5) / 45)) > 0 and var_85_4 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_3 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_3
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_4, arg_82_1.talkMaxDuration)

			if var_85_3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_3 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_3) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_3 + var_85_8 and arg_82_1.time_ < var_85_3 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play425071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 425071021
		arg_86_1.duration_ = 2.83

		local var_86_0 = {
			zh = 2.833,
			ja = 2.133
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
				arg_86_0:Play425071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1037"]) and arg_86_1.var_.actorSpriteComps1037 == nil then
				arg_86_1.var_.actorSpriteComps1037 = arg_86_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1037"]) then
				if arg_86_1.var_.actorSpriteComps1037 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1037"]) and arg_86_1.var_.actorSpriteComps1037 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps1037 = nil
			end

			local var_89_2 = arg_86_1.actors_["1037"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1037 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1037", 3)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "split_5" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_89_5 = 0
			local var_89_6 = 0.2

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:GetWordFromCfg(425071021)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 8 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 8)

				if (8 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_8) / 8)) > 0 and var_89_6 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_5
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071021", "story_v_out_425071.awb") ~= 0 then
					local var_89_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071021", "story_v_out_425071.awb") / 1000

					if var_89_11 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_5
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_425071", "425071021", "story_v_out_425071.awb")

						arg_86_1:RecordAudio("425071021", var_89_12)
						arg_86_1:RecordAudio("425071021", var_89_12)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_425071", "425071021", "story_v_out_425071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_425071", "425071021", "story_v_out_425071.awb")
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
				actorName = "1037",
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
	Play425071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 425071022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play425071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1037"]) and arg_90_1.var_.actorSpriteComps1037 == nil then
				arg_90_1.var_.actorSpriteComps1037 = arg_90_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1037"]) then
				if arg_90_1.var_.actorSpriteComps1037 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1037"]) and arg_90_1.var_.actorSpriteComps1037 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps1037 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_4 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(425071022).content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 4 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 4)

				if (4 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 4)) > 0 and var_93_3 < var_93_6 then
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
	Play425071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 425071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play425071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1037 = arg_94_1.actors_["1037"].transform.localPosition
				arg_94_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1037", 7)

				for iter_97_0 = 0, arg_94_1.actors_["1037"].transform.childCount - 1 do
					local var_97_0 = arg_94_1.actors_["1037"].transform:GetChild(iter_97_0)

					if var_97_0.name == "" or not string.find(var_97_0.name, "split") then
						var_97_0.gameObject:SetActive(true)
					else
						var_97_0.gameObject:SetActive(false)
					end
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_94_1.time_ - 0) / var_97_1)
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:AudioAction("stop", "effect", "se_story_10", "se_story_10_energy_loop", "")
			end

			if 0.233333333333333 < arg_94_1.time_ and arg_94_1.time_ <= 0.233333333333333 + arg_97_0 then
				arg_94_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_97_4 = manager.ui.mainCamera.transform

			if 0.034 < arg_94_1.time_ and arg_94_1.time_ <= 0.034 + arg_97_0 then
				arg_94_1.var_.shakeOldPos = var_97_4.localPosition
			end

			local var_97_5 = 0.3

			if 0.034 <= arg_94_1.time_ and arg_94_1.time_ < 0.034 + var_97_5 then
				local var_97_6, var_97_7 = math.modf((arg_94_1.time_ - 0.034) / 0.132)

				var_97_4.localPosition = Vector3.New(var_97_7 * 0.1, var_97_7 * 0.1, var_97_7 * 0.1) + arg_94_1.var_.shakeOldPos
			end

			if arg_94_1.time_ >= 0.034 + var_97_5 and arg_94_1.time_ < 0.034 + var_97_5 + arg_97_0 then
				var_97_4.localPosition = arg_94_1.var_.shakeOldPos
			end

			local var_97_8 = 0
			local var_97_9 = 1.525

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(425071023).content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_12 = 61 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_10) / 61)

				if (61 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_10) / 61)) > 0 and var_97_9 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12

					if var_97_12 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_13 and arg_94_1.time_ < var_97_8 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 425071024
		arg_98_1.duration_ = 9.9

		local var_98_0 = {
			zh = 8.06600033333333,
			ja = 9.90000033333333
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
				arg_98_0:Play425071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 5.60000033333333 < arg_98_1.time_ and arg_98_1.time_ <= 5.60000033333333 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			if arg_98_1.time_ >= 5.60000033333333 + 0.275 and arg_98_1.time_ < 5.60000033333333 + 0.275 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_0 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_1 = 1.2

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_1 then
				local var_101_2 = Color.New(0, 0, 0)

				var_101_2.a = Mathf.Lerp(0, 1, (arg_98_1.time_ - var_101_0) / var_101_1)
				arg_98_1.mask_.color = var_101_2
			end

			if arg_98_1.time_ >= var_101_0 + var_101_1 and arg_98_1.time_ < var_101_0 + var_101_1 + arg_101_0 then
				local var_101_3 = Color.New(0, 0, 0)

				var_101_3.a = 1
				arg_98_1.mask_.color = var_101_3
			end

			local var_101_4 = 1.2

			if 1.2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_5 = 1.2

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_5 then
				local var_101_6 = Color.New(0, 0, 0)

				var_101_6.a = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_4) / var_101_5)
				arg_98_1.mask_.color = var_101_6
			end

			if arg_98_1.time_ >= var_101_4 + var_101_5 and arg_98_1.time_ < var_101_4 + var_101_5 + arg_101_0 then
				local var_101_7 = Color.New(0, 0, 0)

				arg_98_1.mask_.enabled = false
				var_101_7.a = 0
				arg_98_1.mask_.color = var_101_7
			end

			local var_101_8 = 1.2

			if 1.2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.timestampController_:SetSelectedState("show")
				arg_98_1.timestampAni_:Play("in")

				arg_98_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H04")

				arg_98_1.timestampColorController_:SetSelectedState("hot")
				arg_98_1.timeColdImg_:SetAlpha(0.031)

				arg_98_1.text_timeText_.text = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(501108).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_timeText_)

				arg_98_1.text_siteText_.text = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(501109).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_siteText_)
			end

			if arg_98_1.time_ >= var_101_8 + 1.999999999999 and arg_98_1.time_ < var_101_8 + 1.999999999999 + arg_101_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_98_1.timestampAni_, "out", function()
					arg_98_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_101_9 = 3.20000033333333

			if 3.20000033333333 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_10 = 1.2

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_10 then
				local var_101_11 = Color.New(0, 0, 0)

				var_101_11.a = Mathf.Lerp(0, 1, (arg_98_1.time_ - var_101_9) / var_101_10)
				arg_98_1.mask_.color = var_101_11
			end

			if arg_98_1.time_ >= var_101_9 + var_101_10 and arg_98_1.time_ < var_101_9 + var_101_10 + arg_101_0 then
				local var_101_12 = Color.New(0, 0, 0)

				var_101_12.a = 1
				arg_98_1.mask_.color = var_101_12
			end

			local var_101_13 = 4.40000033333333

			if 4.40000033333333 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_14 = 1.2

			if var_101_13 <= arg_98_1.time_ and arg_98_1.time_ < var_101_13 + var_101_14 then
				local var_101_15 = Color.New(0, 0, 0)

				var_101_15.a = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_13) / var_101_14)
				arg_98_1.mask_.color = var_101_15
			end

			if arg_98_1.time_ >= var_101_13 + var_101_14 and arg_98_1.time_ < var_101_13 + var_101_14 + arg_101_0 then
				local var_101_16 = Color.New(0, 0, 0)

				arg_98_1.mask_.enabled = false
				var_101_16.a = 0
				arg_98_1.mask_.color = var_101_16
			end

			local var_101_17 = "H04"

			if arg_98_1.bgs_.H04 == nil then
				local var_101_18 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_17)
				var_101_18.name = var_101_17
				var_101_18.transform.parent = arg_98_1.stage_.transform
				var_101_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_17] = var_101_18
			end

			if 1.2 < arg_98_1.time_ and arg_98_1.time_ <= 1.2 + arg_101_0 then
				local var_101_19 = arg_98_1.bgs_.H04

				arg_98_1.bgs_.H04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_101_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_20 = var_101_19:GetComponent("SpriteRenderer")

				if var_101_20 and var_101_20.sprite then
					local var_101_21 = 2 * (var_101_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_101_19.transform.localScale = Vector3.New(var_101_21 / var_101_20.sprite.bounds.size.y < var_101_21 * manager.ui.mainCameraCom_.aspect / var_101_20.sprite.bounds.size.x and var_101_21 * manager.ui.mainCameraCom_.aspect / var_101_20.sprite.bounds.size.x or var_101_21 / var_101_20.sprite.bounds.size.y, var_101_21 / var_101_20.sprite.bounds.size.y < var_101_21 * manager.ui.mainCameraCom_.aspect / var_101_20.sprite.bounds.size.x and var_101_21 * manager.ui.mainCameraCom_.aspect / var_101_20.sprite.bounds.size.x or var_101_21 / var_101_20.sprite.bounds.size.y, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "H04" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 3.96666666666667 < arg_98_1.time_ and arg_98_1.time_ <= 3.96666666666667 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.133333333333333 < arg_98_1.time_ and arg_98_1.time_ <= 0.133333333333333 + arg_101_0 then
				arg_98_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_24 = 5.60000033333333
			local var_101_25 = 0.275

			if 5.60000033333333 < arg_98_1.time_ and arg_98_1.time_ <= var_101_24 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_26 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_26:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_98_1.dialogCg_.alpha = arg_103_0
				end))
				var_101_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_27 = arg_98_1:GetWordFromCfg(425071024)
				local var_101_28 = arg_98_1:FormatText(var_101_27.content)

				arg_98_1.text_.text = var_101_28

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_30 = 11 <= 0 and var_101_25 or var_101_25 * (utf8.len(var_101_28) / 11)

				if (11 <= 0 and var_101_25 or var_101_25 * (utf8.len(var_101_28) / 11)) > 0 and var_101_25 < var_101_30 then
					arg_98_1.talkMaxDuration = var_101_30
					var_101_24 = var_101_24 + 0.3

					if var_101_30 + var_101_24 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_30 + var_101_24
					end
				end

				arg_98_1.text_.text = var_101_28
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071024", "story_v_out_425071.awb") ~= 0 then
					local var_101_31 = manager.audio:GetVoiceLength("story_v_out_425071", "425071024", "story_v_out_425071.awb") / 1000

					if var_101_31 + var_101_24 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_31 + var_101_24
					end

					if var_101_27.prefab_name ~= "" and arg_98_1.actors_[var_101_27.prefab_name] ~= nil then
						local var_101_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_27.prefab_name].transform, "story_v_out_425071", "425071024", "story_v_out_425071.awb")

						arg_98_1:RecordAudio("425071024", var_101_32)
						arg_98_1:RecordAudio("425071024", var_101_32)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_425071", "425071024", "story_v_out_425071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_425071", "425071024", "story_v_out_425071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_33 = var_101_24 + 0.3
			local var_101_34 = math.max(var_101_25, arg_98_1.talkMaxDuration)

			if var_101_24 + 0.3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_33 + var_101_34 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_33) / var_101_34

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_33 + var_101_34 and arg_98_1.time_ < var_101_33 + var_101_34 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.2,
				startTime = 5.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(10, 10, 0)
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play425071025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425071025
		arg_105_1.duration_ = 13.4

		local var_105_0 = {
			zh = 8.69933333333333,
			ja = 13.3993333333333
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
				arg_105_0:Play425071026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				local var_108_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_0 then
					var_108_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_0.radialBlurScale = 0
					var_108_0.radialBlurGradient = 1
					var_108_0.radialBlurIntensity = 0

					if nil then
						var_108_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_108_1 = 1

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				local var_108_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_2 then
					var_108_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_2.radialBlurScale = Mathf.Lerp(0, 0.8, (arg_105_1.time_ - 0) / var_108_1)
					var_108_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_105_1.time_ - 0) / var_108_1)
					var_108_2.radialBlurIntensity = Mathf.Lerp(0, 0.8, (arg_105_1.time_ - 0) / var_108_1)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_3 then
					var_108_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_3.radialBlurScale = 0.8
					var_108_3.radialBlurGradient = 1
					var_108_3.radialBlurIntensity = 0.8
				end
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_4 = 0.733333333333333
			local var_108_5 = 0.5

			if 0.733333333333333 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_6 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_6:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_7 = arg_105_1:GetWordFromCfg(425071025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 20 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_8) / 20)

				if (20 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_8) / 20)) > 0 and var_108_5 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10
					var_108_4 = var_108_4 + 0.3

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071025", "story_v_out_425071.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071025", "story_v_out_425071.awb") / 1000

					if var_108_11 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_4
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_425071", "425071025", "story_v_out_425071.awb")

						arg_105_1:RecordAudio("425071025", var_108_12)
						arg_105_1:RecordAudio("425071025", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425071", "425071025", "story_v_out_425071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425071", "425071025", "story_v_out_425071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = var_108_4 + 0.3
			local var_108_14 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_13) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_13 + var_108_14 and arg_105_1.time_ < var_108_13 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play425071026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 425071026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play425071027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_0 then
					var_114_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_0.radialBlurScale = 0.8
					var_114_0.radialBlurGradient = 1
					var_114_0.radialBlurIntensity = 0.8

					if nil then
						var_114_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_114_1 = 1

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				local var_114_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_2 then
					var_114_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_2.radialBlurScale = Mathf.Lerp(0.8, 0, (arg_111_1.time_ - 0) / var_114_1)
					var_114_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_111_1.time_ - 0) / var_114_1)
					var_114_2.radialBlurIntensity = Mathf.Lerp(0.8, 0, (arg_111_1.time_ - 0) / var_114_1)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				local var_114_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_3 then
					var_114_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_3.radialBlurScale = 0
					var_114_3.radialBlurGradient = 1
					var_114_3.radialBlurIntensity = 0
				end
			end

			local var_114_4 = 0
			local var_114_5 = 1.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(425071026).content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 60 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 60)

				if (60 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 60)) > 0 and var_114_5 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_9 and arg_111_1.time_ < var_114_4 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play425071027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 425071027
		arg_115_1.duration_ = 5.03

		local var_115_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_115_0:Play425071028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["10127"] == nil then
				local var_118_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_118_0) then
					local var_118_1 = Object.Instantiate(var_118_0, arg_115_1.canvasGo_.transform)

					var_118_1.transform:SetSiblingIndex(1)

					var_118_1.name = "10127"
					var_118_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_["10127"] = var_118_1

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs((var_118_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_2 = arg_115_1.actors_["10127"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10127 == nil then
				arg_115_1.var_.actorSpriteComps10127 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10127 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_118_3 then
							if arg_115_1.isInRecall_ then
								iter_118_3.color = Color.New(Mathf.Lerp(iter_118_3.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_3.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_3.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_3.color.r, 1, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_3.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10127 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_118_5 then
						iter_118_5.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10127 = nil
			end

			local var_118_5 = arg_115_1.actors_["10127"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10127 = var_118_5.localPosition
				var_118_5.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10127", 3)

				for iter_118_6 = 0, var_118_5.childCount - 1 do
					local var_118_6 = var_118_5:GetChild(iter_118_6)

					if var_118_6.name == "split_6" or not string.find(var_118_6.name, "split") then
						var_118_6.gameObject:SetActive(true)
					else
						var_118_6.gameObject:SetActive(false)
					end
				end
			end

			local var_118_7 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_115_1.time_ - 0) / var_118_7)
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_118_8 = 0
			local var_118_9 = 0.425

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
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

				local var_118_10 = arg_115_1:GetWordFromCfg(425071027)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 17 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 17)

				if (17 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 17)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071027", "story_v_out_425071.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_425071", "425071027", "story_v_out_425071.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_425071", "425071027", "story_v_out_425071.awb")

						arg_115_1:RecordAudio("425071027", var_118_15)
						arg_115_1:RecordAudio("425071027", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_425071", "425071027", "story_v_out_425071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_425071", "425071027", "story_v_out_425071.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play425071028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 425071028
		arg_119_1.duration_ = 4.6

		local var_119_0 = {
			zh = 3.7,
			ja = 4.6
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
				arg_119_0:Play425071029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10127 = arg_119_1.actors_["10127"].transform.localPosition
				arg_119_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10127", 7)

				for iter_122_0 = 0, arg_119_1.actors_["10127"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10127"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10127"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_2 = 0
			local var_122_3 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_4 = arg_119_1:GetWordFromCfg(425071028)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 14 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 14)

				if (14 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 14)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071028", "story_v_out_425071.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071028", "story_v_out_425071.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_425071", "425071028", "story_v_out_425071.awb")

						arg_119_1:RecordAudio("425071028", var_122_9)
						arg_119_1:RecordAudio("425071028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_425071", "425071028", "story_v_out_425071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_425071", "425071028", "story_v_out_425071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play425071029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 425071029
		arg_123_1.duration_ = 5.5

		local var_123_0 = {
			zh = 4,
			ja = 5.5
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
				arg_123_0:Play425071030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.425

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(425071029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 17 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 17)

				if (17 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 17)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071029", "story_v_out_425071.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071029", "story_v_out_425071.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_425071", "425071029", "story_v_out_425071.awb")

						arg_123_1:RecordAudio("425071029", var_126_6)
						arg_123_1:RecordAudio("425071029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_425071", "425071029", "story_v_out_425071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_425071", "425071029", "story_v_out_425071.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play425071030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425071030
		arg_127_1.duration_ = 6.57

		local var_127_0 = {
			zh = 4.266,
			ja = 6.566
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
				arg_127_0:Play425071031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.4

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(425071030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 16 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 16)

				if (16 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 16)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071030", "story_v_out_425071.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071030", "story_v_out_425071.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_425071", "425071030", "story_v_out_425071.awb")

						arg_127_1:RecordAudio("425071030", var_130_6)
						arg_127_1:RecordAudio("425071030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_425071", "425071030", "story_v_out_425071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_425071", "425071030", "story_v_out_425071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play425071031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425071031
		arg_131_1.duration_ = 5.33

		local var_131_0 = {
			zh = 5.2,
			ja = 5.333
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
				arg_131_0:Play425071032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10127"]) and arg_131_1.var_.actorSpriteComps10127 == nil then
				arg_131_1.var_.actorSpriteComps10127 = arg_131_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10127"]) then
				if arg_131_1.var_.actorSpriteComps10127 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 1, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10127"]) and arg_131_1.var_.actorSpriteComps10127 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10127 = nil
			end

			local var_134_2 = arg_131_1.actors_["10127"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10127 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10127", 3)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_6" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_131_1.time_ - 0) / var_134_4)
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_134_5 = 0
			local var_134_6 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(425071031)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 25 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 25)

				if (25 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 25)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071031", "story_v_out_425071.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_425071", "425071031", "story_v_out_425071.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_425071", "425071031", "story_v_out_425071.awb")

						arg_131_1:RecordAudio("425071031", var_134_12)
						arg_131_1:RecordAudio("425071031", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425071", "425071031", "story_v_out_425071.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425071", "425071031", "story_v_out_425071.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_6, arg_131_1.talkMaxDuration)

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_5) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_5 + var_134_13 and arg_131_1.time_ < var_134_5 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play425071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425071032
		arg_135_1.duration_ = 3.83

		local var_135_0 = {
			zh = 3.2,
			ja = 3.833
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
				arg_135_0:Play425071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10127"]) and arg_135_1.var_.actorSpriteComps10127 == nil then
				arg_135_1.var_.actorSpriteComps10127 = arg_135_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10127"]) then
				if arg_135_1.var_.actorSpriteComps10127 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10127"]) and arg_135_1.var_.actorSpriteComps10127 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10127 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:GetWordFromCfg(425071032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 14 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 14)

				if (14 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 14)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071032", "story_v_out_425071.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071032", "story_v_out_425071.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_425071", "425071032", "story_v_out_425071.awb")

						arg_135_1:RecordAudio("425071032", var_138_9)
						arg_135_1:RecordAudio("425071032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_425071", "425071032", "story_v_out_425071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_425071", "425071032", "story_v_out_425071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425071033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425071033
		arg_139_1.duration_ = 7.1

		local var_139_0 = {
			zh = 7.1,
			ja = 6.266
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
				arg_139_0:Play425071034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10127 = arg_139_1.actors_["10127"].transform.localPosition
				arg_139_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10127", 7)

				for iter_142_0 = 0, arg_139_1.actors_["10127"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10127"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10127"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_2 = 0
			local var_142_3 = 0.425

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_4 = arg_139_1:GetWordFromCfg(425071033)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 17 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 17)

				if (17 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 17)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071033", "story_v_out_425071.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071033", "story_v_out_425071.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_425071", "425071033", "story_v_out_425071.awb")

						arg_139_1:RecordAudio("425071033", var_142_9)
						arg_139_1:RecordAudio("425071033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425071", "425071033", "story_v_out_425071.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425071", "425071033", "story_v_out_425071.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play425071034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425071034
		arg_143_1.duration_ = 8.87

		local var_143_0 = {
			zh = 5.766,
			ja = 8.866
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
				arg_143_0:Play425071035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(425071034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)

				if (21 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 21)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071034", "story_v_out_425071.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071034", "story_v_out_425071.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_425071", "425071034", "story_v_out_425071.awb")

						arg_143_1:RecordAudio("425071034", var_146_6)
						arg_143_1:RecordAudio("425071034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425071", "425071034", "story_v_out_425071.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425071", "425071034", "story_v_out_425071.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play425071035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425071035
		arg_147_1.duration_ = 2.63

		local var_147_0 = {
			zh = 1.733,
			ja = 2.633
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
				arg_147_0:Play425071036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.actors_["1080"] == nil then
				local var_150_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1080")

				if not isNil(var_150_0) then
					local var_150_1 = Object.Instantiate(var_150_0, arg_147_1.canvasGo_.transform)

					var_150_1.transform:SetSiblingIndex(1)

					var_150_1.name = "1080"
					var_150_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_147_1.actors_["1080"] = var_150_1

					if arg_147_1.isInRecall_ then
						for iter_150_0, iter_150_1 in ipairs((var_150_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_150_1.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_150_2 = arg_147_1.actors_["1080"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1080 == nil then
				arg_147_1.var_.actorSpriteComps1080 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1080 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								iter_150_3.color = Color.New(Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_3.color.r, 1, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_3.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1080 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_150_5 then
						iter_150_5.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1080 = nil
			end

			local var_150_5 = arg_147_1.actors_["1037"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps1037 == nil then
				arg_147_1.var_.actorSpriteComps1037 = var_150_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.actorSpriteComps1037 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								iter_150_7.color = Color.New(Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_6), Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_6), (Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_6)))
							else
								local var_150_7 = Mathf.Lerp(iter_150_7.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_6)

								iter_150_7.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps1037 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_150_9 then
						iter_150_9.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps1037 = nil
			end

			local var_150_8 = arg_147_1.actors_["1080"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1080 = var_150_8.localPosition
				var_150_8.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1080", 3)

				for iter_150_10 = 0, var_150_8.childCount - 1 do
					local var_150_9 = var_150_8:GetChild(iter_150_10)

					if var_150_9.name == "" or not string.find(var_150_9.name, "split") then
						var_150_9.gameObject:SetActive(true)
					else
						var_150_9.gameObject:SetActive(false)
					end
				end
			end

			local var_150_10 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_10 then
				var_150_8.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1080, Vector3.New(0, -378, -170), (arg_147_1.time_ - 0) / var_150_10)
			end

			if arg_147_1.time_ >= 0 + var_150_10 and arg_147_1.time_ < 0 + var_150_10 + arg_150_0 then
				var_150_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_150_11 = 0
			local var_150_12 = 0.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_13 = arg_147_1:GetWordFromCfg(425071035)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 7 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 7)

				if (7 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 7)) > 0 and var_150_12 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071035", "story_v_out_425071.awb") ~= 0 then
					local var_150_17 = manager.audio:GetVoiceLength("story_v_out_425071", "425071035", "story_v_out_425071.awb") / 1000

					if var_150_17 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_11
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_425071", "425071035", "story_v_out_425071.awb")

						arg_147_1:RecordAudio("425071035", var_150_18)
						arg_147_1:RecordAudio("425071035", var_150_18)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425071", "425071035", "story_v_out_425071.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425071", "425071035", "story_v_out_425071.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_19 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_19 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_19

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_19 and arg_147_1.time_ < var_150_11 + var_150_19 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425071036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425071036
		arg_151_1.duration_ = 10.87

		local var_151_0 = {
			zh = 7.033,
			ja = 10.866
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
				arg_151_0:Play425071037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1080 = arg_151_1.actors_["1080"].transform.localPosition
				arg_151_1.actors_["1080"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1080", 7)

				for iter_154_0 = 0, arg_151_1.actors_["1080"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["1080"].transform:GetChild(iter_154_0)

					if var_154_0.name == "" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["1080"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1080, Vector3.New(0, -2000, 0), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["1080"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_154_2 = 0
			local var_154_3 = 0.85

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:GetWordFromCfg(425071036)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 34 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 34)

				if (34 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 34)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071036", "story_v_out_425071.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071036", "story_v_out_425071.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_425071", "425071036", "story_v_out_425071.awb")

						arg_151_1:RecordAudio("425071036", var_154_9)
						arg_151_1:RecordAudio("425071036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425071", "425071036", "story_v_out_425071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425071", "425071036", "story_v_out_425071.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play425071037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425071037
		arg_155_1.duration_ = 1.5

		local var_155_0 = {
			zh = 1.266,
			ja = 1.5
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
				arg_155_0:Play425071038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.1

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(425071037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 4 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 4)

				if (4 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 4)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071037", "story_v_out_425071.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071037", "story_v_out_425071.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_425071", "425071037", "story_v_out_425071.awb")

						arg_155_1:RecordAudio("425071037", var_158_6)
						arg_155_1:RecordAudio("425071037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_425071", "425071037", "story_v_out_425071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_425071", "425071037", "story_v_out_425071.awb")
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
	Play425071038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425071038
		arg_159_1.duration_ = 5

		local var_159_0 = {
			zh = 2.533,
			ja = 5
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
				arg_159_0:Play425071039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.275

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(425071038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 11 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 11)

				if (11 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 11)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071038", "story_v_out_425071.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071038", "story_v_out_425071.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_425071", "425071038", "story_v_out_425071.awb")

						arg_159_1:RecordAudio("425071038", var_162_6)
						arg_159_1:RecordAudio("425071038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_425071", "425071038", "story_v_out_425071.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_425071", "425071038", "story_v_out_425071.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play425071039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425071039
		arg_163_1.duration_ = 5.07

		local var_163_0 = {
			zh = 2.866,
			ja = 5.066
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
				arg_163_0:Play425071040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.35

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(425071039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 14 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 14)

				if (14 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 14)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071039", "story_v_out_425071.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071039", "story_v_out_425071.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_425071", "425071039", "story_v_out_425071.awb")

						arg_163_1:RecordAudio("425071039", var_166_6)
						arg_163_1:RecordAudio("425071039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_425071", "425071039", "story_v_out_425071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_425071", "425071039", "story_v_out_425071.awb")
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
	Play425071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425071040
		arg_167_1.duration_ = 2.87

		local var_167_0 = {
			zh = 2.766,
			ja = 2.866
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
				arg_167_0:Play425071041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.2

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(425071040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 8 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 8)

				if (8 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 8)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071040", "story_v_out_425071.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071040", "story_v_out_425071.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_425071", "425071040", "story_v_out_425071.awb")

						arg_167_1:RecordAudio("425071040", var_170_6)
						arg_167_1:RecordAudio("425071040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_425071", "425071040", "story_v_out_425071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_425071", "425071040", "story_v_out_425071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play425071041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425071041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play425071042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0.698548501357436 < arg_171_1.time_ and arg_171_1.time_ <= 0.698548501357436 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run06", "")
			end

			local var_174_1 = 0
			local var_174_2 = 1.125

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(425071041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 45 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 45)

				if (45 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 45)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play425071042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425071042
		arg_175_1.duration_ = 1.87

		local var_175_0 = {
			zh = 1.466,
			ja = 1.866
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
			arg_175_1.auto_ = false
		end

		function arg_175_1.playNext_(arg_177_0)
			arg_175_1.onStoryFinished_()
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.175

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(425071042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 7 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 7)

				if (7 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 7)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071042", "story_v_out_425071.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_425071", "425071042", "story_v_out_425071.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_425071", "425071042", "story_v_out_425071.awb")

						arg_175_1:RecordAudio("425071042", var_178_6)
						arg_175_1:RecordAudio("425071042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425071", "425071042", "story_v_out_425071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425071", "425071042", "story_v_out_425071.awb")
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
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/H04"
	},
	voices = {
		"story_v_out_425071.awb"
	}
}
