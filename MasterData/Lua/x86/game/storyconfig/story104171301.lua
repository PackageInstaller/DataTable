return {
	Play417131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417131001
		arg_1_1.duration_ = 10.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.ST2105a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2105a")
				var_4_0.name = "ST2105a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2105a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2105a

				arg_1_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2105a" then
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

			if 4.18791796957764 < arg_1_1.time_ and arg_1_1.time_ <= 4.18791796957764 + arg_4_0 then
				local var_4_5 = arg_1_1.var_.effect809

				if not arg_1_1.var_.effect809 then
					var_4_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), manager.ui.mainCamera.transform)
					var_4_5.name = "809"
					arg_1_1.var_.effect809 = var_4_5
				else
					var_4_5.transform:SetParent(var_4_9000)
				end

				var_4_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_8 = var_4_5.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_2, iter_4_3 in ipairs((var_4_8:ToTable())) do
					iter_4_3.transform.localScale = Vector3.New(iter_4_3.transform.localScale.x / var_4_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_8 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_3.transform.localScale.y / var_4_7, iter_4_3.transform.localScale.z)
				end
			end

			if 0.0430384017527103 < arg_1_1.time_ and arg_1_1.time_ <= 0.0430384017527103 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_3_10_story_dock", "bgm_activity_3_10_story_dock")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2105a")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501043).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_17 + 3 and arg_1_1.time_ < var_4_17 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_18 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 1.2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = Color.New(0, 0, 0)

				var_4_20.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_18) / var_4_19)
				arg_1_1.mask_.color = var_4_20
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = 1
				arg_1_1.mask_.color = var_4_21
			end

			local var_4_22 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_23 = 1.2

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = Color.New(0, 0, 0)

				var_4_24.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_22) / var_4_23)
				arg_1_1.mask_.color = var_4_24
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				local var_4_25 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_25.a = 0
				arg_1_1.mask_.color = var_4_25
			end

			local var_4_26 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_27 = 1

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = Color.New(0, 0, 0)

				var_4_28.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_26) / var_4_27)
				arg_1_1.mask_.color = var_4_28
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				local var_4_29 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_29.a = 0
				arg_1_1.mask_.color = var_4_29
			end

			local var_4_30 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_30 + 3 and arg_1_1.time_ < var_4_30 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_31 = 5.4
			local var_4_32 = 1.3

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417131001).content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 52 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_34) / 52)

				if (52 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_34) / 52)) > 0 and var_4_32 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_31 = var_4_31 + 0.3

					if var_4_36 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_31 + 0.3
			local var_4_38 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_31 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417131002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417131002
		arg_10_1.duration_ = 9.87

		local var_10_0 = {
			zh = 5.333,
			ja = 9.866
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
				arg_10_0:Play417131003(arg_10_1)
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

				arg_10_1:CheckSpriteTmpPos("1034", 2)

				for iter_13_6 = 0, var_13_5.childCount - 1 do
					local var_13_6 = var_13_5:GetChild(iter_13_6)

					if var_13_6.name == "split_4" or not string.find(var_13_6.name, "split") then
						var_13_6.gameObject:SetActive(true)
					else
						var_13_6.gameObject:SetActive(false)
					end
				end
			end

			local var_13_7 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_10_1.time_ - 0) / var_13_7)
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_13_8 = 0
			local var_13_9 = 0.725

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

				local var_13_10 = arg_10_1:GetWordFromCfg(417131002)
				local var_13_11 = arg_10_1:FormatText(var_13_10.content)

				arg_10_1.text_.text = var_13_11

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 29 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 29)

				if (29 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_11) / 29)) > 0 and var_13_9 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_11
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131002", "story_v_out_417131.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131002", "story_v_out_417131.awb") / 1000

					if var_13_14 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_8
					end

					if var_13_10.prefab_name ~= "" and arg_10_1.actors_[var_13_10.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_10.prefab_name].transform, "story_v_out_417131", "417131002", "story_v_out_417131.awb")

						arg_10_1:RecordAudio("417131002", var_13_15)
						arg_10_1:RecordAudio("417131002", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417131", "417131002", "story_v_out_417131.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417131", "417131002", "story_v_out_417131.awb")
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
	Play417131003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417131003
		arg_14_1.duration_ = 10

		local var_14_0 = {
			zh = 10,
			ja = 8.433
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
				arg_14_0:Play417131004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["10115"] == nil then
				local var_17_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_17_0) then
					local var_17_1 = Object.Instantiate(var_17_0, arg_14_1.canvasGo_.transform)

					var_17_1.transform:SetSiblingIndex(1)

					var_17_1.name = "10115"
					var_17_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_["10115"] = var_17_1

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs((var_17_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_2 = arg_14_1.actors_["10115"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10115 == nil then
				arg_14_1.var_.actorSpriteComps10115 = var_17_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_3 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_3 and not isNil(var_17_2) then
				if arg_14_1.var_.actorSpriteComps10115 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								iter_17_3.color = Color.New(Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_3), Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_3), (Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_3)))
							else
								local var_17_4 = Mathf.Lerp(iter_17_3.color.r, 1, (arg_14_1.time_ - 0) / var_17_3)

								iter_17_3.color = Color.New(var_17_4, var_17_4, var_17_4)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_3 and arg_14_1.time_ < 0 + var_17_3 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10115 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_17_5 then
						iter_17_5.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps10115 = nil
			end

			local var_17_5 = arg_14_1.actors_["1034"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_6 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_6 and not isNil(var_17_5) then
				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_7 then
							if arg_14_1.isInRecall_ then
								iter_17_7.color = Color.New(Mathf.Lerp(iter_17_7.color.r, arg_14_1.hightColor2.r, (arg_14_1.time_ - 0) / var_17_6), Mathf.Lerp(iter_17_7.color.g, arg_14_1.hightColor2.g, (arg_14_1.time_ - 0) / var_17_6), (Mathf.Lerp(iter_17_7.color.b, arg_14_1.hightColor2.b, (arg_14_1.time_ - 0) / var_17_6)))
							else
								local var_17_7 = Mathf.Lerp(iter_17_7.color.r, 0.5, (arg_14_1.time_ - 0) / var_17_6)

								iter_17_7.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_6 and arg_14_1.time_ < 0 + var_17_6 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_9 then
						iter_17_9.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_8 = arg_14_1.actors_["10115"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10115 = var_17_8.localPosition
				var_17_8.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10115", 4)

				for iter_17_10 = 0, var_17_8.childCount - 1 do
					local var_17_9 = var_17_8:GetChild(iter_17_10)

					if var_17_9.name == "" or not string.find(var_17_9.name, "split") then
						var_17_9.gameObject:SetActive(true)
					else
						var_17_9.gameObject:SetActive(false)
					end
				end
			end

			local var_17_10 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_10 then
				var_17_8.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_14_1.time_ - 0) / var_17_10)
			end

			if arg_14_1.time_ >= 0 + var_17_10 and arg_14_1.time_ < 0 + var_17_10 + arg_17_0 then
				var_17_8.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_17_11 = 0
			local var_17_12 = 1.15

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_13 = arg_14_1:GetWordFromCfg(417131003)
				local var_17_14 = arg_14_1:FormatText(var_17_13.content)

				arg_14_1.text_.text = var_17_14

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_16 = 46 <= 0 and var_17_12 or var_17_12 * (utf8.len(var_17_14) / 46)

				if (46 <= 0 and var_17_12 or var_17_12 * (utf8.len(var_17_14) / 46)) > 0 and var_17_12 < var_17_16 then
					arg_14_1.talkMaxDuration = var_17_16

					if var_17_16 + var_17_11 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_16 + var_17_11
					end
				end

				arg_14_1.text_.text = var_17_14
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131003", "story_v_out_417131.awb") ~= 0 then
					local var_17_17 = manager.audio:GetVoiceLength("story_v_out_417131", "417131003", "story_v_out_417131.awb") / 1000

					if var_17_17 + var_17_11 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_17 + var_17_11
					end

					if var_17_13.prefab_name ~= "" and arg_14_1.actors_[var_17_13.prefab_name] ~= nil then
						local var_17_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_13.prefab_name].transform, "story_v_out_417131", "417131003", "story_v_out_417131.awb")

						arg_14_1:RecordAudio("417131003", var_17_18)
						arg_14_1:RecordAudio("417131003", var_17_18)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417131", "417131003", "story_v_out_417131.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417131", "417131003", "story_v_out_417131.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_19 = math.max(var_17_12, arg_14_1.talkMaxDuration)

			if var_17_11 <= arg_14_1.time_ and arg_14_1.time_ < var_17_11 + var_17_19 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_11) / var_17_19

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_11 + var_17_19 and arg_14_1.time_ < var_17_11 + var_17_19 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417131004
		arg_18_1.duration_ = 8.1

		local var_18_0 = {
			zh = 5.5,
			ja = 8.1
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
				arg_18_0:Play417131005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.625

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(417131004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 25 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 25)

				if (25 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 25)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131004", "story_v_out_417131.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131004", "story_v_out_417131.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417131", "417131004", "story_v_out_417131.awb")

						arg_18_1:RecordAudio("417131004", var_21_6)
						arg_18_1:RecordAudio("417131004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417131", "417131004", "story_v_out_417131.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417131", "417131004", "story_v_out_417131.awb")
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
	Play417131005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417131005
		arg_22_1.duration_ = 7.27

		local var_22_0 = {
			zh = 2.566,
			ja = 7.266
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
				arg_22_0:Play417131006(arg_22_1)
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
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor1.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor1.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor1.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 1, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1034"]) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_2 = arg_22_1.actors_["10115"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = var_25_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_3 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_3 and not isNil(var_25_2) then
				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_25_5 then
							if arg_22_1.isInRecall_ then
								iter_25_5.color = Color.New(Mathf.Lerp(iter_25_5.color.r, arg_22_1.hightColor2.r, (arg_22_1.time_ - 0) / var_25_3), Mathf.Lerp(iter_25_5.color.g, arg_22_1.hightColor2.g, (arg_22_1.time_ - 0) / var_25_3), (Mathf.Lerp(iter_25_5.color.b, arg_22_1.hightColor2.b, (arg_22_1.time_ - 0) / var_25_3)))
							else
								local var_25_4 = Mathf.Lerp(iter_25_5.color.r, 0.5, (arg_22_1.time_ - 0) / var_25_3)

								iter_25_5.color = Color.New(var_25_4, var_25_4, var_25_4)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_3 and arg_22_1.time_ < 0 + var_25_3 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_6, iter_25_7 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_7 then
						iter_25_7.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_5 = 0
			local var_25_6 = 0.375

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_7 = arg_22_1:GetWordFromCfg(417131005)
				local var_25_8 = arg_22_1:FormatText(var_25_7.content)

				arg_22_1.text_.text = var_25_8

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_10 = 15 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 15)

				if (15 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 15)) > 0 and var_25_6 < var_25_10 then
					arg_22_1.talkMaxDuration = var_25_10

					if var_25_10 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_5
					end
				end

				arg_22_1.text_.text = var_25_8
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131005", "story_v_out_417131.awb") ~= 0 then
					local var_25_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131005", "story_v_out_417131.awb") / 1000

					if var_25_11 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_5
					end

					if var_25_7.prefab_name ~= "" and arg_22_1.actors_[var_25_7.prefab_name] ~= nil then
						local var_25_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_7.prefab_name].transform, "story_v_out_417131", "417131005", "story_v_out_417131.awb")

						arg_22_1:RecordAudio("417131005", var_25_12)
						arg_22_1:RecordAudio("417131005", var_25_12)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417131", "417131005", "story_v_out_417131.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417131", "417131005", "story_v_out_417131.awb")
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

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417131006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417131006
		arg_26_1.duration_ = 6.53

		local var_26_0 = {
			zh = 2.066,
			ja = 6.533
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
				arg_26_0:Play417131007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10115"]) and arg_26_1.var_.actorSpriteComps10115 == nil then
				arg_26_1.var_.actorSpriteComps10115 = arg_26_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10115"]) then
				if arg_26_1.var_.actorSpriteComps10115 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								iter_29_1.color = Color.New(Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, (arg_26_1.time_ - 0) / var_29_0), Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, (arg_26_1.time_ - 0) / var_29_0), (Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, (arg_26_1.time_ - 0) / var_29_0)))
							else
								local var_29_1 = Mathf.Lerp(iter_29_1.color.r, 1, (arg_26_1.time_ - 0) / var_29_0)

								iter_29_1.color = Color.New(var_29_1, var_29_1, var_29_1)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10115"]) and arg_26_1.var_.actorSpriteComps10115 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps10115 = nil
			end

			local var_29_2 = arg_26_1.actors_["1034"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps1034 == nil then
				arg_26_1.var_.actorSpriteComps1034 = var_29_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_3 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.actorSpriteComps1034 then
					for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_29_5 then
							if arg_26_1.isInRecall_ then
								iter_29_5.color = Color.New(Mathf.Lerp(iter_29_5.color.r, arg_26_1.hightColor2.r, (arg_26_1.time_ - 0) / var_29_3), Mathf.Lerp(iter_29_5.color.g, arg_26_1.hightColor2.g, (arg_26_1.time_ - 0) / var_29_3), (Mathf.Lerp(iter_29_5.color.b, arg_26_1.hightColor2.b, (arg_26_1.time_ - 0) / var_29_3)))
							else
								local var_29_4 = Mathf.Lerp(iter_29_5.color.r, 0.5, (arg_26_1.time_ - 0) / var_29_3)

								iter_29_5.color = Color.New(var_29_4, var_29_4, var_29_4)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps1034 then
				for iter_29_6, iter_29_7 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_29_7 then
						iter_29_7.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_26_1.var_.actorSpriteComps1034 = nil
			end

			local var_29_5 = arg_26_1.actors_["10115"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10115 = var_29_5.localPosition
				var_29_5.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10115", 4)

				for iter_29_8 = 0, var_29_5.childCount - 1 do
					local var_29_6 = var_29_5:GetChild(iter_29_8)

					if var_29_6.name == "split_4" or not string.find(var_29_6.name, "split") then
						var_29_6.gameObject:SetActive(true)
					else
						var_29_6.gameObject:SetActive(false)
					end
				end
			end

			local var_29_7 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_26_1.time_ - 0) / var_29_7)
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_29_8 = 0
			local var_29_9 = 0.25

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_10 = arg_26_1:GetWordFromCfg(417131006)
				local var_29_11 = arg_26_1:FormatText(var_29_10.content)

				arg_26_1.text_.text = var_29_11

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 10 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 10)

				if (10 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 10)) > 0 and var_29_9 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_11
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131006", "story_v_out_417131.awb") ~= 0 then
					local var_29_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131006", "story_v_out_417131.awb") / 1000

					if var_29_14 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_14 + var_29_8
					end

					if var_29_10.prefab_name ~= "" and arg_26_1.actors_[var_29_10.prefab_name] ~= nil then
						local var_29_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_10.prefab_name].transform, "story_v_out_417131", "417131006", "story_v_out_417131.awb")

						arg_26_1:RecordAudio("417131006", var_29_15)
						arg_26_1:RecordAudio("417131006", var_29_15)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417131", "417131006", "story_v_out_417131.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417131", "417131006", "story_v_out_417131.awb")
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
				actorName = "10115",
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
	Play417131007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417131007
		arg_30_1.duration_ = 5.9

		local var_30_0 = {
			zh = 4.266,
			ja = 5.9
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
				arg_30_0:Play417131008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = arg_30_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1034"]) then
				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_2 = arg_30_1.actors_["10115"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.actorSpriteComps10115 == nil then
				arg_30_1.var_.actorSpriteComps10115 = var_33_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_3 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 and not isNil(var_33_2) then
				if arg_30_1.var_.actorSpriteComps10115 then
					for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.actorSpriteComps10115 then
				for iter_33_6, iter_33_7 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_33_7 then
						iter_33_7.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps10115 = nil
			end

			local var_33_5 = arg_30_1.actors_["1034"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_5.localPosition
				var_33_5.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 2)

				for iter_33_8 = 0, var_33_5.childCount - 1 do
					local var_33_6 = var_33_5:GetChild(iter_33_8)

					if var_33_6.name == "split_3" or not string.find(var_33_6.name, "split") then
						var_33_6.gameObject:SetActive(true)
					else
						var_33_6.gameObject:SetActive(false)
					end
				end
			end

			local var_33_7 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				var_33_5.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_30_1.time_ - 0) / var_33_7)
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				var_33_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_33_8 = 0
			local var_33_9 = 0.575

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_10 = arg_30_1:GetWordFromCfg(417131007)
				local var_33_11 = arg_30_1:FormatText(var_33_10.content)

				arg_30_1.text_.text = var_33_11

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 23 <= 0 and var_33_9 or var_33_9 * (utf8.len(var_33_11) / 23)

				if (23 <= 0 and var_33_9 or var_33_9 * (utf8.len(var_33_11) / 23)) > 0 and var_33_9 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_11
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131007", "story_v_out_417131.awb") ~= 0 then
					local var_33_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131007", "story_v_out_417131.awb") / 1000

					if var_33_14 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_8
					end

					if var_33_10.prefab_name ~= "" and arg_30_1.actors_[var_33_10.prefab_name] ~= nil then
						local var_33_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_10.prefab_name].transform, "story_v_out_417131", "417131007", "story_v_out_417131.awb")

						arg_30_1:RecordAudio("417131007", var_33_15)
						arg_30_1:RecordAudio("417131007", var_33_15)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417131", "417131007", "story_v_out_417131.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417131", "417131007", "story_v_out_417131.awb")
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
				actorName = "1034",
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
	Play417131008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417131008
		arg_34_1.duration_ = 9.37

		local var_34_0 = {
			zh = 9.2,
			ja = 9.366
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
				arg_34_0:Play417131009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.95

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(417131008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 38 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 38)

				if (38 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 38)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131008", "story_v_out_417131.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131008", "story_v_out_417131.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_417131", "417131008", "story_v_out_417131.awb")

						arg_34_1:RecordAudio("417131008", var_37_6)
						arg_34_1:RecordAudio("417131008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417131", "417131008", "story_v_out_417131.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417131", "417131008", "story_v_out_417131.awb")
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
	Play417131009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417131009
		arg_38_1.duration_ = 9.93

		local var_38_0 = {
			zh = 4.1,
			ja = 9.933
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
				arg_38_0:Play417131010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10115"]) and arg_38_1.var_.actorSpriteComps10115 == nil then
				arg_38_1.var_.actorSpriteComps10115 = arg_38_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10115"]) then
				if arg_38_1.var_.actorSpriteComps10115 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10115"]) and arg_38_1.var_.actorSpriteComps10115 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps10115 = nil
			end

			local var_41_2 = arg_38_1.actors_["1034"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_3 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								iter_41_5.color = Color.New(Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, (arg_38_1.time_ - 0) / var_41_3), Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, (arg_38_1.time_ - 0) / var_41_3), (Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, (arg_38_1.time_ - 0) / var_41_3)))
							else
								local var_41_4 = Mathf.Lerp(iter_41_5.color.r, 0.5, (arg_38_1.time_ - 0) / var_41_3)

								iter_41_5.color = Color.New(var_41_4, var_41_4, var_41_4)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_7 then
						iter_41_7.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_5 = arg_38_1.actors_["10115"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10115 = var_41_5.localPosition
				var_41_5.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10115", 4)

				for iter_41_8 = 0, var_41_5.childCount - 1 do
					local var_41_6 = var_41_5:GetChild(iter_41_8)

					if var_41_6.name == "split_6" or not string.find(var_41_6.name, "split") then
						var_41_6.gameObject:SetActive(true)
					else
						var_41_6.gameObject:SetActive(false)
					end
				end
			end

			local var_41_7 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_38_1.time_ - 0) / var_41_7)
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_41_8 = 0
			local var_41_9 = 0.475

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_10 = arg_38_1:GetWordFromCfg(417131009)
				local var_41_11 = arg_38_1:FormatText(var_41_10.content)

				arg_38_1.text_.text = var_41_11

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 19 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 19)

				if (19 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 19)) > 0 and var_41_9 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_11
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131009", "story_v_out_417131.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131009", "story_v_out_417131.awb") / 1000

					if var_41_14 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_8
					end

					if var_41_10.prefab_name ~= "" and arg_38_1.actors_[var_41_10.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_10.prefab_name].transform, "story_v_out_417131", "417131009", "story_v_out_417131.awb")

						arg_38_1:RecordAudio("417131009", var_41_15)
						arg_38_1:RecordAudio("417131009", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417131", "417131009", "story_v_out_417131.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417131", "417131009", "story_v_out_417131.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_16 and arg_38_1.time_ < var_41_8 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417131010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417131010
		arg_42_1.duration_ = 3.13

		local var_42_0 = {
			zh = 3.133,
			ja = 2.8
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
				arg_42_0:Play417131011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = arg_42_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1034"]) then
				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_2 = arg_42_1.actors_["10115"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10115 == nil then
				arg_42_1.var_.actorSpriteComps10115 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps10115 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								iter_45_5.color = Color.New(Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_5.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_5.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10115 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_45_7 then
						iter_45_7.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps10115 = nil
			end

			local var_45_5 = arg_42_1.actors_["1034"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = var_45_5.localPosition
				var_45_5.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 2)

				for iter_45_8 = 0, var_45_5.childCount - 1 do
					local var_45_6 = var_45_5:GetChild(iter_45_8)

					if var_45_6.name == "split_6" or not string.find(var_45_6.name, "split") then
						var_45_6.gameObject:SetActive(true)
					else
						var_45_6.gameObject:SetActive(false)
					end
				end
			end

			local var_45_7 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				var_45_5.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_42_1.time_ - 0) / var_45_7)
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				var_45_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_45_8 = 0
			local var_45_9 = 0.2

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_10 = arg_42_1:GetWordFromCfg(417131010)
				local var_45_11 = arg_42_1:FormatText(var_45_10.content)

				arg_42_1.text_.text = var_45_11

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 8 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 8)

				if (8 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 8)) > 0 and var_45_9 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_11
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131010", "story_v_out_417131.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131010", "story_v_out_417131.awb") / 1000

					if var_45_14 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_8
					end

					if var_45_10.prefab_name ~= "" and arg_42_1.actors_[var_45_10.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_10.prefab_name].transform, "story_v_out_417131", "417131010", "story_v_out_417131.awb")

						arg_42_1:RecordAudio("417131010", var_45_15)
						arg_42_1:RecordAudio("417131010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417131", "417131010", "story_v_out_417131.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417131", "417131010", "story_v_out_417131.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_16 and arg_42_1.time_ < var_45_8 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play417131011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417131011
		arg_46_1.duration_ = 6.27

		local var_46_0 = {
			zh = 5.066,
			ja = 6.266
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
				arg_46_0:Play417131012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.625

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
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

				local var_49_1 = arg_46_1:GetWordFromCfg(417131011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 25 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 25)

				if (25 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 25)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131011", "story_v_out_417131.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131011", "story_v_out_417131.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_417131", "417131011", "story_v_out_417131.awb")

						arg_46_1:RecordAudio("417131011", var_49_6)
						arg_46_1:RecordAudio("417131011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417131", "417131011", "story_v_out_417131.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417131", "417131011", "story_v_out_417131.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417131012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417131012
		arg_50_1.duration_ = 6.43

		local var_50_0 = {
			zh = 6,
			ja = 6.433
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
				arg_50_0:Play417131013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10115"]) and arg_50_1.var_.actorSpriteComps10115 == nil then
				arg_50_1.var_.actorSpriteComps10115 = arg_50_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10115"]) then
				if arg_50_1.var_.actorSpriteComps10115 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10115"]) and arg_50_1.var_.actorSpriteComps10115 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10115 = nil
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

			local var_53_5 = 0
			local var_53_6 = 0.65

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(417131012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 26 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 26)

				if (26 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 26)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131012", "story_v_out_417131.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131012", "story_v_out_417131.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_417131", "417131012", "story_v_out_417131.awb")

						arg_50_1:RecordAudio("417131012", var_53_12)
						arg_50_1:RecordAudio("417131012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417131", "417131012", "story_v_out_417131.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417131", "417131012", "story_v_out_417131.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417131013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417131013
		arg_54_1.duration_ = 6.63

		local var_54_0 = {
			zh = 4.533,
			ja = 6.633
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
				arg_54_0:Play417131014(arg_54_1)
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

			local var_57_2 = arg_54_1.actors_["10115"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps10115 == nil then
				arg_54_1.var_.actorSpriteComps10115 = var_57_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_3 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.actorSpriteComps10115 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps10115 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_57_7 then
						iter_57_7.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps10115 = nil
			end

			local var_57_5 = 0
			local var_57_6 = 0.55

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

				local var_57_7 = arg_54_1:GetWordFromCfg(417131013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 22 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 22)

				if (22 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 22)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131013", "story_v_out_417131.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131013", "story_v_out_417131.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_417131", "417131013", "story_v_out_417131.awb")

						arg_54_1:RecordAudio("417131013", var_57_12)
						arg_54_1:RecordAudio("417131013", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417131", "417131013", "story_v_out_417131.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417131", "417131013", "story_v_out_417131.awb")
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
	Play417131014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417131014
		arg_58_1.duration_ = 12.1

		local var_58_0 = {
			zh = 9.9,
			ja = 12.1
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
				arg_58_0:Play417131015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10115"]) and arg_58_1.var_.actorSpriteComps10115 == nil then
				arg_58_1.var_.actorSpriteComps10115 = arg_58_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10115"]) then
				if arg_58_1.var_.actorSpriteComps10115 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10115"]) and arg_58_1.var_.actorSpriteComps10115 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10115 = nil
			end

			local var_61_2 = arg_58_1.actors_["1034"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								iter_61_5.color = Color.New(Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_5.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_5.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_7 then
						iter_61_7.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_5 = arg_58_1.actors_["10115"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10115 = var_61_5.localPosition
				var_61_5.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10115", 4)

				for iter_61_8 = 0, var_61_5.childCount - 1 do
					local var_61_6 = var_61_5:GetChild(iter_61_8)

					if var_61_6.name == "split_4" or not string.find(var_61_6.name, "split") then
						var_61_6.gameObject:SetActive(true)
					else
						var_61_6.gameObject:SetActive(false)
					end
				end
			end

			local var_61_7 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_58_1.time_ - 0) / var_61_7)
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_61_8 = 0
			local var_61_9 = 1.2

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:GetWordFromCfg(417131014)
				local var_61_11 = arg_58_1:FormatText(var_61_10.content)

				arg_58_1.text_.text = var_61_11

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 48 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 48)

				if (48 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 48)) > 0 and var_61_9 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_11
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131014", "story_v_out_417131.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131014", "story_v_out_417131.awb") / 1000

					if var_61_14 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_8
					end

					if var_61_10.prefab_name ~= "" and arg_58_1.actors_[var_61_10.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_10.prefab_name].transform, "story_v_out_417131", "417131014", "story_v_out_417131.awb")

						arg_58_1:RecordAudio("417131014", var_61_15)
						arg_58_1:RecordAudio("417131014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417131", "417131014", "story_v_out_417131.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417131", "417131014", "story_v_out_417131.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play417131015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417131015
		arg_62_1.duration_ = 10.8

		local var_62_0 = {
			zh = 10.433,
			ja = 10.8
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
				arg_62_0:Play417131016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10115 = arg_62_1.actors_["10115"].transform.localPosition
				arg_62_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10115", 4)

				for iter_65_0 = 0, arg_62_1.actors_["10115"].transform.childCount - 1 do
					local var_65_0 = arg_62_1.actors_["10115"].transform:GetChild(iter_65_0)

					if var_65_0.name == "split_6" or not string.find(var_65_0.name, "split") then
						var_65_0.gameObject:SetActive(true)
					else
						var_65_0.gameObject:SetActive(false)
					end
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_62_1.time_ - 0) / var_65_1)
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["10115"].transform.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_65_2 = 0
			local var_65_3 = 1.325

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(417131015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 53 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 53)

				if (53 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 53)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131015", "story_v_out_417131.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131015", "story_v_out_417131.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_417131", "417131015", "story_v_out_417131.awb")

						arg_62_1:RecordAudio("417131015", var_65_9)
						arg_62_1:RecordAudio("417131015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417131", "417131015", "story_v_out_417131.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417131", "417131015", "story_v_out_417131.awb")
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
				actorName = "10115",
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
	Play417131016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417131016
		arg_66_1.duration_ = 8.8

		local var_66_0 = {
			zh = 8.8,
			ja = 8.533
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
				arg_66_0:Play417131017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.1

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(417131016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 44 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 44)

				if (44 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 44)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131016", "story_v_out_417131.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131016", "story_v_out_417131.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_417131", "417131016", "story_v_out_417131.awb")

						arg_66_1:RecordAudio("417131016", var_69_6)
						arg_66_1:RecordAudio("417131016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417131", "417131016", "story_v_out_417131.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417131", "417131016", "story_v_out_417131.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417131017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417131017
		arg_70_1.duration_ = 5.1

		local var_70_0 = {
			zh = 4.3,
			ja = 5.1
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
				arg_70_0:Play417131018(arg_70_1)
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

			local var_73_2 = arg_70_1.actors_["10115"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10115 == nil then
				arg_70_1.var_.actorSpriteComps10115 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps10115 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10115 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps10115 = nil
			end

			local var_73_5 = arg_70_1.actors_["1034"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_5.localPosition
				var_73_5.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 2)

				for iter_73_8 = 0, var_73_5.childCount - 1 do
					local var_73_6 = var_73_5:GetChild(iter_73_8)

					if var_73_6.name == "split_4" or not string.find(var_73_6.name, "split") then
						var_73_6.gameObject:SetActive(true)
					else
						var_73_6.gameObject:SetActive(false)
					end
				end
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_70_1.time_ - 0) / var_73_7)
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_73_8 = 0
			local var_73_9 = 0.25

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
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

				local var_73_10 = arg_70_1:GetWordFromCfg(417131017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 10 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 10)

				if (10 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 10)) > 0 and var_73_9 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131017", "story_v_out_417131.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131017", "story_v_out_417131.awb") / 1000

					if var_73_14 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_8
					end

					if var_73_10.prefab_name ~= "" and arg_70_1.actors_[var_73_10.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_10.prefab_name].transform, "story_v_out_417131", "417131017", "story_v_out_417131.awb")

						arg_70_1:RecordAudio("417131017", var_73_15)
						arg_70_1:RecordAudio("417131017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417131", "417131017", "story_v_out_417131.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417131", "417131017", "story_v_out_417131.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_16 and arg_70_1.time_ < var_73_8 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play417131018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417131018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417131019(arg_74_1)
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

			local var_77_2 = 0
			local var_77_3 = 1.35

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(417131018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 54 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 54)

				if (54 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 54)) > 0 and var_77_3 < var_77_6 then
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
	Play417131019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417131019
		arg_78_1.duration_ = 12.17

		local var_78_0 = {
			zh = 12.166,
			ja = 9.366
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
				arg_78_0:Play417131020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1034"]) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = arg_78_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1034"]) then
				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1034"]) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_2 = arg_78_1.actors_["1034"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 2)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "split_6" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_78_1.time_ - 0) / var_81_4)
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_81_5 = 0
			local var_81_6 = 1

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(417131019)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 40 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 40)

				if (40 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 40)) > 0 and var_81_6 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131019", "story_v_out_417131.awb") ~= 0 then
					local var_81_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131019", "story_v_out_417131.awb") / 1000

					if var_81_11 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_5
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_417131", "417131019", "story_v_out_417131.awb")

						arg_78_1:RecordAudio("417131019", var_81_12)
						arg_78_1:RecordAudio("417131019", var_81_12)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417131", "417131019", "story_v_out_417131.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417131", "417131019", "story_v_out_417131.awb")
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
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play417131020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417131020
		arg_82_1.duration_ = 11.37

		local var_82_0 = {
			zh = 11.366,
			ja = 10.566
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
				arg_82_0:Play417131021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.4

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(417131020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 56)

				if (56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 56)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131020", "story_v_out_417131.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131020", "story_v_out_417131.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_417131", "417131020", "story_v_out_417131.awb")

						arg_82_1:RecordAudio("417131020", var_85_6)
						arg_82_1:RecordAudio("417131020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417131", "417131020", "story_v_out_417131.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417131", "417131020", "story_v_out_417131.awb")
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
	Play417131021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417131021
		arg_86_1.duration_ = 9.77

		local var_86_0 = {
			zh = 9.766,
			ja = 9.4
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
				arg_86_0:Play417131022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.2

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(417131021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 48 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 48)

				if (48 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 48)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131021", "story_v_out_417131.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131021", "story_v_out_417131.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_417131", "417131021", "story_v_out_417131.awb")

						arg_86_1:RecordAudio("417131021", var_89_6)
						arg_86_1:RecordAudio("417131021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417131", "417131021", "story_v_out_417131.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417131", "417131021", "story_v_out_417131.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417131022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417131022
		arg_90_1.duration_ = 4.3

		local var_90_0 = {
			zh = 4.3,
			ja = 2.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417131023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10115"]) and arg_90_1.var_.actorSpriteComps10115 == nil then
				arg_90_1.var_.actorSpriteComps10115 = arg_90_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10115"]) then
				if arg_90_1.var_.actorSpriteComps10115 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10115"]) and arg_90_1.var_.actorSpriteComps10115 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps10115 = nil
			end

			local var_93_2 = arg_90_1.actors_["1034"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.actorSpriteComps1034 == nil then
				arg_90_1.var_.actorSpriteComps1034 = var_93_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_3 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.actorSpriteComps1034 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								iter_93_5.color = Color.New(Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_3), Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_3), (Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_3)))
							else
								local var_93_4 = Mathf.Lerp(iter_93_5.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_3)

								iter_93_5.color = Color.New(var_93_4, var_93_4, var_93_4)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.actorSpriteComps1034 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_93_7 then
						iter_93_7.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps1034 = nil
			end

			local var_93_5 = arg_90_1.actors_["10115"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10115 = var_93_5.localPosition
				var_93_5.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10115", 4)

				for iter_93_8 = 0, var_93_5.childCount - 1 do
					local var_93_6 = var_93_5:GetChild(iter_93_8)

					if var_93_6.name == "split_4" or not string.find(var_93_6.name, "split") then
						var_93_6.gameObject:SetActive(true)
					else
						var_93_6.gameObject:SetActive(false)
					end
				end
			end

			local var_93_7 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_90_1.time_ - 0) / var_93_7)
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_93_8 = 0
			local var_93_9 = 1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(417131022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 17 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 17)

				if (17 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 17)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131022", "story_v_out_417131.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131022", "story_v_out_417131.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_417131", "417131022", "story_v_out_417131.awb")

						arg_90_1:RecordAudio("417131022", var_93_15)
						arg_90_1:RecordAudio("417131022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417131", "417131022", "story_v_out_417131.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417131", "417131022", "story_v_out_417131.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play417131023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417131023
		arg_94_1.duration_ = 7.13

		local var_94_0 = {
			zh = 5.933,
			ja = 7.133
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417131024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1034"]) and arg_94_1.var_.actorSpriteComps1034 == nil then
				arg_94_1.var_.actorSpriteComps1034 = arg_94_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1034"]) then
				if arg_94_1.var_.actorSpriteComps1034 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1034"]) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			local var_97_2 = arg_94_1.actors_["10115"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps10115 == nil then
				arg_94_1.var_.actorSpriteComps10115 = var_97_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_3 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.actorSpriteComps10115 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								iter_97_5.color = Color.New(Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_3), Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_3), (Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_3)))
							else
								local var_97_4 = Mathf.Lerp(iter_97_5.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_3)

								iter_97_5.color = Color.New(var_97_4, var_97_4, var_97_4)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps10115 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_97_7 then
						iter_97_7.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps10115 = nil
			end

			local var_97_5 = arg_94_1.actors_["1034"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1034 = var_97_5.localPosition
				var_97_5.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1034", 2)

				for iter_97_8 = 0, var_97_5.childCount - 1 do
					local var_97_6 = var_97_5:GetChild(iter_97_8)

					if var_97_6.name == "split_3" or not string.find(var_97_6.name, "split") then
						var_97_6.gameObject:SetActive(true)
					else
						var_97_6.gameObject:SetActive(false)
					end
				end
			end

			local var_97_7 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				var_97_5.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_94_1.time_ - 0) / var_97_7)
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				var_97_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_97_8 = 0
			local var_97_9 = 0.55

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(417131023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 22 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 22)

				if (22 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 22)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131023", "story_v_out_417131.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131023", "story_v_out_417131.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_417131", "417131023", "story_v_out_417131.awb")

						arg_94_1:RecordAudio("417131023", var_97_15)
						arg_94_1:RecordAudio("417131023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417131", "417131023", "story_v_out_417131.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417131", "417131023", "story_v_out_417131.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play417131024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417131024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417131025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1034"]) and arg_98_1.var_.actorSpriteComps1034 == nil then
				arg_98_1.var_.actorSpriteComps1034 = arg_98_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1034"]) then
				if arg_98_1.var_.actorSpriteComps1034 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor2.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor2.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor2.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 0.5, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1034"]) and arg_98_1.var_.actorSpriteComps1034 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps1034 = nil
			end

			local var_101_2 = arg_98_1.actors_["1034"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1034 = var_101_2.localPosition
				var_101_2.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1034", 2)

				for iter_101_4 = 0, var_101_2.childCount - 1 do
					local var_101_3 = var_101_2:GetChild(iter_101_4)

					if var_101_3.name == "split_6" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_98_1.time_ - 0) / var_101_4)
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_101_5 = 0
			local var_101_6 = 1.55

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(417131024).content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 62 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 62)

				if (62 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 62)) > 0 and var_101_6 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_10 and arg_98_1.time_ < var_101_5 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play417131025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417131025
		arg_102_1.duration_ = 10.3

		local var_102_0 = {
			zh = 7.1,
			ja = 10.3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417131026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1034"]) and arg_102_1.var_.actorSpriteComps1034 == nil then
				arg_102_1.var_.actorSpriteComps1034 = arg_102_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1034"]) then
				if arg_102_1.var_.actorSpriteComps1034 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 1, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1034"]) and arg_102_1.var_.actorSpriteComps1034 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps1034 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.55

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(417131025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 22 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 22)

				if (22 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 22)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131025", "story_v_out_417131.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131025", "story_v_out_417131.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_417131", "417131025", "story_v_out_417131.awb")

						arg_102_1:RecordAudio("417131025", var_105_9)
						arg_102_1:RecordAudio("417131025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417131", "417131025", "story_v_out_417131.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417131", "417131025", "story_v_out_417131.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417131026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417131026
		arg_106_1.duration_ = 4.43

		local var_106_0 = {
			zh = 4.066,
			ja = 4.433
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
				arg_106_0:Play417131027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(417131026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 14 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 14)

				if (14 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 14)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131026", "story_v_out_417131.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131026", "story_v_out_417131.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_417131", "417131026", "story_v_out_417131.awb")

						arg_106_1:RecordAudio("417131026", var_109_6)
						arg_106_1:RecordAudio("417131026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417131", "417131026", "story_v_out_417131.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417131", "417131026", "story_v_out_417131.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417131027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417131027
		arg_110_1.duration_ = 7.8

		local var_110_0 = {
			zh = 5.8,
			ja = 7.8
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
				arg_110_0:Play417131028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10115"]) and arg_110_1.var_.actorSpriteComps10115 == nil then
				arg_110_1.var_.actorSpriteComps10115 = arg_110_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10115"]) then
				if arg_110_1.var_.actorSpriteComps10115 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								iter_113_1.color = Color.New(Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, (arg_110_1.time_ - 0) / var_113_0), Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, (arg_110_1.time_ - 0) / var_113_0), (Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, (arg_110_1.time_ - 0) / var_113_0)))
							else
								local var_113_1 = Mathf.Lerp(iter_113_1.color.r, 1, (arg_110_1.time_ - 0) / var_113_0)

								iter_113_1.color = Color.New(var_113_1, var_113_1, var_113_1)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10115"]) and arg_110_1.var_.actorSpriteComps10115 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps10115 = nil
			end

			local var_113_2 = arg_110_1.actors_["1034"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps1034 == nil then
				arg_110_1.var_.actorSpriteComps1034 = var_113_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_3 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.actorSpriteComps1034 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								iter_113_5.color = Color.New(Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor2.r, (arg_110_1.time_ - 0) / var_113_3), Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor2.g, (arg_110_1.time_ - 0) / var_113_3), (Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor2.b, (arg_110_1.time_ - 0) / var_113_3)))
							else
								local var_113_4 = Mathf.Lerp(iter_113_5.color.r, 0.5, (arg_110_1.time_ - 0) / var_113_3)

								iter_113_5.color = Color.New(var_113_4, var_113_4, var_113_4)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps1034 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_113_7 then
						iter_113_7.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_110_1.var_.actorSpriteComps1034 = nil
			end

			local var_113_5 = arg_110_1.actors_["10115"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10115 = var_113_5.localPosition
				var_113_5.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10115", 4)

				for iter_113_8 = 0, var_113_5.childCount - 1 do
					local var_113_6 = var_113_5:GetChild(iter_113_8)

					if var_113_6.name == "split_6" or not string.find(var_113_6.name, "split") then
						var_113_6.gameObject:SetActive(true)
					else
						var_113_6.gameObject:SetActive(false)
					end
				end
			end

			local var_113_7 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_110_1.time_ - 0) / var_113_7)
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_113_8 = 0
			local var_113_9 = 0.725

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:GetWordFromCfg(417131027)
				local var_113_11 = arg_110_1:FormatText(var_113_10.content)

				arg_110_1.text_.text = var_113_11

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 29 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 29)

				if (29 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 29)) > 0 and var_113_9 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_11
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131027", "story_v_out_417131.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131027", "story_v_out_417131.awb") / 1000

					if var_113_14 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_8
					end

					if var_113_10.prefab_name ~= "" and arg_110_1.actors_[var_113_10.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_10.prefab_name].transform, "story_v_out_417131", "417131027", "story_v_out_417131.awb")

						arg_110_1:RecordAudio("417131027", var_113_15)
						arg_110_1:RecordAudio("417131027", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417131", "417131027", "story_v_out_417131.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417131", "417131027", "story_v_out_417131.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_16 and arg_110_1.time_ < var_113_8 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play417131028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417131028
		arg_114_1.duration_ = 20.4

		local var_114_0 = {
			zh = 15.6,
			ja = 20.4
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417131029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.9

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(417131028)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 76 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 76)

				if (76 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 76)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131028", "story_v_out_417131.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131028", "story_v_out_417131.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_417131", "417131028", "story_v_out_417131.awb")

						arg_114_1:RecordAudio("417131028", var_117_6)
						arg_114_1:RecordAudio("417131028", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417131", "417131028", "story_v_out_417131.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417131", "417131028", "story_v_out_417131.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play417131029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417131029
		arg_118_1.duration_ = 9.7

		local var_118_0 = {
			zh = 6.5,
			ja = 9.7
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play417131030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos10115 = arg_118_1.actors_["10115"].transform.localPosition
				arg_118_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10115", 4)

				for iter_121_0 = 0, arg_118_1.actors_["10115"].transform.childCount - 1 do
					local var_121_0 = arg_118_1.actors_["10115"].transform:GetChild(iter_121_0)

					if var_121_0.name == "split_4" or not string.find(var_121_0.name, "split") then
						var_121_0.gameObject:SetActive(true)
					else
						var_121_0.gameObject:SetActive(false)
					end
				end
			end

			local var_121_1 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_1 then
				arg_118_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_118_1.time_ - 0) / var_121_1)
			end

			if arg_118_1.time_ >= 0 + var_121_1 and arg_118_1.time_ < 0 + var_121_1 + arg_121_0 then
				arg_118_1.actors_["10115"].transform.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_121_2 = 0
			local var_121_3 = 0.85

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(417131029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 34 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 34)

				if (34 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 34)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131029", "story_v_out_417131.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131029", "story_v_out_417131.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_417131", "417131029", "story_v_out_417131.awb")

						arg_118_1:RecordAudio("417131029", var_121_9)
						arg_118_1:RecordAudio("417131029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417131", "417131029", "story_v_out_417131.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417131", "417131029", "story_v_out_417131.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_10 and arg_118_1.time_ < var_121_2 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play417131030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417131030
		arg_122_1.duration_ = 13.33

		local var_122_0 = {
			zh = 12.5,
			ja = 13.333
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417131031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 1.15

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:GetWordFromCfg(417131030)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 46 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 46)

				if (46 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 46)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131030", "story_v_out_417131.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131030", "story_v_out_417131.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_417131", "417131030", "story_v_out_417131.awb")

						arg_122_1:RecordAudio("417131030", var_125_6)
						arg_122_1:RecordAudio("417131030", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417131", "417131030", "story_v_out_417131.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417131", "417131030", "story_v_out_417131.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417131031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417131031
		arg_126_1.duration_ = 6.7

		local var_126_0 = {
			zh = 6.266,
			ja = 6.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417131032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1034"]) and arg_126_1.var_.actorSpriteComps1034 == nil then
				arg_126_1.var_.actorSpriteComps1034 = arg_126_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1034"]) then
				if arg_126_1.var_.actorSpriteComps1034 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 1, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1034"]) and arg_126_1.var_.actorSpriteComps1034 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps1034 = nil
			end

			local var_129_2 = arg_126_1.actors_["10115"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10115 == nil then
				arg_126_1.var_.actorSpriteComps10115 = var_129_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_3 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.actorSpriteComps10115 then
					for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_129_5 then
							if arg_126_1.isInRecall_ then
								iter_129_5.color = Color.New(Mathf.Lerp(iter_129_5.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_3), Mathf.Lerp(iter_129_5.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_3), (Mathf.Lerp(iter_129_5.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_3)))
							else
								local var_129_4 = Mathf.Lerp(iter_129_5.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_3)

								iter_129_5.color = Color.New(var_129_4, var_129_4, var_129_4)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10115 then
				for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_129_7 then
						iter_129_7.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps10115 = nil
			end

			local var_129_5 = 0
			local var_129_6 = 0.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:GetWordFromCfg(417131031)
				local var_129_8 = arg_126_1:FormatText(var_129_7.content)

				arg_126_1.text_.text = var_129_8

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 16 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 16)

				if (16 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 16)) > 0 and var_129_6 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_8
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131031", "story_v_out_417131.awb") ~= 0 then
					local var_129_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131031", "story_v_out_417131.awb") / 1000

					if var_129_11 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_5
					end

					if var_129_7.prefab_name ~= "" and arg_126_1.actors_[var_129_7.prefab_name] ~= nil then
						local var_129_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_7.prefab_name].transform, "story_v_out_417131", "417131031", "story_v_out_417131.awb")

						arg_126_1:RecordAudio("417131031", var_129_12)
						arg_126_1:RecordAudio("417131031", var_129_12)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417131", "417131031", "story_v_out_417131.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417131", "417131031", "story_v_out_417131.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_13 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_13 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_13

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_13 and arg_126_1.time_ < var_129_5 + var_129_13 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417131032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417131032
		arg_130_1.duration_ = 9.53

		local var_130_0 = {
			zh = 4.2,
			ja = 9.533
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417131033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["10115"]) and arg_130_1.var_.actorSpriteComps10115 == nil then
				arg_130_1.var_.actorSpriteComps10115 = arg_130_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["10115"]) then
				if arg_130_1.var_.actorSpriteComps10115 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 1, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["10115"]) and arg_130_1.var_.actorSpriteComps10115 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_130_1.var_.actorSpriteComps10115 = nil
			end

			local var_133_2 = arg_130_1.actors_["1034"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.actorSpriteComps1034 == nil then
				arg_130_1.var_.actorSpriteComps1034 = var_133_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_3 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.actorSpriteComps1034 then
					for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_133_5 then
							if arg_130_1.isInRecall_ then
								iter_133_5.color = Color.New(Mathf.Lerp(iter_133_5.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 0) / var_133_3), Mathf.Lerp(iter_133_5.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 0) / var_133_3), (Mathf.Lerp(iter_133_5.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 0) / var_133_3)))
							else
								local var_133_4 = Mathf.Lerp(iter_133_5.color.r, 0.5, (arg_130_1.time_ - 0) / var_133_3)

								iter_133_5.color = Color.New(var_133_4, var_133_4, var_133_4)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.actorSpriteComps1034 then
				for iter_133_6, iter_133_7 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_133_7 then
						iter_133_7.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps1034 = nil
			end

			local var_133_5 = 0
			local var_133_6 = 0.55

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(417131032)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 22 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 22)

				if (22 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 22)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131032", "story_v_out_417131.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131032", "story_v_out_417131.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_417131", "417131032", "story_v_out_417131.awb")

						arg_130_1:RecordAudio("417131032", var_133_12)
						arg_130_1:RecordAudio("417131032", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417131", "417131032", "story_v_out_417131.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417131", "417131032", "story_v_out_417131.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_13 and arg_130_1.time_ < var_133_5 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417131033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417131033
		arg_134_1.duration_ = 10.67

		local var_134_0 = {
			zh = 8.633,
			ja = 10.666
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417131034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1034"]) and arg_134_1.var_.actorSpriteComps1034 == nil then
				arg_134_1.var_.actorSpriteComps1034 = arg_134_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1034"]) then
				if arg_134_1.var_.actorSpriteComps1034 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 1, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1034"]) and arg_134_1.var_.actorSpriteComps1034 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_134_1.var_.actorSpriteComps1034 = nil
			end

			local var_137_2 = arg_134_1.actors_["10115"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps10115 == nil then
				arg_134_1.var_.actorSpriteComps10115 = var_137_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_3 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.actorSpriteComps10115 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_137_5 then
							if arg_134_1.isInRecall_ then
								iter_137_5.color = Color.New(Mathf.Lerp(iter_137_5.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_3), Mathf.Lerp(iter_137_5.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_3), (Mathf.Lerp(iter_137_5.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_3)))
							else
								local var_137_4 = Mathf.Lerp(iter_137_5.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_3)

								iter_137_5.color = Color.New(var_137_4, var_137_4, var_137_4)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps10115 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_137_7 then
						iter_137_7.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps10115 = nil
			end

			local var_137_5 = 0
			local var_137_6 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_7 = arg_134_1:GetWordFromCfg(417131033)
				local var_137_8 = arg_134_1:FormatText(var_137_7.content)

				arg_134_1.text_.text = var_137_8

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_10 = 40 <= 0 and var_137_6 or var_137_6 * (utf8.len(var_137_8) / 40)

				if (40 <= 0 and var_137_6 or var_137_6 * (utf8.len(var_137_8) / 40)) > 0 and var_137_6 < var_137_10 then
					arg_134_1.talkMaxDuration = var_137_10

					if var_137_10 + var_137_5 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_5
					end
				end

				arg_134_1.text_.text = var_137_8
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131033", "story_v_out_417131.awb") ~= 0 then
					local var_137_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131033", "story_v_out_417131.awb") / 1000

					if var_137_11 + var_137_5 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_5
					end

					if var_137_7.prefab_name ~= "" and arg_134_1.actors_[var_137_7.prefab_name] ~= nil then
						local var_137_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_7.prefab_name].transform, "story_v_out_417131", "417131033", "story_v_out_417131.awb")

						arg_134_1:RecordAudio("417131033", var_137_12)
						arg_134_1:RecordAudio("417131033", var_137_12)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417131", "417131033", "story_v_out_417131.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417131", "417131033", "story_v_out_417131.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_13 = math.max(var_137_6, arg_134_1.talkMaxDuration)

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_13 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_5) / var_137_13

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_5 + var_137_13 and arg_134_1.time_ < var_137_5 + var_137_13 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417131034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417131034
		arg_138_1.duration_ = 11.73

		local var_138_0 = {
			zh = 10.1,
			ja = 11.733
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417131035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10115"]) and arg_138_1.var_.actorSpriteComps10115 == nil then
				arg_138_1.var_.actorSpriteComps10115 = arg_138_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10115"]) then
				if arg_138_1.var_.actorSpriteComps10115 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 1, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10115"]) and arg_138_1.var_.actorSpriteComps10115 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps10115 = nil
			end

			local var_141_2 = arg_138_1.actors_["1034"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1034 == nil then
				arg_138_1.var_.actorSpriteComps1034 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps1034 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								iter_141_5.color = Color.New(Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_5.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_5.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1034 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_141_7 then
						iter_141_7.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps1034 = nil
			end

			local var_141_5 = 0
			local var_141_6 = 1.05

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(417131034)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 42 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 42)

				if (42 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 42)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131034", "story_v_out_417131.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131034", "story_v_out_417131.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_417131", "417131034", "story_v_out_417131.awb")

						arg_138_1:RecordAudio("417131034", var_141_12)
						arg_138_1:RecordAudio("417131034", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417131", "417131034", "story_v_out_417131.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417131", "417131034", "story_v_out_417131.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417131035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417131035
		arg_142_1.duration_ = 9.57

		local var_142_0 = {
			zh = 6.766,
			ja = 9.566
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417131036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10115 = arg_142_1.actors_["10115"].transform.localPosition
				arg_142_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10115", 4)

				for iter_145_0 = 0, arg_142_1.actors_["10115"].transform.childCount - 1 do
					local var_145_0 = arg_142_1.actors_["10115"].transform:GetChild(iter_145_0)

					if var_145_0.name == "split_6" or not string.find(var_145_0.name, "split") then
						var_145_0.gameObject:SetActive(true)
					else
						var_145_0.gameObject:SetActive(false)
					end
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_142_1.time_ - 0) / var_145_1)
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["10115"].transform.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_145_2 = 0
			local var_145_3 = 0.875

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(417131035)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 35 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 35)

				if (35 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 35)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131035", "story_v_out_417131.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131035", "story_v_out_417131.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_417131", "417131035", "story_v_out_417131.awb")

						arg_142_1:RecordAudio("417131035", var_145_9)
						arg_142_1:RecordAudio("417131035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417131", "417131035", "story_v_out_417131.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417131", "417131035", "story_v_out_417131.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play417131036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417131036
		arg_146_1.duration_ = 11.63

		local var_146_0 = {
			zh = 6.733,
			ja = 11.633
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
				arg_146_0:Play417131037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.85

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(417131036)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 34 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 34)

				if (34 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 34)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131036", "story_v_out_417131.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131036", "story_v_out_417131.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_417131", "417131036", "story_v_out_417131.awb")

						arg_146_1:RecordAudio("417131036", var_149_6)
						arg_146_1:RecordAudio("417131036", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417131", "417131036", "story_v_out_417131.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417131", "417131036", "story_v_out_417131.awb")
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
	Play417131037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417131037
		arg_150_1.duration_ = 4.73

		local var_150_0 = {
			zh = 1.433,
			ja = 4.733
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417131038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1034"]) and arg_150_1.var_.actorSpriteComps1034 == nil then
				arg_150_1.var_.actorSpriteComps1034 = arg_150_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1034"]) then
				if arg_150_1.var_.actorSpriteComps1034 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1034"]) and arg_150_1.var_.actorSpriteComps1034 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps1034 = nil
			end

			local var_153_2 = arg_150_1.actors_["10115"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps10115 == nil then
				arg_150_1.var_.actorSpriteComps10115 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps10115 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_5.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_5.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps10115 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps10115 = nil
			end

			local var_153_5 = 0
			local var_153_6 = 0.175

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_7 = arg_150_1:GetWordFromCfg(417131037)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 7 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 7)

				if (7 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 7)) > 0 and var_153_6 < var_153_10 then
					arg_150_1.talkMaxDuration = var_153_10

					if var_153_10 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131037", "story_v_out_417131.awb") ~= 0 then
					local var_153_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131037", "story_v_out_417131.awb") / 1000

					if var_153_11 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_5
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_out_417131", "417131037", "story_v_out_417131.awb")

						arg_150_1:RecordAudio("417131037", var_153_12)
						arg_150_1:RecordAudio("417131037", var_153_12)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417131", "417131037", "story_v_out_417131.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417131", "417131037", "story_v_out_417131.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_13 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_13

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_13 and arg_150_1.time_ < var_153_5 + var_153_13 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417131038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417131038
		arg_154_1.duration_ = 13.87

		local var_154_0 = {
			zh = 13.866,
			ja = 12.566
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417131039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = arg_154_1.actors_["1034"].transform.localPosition
				arg_154_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 2)

				for iter_157_0 = 0, arg_154_1.actors_["1034"].transform.childCount - 1 do
					local var_157_0 = arg_154_1.actors_["1034"].transform:GetChild(iter_157_0)

					if var_157_0.name == "" or not string.find(var_157_0.name, "split") then
						var_157_0.gameObject:SetActive(true)
					else
						var_157_0.gameObject:SetActive(false)
					end
				end
			end

			local var_157_1 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_154_1.time_ - 0) / var_157_1)
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["1034"].transform.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_157_2 = 0
			local var_157_3 = 1.55

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_4 = arg_154_1:GetWordFromCfg(417131038)
				local var_157_5 = arg_154_1:FormatText(var_157_4.content)

				arg_154_1.text_.text = var_157_5

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_7 = 62 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_5) / 62)

				if (62 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_5) / 62)) > 0 and var_157_3 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_5
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131038", "story_v_out_417131.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131038", "story_v_out_417131.awb") / 1000

					if var_157_8 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_2
					end

					if var_157_4.prefab_name ~= "" and arg_154_1.actors_[var_157_4.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_4.prefab_name].transform, "story_v_out_417131", "417131038", "story_v_out_417131.awb")

						arg_154_1:RecordAudio("417131038", var_157_9)
						arg_154_1:RecordAudio("417131038", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417131", "417131038", "story_v_out_417131.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417131", "417131038", "story_v_out_417131.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_10 and arg_154_1.time_ < var_157_2 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play417131039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417131039
		arg_158_1.duration_ = 8.73

		local var_158_0 = {
			zh = 5.766,
			ja = 8.733
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417131040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.725

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(417131039)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 29 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 29)

				if (29 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 29)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131039", "story_v_out_417131.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131039", "story_v_out_417131.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_417131", "417131039", "story_v_out_417131.awb")

						arg_158_1:RecordAudio("417131039", var_161_6)
						arg_158_1:RecordAudio("417131039", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_417131", "417131039", "story_v_out_417131.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_417131", "417131039", "story_v_out_417131.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417131040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417131040
		arg_162_1.duration_ = 10.87

		local var_162_0 = {
			zh = 6.8,
			ja = 10.866
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
				arg_162_0:Play417131041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.625

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
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

				local var_165_1 = arg_162_1:GetWordFromCfg(417131040)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 25 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 25)

				if (25 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 25)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131040", "story_v_out_417131.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131040", "story_v_out_417131.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_417131", "417131040", "story_v_out_417131.awb")

						arg_162_1:RecordAudio("417131040", var_165_6)
						arg_162_1:RecordAudio("417131040", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417131", "417131040", "story_v_out_417131.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417131", "417131040", "story_v_out_417131.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417131041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417131041
		arg_166_1.duration_ = 6

		local var_166_0 = {
			zh = 6,
			ja = 5.266
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
				arg_166_0:Play417131042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10115"]) and arg_166_1.var_.actorSpriteComps10115 == nil then
				arg_166_1.var_.actorSpriteComps10115 = arg_166_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10115"]) then
				if arg_166_1.var_.actorSpriteComps10115 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10115"]) and arg_166_1.var_.actorSpriteComps10115 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10115 = nil
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

			local var_169_5 = arg_166_1.actors_["10115"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10115 = var_169_5.localPosition
				var_169_5.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10115", 4)

				for iter_169_8 = 0, var_169_5.childCount - 1 do
					local var_169_6 = var_169_5:GetChild(iter_169_8)

					if var_169_6.name == "split_6" or not string.find(var_169_6.name, "split") then
						var_169_6.gameObject:SetActive(true)
					else
						var_169_6.gameObject:SetActive(false)
					end
				end
			end

			local var_169_7 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_166_1.time_ - 0) / var_169_7)
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_169_8 = 0
			local var_169_9 = 0.75

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:GetWordFromCfg(417131041)
				local var_169_11 = arg_166_1:FormatText(var_169_10.content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 30 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 30)

				if (30 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 30)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131041", "story_v_out_417131.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131041", "story_v_out_417131.awb") / 1000

					if var_169_14 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_8
					end

					if var_169_10.prefab_name ~= "" and arg_166_1.actors_[var_169_10.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_10.prefab_name].transform, "story_v_out_417131", "417131041", "story_v_out_417131.awb")

						arg_166_1:RecordAudio("417131041", var_169_15)
						arg_166_1:RecordAudio("417131041", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417131", "417131041", "story_v_out_417131.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417131", "417131041", "story_v_out_417131.awb")
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
				actorName = "10115",
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
	Play417131042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417131042
		arg_170_1.duration_ = 9.9

		local var_170_0 = {
			zh = 9.9,
			ja = 6.133
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
				arg_170_0:Play417131043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 1.125

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(417131042)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 45 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 45)

				if (45 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 45)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131042", "story_v_out_417131.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131042", "story_v_out_417131.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_417131", "417131042", "story_v_out_417131.awb")

						arg_170_1:RecordAudio("417131042", var_173_6)
						arg_170_1:RecordAudio("417131042", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417131", "417131042", "story_v_out_417131.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417131", "417131042", "story_v_out_417131.awb")
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
	Play417131043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417131043
		arg_174_1.duration_ = 11.9

		local var_174_0 = {
			zh = 10.5,
			ja = 11.9
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
				arg_174_0:Play417131044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10115 = arg_174_1.actors_["10115"].transform.localPosition
				arg_174_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10115", 4)

				for iter_177_0 = 0, arg_174_1.actors_["10115"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["10115"].transform:GetChild(iter_177_0)

					if var_177_0.name == "" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["10115"].transform.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_177_2 = 0
			local var_177_3 = 1.275

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(417131043)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 51 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 51)

				if (51 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 51)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131043", "story_v_out_417131.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131043", "story_v_out_417131.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_417131", "417131043", "story_v_out_417131.awb")

						arg_174_1:RecordAudio("417131043", var_177_9)
						arg_174_1:RecordAudio("417131043", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417131", "417131043", "story_v_out_417131.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417131", "417131043", "story_v_out_417131.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417131044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417131045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10115"]) and arg_178_1.var_.actorSpriteComps10115 == nil then
				arg_178_1.var_.actorSpriteComps10115 = arg_178_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10115"]) then
				if arg_178_1.var_.actorSpriteComps10115 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10115"]) and arg_178_1.var_.actorSpriteComps10115 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps10115 = nil
			end

			local var_181_2 = arg_178_1.actors_["10115"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10115 = var_181_2.localPosition
				var_181_2.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10115", 7)

				for iter_181_4 = 0, var_181_2.childCount - 1 do
					local var_181_3 = var_181_2:GetChild(iter_181_4)

					if var_181_3.name == "" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_2.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 0) / var_181_4)
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_5 = arg_178_1.actors_["1034"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1034 = var_181_5.localPosition
				var_181_5.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1034", 7)

				for iter_181_5 = 0, var_181_5.childCount - 1 do
					local var_181_6 = var_181_5:GetChild(iter_181_5)

					if var_181_6.name == "" or not string.find(var_181_6.name, "split") then
						var_181_6.gameObject:SetActive(true)
					else
						var_181_6.gameObject:SetActive(false)
					end
				end
			end

			local var_181_7 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 0) / var_181_7)
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_8 = 0
			local var_181_9 = 1.55

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(417131044).content)

				arg_178_1.text_.text = var_181_10

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_12 = 62 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_10) / 62)

				if (62 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_10) / 62)) > 0 and var_181_9 < var_181_12 then
					arg_178_1.talkMaxDuration = var_181_12

					if var_181_12 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_10
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_13 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_13 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_13

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_13 and arg_178_1.time_ < var_181_8 + var_181_13 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_178_1:InitPlayNodeList()
	end,
	Play417131045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417131045
		arg_182_1.duration_ = 15.33

		local var_182_0 = {
			zh = 7.266,
			ja = 15.333
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
				arg_182_0:Play417131046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1034"]) and arg_182_1.var_.actorSpriteComps1034 == nil then
				arg_182_1.var_.actorSpriteComps1034 = arg_182_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1034"]) then
				if arg_182_1.var_.actorSpriteComps1034 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1034"]) and arg_182_1.var_.actorSpriteComps1034 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps1034 = nil
			end

			local var_185_2 = arg_182_1.actors_["1034"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1034 = var_185_2.localPosition
				var_185_2.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1034", 2)

				for iter_185_4 = 0, var_185_2.childCount - 1 do
					local var_185_3 = var_185_2:GetChild(iter_185_4)

					if var_185_3.name == "split_6" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_2.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_182_1.time_ - 0) / var_185_4)
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_2.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_185_5 = 0
			local var_185_6 = 0.625

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(417131045)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 25 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 25)

				if (25 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 25)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131045", "story_v_out_417131.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131045", "story_v_out_417131.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_417131", "417131045", "story_v_out_417131.awb")

						arg_182_1:RecordAudio("417131045", var_185_12)
						arg_182_1:RecordAudio("417131045", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417131", "417131045", "story_v_out_417131.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417131", "417131045", "story_v_out_417131.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play417131046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417131046
		arg_186_1.duration_ = 8.6

		local var_186_0 = {
			zh = 4.8,
			ja = 8.6
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
				arg_186_0:Play417131047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10115"]) and arg_186_1.var_.actorSpriteComps10115 == nil then
				arg_186_1.var_.actorSpriteComps10115 = arg_186_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10115"]) then
				if arg_186_1.var_.actorSpriteComps10115 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 1, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10115"]) and arg_186_1.var_.actorSpriteComps10115 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps10115 = nil
			end

			local var_189_2 = arg_186_1.actors_["1034"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps1034 == nil then
				arg_186_1.var_.actorSpriteComps1034 = var_189_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_3 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.actorSpriteComps1034 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								iter_189_5.color = Color.New(Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_3), Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_3), (Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_3)))
							else
								local var_189_4 = Mathf.Lerp(iter_189_5.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_3)

								iter_189_5.color = Color.New(var_189_4, var_189_4, var_189_4)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps1034 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_189_7 then
						iter_189_7.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps1034 = nil
			end

			local var_189_5 = arg_186_1.actors_["10115"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10115 = var_189_5.localPosition
				var_189_5.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10115", 4)

				for iter_189_8 = 0, var_189_5.childCount - 1 do
					local var_189_6 = var_189_5:GetChild(iter_189_8)

					if var_189_6.name == "split_4" or not string.find(var_189_6.name, "split") then
						var_189_6.gameObject:SetActive(true)
					else
						var_189_6.gameObject:SetActive(false)
					end
				end
			end

			local var_189_7 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_186_1.time_ - 0) / var_189_7)
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_189_8 = 0
			local var_189_9 = 0.625

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:GetWordFromCfg(417131046)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 25 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 25)

				if (25 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 25)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131046", "story_v_out_417131.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131046", "story_v_out_417131.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_out_417131", "417131046", "story_v_out_417131.awb")

						arg_186_1:RecordAudio("417131046", var_189_15)
						arg_186_1:RecordAudio("417131046", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417131", "417131046", "story_v_out_417131.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417131", "417131046", "story_v_out_417131.awb")
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
				actorName = "10115",
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
	Play417131047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417131047
		arg_190_1.duration_ = 15.33

		local var_190_0 = {
			zh = 13.833,
			ja = 15.333
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417131048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 1.625

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:GetWordFromCfg(417131047)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 65 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 65)

				if (65 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 65)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131047", "story_v_out_417131.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131047", "story_v_out_417131.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_417131", "417131047", "story_v_out_417131.awb")

						arg_190_1:RecordAudio("417131047", var_193_6)
						arg_190_1:RecordAudio("417131047", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_417131", "417131047", "story_v_out_417131.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_417131", "417131047", "story_v_out_417131.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417131048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417131048
		arg_194_1.duration_ = 14.8

		local var_194_0 = {
			zh = 7.7,
			ja = 14.8
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
				arg_194_0:Play417131049(arg_194_1)
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

			local var_197_2 = arg_194_1.actors_["10115"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps10115 == nil then
				arg_194_1.var_.actorSpriteComps10115 = var_197_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_3 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.actorSpriteComps10115 then
					for iter_197_4, iter_197_5 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_197_5 then
							if arg_194_1.isInRecall_ then
								iter_197_5.color = Color.New(Mathf.Lerp(iter_197_5.color.r, arg_194_1.hightColor2.r, (arg_194_1.time_ - 0) / var_197_3), Mathf.Lerp(iter_197_5.color.g, arg_194_1.hightColor2.g, (arg_194_1.time_ - 0) / var_197_3), (Mathf.Lerp(iter_197_5.color.b, arg_194_1.hightColor2.b, (arg_194_1.time_ - 0) / var_197_3)))
							else
								local var_197_4 = Mathf.Lerp(iter_197_5.color.r, 0.5, (arg_194_1.time_ - 0) / var_197_3)

								iter_197_5.color = Color.New(var_197_4, var_197_4, var_197_4)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps10115 then
				for iter_197_6, iter_197_7 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_197_7 then
						iter_197_7.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_194_1.var_.actorSpriteComps10115 = nil
			end

			local var_197_5 = arg_194_1.actors_["1034"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034 = var_197_5.localPosition
				var_197_5.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1034", 2)

				for iter_197_8 = 0, var_197_5.childCount - 1 do
					local var_197_6 = var_197_5:GetChild(iter_197_8)

					if var_197_6.name == "split_4" or not string.find(var_197_6.name, "split") then
						var_197_6.gameObject:SetActive(true)
					else
						var_197_6.gameObject:SetActive(false)
					end
				end
			end

			local var_197_7 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				var_197_5.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_194_1.time_ - 0) / var_197_7)
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				var_197_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_197_8 = 0
			local var_197_9 = 0.825

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
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

				local var_197_10 = arg_194_1:GetWordFromCfg(417131048)
				local var_197_11 = arg_194_1:FormatText(var_197_10.content)

				arg_194_1.text_.text = var_197_11

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 33 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 33)

				if (33 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 33)) > 0 and var_197_9 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_11
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131048", "story_v_out_417131.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131048", "story_v_out_417131.awb") / 1000

					if var_197_14 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_8
					end

					if var_197_10.prefab_name ~= "" and arg_194_1.actors_[var_197_10.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_10.prefab_name].transform, "story_v_out_417131", "417131048", "story_v_out_417131.awb")

						arg_194_1:RecordAudio("417131048", var_197_15)
						arg_194_1:RecordAudio("417131048", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417131", "417131048", "story_v_out_417131.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417131", "417131048", "story_v_out_417131.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_16 and arg_194_1.time_ < var_197_8 + var_197_16 + arg_197_0 then
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
	Play417131049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417131049
		arg_198_1.duration_ = 10.23

		local var_198_0 = {
			zh = 10.233,
			ja = 8.333
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
				arg_198_0:Play417131050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.175

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(417131049)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 47 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 47)

				if (47 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 47)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131049", "story_v_out_417131.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131049", "story_v_out_417131.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_417131", "417131049", "story_v_out_417131.awb")

						arg_198_1:RecordAudio("417131049", var_201_6)
						arg_198_1:RecordAudio("417131049", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417131", "417131049", "story_v_out_417131.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417131", "417131049", "story_v_out_417131.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417131050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417131050
		arg_202_1.duration_ = 5.63

		local var_202_0 = {
			zh = 4.1,
			ja = 5.633
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
				arg_202_0:Play417131051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10115"]) and arg_202_1.var_.actorSpriteComps10115 == nil then
				arg_202_1.var_.actorSpriteComps10115 = arg_202_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10115"]) then
				if arg_202_1.var_.actorSpriteComps10115 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10115"]) and arg_202_1.var_.actorSpriteComps10115 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps10115 = nil
			end

			local var_205_2 = arg_202_1.actors_["1034"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = var_205_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_3 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_5 then
							if arg_202_1.isInRecall_ then
								iter_205_5.color = Color.New(Mathf.Lerp(iter_205_5.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_3), Mathf.Lerp(iter_205_5.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_3), (Mathf.Lerp(iter_205_5.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_3)))
							else
								local var_205_4 = Mathf.Lerp(iter_205_5.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_3)

								iter_205_5.color = Color.New(var_205_4, var_205_4, var_205_4)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_7 then
						iter_205_7.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_5 = arg_202_1.actors_["10115"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10115 = var_205_5.localPosition
				var_205_5.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10115", 4)

				for iter_205_8 = 0, var_205_5.childCount - 1 do
					local var_205_6 = var_205_5:GetChild(iter_205_8)

					if var_205_6.name == "split_4" or not string.find(var_205_6.name, "split") then
						var_205_6.gameObject:SetActive(true)
					else
						var_205_6.gameObject:SetActive(false)
					end
				end
			end

			local var_205_7 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				var_205_5.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_202_1.time_ - 0) / var_205_7)
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				var_205_5.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_205_8 = 0
			local var_205_9 = 0.5

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_10 = arg_202_1:GetWordFromCfg(417131050)
				local var_205_11 = arg_202_1:FormatText(var_205_10.content)

				arg_202_1.text_.text = var_205_11

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 20 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_11) / 20)

				if (20 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_11) / 20)) > 0 and var_205_9 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_11
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131050", "story_v_out_417131.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131050", "story_v_out_417131.awb") / 1000

					if var_205_14 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_8
					end

					if var_205_10.prefab_name ~= "" and arg_202_1.actors_[var_205_10.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_10.prefab_name].transform, "story_v_out_417131", "417131050", "story_v_out_417131.awb")

						arg_202_1:RecordAudio("417131050", var_205_15)
						arg_202_1:RecordAudio("417131050", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417131", "417131050", "story_v_out_417131.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417131", "417131050", "story_v_out_417131.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_16 and arg_202_1.time_ < var_205_8 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417131051
		arg_206_1.duration_ = 12.53

		local var_206_0 = {
			zh = 11.9,
			ja = 12.533
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
				arg_206_0:Play417131052(arg_206_1)
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

			local var_209_2 = arg_206_1.actors_["10115"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10115 == nil then
				arg_206_1.var_.actorSpriteComps10115 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps10115 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10115 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps10115 = nil
			end

			local var_209_5 = arg_206_1.actors_["1034"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1034", 2)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "split_3" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_209_8 = 0
			local var_209_9 = 1.175

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
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

				local var_209_10 = arg_206_1:GetWordFromCfg(417131051)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 47 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 47)

				if (47 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 47)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131051", "story_v_out_417131.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131051", "story_v_out_417131.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_417131", "417131051", "story_v_out_417131.awb")

						arg_206_1:RecordAudio("417131051", var_209_15)
						arg_206_1:RecordAudio("417131051", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417131", "417131051", "story_v_out_417131.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417131", "417131051", "story_v_out_417131.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
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
	Play417131052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417131052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417131053(arg_210_1)
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
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1034"]) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_2 = arg_210_1.actors_["10115"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10115 = var_213_2.localPosition
				var_213_2.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10115", 7)

				for iter_213_4 = 0, var_213_2.childCount - 1 do
					local var_213_3 = var_213_2:GetChild(iter_213_4)

					if var_213_3.name == "" or not string.find(var_213_3.name, "split") then
						var_213_3.gameObject:SetActive(true)
					else
						var_213_3.gameObject:SetActive(false)
					end
				end
			end

			local var_213_4 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				var_213_2.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_210_1.time_ - 0) / var_213_4)
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				var_213_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_5 = arg_210_1.actors_["1034"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1034 = var_213_5.localPosition
				var_213_5.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1034", 7)

				for iter_213_5 = 0, var_213_5.childCount - 1 do
					local var_213_6 = var_213_5:GetChild(iter_213_5)

					if var_213_6.name == "" or not string.find(var_213_6.name, "split") then
						var_213_6.gameObject:SetActive(true)
					else
						var_213_6.gameObject:SetActive(false)
					end
				end
			end

			local var_213_7 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				var_213_5.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_210_1.time_ - 0) / var_213_7)
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				var_213_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_8 = 0
			local var_213_9 = 1.325

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(417131052).content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_12 = 53 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_10) / 53)

				if (53 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_10) / 53)) > 0 and var_213_9 < var_213_12 then
					arg_210_1.talkMaxDuration = var_213_12

					if var_213_12 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_12 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_13 and arg_210_1.time_ < var_213_8 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_210_1:InitPlayNodeList()
	end,
	Play417131053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417131053
		arg_214_1.duration_ = 5.17

		local var_214_0 = {
			zh = 2.4,
			ja = 5.166
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
				arg_214_0:Play417131054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_4")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(417131053)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 10 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 10)

				if (10 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 10)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131053", "story_v_out_417131.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131053", "story_v_out_417131.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_417131", "417131053", "story_v_out_417131.awb")

						arg_214_1:RecordAudio("417131053", var_217_6)
						arg_214_1:RecordAudio("417131053", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417131", "417131053", "story_v_out_417131.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417131", "417131053", "story_v_out_417131.awb")
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
	Play417131054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417131054
		arg_218_1.duration_ = 4.4

		local var_218_0 = {
			zh = 3.266,
			ja = 4.4
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
				arg_218_0:Play417131055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1034"]) and arg_218_1.var_.actorSpriteComps1034 == nil then
				arg_218_1.var_.actorSpriteComps1034 = arg_218_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1034"]) then
				if arg_218_1.var_.actorSpriteComps1034 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1034"]) and arg_218_1.var_.actorSpriteComps1034 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps1034 = nil
			end

			local var_221_2 = arg_218_1.actors_["10115"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps10115 == nil then
				arg_218_1.var_.actorSpriteComps10115 = var_221_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_3 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.actorSpriteComps10115 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								iter_221_5.color = Color.New(Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_3), Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_3), (Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_3)))
							else
								local var_221_4 = Mathf.Lerp(iter_221_5.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_3)

								iter_221_5.color = Color.New(var_221_4, var_221_4, var_221_4)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps10115 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_221_7 then
						iter_221_7.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps10115 = nil
			end

			local var_221_5 = arg_218_1.actors_["1034"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1034 = var_221_5.localPosition
				var_221_5.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1034", 3)

				for iter_221_8 = 0, var_221_5.childCount - 1 do
					local var_221_6 = var_221_5:GetChild(iter_221_8)

					if var_221_6.name == "split_6" or not string.find(var_221_6.name, "split") then
						var_221_6.gameObject:SetActive(true)
					else
						var_221_6.gameObject:SetActive(false)
					end
				end
			end

			local var_221_7 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				var_221_5.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_218_1.time_ - 0) / var_221_7)
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				var_221_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_221_8 = 0
			local var_221_9 = 0.35

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(417131054)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 14 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 14)

				if (14 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 14)) > 0 and var_221_9 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_8
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131054", "story_v_out_417131.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131054", "story_v_out_417131.awb") / 1000

					if var_221_14 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_8
					end

					if var_221_10.prefab_name ~= "" and arg_218_1.actors_[var_221_10.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_10.prefab_name].transform, "story_v_out_417131", "417131054", "story_v_out_417131.awb")

						arg_218_1:RecordAudio("417131054", var_221_15)
						arg_218_1:RecordAudio("417131054", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417131", "417131054", "story_v_out_417131.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417131", "417131054", "story_v_out_417131.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_9, arg_218_1.talkMaxDuration)

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_8) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_8 + var_221_16 and arg_218_1.time_ < var_221_8 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play417131055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417131055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417131056(arg_222_1)
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
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1034"]) and arg_222_1.var_.actorSpriteComps1034 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps1034 = nil
			end

			local var_225_2 = arg_222_1.actors_["1034"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1034 = var_225_2.localPosition
				var_225_2.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1034", 7)

				for iter_225_4 = 0, var_225_2.childCount - 1 do
					local var_225_3 = var_225_2:GetChild(iter_225_4)

					if var_225_3.name == "" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_2.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_222_1.time_ - 0) / var_225_4)
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_225_5 = arg_222_1.actors_["10115"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10115 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10115", 7)

				for iter_225_5 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_5)

					if var_225_6.name == "" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_222_1.time_ and arg_222_1.time_ <= 1 + arg_225_0 then
				arg_222_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_225_9 = 0
			local var_225_10 = 1.1

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_11 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(417131055).content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 44 <= 0 and var_225_10 or var_225_10 * (utf8.len(var_225_11) / 44)

				if (44 <= 0 and var_225_10 or var_225_10 * (utf8.len(var_225_11) / 44)) > 0 and var_225_10 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_9 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_9
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_10, arg_222_1.talkMaxDuration)

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_9) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_9 + var_225_14 and arg_222_1.time_ < var_225_9 + var_225_14 + arg_225_0 then
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
			},
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417131056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417131057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.65

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(417131056).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 26 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 26)

				if (26 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 26)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417131057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417131057
		arg_230_1.duration_ = 8.97

		local var_230_0 = {
			zh = 8.36666666666667,
			ja = 8.96666666666667
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417131058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if arg_230_1.bgs_.B02f == nil then
				local var_233_0 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02f")
				var_233_0.name = "B02f"
				var_233_0.transform.parent = arg_230_1.stage_.transform
				var_233_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_.B02f = var_233_0
			end

			if 1.66666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 1.66666666666667 + arg_233_0 then
				local var_233_1 = arg_230_1.bgs_.B02f

				arg_230_1.bgs_.B02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_233_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_2 = var_233_1:GetComponent("SpriteRenderer")

				if var_233_2 and var_233_2.sprite then
					local var_233_3 = 2 * (var_233_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_233_1.transform.localScale = Vector3.New(var_233_3 / var_233_2.sprite.bounds.size.y < var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x and var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x or var_233_3 / var_233_2.sprite.bounds.size.y, var_233_3 / var_233_2.sprite.bounds.size.y < var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x and var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x or var_233_3 / var_233_2.sprite.bounds.size.y, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "B02f" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_4 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			if arg_230_1.time_ >= var_233_4 + 0.3 and arg_230_1.time_ < var_233_4 + 0.3 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_5 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_6 = 1.66666666666667

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_6 then
				local var_233_7 = Color.New(0, 0, 0)

				var_233_7.a = Mathf.Lerp(0, 1, (arg_230_1.time_ - var_233_5) / var_233_6)
				arg_230_1.mask_.color = var_233_7
			end

			if arg_230_1.time_ >= var_233_5 + var_233_6 and arg_230_1.time_ < var_233_5 + var_233_6 + arg_233_0 then
				local var_233_8 = Color.New(0, 0, 0)

				var_233_8.a = 1
				arg_230_1.mask_.color = var_233_8
			end

			local var_233_9 = 1.66666666666667

			if 1.66666666666667 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_10 = 2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 then
				local var_233_11 = Color.New(0, 0, 0)

				var_233_11.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_9) / var_233_10)
				arg_230_1.mask_.color = var_233_11
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 then
				local var_233_12 = Color.New(0, 0, 0)

				arg_230_1.mask_.enabled = false
				var_233_12.a = 0
				arg_230_1.mask_.color = var_233_12
			end

			if 1.66666666666667 < arg_230_1.time_ and arg_230_1.time_ <= 1.66666666666667 + arg_233_0 then
				if arg_230_1.var_.effect809 then
					Object.Destroy(arg_230_1.var_.effect809)

					arg_230_1.var_.effect809 = nil
				end
			end

			local var_233_14 = 1.66666666666667

			arg_230_1.isInRecall_ = true

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.screenFilterGo_:SetActive(true)

				arg_230_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_230_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_230_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_233_2, iter_233_3 in pairs(arg_230_1.actors_) do
					for iter_233_4, iter_233_5 in ipairs((iter_233_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_233_5.color = iter_233_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_233_15 = 0.0166666666666667

			if var_233_14 <= arg_230_1.time_ and arg_230_1.time_ < var_233_14 + var_233_15 then
				arg_230_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_230_1.time_ - var_233_14) / var_233_15)
			end

			if arg_230_1.time_ >= var_233_14 + var_233_15 and arg_230_1.time_ < var_233_14 + var_233_15 + arg_233_0 then
				arg_230_1.screenFilterEffect_.weight = 1
			end

			if 0.3 < arg_230_1.time_ and arg_230_1.time_ <= 0.3 + arg_233_0 then
				arg_230_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_17 = 3.16666666666667
			local var_233_18 = 0.4

			if 3.16666666666667 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_19 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_19:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_20 = arg_230_1:GetWordFromCfg(417131057)
				local var_233_21 = arg_230_1:FormatText(var_233_20.content)

				arg_230_1.text_.text = var_233_21

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_23 = 16 <= 0 and var_233_18 or var_233_18 * (utf8.len(var_233_21) / 16)

				if (16 <= 0 and var_233_18 or var_233_18 * (utf8.len(var_233_21) / 16)) > 0 and var_233_18 < var_233_23 then
					arg_230_1.talkMaxDuration = var_233_23
					var_233_17 = var_233_17 + 0.3

					if var_233_23 + var_233_17 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_23 + var_233_17
					end
				end

				arg_230_1.text_.text = var_233_21
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131057", "story_v_out_417131.awb") ~= 0 then
					local var_233_24 = manager.audio:GetVoiceLength("story_v_out_417131", "417131057", "story_v_out_417131.awb") / 1000

					if var_233_24 + var_233_17 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_24 + var_233_17
					end

					if var_233_20.prefab_name ~= "" and arg_230_1.actors_[var_233_20.prefab_name] ~= nil then
						local var_233_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_20.prefab_name].transform, "story_v_out_417131", "417131057", "story_v_out_417131.awb")

						arg_230_1:RecordAudio("417131057", var_233_25)
						arg_230_1:RecordAudio("417131057", var_233_25)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417131", "417131057", "story_v_out_417131.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417131", "417131057", "story_v_out_417131.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_26 = var_233_17 + 0.3
			local var_233_27 = math.max(var_233_18, arg_230_1.talkMaxDuration)

			if var_233_17 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_26 + var_233_27 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_26) / var_233_27

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_26 + var_233_27 and arg_230_1.time_ < var_233_26 + var_233_27 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417131058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 417131058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play417131059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0.1 < arg_236_1.time_ and arg_236_1.time_ <= 0.1 + arg_239_0 then
				arg_236_1:AudioAction("play", "effect", "se_story_130", "se_story_130__holographic", "")
			end

			local var_239_1 = 0
			local var_239_2 = 1.4

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(417131058).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 56 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 56)

				if (56 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 56)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play417131059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417131059
		arg_240_1.duration_ = 1.57

		local var_240_0 = {
			zh = 1.233,
			ja = 1.566
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
				arg_240_0:Play417131060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10115"]) and arg_240_1.var_.actorSpriteComps10115 == nil then
				arg_240_1.var_.actorSpriteComps10115 = arg_240_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10115"]) then
				if arg_240_1.var_.actorSpriteComps10115 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10115"]) and arg_240_1.var_.actorSpriteComps10115 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10115 = nil
			end

			local var_243_2 = arg_240_1.actors_["10115"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10115 = var_243_2.localPosition
				var_243_2.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10115", 4)

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
				var_243_2.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_240_1.time_ - 0) / var_243_4)
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				var_243_2.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_243_5 = 0
			local var_243_6 = 0.1

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:GetWordFromCfg(417131059)
				local var_243_8 = arg_240_1:FormatText(var_243_7.content)

				arg_240_1.text_.text = var_243_8

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_10 = 4 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_8) / 4)

				if (4 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_8) / 4)) > 0 and var_243_6 < var_243_10 then
					arg_240_1.talkMaxDuration = var_243_10

					if var_243_10 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_5
					end
				end

				arg_240_1.text_.text = var_243_8
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131059", "story_v_out_417131.awb") ~= 0 then
					local var_243_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131059", "story_v_out_417131.awb") / 1000

					if var_243_11 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_5
					end

					if var_243_7.prefab_name ~= "" and arg_240_1.actors_[var_243_7.prefab_name] ~= nil then
						local var_243_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_7.prefab_name].transform, "story_v_out_417131", "417131059", "story_v_out_417131.awb")

						arg_240_1:RecordAudio("417131059", var_243_12)
						arg_240_1:RecordAudio("417131059", var_243_12)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417131", "417131059", "story_v_out_417131.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417131", "417131059", "story_v_out_417131.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_13 = math.max(var_243_6, arg_240_1.talkMaxDuration)

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_13 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_5) / var_243_13

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_5 + var_243_13 and arg_240_1.time_ < var_243_5 + var_243_13 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417131060
		arg_244_1.duration_ = 4.53

		local var_244_0 = {
			zh = 1.4,
			ja = 4.533
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
				arg_244_0:Play417131061(arg_244_1)
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

			local var_247_2 = arg_244_1.actors_["10115"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10115 == nil then
				arg_244_1.var_.actorSpriteComps10115 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps10115 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10115 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_247_7 then
						iter_247_7.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10115 = nil
			end

			local var_247_5 = arg_244_1.actors_["1034"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1034 = var_247_5.localPosition
				var_247_5.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1034", 2)

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
				var_247_5.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_244_1.time_ - 0) / var_247_7)
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				var_247_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_247_8 = 0
			local var_247_9 = 0.175

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
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

				local var_247_10 = arg_244_1:GetWordFromCfg(417131060)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 7 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 7)

				if (7 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 7)) > 0 and var_247_9 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_8
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131060", "story_v_out_417131.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131060", "story_v_out_417131.awb") / 1000

					if var_247_14 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_8
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_out_417131", "417131060", "story_v_out_417131.awb")

						arg_244_1:RecordAudio("417131060", var_247_15)
						arg_244_1:RecordAudio("417131060", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417131", "417131060", "story_v_out_417131.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417131", "417131060", "story_v_out_417131.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_9, arg_244_1.talkMaxDuration)

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_8) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_8 + var_247_16 and arg_244_1.time_ < var_247_8 + var_247_16 + arg_247_0 then
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
	Play417131061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417131061
		arg_248_1.duration_ = 7

		local var_248_0 = {
			zh = 3.866,
			ja = 7
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
				arg_248_0:Play417131062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10115"]) and arg_248_1.var_.actorSpriteComps10115 == nil then
				arg_248_1.var_.actorSpriteComps10115 = arg_248_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10115"]) then
				if arg_248_1.var_.actorSpriteComps10115 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								iter_251_1.color = Color.New(Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, (arg_248_1.time_ - 0) / var_251_0), Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, (arg_248_1.time_ - 0) / var_251_0), (Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, (arg_248_1.time_ - 0) / var_251_0)))
							else
								local var_251_1 = Mathf.Lerp(iter_251_1.color.r, 1, (arg_248_1.time_ - 0) / var_251_0)

								iter_251_1.color = Color.New(var_251_1, var_251_1, var_251_1)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10115"]) and arg_248_1.var_.actorSpriteComps10115 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_251_3 then
						iter_251_3.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_248_1.var_.actorSpriteComps10115 = nil
			end

			local var_251_2 = arg_248_1.actors_["1034"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1034 == nil then
				arg_248_1.var_.actorSpriteComps1034 = var_251_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_3 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 and not isNil(var_251_2) then
				if arg_248_1.var_.actorSpriteComps1034 then
					for iter_251_4, iter_251_5 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_251_5 then
							if arg_248_1.isInRecall_ then
								iter_251_5.color = Color.New(Mathf.Lerp(iter_251_5.color.r, arg_248_1.hightColor2.r, (arg_248_1.time_ - 0) / var_251_3), Mathf.Lerp(iter_251_5.color.g, arg_248_1.hightColor2.g, (arg_248_1.time_ - 0) / var_251_3), (Mathf.Lerp(iter_251_5.color.b, arg_248_1.hightColor2.b, (arg_248_1.time_ - 0) / var_251_3)))
							else
								local var_251_4 = Mathf.Lerp(iter_251_5.color.r, 0.5, (arg_248_1.time_ - 0) / var_251_3)

								iter_251_5.color = Color.New(var_251_4, var_251_4, var_251_4)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 and not isNil(var_251_2) and arg_248_1.var_.actorSpriteComps1034 then
				for iter_251_6, iter_251_7 in pairs(arg_248_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_251_7 then
						iter_251_7.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_248_1.var_.actorSpriteComps1034 = nil
			end

			local var_251_5 = 0
			local var_251_6 = 0.4

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:GetWordFromCfg(417131061)
				local var_251_8 = arg_248_1:FormatText(var_251_7.content)

				arg_248_1.text_.text = var_251_8

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_10 = 16 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_8) / 16)

				if (16 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_8) / 16)) > 0 and var_251_6 < var_251_10 then
					arg_248_1.talkMaxDuration = var_251_10

					if var_251_10 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_5
					end
				end

				arg_248_1.text_.text = var_251_8
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131061", "story_v_out_417131.awb") ~= 0 then
					local var_251_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131061", "story_v_out_417131.awb") / 1000

					if var_251_11 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_5
					end

					if var_251_7.prefab_name ~= "" and arg_248_1.actors_[var_251_7.prefab_name] ~= nil then
						local var_251_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_7.prefab_name].transform, "story_v_out_417131", "417131061", "story_v_out_417131.awb")

						arg_248_1:RecordAudio("417131061", var_251_12)
						arg_248_1:RecordAudio("417131061", var_251_12)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_417131", "417131061", "story_v_out_417131.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_417131", "417131061", "story_v_out_417131.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_13 = math.max(var_251_6, arg_248_1.talkMaxDuration)

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_13 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_5) / var_251_13

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_5 + var_251_13 and arg_248_1.time_ < var_251_5 + var_251_13 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417131062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417131062
		arg_252_1.duration_ = 6.2

		local var_252_0 = {
			zh = 5.166,
			ja = 6.2
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
				arg_252_0:Play417131063(arg_252_1)
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
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 1, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1034"]) and arg_252_1.var_.actorSpriteComps1034 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps1034 = nil
			end

			local var_255_2 = arg_252_1.actors_["10115"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10115 == nil then
				arg_252_1.var_.actorSpriteComps10115 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps10115 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								iter_255_5.color = Color.New(Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_5.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_5.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10115 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_255_7 then
						iter_255_7.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps10115 = nil
			end

			local var_255_5 = arg_252_1.actors_["1034"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1034 = var_255_5.localPosition
				var_255_5.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("1034", 2)

				for iter_255_8 = 0, var_255_5.childCount - 1 do
					local var_255_6 = var_255_5:GetChild(iter_255_8)

					if var_255_6.name == "split_7" or not string.find(var_255_6.name, "split") then
						var_255_6.gameObject:SetActive(true)
					else
						var_255_6.gameObject:SetActive(false)
					end
				end
			end

			local var_255_7 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				var_255_5.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_252_1.time_ - 0) / var_255_7)
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				var_255_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_255_8 = 0
			local var_255_9 = 0.65

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:GetWordFromCfg(417131062)
				local var_255_11 = arg_252_1:FormatText(var_255_10.content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 26 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 26)

				if (26 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 26)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131062", "story_v_out_417131.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131062", "story_v_out_417131.awb") / 1000

					if var_255_14 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_8
					end

					if var_255_10.prefab_name ~= "" and arg_252_1.actors_[var_255_10.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_10.prefab_name].transform, "story_v_out_417131", "417131062", "story_v_out_417131.awb")

						arg_252_1:RecordAudio("417131062", var_255_15)
						arg_252_1:RecordAudio("417131062", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417131", "417131062", "story_v_out_417131.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417131", "417131062", "story_v_out_417131.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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
	Play417131063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417131063
		arg_256_1.duration_ = 6.67

		local var_256_0 = {
			zh = 4.133,
			ja = 6.666
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
				arg_256_0:Play417131064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10115"]) and arg_256_1.var_.actorSpriteComps10115 == nil then
				arg_256_1.var_.actorSpriteComps10115 = arg_256_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10115"]) then
				if arg_256_1.var_.actorSpriteComps10115 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								iter_259_1.color = Color.New(Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor1.r, (arg_256_1.time_ - 0) / var_259_0), Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor1.g, (arg_256_1.time_ - 0) / var_259_0), (Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor1.b, (arg_256_1.time_ - 0) / var_259_0)))
							else
								local var_259_1 = Mathf.Lerp(iter_259_1.color.r, 1, (arg_256_1.time_ - 0) / var_259_0)

								iter_259_1.color = Color.New(var_259_1, var_259_1, var_259_1)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10115"]) and arg_256_1.var_.actorSpriteComps10115 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_259_3 then
						iter_259_3.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_256_1.var_.actorSpriteComps10115 = nil
			end

			local var_259_2 = arg_256_1.actors_["1034"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps1034 == nil then
				arg_256_1.var_.actorSpriteComps1034 = var_259_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_3 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.actorSpriteComps1034 then
					for iter_259_4, iter_259_5 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_259_5 then
							if arg_256_1.isInRecall_ then
								iter_259_5.color = Color.New(Mathf.Lerp(iter_259_5.color.r, arg_256_1.hightColor2.r, (arg_256_1.time_ - 0) / var_259_3), Mathf.Lerp(iter_259_5.color.g, arg_256_1.hightColor2.g, (arg_256_1.time_ - 0) / var_259_3), (Mathf.Lerp(iter_259_5.color.b, arg_256_1.hightColor2.b, (arg_256_1.time_ - 0) / var_259_3)))
							else
								local var_259_4 = Mathf.Lerp(iter_259_5.color.r, 0.5, (arg_256_1.time_ - 0) / var_259_3)

								iter_259_5.color = Color.New(var_259_4, var_259_4, var_259_4)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps1034 then
				for iter_259_6, iter_259_7 in pairs(arg_256_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_259_7 then
						iter_259_7.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_256_1.var_.actorSpriteComps1034 = nil
			end

			local var_259_5 = 0
			local var_259_6 = 0.525

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_7 = arg_256_1:GetWordFromCfg(417131063)
				local var_259_8 = arg_256_1:FormatText(var_259_7.content)

				arg_256_1.text_.text = var_259_8

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 21 <= 0 and var_259_6 or var_259_6 * (utf8.len(var_259_8) / 21)

				if (21 <= 0 and var_259_6 or var_259_6 * (utf8.len(var_259_8) / 21)) > 0 and var_259_6 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_5
					end
				end

				arg_256_1.text_.text = var_259_8
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131063", "story_v_out_417131.awb") ~= 0 then
					local var_259_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131063", "story_v_out_417131.awb") / 1000

					if var_259_11 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_5
					end

					if var_259_7.prefab_name ~= "" and arg_256_1.actors_[var_259_7.prefab_name] ~= nil then
						local var_259_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_7.prefab_name].transform, "story_v_out_417131", "417131063", "story_v_out_417131.awb")

						arg_256_1:RecordAudio("417131063", var_259_12)
						arg_256_1:RecordAudio("417131063", var_259_12)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417131", "417131063", "story_v_out_417131.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417131", "417131063", "story_v_out_417131.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_13 = math.max(var_259_6, arg_256_1.talkMaxDuration)

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_13 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_5) / var_259_13

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_5 + var_259_13 and arg_256_1.time_ < var_259_5 + var_259_13 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417131064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417131064
		arg_260_1.duration_ = 12.03

		local var_260_0 = {
			zh = 8.566,
			ja = 12.033
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
				arg_260_0:Play417131065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10115 = arg_260_1.actors_["10115"].transform.localPosition
				arg_260_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10115", 4)

				for iter_263_0 = 0, arg_260_1.actors_["10115"].transform.childCount - 1 do
					local var_263_0 = arg_260_1.actors_["10115"].transform:GetChild(iter_263_0)

					if var_263_0.name == "" or not string.find(var_263_0.name, "split") then
						var_263_0.gameObject:SetActive(true)
					else
						var_263_0.gameObject:SetActive(false)
					end
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_260_1.time_ - 0) / var_263_1)
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["10115"].transform.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_263_2 = 0
			local var_263_3 = 0.925

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:GetWordFromCfg(417131064)
				local var_263_5 = arg_260_1:FormatText(var_263_4.content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 37 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 37)

				if (37 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 37)) > 0 and var_263_3 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131064", "story_v_out_417131.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131064", "story_v_out_417131.awb") / 1000

					if var_263_8 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_2
					end

					if var_263_4.prefab_name ~= "" and arg_260_1.actors_[var_263_4.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_4.prefab_name].transform, "story_v_out_417131", "417131064", "story_v_out_417131.awb")

						arg_260_1:RecordAudio("417131064", var_263_9)
						arg_260_1:RecordAudio("417131064", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417131", "417131064", "story_v_out_417131.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417131", "417131064", "story_v_out_417131.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_10 and arg_260_1.time_ < var_263_2 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417131065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417131065
		arg_264_1.duration_ = 4.9

		local var_264_0 = {
			zh = 4.6,
			ja = 4.9
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
				arg_264_0:Play417131066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1034"]) and arg_264_1.var_.actorSpriteComps1034 == nil then
				arg_264_1.var_.actorSpriteComps1034 = arg_264_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1034"]) then
				if arg_264_1.var_.actorSpriteComps1034 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1034"]) and arg_264_1.var_.actorSpriteComps1034 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps1034 = nil
			end

			local var_267_2 = arg_264_1.actors_["10115"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10115 == nil then
				arg_264_1.var_.actorSpriteComps10115 = var_267_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_3 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.actorSpriteComps10115 then
					for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.actorSpriteComps10115 then
				for iter_267_6, iter_267_7 in pairs(arg_264_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_267_7 then
						iter_267_7.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_264_1.var_.actorSpriteComps10115 = nil
			end

			local var_267_5 = arg_264_1.actors_["1034"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1034 = var_267_5.localPosition
				var_267_5.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1034", 2)

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
				var_267_5.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_264_1.time_ - 0) / var_267_7)
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				var_267_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_267_8 = 0
			local var_267_9 = 0.6

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_10 = arg_264_1:GetWordFromCfg(417131065)
				local var_267_11 = arg_264_1:FormatText(var_267_10.content)

				arg_264_1.text_.text = var_267_11

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_13 = 24 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 24)

				if (24 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 24)) > 0 and var_267_9 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_11
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131065", "story_v_out_417131.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_out_417131", "417131065", "story_v_out_417131.awb") / 1000

					if var_267_14 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_8
					end

					if var_267_10.prefab_name ~= "" and arg_264_1.actors_[var_267_10.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_10.prefab_name].transform, "story_v_out_417131", "417131065", "story_v_out_417131.awb")

						arg_264_1:RecordAudio("417131065", var_267_15)
						arg_264_1:RecordAudio("417131065", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417131", "417131065", "story_v_out_417131.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417131", "417131065", "story_v_out_417131.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_16 and arg_264_1.time_ < var_267_8 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
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

		arg_264_1:InitPlayNodeList()
	end,
	Play417131066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 417131066
		arg_268_1.duration_ = 11.23

		local var_268_0 = {
			zh = 5.5,
			ja = 11.233
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
				arg_268_0:Play417131067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.725

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(417131066)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 29 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 29)

				if (29 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 29)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131066", "story_v_out_417131.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131066", "story_v_out_417131.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_417131", "417131066", "story_v_out_417131.awb")

						arg_268_1:RecordAudio("417131066", var_271_6)
						arg_268_1:RecordAudio("417131066", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_417131", "417131066", "story_v_out_417131.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_417131", "417131066", "story_v_out_417131.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play417131067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 417131067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play417131068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1034"]) and arg_272_1.var_.actorSpriteComps1034 == nil then
				arg_272_1.var_.actorSpriteComps1034 = arg_272_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_0 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1034"]) then
				if arg_272_1.var_.actorSpriteComps1034 then
					for iter_275_0, iter_275_1 in pairs(arg_272_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_275_1 then
							if arg_272_1.isInRecall_ then
								iter_275_1.color = Color.New(Mathf.Lerp(iter_275_1.color.r, arg_272_1.hightColor2.r, (arg_272_1.time_ - 0) / var_275_0), Mathf.Lerp(iter_275_1.color.g, arg_272_1.hightColor2.g, (arg_272_1.time_ - 0) / var_275_0), (Mathf.Lerp(iter_275_1.color.b, arg_272_1.hightColor2.b, (arg_272_1.time_ - 0) / var_275_0)))
							else
								local var_275_1 = Mathf.Lerp(iter_275_1.color.r, 0.5, (arg_272_1.time_ - 0) / var_275_0)

								iter_275_1.color = Color.New(var_275_1, var_275_1, var_275_1)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1034"]) and arg_272_1.var_.actorSpriteComps1034 then
				for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_275_3 then
						iter_275_3.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_272_1.var_.actorSpriteComps1034 = nil
			end

			local var_275_2 = arg_272_1.actors_["1034"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1034 = var_275_2.localPosition
				var_275_2.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("1034", 7)

				for iter_275_4 = 0, var_275_2.childCount - 1 do
					local var_275_3 = var_275_2:GetChild(iter_275_4)

					if var_275_3.name == "" or not string.find(var_275_3.name, "split") then
						var_275_3.gameObject:SetActive(true)
					else
						var_275_3.gameObject:SetActive(false)
					end
				end
			end

			local var_275_4 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				var_275_2.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_272_1.time_ - 0) / var_275_4)
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				var_275_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_275_5 = arg_272_1.actors_["10115"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10115 = var_275_5.localPosition
				var_275_5.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10115", 7)

				for iter_275_5 = 0, var_275_5.childCount - 1 do
					local var_275_6 = var_275_5:GetChild(iter_275_5)

					if var_275_6.name == "" or not string.find(var_275_6.name, "split") then
						var_275_6.gameObject:SetActive(true)
					else
						var_275_6.gameObject:SetActive(false)
					end
				end
			end

			local var_275_7 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				var_275_5.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_272_1.time_ - 0) / var_275_7)
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				var_275_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_272_1.time_ and arg_272_1.time_ <= 0.3 + arg_275_0 then
				arg_272_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_275_9 = 0
			local var_275_10 = 1.3

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_9 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_11 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(417131067).content)

				arg_272_1.text_.text = var_275_11

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_13 = 52 <= 0 and var_275_10 or var_275_10 * (utf8.len(var_275_11) / 52)

				if (52 <= 0 and var_275_10 or var_275_10 * (utf8.len(var_275_11) / 52)) > 0 and var_275_10 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_9 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_9
					end
				end

				arg_272_1.text_.text = var_275_11
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_14 = math.max(var_275_10, arg_272_1.talkMaxDuration)

			if var_275_9 <= arg_272_1.time_ and arg_272_1.time_ < var_275_9 + var_275_14 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_9) / var_275_14

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_9 + var_275_14 and arg_272_1.time_ < var_275_9 + var_275_14 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
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
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play417131068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 417131068
		arg_276_1.duration_ = 2.8

		local var_276_0 = {
			zh = 2.8,
			ja = 2.1
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
				arg_276_0:Play417131069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.3

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_4")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:GetWordFromCfg(417131068)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 12 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 12)

				if (12 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 12)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131068", "story_v_out_417131.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131068", "story_v_out_417131.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_417131", "417131068", "story_v_out_417131.awb")

						arg_276_1:RecordAudio("417131068", var_279_6)
						arg_276_1:RecordAudio("417131068", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_417131", "417131068", "story_v_out_417131.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_417131", "417131068", "story_v_out_417131.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play417131069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 417131069
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play417131070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0.8 < arg_280_1.time_ and arg_280_1.time_ <= 0.8 + arg_283_0 then
				arg_280_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_283_1 = 0
			local var_283_2 = 1.575

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0

				arg_280_1.dialog_:SetActive(true)

				arg_280_1.dialogCg_.alpha = 0

				local var_283_3 = LeanTween.value(arg_280_1.dialog_, 0, 1, 0.3)

				var_283_3:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_280_1.dialogCg_.alpha = arg_284_0
				end))
				var_283_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_280_1.dialog_)
					var_283_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_280_1.duration_ = arg_280_1.duration_ + 0.3

				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(417131069).content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 63 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 63)

				if (63 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 63)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6
					var_283_1 = var_283_1 + 0.3

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = var_283_1 + 0.3
			local var_283_8 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 + 0.3 <= arg_280_1.time_ and arg_280_1.time_ < var_283_7 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_7) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_7 + var_283_8 and arg_280_1.time_ < var_283_7 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play417131070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417131070
		arg_286_1.duration_ = 8.43

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417131071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_9001
			local var_289_9000

			if 1.56666666666667 < arg_286_1.time_ and arg_286_1.time_ <= 1.56666666666667 + arg_289_0 then
				local var_289_0 = arg_286_1.bgs_.ST2105a

				arg_286_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_1 = var_289_0:GetComponent("SpriteRenderer")

				if var_289_1 and var_289_1.sprite then
					local var_289_2 = 2 * (var_289_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_0.transform.localScale = Vector3.New(var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "ST2105a" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_3 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= var_289_3 + 0.3 and arg_286_1.time_ < var_289_3 + 0.3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_4 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_5 = 1.56666666666667

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_5 then
				local var_289_6 = Color.New(0, 0, 0)

				var_289_6.a = Mathf.Lerp(0, 1, (arg_286_1.time_ - var_289_4) / var_289_5)
				arg_286_1.mask_.color = var_289_6
			end

			if arg_286_1.time_ >= var_289_4 + var_289_5 and arg_286_1.time_ < var_289_4 + var_289_5 + arg_289_0 then
				local var_289_7 = Color.New(0, 0, 0)

				var_289_7.a = 1
				arg_286_1.mask_.color = var_289_7
			end

			local var_289_8 = 1.56666666666667

			if 1.56666666666667 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_9 = 2

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_9 then
				local var_289_10 = Color.New(0, 0, 0)

				var_289_10.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_8) / var_289_9)
				arg_286_1.mask_.color = var_289_10
			end

			if arg_286_1.time_ >= var_289_8 + var_289_9 and arg_286_1.time_ < var_289_8 + var_289_9 + arg_289_0 then
				local var_289_11 = Color.New(0, 0, 0)

				arg_286_1.mask_.enabled = false
				var_289_11.a = 0
				arg_286_1.mask_.color = var_289_11
			end

			local var_289_12 = 1.53333333333333

			arg_286_1.isInRecall_ = false

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.screenFilterGo_:SetActive(false)

				for iter_289_2, iter_289_3 in pairs(arg_286_1.actors_) do
					for iter_289_4, iter_289_5 in ipairs((iter_289_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_289_5.color = iter_289_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_289_13 = 0.0333333333333332

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_13 then
				arg_286_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_12) / var_289_13)
			end

			if arg_286_1.time_ >= var_289_12 + var_289_13 and arg_286_1.time_ < var_289_12 + var_289_13 + arg_289_0 then
				arg_286_1.screenFilterEffect_.weight = 0
			end

			if 2.43333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 2.43333333333333 + arg_289_0 then
				local var_289_14 = arg_286_1.var_.effect7456

				if not arg_286_1.var_.effect7456 then
					var_289_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_289_14.name = "7456"
					arg_286_1.var_.effect7456 = var_289_14
				else
					var_289_14.transform:SetParent(var_289_9001)
				end

				var_289_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_289_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_289_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_289_17 = var_289_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_289_6, iter_289_7 in ipairs((var_289_17:ToTable())) do
					iter_289_7.transform.localScale = Vector3.New(iter_289_7.transform.localScale.x / var_289_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_289_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_289_7.transform.localScale.y / var_289_16, iter_289_7.transform.localScale.z)
				end
			end

			if 1.56666666666667 < arg_286_1.time_ and arg_286_1.time_ <= 1.56666666666667 + arg_289_0 then
				local var_289_19 = arg_286_1.var_.effect811

				if not arg_286_1.var_.effect811 then
					var_289_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_289_19.name = "811"
					arg_286_1.var_.effect811 = var_289_19
				else
					var_289_19.transform:SetParent(var_289_9000)
				end

				var_289_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_289_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_289_21 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_289_22 = var_289_19.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_289_8, iter_289_9 in ipairs((var_289_22:ToTable())) do
					iter_289_9.transform.localScale = Vector3.New(iter_289_9.transform.localScale.x / var_289_21 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_289_22 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_289_9.transform.localScale.y / var_289_21, iter_289_9.transform.localScale.z)
				end
			end

			if 1.43333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 1.43333333333333 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crisis02_loop", "")
			end

			if 2.4 < arg_286_1.time_ and arg_286_1.time_ <= 2.4 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit02", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_26 = 3.43333333333333
			local var_289_27 = 1.25

			if 3.43333333333333 < arg_286_1.time_ and arg_286_1.time_ <= var_289_26 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_28 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_28:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_29 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(417131070).content)

				arg_286_1.text_.text = var_289_29

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_31 = 50 <= 0 and var_289_27 or var_289_27 * (utf8.len(var_289_29) / 50)

				if (50 <= 0 and var_289_27 or var_289_27 * (utf8.len(var_289_29) / 50)) > 0 and var_289_27 < var_289_31 then
					arg_286_1.talkMaxDuration = var_289_31
					var_289_26 = var_289_26 + 0.3

					if var_289_31 + var_289_26 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_31 + var_289_26
					end
				end

				arg_286_1.text_.text = var_289_29
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_32 = var_289_26 + 0.3
			local var_289_33 = math.max(var_289_27, arg_286_1.talkMaxDuration)

			if var_289_26 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_32 + var_289_33 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_32) / var_289_33

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_32 + var_289_33 and arg_286_1.time_ < var_289_32 + var_289_33 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417131071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417131071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417131072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				if arg_292_1.var_.effect7456 then
					Object.Destroy(arg_292_1.var_.effect7456)

					arg_292_1.var_.effect7456 = nil
				end
			end

			if 0.05 < arg_292_1.time_ and arg_292_1.time_ <= 0.05 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_295_2 = 0
			local var_295_3 = 1.025

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_4 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(417131071).content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_6 = 41 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_4) / 41)

				if (41 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_4) / 41)) > 0 and var_295_3 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_7 and arg_292_1.time_ < var_295_2 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417131072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417131072
		arg_296_1.duration_ = 4.87

		local var_296_0 = {
			zh = 3.666,
			ja = 4.866
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
				arg_296_0:Play417131073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10115"]) and arg_296_1.var_.actorSpriteComps10115 == nil then
				arg_296_1.var_.actorSpriteComps10115 = arg_296_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10115"]) then
				if arg_296_1.var_.actorSpriteComps10115 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10115"]) and arg_296_1.var_.actorSpriteComps10115 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10115 = nil
			end

			local var_299_2 = 0
			local var_299_3 = 0.45

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_6")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_4 = arg_296_1:GetWordFromCfg(417131072)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 18 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 18)

				if (18 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 18)) > 0 and var_299_3 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131072", "story_v_out_417131.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131072", "story_v_out_417131.awb") / 1000

					if var_299_8 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_2
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_out_417131", "417131072", "story_v_out_417131.awb")

						arg_296_1:RecordAudio("417131072", var_299_9)
						arg_296_1:RecordAudio("417131072", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417131", "417131072", "story_v_out_417131.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417131", "417131072", "story_v_out_417131.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_10 and arg_296_1.time_ < var_299_2 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play417131073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417131073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417131074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10115"]) and arg_300_1.var_.actorSpriteComps10115 == nil then
				arg_300_1.var_.actorSpriteComps10115 = arg_300_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10115"]) then
				if arg_300_1.var_.actorSpriteComps10115 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10115"]) and arg_300_1.var_.actorSpriteComps10115 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10115 = nil
			end

			if 0.05 < arg_300_1.time_ and arg_300_1.time_ <= 0.05 + arg_303_0 then
				arg_300_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit03", "")
			end

			local var_303_3 = 0
			local var_303_4 = 0.475

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_5 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(417131073).content)

				arg_300_1.text_.text = var_303_5

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_7 = 19 <= 0 and var_303_4 or var_303_4 * (utf8.len(var_303_5) / 19)

				if (19 <= 0 and var_303_4 or var_303_4 * (utf8.len(var_303_5) / 19)) > 0 and var_303_4 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_3 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_3
					end
				end

				arg_300_1.text_.text = var_303_5
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_4, arg_300_1.talkMaxDuration)

			if var_303_3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_3 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_3) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_3 + var_303_8 and arg_300_1.time_ < var_303_3 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play417131074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 417131074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play417131075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.525

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(417131074).content)

				arg_304_1.text_.text = var_307_1

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_3 = 61 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 61)

				if (61 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 61)) > 0 and var_307_0 < var_307_3 then
					arg_304_1.talkMaxDuration = var_307_3

					if var_307_3 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_3 + 0
					end
				end

				arg_304_1.text_.text = var_307_1
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_4 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_4

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play417131075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 417131075
		arg_308_1.duration_ = 9.93

		local var_308_0 = {
			zh = 8.633,
			ja = 9.933
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
				arg_308_0:Play417131076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["10115"]) and arg_308_1.var_.actorSpriteComps10115 == nil then
				arg_308_1.var_.actorSpriteComps10115 = arg_308_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["10115"]) then
				if arg_308_1.var_.actorSpriteComps10115 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								iter_311_1.color = Color.New(Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_0), Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_0), (Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_0)))
							else
								local var_311_1 = Mathf.Lerp(iter_311_1.color.r, 1, (arg_308_1.time_ - 0) / var_311_0)

								iter_311_1.color = Color.New(var_311_1, var_311_1, var_311_1)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["10115"]) and arg_308_1.var_.actorSpriteComps10115 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps10115 = nil
			end

			local var_311_2 = arg_308_1.actors_["10115"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10115 = var_311_2.localPosition
				var_311_2.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10115", 3)

				for iter_311_4 = 0, var_311_2.childCount - 1 do
					local var_311_3 = var_311_2:GetChild(iter_311_4)

					if var_311_3.name == "split_6" or not string.find(var_311_3.name, "split") then
						var_311_3.gameObject:SetActive(true)
					else
						var_311_3.gameObject:SetActive(false)
					end
				end
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_2.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_308_1.time_ - 0) / var_311_4)
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_311_5 = 0
			local var_311_6 = 0.925

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_7 = arg_308_1:GetWordFromCfg(417131075)
				local var_311_8 = arg_308_1:FormatText(var_311_7.content)

				arg_308_1.text_.text = var_311_8

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 37 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 37)

				if (37 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 37)) > 0 and var_311_6 < var_311_10 then
					arg_308_1.talkMaxDuration = var_311_10

					if var_311_10 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_5
					end
				end

				arg_308_1.text_.text = var_311_8
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131075", "story_v_out_417131.awb") ~= 0 then
					local var_311_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131075", "story_v_out_417131.awb") / 1000

					if var_311_11 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_5
					end

					if var_311_7.prefab_name ~= "" and arg_308_1.actors_[var_311_7.prefab_name] ~= nil then
						local var_311_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_7.prefab_name].transform, "story_v_out_417131", "417131075", "story_v_out_417131.awb")

						arg_308_1:RecordAudio("417131075", var_311_12)
						arg_308_1:RecordAudio("417131075", var_311_12)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_417131", "417131075", "story_v_out_417131.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_417131", "417131075", "story_v_out_417131.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_13 = math.max(var_311_6, arg_308_1.talkMaxDuration)

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_13 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_5) / var_311_13

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_5 + var_311_13 and arg_308_1.time_ < var_311_5 + var_311_13 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play417131076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 417131076
		arg_312_1.duration_ = 5.1

		local var_312_0 = {
			zh = 5.1,
			ja = 4.833
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
				arg_312_0:Play417131077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1034"]) and arg_312_1.var_.actorSpriteComps1034 == nil then
				arg_312_1.var_.actorSpriteComps1034 = arg_312_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1034"]) then
				if arg_312_1.var_.actorSpriteComps1034 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 1, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1034"]) and arg_312_1.var_.actorSpriteComps1034 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps1034 = nil
			end

			local var_315_2 = arg_312_1.actors_["10115"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10115 == nil then
				arg_312_1.var_.actorSpriteComps10115 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps10115 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								iter_315_5.color = Color.New(Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_3), Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_3), (Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_3)))
							else
								local var_315_4 = Mathf.Lerp(iter_315_5.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_3)

								iter_315_5.color = Color.New(var_315_4, var_315_4, var_315_4)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10115 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_315_7 then
						iter_315_7.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps10115 = nil
			end

			local var_315_5 = arg_312_1.actors_["10115"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10115 = var_315_5.localPosition
				var_315_5.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10115", 7)

				for iter_315_8 = 0, var_315_5.childCount - 1 do
					local var_315_6 = var_315_5:GetChild(iter_315_8)

					if var_315_6.name == "" or not string.find(var_315_6.name, "split") then
						var_315_6.gameObject:SetActive(true)
					else
						var_315_6.gameObject:SetActive(false)
					end
				end
			end

			local var_315_7 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				var_315_5.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_312_1.time_ - 0) / var_315_7)
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				var_315_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_8 = arg_312_1.actors_["1034"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1034 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1034", 3)

				for iter_315_9 = 0, var_315_8.childCount - 1 do
					local var_315_9 = var_315_8:GetChild(iter_315_9)

					if var_315_9.name == "split_6" or not string.find(var_315_9.name, "split") then
						var_315_9.gameObject:SetActive(true)
					else
						var_315_9.gameObject:SetActive(false)
					end
				end
			end

			local var_315_10 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_10 then
				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_312_1.time_ - 0) / var_315_10)
			end

			if arg_312_1.time_ >= 0 + var_315_10 and arg_312_1.time_ < 0 + var_315_10 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_315_11 = 0
			local var_315_12 = 0.675

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_11 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_13 = arg_312_1:GetWordFromCfg(417131076)
				local var_315_14 = arg_312_1:FormatText(var_315_13.content)

				arg_312_1.text_.text = var_315_14

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_16 = 27 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 27)

				if (27 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 27)) > 0 and var_315_12 < var_315_16 then
					arg_312_1.talkMaxDuration = var_315_16

					if var_315_16 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_16 + var_315_11
					end
				end

				arg_312_1.text_.text = var_315_14
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131076", "story_v_out_417131.awb") ~= 0 then
					local var_315_17 = manager.audio:GetVoiceLength("story_v_out_417131", "417131076", "story_v_out_417131.awb") / 1000

					if var_315_17 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_17 + var_315_11
					end

					if var_315_13.prefab_name ~= "" and arg_312_1.actors_[var_315_13.prefab_name] ~= nil then
						local var_315_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_13.prefab_name].transform, "story_v_out_417131", "417131076", "story_v_out_417131.awb")

						arg_312_1:RecordAudio("417131076", var_315_18)
						arg_312_1:RecordAudio("417131076", var_315_18)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_417131", "417131076", "story_v_out_417131.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_417131", "417131076", "story_v_out_417131.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_19 = math.max(var_315_12, arg_312_1.talkMaxDuration)

			if var_315_11 <= arg_312_1.time_ and arg_312_1.time_ < var_315_11 + var_315_19 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_11) / var_315_19

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_11 + var_315_19 and arg_312_1.time_ < var_315_11 + var_315_19 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_312_1:InitPlayNodeList()
	end,
	Play417131077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 417131077
		arg_316_1.duration_ = 8.23

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play417131078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_9000

			if 1.16666666666667 < arg_316_1.time_ and arg_316_1.time_ <= 1.16666666666667 + arg_319_0 and not isNil(arg_316_1.actors_["1034"]) and arg_316_1.var_.actorSpriteComps1034 == nil then
				arg_316_1.var_.actorSpriteComps1034 = arg_316_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.2

			if 1.16666666666667 <= arg_316_1.time_ and arg_316_1.time_ < 1.16666666666667 + var_319_0 and not isNil(arg_316_1.actors_["1034"]) then
				if arg_316_1.var_.actorSpriteComps1034 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 1.16666666666667) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 1.16666666666667) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 1.16666666666667) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 0.5, (arg_316_1.time_ - 1.16666666666667) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 1.16666666666667 + var_319_0 and arg_316_1.time_ < 1.16666666666667 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1034"]) and arg_316_1.var_.actorSpriteComps1034 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps1034 = nil
			end

			local var_319_2 = arg_316_1.actors_["1034"].transform

			if 1.16666666666667 < arg_316_1.time_ and arg_316_1.time_ <= 1.16666666666667 + arg_319_0 then
				arg_316_1.var_.moveOldPos1034 = var_319_2.localPosition
				var_319_2.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("1034", 7)

				for iter_319_4 = 0, var_319_2.childCount - 1 do
					local var_319_3 = var_319_2:GetChild(iter_319_4)

					if var_319_3.name == "" or not string.find(var_319_3.name, "split") then
						var_319_3.gameObject:SetActive(true)
					else
						var_319_3.gameObject:SetActive(false)
					end
				end
			end

			local var_319_4 = 0.001

			if 1.16666666666667 <= arg_316_1.time_ and arg_316_1.time_ < 1.16666666666667 + var_319_4 then
				var_319_2.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_316_1.time_ - 1.16666666666667) / var_319_4)
			end

			if arg_316_1.time_ >= 1.16666666666667 + var_319_4 and arg_316_1.time_ < 1.16666666666667 + var_319_4 + arg_319_0 then
				var_319_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.26666666666667 < arg_316_1.time_ and arg_316_1.time_ <= 2.26666666666667 + arg_319_0 then
				local var_319_5 = arg_316_1.var_.effect798

				if not arg_316_1.var_.effect798 then
					var_319_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), manager.ui.mainCamera.transform)
					var_319_5.name = "798"
					arg_316_1.var_.effect798 = var_319_5
				else
					var_319_5.transform:SetParent(var_319_9000)
				end

				var_319_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_319_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_319_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_319_8 = var_319_5.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_319_5, iter_319_6 in ipairs((var_319_8:ToTable())) do
					iter_319_6.transform.localScale = Vector3.New(iter_319_6.transform.localScale.x / var_319_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_319_8 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_319_6.transform.localScale.y / var_319_7, iter_319_6.transform.localScale.z)
				end
			end

			local var_319_10 = 1.16666666666667

			if 1.16666666666667 < arg_316_1.time_ and arg_316_1.time_ <= var_319_10 + arg_319_0 then
				arg_316_1.allBtn_.enabled = false
			end

			if arg_316_1.time_ >= var_319_10 + 1.76666666666667 and arg_316_1.time_ < var_319_10 + 1.76666666666667 + arg_319_0 then
				arg_316_1.allBtn_.enabled = true
			end

			if 1.7 < arg_316_1.time_ and arg_316_1.time_ <= 1.7 + arg_319_0 then
				arg_316_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_319_12 = 0

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_12 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_13 = 1.23333333333333

			if var_319_12 <= arg_316_1.time_ and arg_316_1.time_ < var_319_12 + var_319_13 then
				local var_319_14 = Color.New(0, 0, 0)

				var_319_14.a = Mathf.Lerp(0, 1, (arg_316_1.time_ - var_319_12) / var_319_13)
				arg_316_1.mask_.color = var_319_14
			end

			if arg_316_1.time_ >= var_319_12 + var_319_13 and arg_316_1.time_ < var_319_12 + var_319_13 + arg_319_0 then
				local var_319_15 = Color.New(0, 0, 0)

				var_319_15.a = 1
				arg_316_1.mask_.color = var_319_15
			end

			local var_319_16 = 1.23333333333333

			if 1.23333333333333 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_17 = 2

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 then
				local var_319_18 = Color.New(0, 0, 0)

				var_319_18.a = Mathf.Lerp(1, 0, (arg_316_1.time_ - var_319_16) / var_319_17)
				arg_316_1.mask_.color = var_319_18
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				local var_319_19 = Color.New(0, 0, 0)

				arg_316_1.mask_.enabled = false
				var_319_19.a = 0
				arg_316_1.mask_.color = var_319_19
			end

			local var_319_20 = "STblack"

			if arg_316_1.bgs_.STblack == nil then
				local var_319_21 = Object.Instantiate(arg_316_1.paintGo_)

				var_319_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_319_20)
				var_319_21.name = var_319_20
				var_319_21.transform.parent = arg_316_1.stage_.transform
				var_319_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.bgs_[var_319_20] = var_319_21
			end

			if 1.23333333333333 < arg_316_1.time_ and arg_316_1.time_ <= 1.23333333333333 + arg_319_0 then
				local var_319_22 = arg_316_1.bgs_.STblack

				arg_316_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_319_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_23 = var_319_22:GetComponent("SpriteRenderer")

				if var_319_23 and var_319_23.sprite then
					local var_319_24 = 2 * (var_319_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_319_22.transform.localScale = Vector3.New(var_319_24 / var_319_23.sprite.bounds.size.y < var_319_24 * manager.ui.mainCameraCom_.aspect / var_319_23.sprite.bounds.size.x and var_319_24 * manager.ui.mainCameraCom_.aspect / var_319_23.sprite.bounds.size.x or var_319_24 / var_319_23.sprite.bounds.size.y, var_319_24 / var_319_23.sprite.bounds.size.y < var_319_24 * manager.ui.mainCameraCom_.aspect / var_319_23.sprite.bounds.size.x and var_319_24 * manager.ui.mainCameraCom_.aspect / var_319_23.sprite.bounds.size.x or var_319_24 / var_319_23.sprite.bounds.size.y, 0)
				end

				for iter_319_7, iter_319_8 in pairs(arg_316_1.bgs_) do
					if iter_319_7 ~= "STblack" then
						iter_319_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_25 = 3.23333333333333
			local var_319_26 = 1.5

			if 3.23333333333333 < arg_316_1.time_ and arg_316_1.time_ <= var_319_25 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_27 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_27:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_28 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(417131077).content)

				arg_316_1.text_.text = var_319_28

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_30 = 60 <= 0 and var_319_26 or var_319_26 * (utf8.len(var_319_28) / 60)

				if (60 <= 0 and var_319_26 or var_319_26 * (utf8.len(var_319_28) / 60)) > 0 and var_319_26 < var_319_30 then
					arg_316_1.talkMaxDuration = var_319_30
					var_319_25 = var_319_25 + 0.3

					if var_319_30 + var_319_25 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_30 + var_319_25
					end
				end

				arg_316_1.text_.text = var_319_28
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_31 = var_319_25 + 0.3
			local var_319_32 = math.max(var_319_26, arg_316_1.talkMaxDuration)

			if var_319_25 + 0.3 <= arg_316_1.time_ and arg_316_1.time_ < var_319_31 + var_319_32 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_31) / var_319_32

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_31 + var_319_32 and arg_316_1.time_ < var_319_31 + var_319_32 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play417131078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417131078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417131079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				if arg_322_1.var_.effect798 then
					Object.Destroy(arg_322_1.var_.effect798)

					arg_322_1.var_.effect798 = nil
				end
			end

			local var_325_1 = 0
			local var_325_2 = 1.125

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(417131078).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 45 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 45)

				if (45 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 45)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417131079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417131079
		arg_326_1.duration_ = 1.88

		local var_326_0 = {
			zh = 1.78333333333333,
			ja = 1.88333333333333
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417131080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0.2 < arg_326_1.time_ and arg_326_1.time_ <= 0.2 + arg_329_0 then
				local var_329_0 = arg_326_1.var_.effect1236

				if not arg_326_1.var_.effect1236 then
					var_329_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_329_0.name = "1236"
					arg_326_1.var_.effect1236 = var_329_0
				else
					var_329_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_329_0.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_329_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_329_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_329_3 = var_329_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_329_0, iter_329_1 in ipairs((var_329_3:ToTable())) do
					iter_329_1.transform.localScale = Vector3.New(iter_329_1.transform.localScale.x / var_329_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_329_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_329_1.transform.localScale.y / var_329_2, iter_329_1.transform.localScale.z)
				end
			end

			local var_329_5 = 0

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = false

				arg_326_1:SetGaussion(false)
			end

			local var_329_6 = 0.3

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_6 then
				local var_329_7 = Color.New(1, 1, 1)

				var_329_7.a = Mathf.Lerp(1, 0, (arg_326_1.time_ - var_329_5) / var_329_6)
				arg_326_1.mask_.color = var_329_7
			end

			if arg_326_1.time_ >= var_329_5 + var_329_6 and arg_326_1.time_ < var_329_5 + var_329_6 + arg_329_0 then
				local var_329_8 = Color.New(1, 1, 1)

				arg_326_1.mask_.enabled = false
				var_329_8.a = 0
				arg_326_1.mask_.color = var_329_8
			end

			if 0.233333333333333 < arg_326_1.time_ and arg_326_1.time_ <= 0.233333333333333 + arg_329_0 then
				arg_326_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_10 = 0.583333333333333
			local var_329_11 = 0.05

			if 0.583333333333333 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_12 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_12:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_13 = arg_326_1:GetWordFromCfg(417131079)
				local var_329_14 = arg_326_1:FormatText(var_329_13.content)

				arg_326_1.text_.text = var_329_14

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_16 = 2 <= 0 and var_329_11 or var_329_11 * (utf8.len(var_329_14) / 2)

				if (2 <= 0 and var_329_11 or var_329_11 * (utf8.len(var_329_14) / 2)) > 0 and var_329_11 < var_329_16 then
					arg_326_1.talkMaxDuration = var_329_16
					var_329_10 = var_329_10 + 0.3

					if var_329_16 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_16 + var_329_10
					end
				end

				arg_326_1.text_.text = var_329_14
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131079", "story_v_out_417131.awb") ~= 0 then
					local var_329_17 = manager.audio:GetVoiceLength("story_v_out_417131", "417131079", "story_v_out_417131.awb") / 1000

					if var_329_17 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_17 + var_329_10
					end

					if var_329_13.prefab_name ~= "" and arg_326_1.actors_[var_329_13.prefab_name] ~= nil then
						local var_329_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_13.prefab_name].transform, "story_v_out_417131", "417131079", "story_v_out_417131.awb")

						arg_326_1:RecordAudio("417131079", var_329_18)
						arg_326_1:RecordAudio("417131079", var_329_18)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417131", "417131079", "story_v_out_417131.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417131", "417131079", "story_v_out_417131.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_19 = var_329_10 + 0.3
			local var_329_20 = math.max(var_329_11, arg_326_1.talkMaxDuration)

			if var_329_10 + 0.3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_19 + var_329_20 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_19) / var_329_20

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_19 + var_329_20 and arg_326_1.time_ < var_329_19 + var_329_20 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417131080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 417131080
		arg_332_1.duration_ = 6.75

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play417131081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1034"]) and arg_332_1.var_.actorSpriteComps1034 == nil then
				arg_332_1.var_.actorSpriteComps1034 = arg_332_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_0 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1034"]) then
				if arg_332_1.var_.actorSpriteComps1034 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								iter_335_1.color = Color.New(Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor2.r, (arg_332_1.time_ - 0) / var_335_0), Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor2.g, (arg_332_1.time_ - 0) / var_335_0), (Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor2.b, (arg_332_1.time_ - 0) / var_335_0)))
							else
								local var_335_1 = Mathf.Lerp(iter_335_1.color.r, 0.5, (arg_332_1.time_ - 0) / var_335_0)

								iter_335_1.color = Color.New(var_335_1, var_335_1, var_335_1)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1034"]) and arg_332_1.var_.actorSpriteComps1034 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_335_3 then
						iter_335_3.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_332_1.var_.actorSpriteComps1034 = nil
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				if arg_332_1.var_.effect1236 then
					Object.Destroy(arg_332_1.var_.effect1236)

					arg_332_1.var_.effect1236 = nil
				end
			end

			if 1.1 < arg_332_1.time_ and arg_332_1.time_ <= 1.1 + arg_335_0 then
				local var_335_3 = arg_332_1.bgs_.ST2105a

				arg_332_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_335_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_4 = var_335_3:GetComponent("SpriteRenderer")

				if var_335_4 and var_335_4.sprite then
					local var_335_5 = 2 * (var_335_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_335_3.transform.localScale = Vector3.New(var_335_5 / var_335_4.sprite.bounds.size.y < var_335_5 * manager.ui.mainCameraCom_.aspect / var_335_4.sprite.bounds.size.x and var_335_5 * manager.ui.mainCameraCom_.aspect / var_335_4.sprite.bounds.size.x or var_335_5 / var_335_4.sprite.bounds.size.y, var_335_5 / var_335_4.sprite.bounds.size.y < var_335_5 * manager.ui.mainCameraCom_.aspect / var_335_4.sprite.bounds.size.x and var_335_5 * manager.ui.mainCameraCom_.aspect / var_335_4.sprite.bounds.size.x or var_335_5 / var_335_4.sprite.bounds.size.y, 0)
				end

				for iter_335_4, iter_335_5 in pairs(arg_332_1.bgs_) do
					if iter_335_4 ~= "ST2105a" then
						iter_335_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_6 = 0

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_7 = 1.1

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_7 then
				local var_335_8 = Color.New(0, 0, 0)

				var_335_8.a = Mathf.Lerp(0, 1, (arg_332_1.time_ - var_335_6) / var_335_7)
				arg_332_1.mask_.color = var_335_8
			end

			if arg_332_1.time_ >= var_335_6 + var_335_7 and arg_332_1.time_ < var_335_6 + var_335_7 + arg_335_0 then
				local var_335_9 = Color.New(0, 0, 0)

				var_335_9.a = 1
				arg_332_1.mask_.color = var_335_9
			end

			local var_335_10 = 1.1

			if 1.1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_11 = 0.933333333333333

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 then
				local var_335_12 = Color.New(0, 0, 0)

				var_335_12.a = Mathf.Lerp(1, 0, (arg_332_1.time_ - var_335_10) / var_335_11)
				arg_332_1.mask_.color = var_335_12
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				local var_335_13 = Color.New(0, 0, 0)

				arg_332_1.mask_.enabled = false
				var_335_13.a = 0
				arg_332_1.mask_.color = var_335_13
			end

			local var_335_14 = 1.74848109856248
			local var_335_15 = 1.525

			if 1.74848109856248 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_16 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(417131080).content)

				arg_332_1.text_.text = var_335_16

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_18 = 61 <= 0 and var_335_15 or var_335_15 * (utf8.len(var_335_16) / 61)

				if (61 <= 0 and var_335_15 or var_335_15 * (utf8.len(var_335_16) / 61)) > 0 and var_335_15 < var_335_18 then
					arg_332_1.talkMaxDuration = var_335_18

					if var_335_18 + var_335_14 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_18 + var_335_14
					end
				end

				arg_332_1.text_.text = var_335_16
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_19 = math.max(var_335_15, arg_332_1.talkMaxDuration)

			if var_335_14 <= arg_332_1.time_ and arg_332_1.time_ < var_335_14 + var_335_19 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_14) / var_335_19

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_14 + var_335_19 and arg_332_1.time_ < var_335_14 + var_335_19 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play417131081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 417131081
		arg_336_1.duration_ = 3.2

		local var_336_0 = {
			zh = 3.2,
			ja = 1.5
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
				arg_336_0:Play417131082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.325

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_3")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:GetWordFromCfg(417131081)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 13 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 13)

				if (13 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 13)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131081", "story_v_out_417131.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131081", "story_v_out_417131.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_417131", "417131081", "story_v_out_417131.awb")

						arg_336_1:RecordAudio("417131081", var_339_6)
						arg_336_1:RecordAudio("417131081", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_417131", "417131081", "story_v_out_417131.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_417131", "417131081", "story_v_out_417131.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play417131082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 417131082
		arg_340_1.duration_ = 8.69

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play417131083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if arg_340_1.bgs_.SS1705 == nil then
				local var_343_0 = Object.Instantiate(arg_340_1.paintGo_)

				var_343_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1705")
				var_343_0.name = "SS1705"
				var_343_0.transform.parent = arg_340_1.stage_.transform
				var_343_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.bgs_.SS1705 = var_343_0
			end

			if 1.96666666666667 < arg_340_1.time_ and arg_340_1.time_ <= 1.96666666666667 + arg_343_0 then
				local var_343_1 = arg_340_1.bgs_.SS1705

				arg_340_1.bgs_.SS1705.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_343_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_343_2 = var_343_1:GetComponent("SpriteRenderer")

				if var_343_2 and var_343_2.sprite then
					local var_343_3 = 2 * (var_343_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_343_1.transform.localScale = Vector3.New(var_343_3 / var_343_2.sprite.bounds.size.y < var_343_3 * manager.ui.mainCameraCom_.aspect / var_343_2.sprite.bounds.size.x and var_343_3 * manager.ui.mainCameraCom_.aspect / var_343_2.sprite.bounds.size.x or var_343_3 / var_343_2.sprite.bounds.size.y, var_343_3 / var_343_2.sprite.bounds.size.y < var_343_3 * manager.ui.mainCameraCom_.aspect / var_343_2.sprite.bounds.size.x and var_343_3 * manager.ui.mainCameraCom_.aspect / var_343_2.sprite.bounds.size.x or var_343_3 / var_343_2.sprite.bounds.size.y, 0)
				end

				for iter_343_0, iter_343_1 in pairs(arg_340_1.bgs_) do
					if iter_343_0 ~= "SS1705" then
						iter_343_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_343_4 = 1.96666666666667

			if 1.96666666666667 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1.allBtn_.enabled = false
			end

			if arg_340_1.time_ >= var_343_4 + 0.3 and arg_340_1.time_ < var_343_4 + 0.3 + arg_343_0 then
				arg_340_1.allBtn_.enabled = true
			end

			local var_343_5 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_6 = 2

			if var_343_5 <= arg_340_1.time_ and arg_340_1.time_ < var_343_5 + var_343_6 then
				local var_343_7 = Color.New(0, 0, 0)

				var_343_7.a = Mathf.Lerp(0, 1, (arg_340_1.time_ - var_343_5) / var_343_6)
				arg_340_1.mask_.color = var_343_7
			end

			if arg_340_1.time_ >= var_343_5 + var_343_6 and arg_340_1.time_ < var_343_5 + var_343_6 + arg_343_0 then
				local var_343_8 = Color.New(0, 0, 0)

				var_343_8.a = 1
				arg_340_1.mask_.color = var_343_8
			end

			local var_343_9 = 2.00066666666667

			if 2.00066666666667 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_10 = 2

			if var_343_9 <= arg_340_1.time_ and arg_340_1.time_ < var_343_9 + var_343_10 then
				local var_343_11 = Color.New(0, 0, 0)

				var_343_11.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_9) / var_343_10)
				arg_340_1.mask_.color = var_343_11
			end

			if arg_340_1.time_ >= var_343_9 + var_343_10 and arg_340_1.time_ < var_343_9 + var_343_10 + arg_343_0 then
				local var_343_12 = Color.New(0, 0, 0)

				arg_340_1.mask_.enabled = false
				var_343_12.a = 0
				arg_340_1.mask_.color = var_343_12
			end

			local var_343_13 = arg_340_1.actors_["10115"]

			if 1.96666666666667 < arg_340_1.time_ and arg_340_1.time_ <= 1.96666666666667 + arg_343_0 and not isNil(var_343_13) and arg_340_1.var_.actorSpriteComps10115 == nil then
				arg_340_1.var_.actorSpriteComps10115 = var_343_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_14 = 0.2

			if 1.96666666666667 <= arg_340_1.time_ and arg_340_1.time_ < 1.96666666666667 + var_343_14 and not isNil(var_343_13) then
				if arg_340_1.var_.actorSpriteComps10115 then
					for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_343_3 then
							if arg_340_1.isInRecall_ then
								iter_343_3.color = Color.New(Mathf.Lerp(iter_343_3.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 1.96666666666667) / var_343_14), Mathf.Lerp(iter_343_3.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 1.96666666666667) / var_343_14), (Mathf.Lerp(iter_343_3.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 1.96666666666667) / var_343_14)))
							else
								local var_343_15 = Mathf.Lerp(iter_343_3.color.r, 0.5, (arg_340_1.time_ - 1.96666666666667) / var_343_14)

								iter_343_3.color = Color.New(var_343_15, var_343_15, var_343_15)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 1.96666666666667 + var_343_14 and arg_340_1.time_ < 1.96666666666667 + var_343_14 + arg_343_0 and not isNil(var_343_13) and arg_340_1.var_.actorSpriteComps10115 then
				for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_343_5 then
						iter_343_5.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps10115 = nil
			end

			local var_343_16 = arg_340_1.actors_["10115"].transform

			if 1.96666666666667 < arg_340_1.time_ and arg_340_1.time_ <= 1.96666666666667 + arg_343_0 then
				arg_340_1.var_.moveOldPos10115 = var_343_16.localPosition
				var_343_16.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10115", 7)

				for iter_343_6 = 0, var_343_16.childCount - 1 do
					local var_343_17 = var_343_16:GetChild(iter_343_6)

					if var_343_17.name == "" or not string.find(var_343_17.name, "split") then
						var_343_17.gameObject:SetActive(true)
					else
						var_343_17.gameObject:SetActive(false)
					end
				end
			end

			local var_343_18 = 0.001

			if 1.96666666666667 <= arg_340_1.time_ and arg_340_1.time_ < 1.96666666666667 + var_343_18 then
				var_343_16.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_340_1.time_ - 1.96666666666667) / var_343_18)
			end

			if arg_340_1.time_ >= 1.96666666666667 + var_343_18 and arg_340_1.time_ < 1.96666666666667 + var_343_18 + arg_343_0 then
				var_343_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 3.33333333333333 < arg_340_1.time_ and arg_340_1.time_ <= 3.33333333333333 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep05", "")
			end

			if arg_340_1.frameCnt_ <= 1 then
				arg_340_1.dialog_:SetActive(false)
			end

			local var_343_20 = 3.68519694558345
			local var_343_21 = 1.275

			if 3.68519694558345 < arg_340_1.time_ and arg_340_1.time_ <= var_343_20 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0

				arg_340_1.dialog_:SetActive(true)

				arg_340_1.dialogCg_.alpha = 0

				local var_343_22 = LeanTween.value(arg_340_1.dialog_, 0, 1, 0.3)

				var_343_22:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_340_1.dialogCg_.alpha = arg_344_0
				end))
				var_343_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_340_1.dialog_)
					var_343_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_340_1.duration_ = arg_340_1.duration_ + 0.3

				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_23 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(417131082).content)

				arg_340_1.text_.text = var_343_23

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_25 = 51 <= 0 and var_343_21 or var_343_21 * (utf8.len(var_343_23) / 51)

				if (51 <= 0 and var_343_21 or var_343_21 * (utf8.len(var_343_23) / 51)) > 0 and var_343_21 < var_343_25 then
					arg_340_1.talkMaxDuration = var_343_25
					var_343_20 = var_343_20 + 0.3

					if var_343_25 + var_343_20 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_25 + var_343_20
					end
				end

				arg_340_1.text_.text = var_343_23
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_26 = var_343_20 + 0.3
			local var_343_27 = math.max(var_343_21, arg_340_1.talkMaxDuration)

			if var_343_20 + 0.3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_26 + var_343_27 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_26) / var_343_27

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_26 + var_343_27 and arg_340_1.time_ < var_343_26 + var_343_27 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play417131083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417131083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play417131084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 1.025

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(417131083).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 41 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 41)

				if (41 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 41)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play417131084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417131084
		arg_350_1.duration_ = 6.67

		local var_350_0 = {
			zh = 4.3,
			ja = 6.666
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
				arg_350_0:Play417131085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1034"]) and arg_350_1.var_.actorSpriteComps1034 == nil then
				arg_350_1.var_.actorSpriteComps1034 = arg_350_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1034"]) then
				if arg_350_1.var_.actorSpriteComps1034 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1034"]) and arg_350_1.var_.actorSpriteComps1034 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps1034 = nil
			end

			local var_353_2 = 0
			local var_353_3 = 0.225

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_4 = arg_350_1:GetWordFromCfg(417131084)
				local var_353_5 = arg_350_1:FormatText(var_353_4.content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 9 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 9)

				if (9 <= 0 and var_353_3 or var_353_3 * (utf8.len(var_353_5) / 9)) > 0 and var_353_3 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_2
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131084", "story_v_out_417131.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_417131", "417131084", "story_v_out_417131.awb") / 1000

					if var_353_8 + var_353_2 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_2
					end

					if var_353_4.prefab_name ~= "" and arg_350_1.actors_[var_353_4.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_4.prefab_name].transform, "story_v_out_417131", "417131084", "story_v_out_417131.awb")

						arg_350_1:RecordAudio("417131084", var_353_9)
						arg_350_1:RecordAudio("417131084", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417131", "417131084", "story_v_out_417131.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417131", "417131084", "story_v_out_417131.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_3, arg_350_1.talkMaxDuration)

			if var_353_2 <= arg_350_1.time_ and arg_350_1.time_ < var_353_2 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_2) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_2 + var_353_10 and arg_350_1.time_ < var_353_2 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417131085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417131085
		arg_354_1.duration_ = 6.13

		local var_354_0 = {
			zh = 4.033,
			ja = 6.133
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417131086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["10115"]) and arg_354_1.var_.actorSpriteComps10115 == nil then
				arg_354_1.var_.actorSpriteComps10115 = arg_354_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["10115"]) then
				if arg_354_1.var_.actorSpriteComps10115 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["10115"]) and arg_354_1.var_.actorSpriteComps10115 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_354_1.var_.actorSpriteComps10115 = nil
			end

			local var_357_2 = arg_354_1.actors_["1034"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_2) and arg_354_1.var_.actorSpriteComps1034 == nil then
				arg_354_1.var_.actorSpriteComps1034 = var_357_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_3 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_3 and not isNil(var_357_2) then
				if arg_354_1.var_.actorSpriteComps1034 then
					for iter_357_4, iter_357_5 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_357_5 then
							if arg_354_1.isInRecall_ then
								iter_357_5.color = Color.New(Mathf.Lerp(iter_357_5.color.r, arg_354_1.hightColor2.r, (arg_354_1.time_ - 0) / var_357_3), Mathf.Lerp(iter_357_5.color.g, arg_354_1.hightColor2.g, (arg_354_1.time_ - 0) / var_357_3), (Mathf.Lerp(iter_357_5.color.b, arg_354_1.hightColor2.b, (arg_354_1.time_ - 0) / var_357_3)))
							else
								local var_357_4 = Mathf.Lerp(iter_357_5.color.r, 0.5, (arg_354_1.time_ - 0) / var_357_3)

								iter_357_5.color = Color.New(var_357_4, var_357_4, var_357_4)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_3 and arg_354_1.time_ < 0 + var_357_3 + arg_357_0 and not isNil(var_357_2) and arg_354_1.var_.actorSpriteComps1034 then
				for iter_357_6, iter_357_7 in pairs(arg_354_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_357_7 then
						iter_357_7.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_354_1.var_.actorSpriteComps1034 = nil
			end

			local var_357_5 = 0
			local var_357_6 = 0.375

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_7 = arg_354_1:GetWordFromCfg(417131085)
				local var_357_8 = arg_354_1:FormatText(var_357_7.content)

				arg_354_1.text_.text = var_357_8

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 15 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 15)

				if (15 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 15)) > 0 and var_357_6 < var_357_10 then
					arg_354_1.talkMaxDuration = var_357_10

					if var_357_10 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_5
					end
				end

				arg_354_1.text_.text = var_357_8
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131085", "story_v_out_417131.awb") ~= 0 then
					local var_357_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131085", "story_v_out_417131.awb") / 1000

					if var_357_11 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_5
					end

					if var_357_7.prefab_name ~= "" and arg_354_1.actors_[var_357_7.prefab_name] ~= nil then
						local var_357_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_7.prefab_name].transform, "story_v_out_417131", "417131085", "story_v_out_417131.awb")

						arg_354_1:RecordAudio("417131085", var_357_12)
						arg_354_1:RecordAudio("417131085", var_357_12)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417131", "417131085", "story_v_out_417131.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417131", "417131085", "story_v_out_417131.awb")
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

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417131086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417131086
		arg_358_1.duration_ = 9.03

		local var_358_0 = {
			zh = 7.066,
			ja = 9.033
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
				arg_358_0:Play417131087(arg_358_1)
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
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 1, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1034"]) and arg_358_1.var_.actorSpriteComps1034 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps1034 = nil
			end

			local var_361_2 = arg_358_1.actors_["10115"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10115 == nil then
				arg_358_1.var_.actorSpriteComps10115 = var_361_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_3 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_3 and not isNil(var_361_2) then
				if arg_358_1.var_.actorSpriteComps10115 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								iter_361_5.color = Color.New(Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, (arg_358_1.time_ - 0) / var_361_3), Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, (arg_358_1.time_ - 0) / var_361_3), (Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, (arg_358_1.time_ - 0) / var_361_3)))
							else
								local var_361_4 = Mathf.Lerp(iter_361_5.color.r, 0.5, (arg_358_1.time_ - 0) / var_361_3)

								iter_361_5.color = Color.New(var_361_4, var_361_4, var_361_4)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_3 and arg_358_1.time_ < 0 + var_361_3 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10115 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_361_7 then
						iter_361_7.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_358_1.var_.actorSpriteComps10115 = nil
			end

			local var_361_5 = 0
			local var_361_6 = 0.525

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:GetWordFromCfg(417131086)
				local var_361_8 = arg_358_1:FormatText(var_361_7.content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_10 = 21 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_8) / 21)

				if (21 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_8) / 21)) > 0 and var_361_6 < var_361_10 then
					arg_358_1.talkMaxDuration = var_361_10

					if var_361_10 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_8
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131086", "story_v_out_417131.awb") ~= 0 then
					local var_361_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131086", "story_v_out_417131.awb") / 1000

					if var_361_11 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_11 + var_361_5
					end

					if var_361_7.prefab_name ~= "" and arg_358_1.actors_[var_361_7.prefab_name] ~= nil then
						local var_361_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_7.prefab_name].transform, "story_v_out_417131", "417131086", "story_v_out_417131.awb")

						arg_358_1:RecordAudio("417131086", var_361_12)
						arg_358_1:RecordAudio("417131086", var_361_12)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417131", "417131086", "story_v_out_417131.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417131", "417131086", "story_v_out_417131.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_13 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_13 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_13

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_13 and arg_358_1.time_ < var_361_5 + var_361_13 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417131087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417131087
		arg_362_1.duration_ = 9.7

		local var_362_0 = {
			zh = 8.433,
			ja = 9.7
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417131088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10115"]) and arg_362_1.var_.actorSpriteComps10115 == nil then
				arg_362_1.var_.actorSpriteComps10115 = arg_362_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10115"]) then
				if arg_362_1.var_.actorSpriteComps10115 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10115"]) and arg_362_1.var_.actorSpriteComps10115 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps10115 = nil
			end

			local var_365_2 = arg_362_1.actors_["1034"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1034 == nil then
				arg_362_1.var_.actorSpriteComps1034 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps1034 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								iter_365_5.color = Color.New(Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, (arg_362_1.time_ - 0) / var_365_3), Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, (arg_362_1.time_ - 0) / var_365_3), (Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, (arg_362_1.time_ - 0) / var_365_3)))
							else
								local var_365_4 = Mathf.Lerp(iter_365_5.color.r, 0.5, (arg_362_1.time_ - 0) / var_365_3)

								iter_365_5.color = Color.New(var_365_4, var_365_4, var_365_4)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1034 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps1034 = nil
			end

			local var_365_5 = 0
			local var_365_6 = 0.95

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_7 = arg_362_1:GetWordFromCfg(417131087)
				local var_365_8 = arg_362_1:FormatText(var_365_7.content)

				arg_362_1.text_.text = var_365_8

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 38 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 38)

				if (38 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 38)) > 0 and var_365_6 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_8
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131087", "story_v_out_417131.awb") ~= 0 then
					local var_365_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131087", "story_v_out_417131.awb") / 1000

					if var_365_11 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_5
					end

					if var_365_7.prefab_name ~= "" and arg_362_1.actors_[var_365_7.prefab_name] ~= nil then
						local var_365_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_7.prefab_name].transform, "story_v_out_417131", "417131087", "story_v_out_417131.awb")

						arg_362_1:RecordAudio("417131087", var_365_12)
						arg_362_1:RecordAudio("417131087", var_365_12)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_417131", "417131087", "story_v_out_417131.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_417131", "417131087", "story_v_out_417131.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_13 and arg_362_1.time_ < var_365_5 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417131088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417131088
		arg_366_1.duration_ = 5

		local var_366_0 = {
			zh = 3.833,
			ja = 5
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
				arg_366_0:Play417131089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.525

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:GetWordFromCfg(417131088)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 21 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 21)

				if (21 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 21)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131088", "story_v_out_417131.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_out_417131", "417131088", "story_v_out_417131.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_out_417131", "417131088", "story_v_out_417131.awb")

						arg_366_1:RecordAudio("417131088", var_369_6)
						arg_366_1:RecordAudio("417131088", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417131", "417131088", "story_v_out_417131.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417131", "417131088", "story_v_out_417131.awb")
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
	Play417131089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417131089
		arg_370_1.duration_ = 6.73

		local var_370_0 = {
			zh = 3.46633333333333,
			ja = 6.73333333333333
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
				arg_370_0:Play417131090(arg_370_1)
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

			local var_373_2 = arg_370_1.actors_["10115"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10115 == nil then
				arg_370_1.var_.actorSpriteComps10115 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps10115 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10115 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps10115 = nil
			end

			local var_373_5 = arg_370_1.bgs_.SS1705.transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPosSS1705 = var_373_5.localPosition
			end

			local var_373_6 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_6 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPosSS1705, Vector3.New(0, 1, 10), (arg_370_1.time_ - 0) / var_373_6)
			end

			if arg_370_1.time_ >= 0 + var_373_6 and arg_370_1.time_ < 0 + var_373_6 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_373_7 = arg_370_1.bgs_.SS1705.transform

			if 0.0166666666666667 < arg_370_1.time_ and arg_370_1.time_ <= 0.0166666666666667 + arg_373_0 then
				arg_370_1.var_.moveOldPosSS1705 = var_373_7.localPosition
			end

			local var_373_8 = 2.61666666666667

			if 0.0166666666666667 <= arg_370_1.time_ and arg_370_1.time_ < 0.0166666666666667 + var_373_8 then
				var_373_7.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPosSS1705, Vector3.New(0, 0.82, 8.38), (arg_370_1.time_ - 0.0166666666666667) / var_373_8)
			end

			if arg_370_1.time_ >= 0.0166666666666667 + var_373_8 and arg_370_1.time_ < 0.0166666666666667 + var_373_8 + arg_373_0 then
				var_373_7.localPosition = Vector3.New(0, 0.82, 8.38)
			end

			local var_373_9 = 0

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 then
				arg_370_1.allBtn_.enabled = false
			end

			if arg_370_1.time_ >= var_373_9 + 2.51666666666667 and arg_370_1.time_ < var_373_9 + 2.51666666666667 + arg_373_0 then
				arg_370_1.allBtn_.enabled = true
			end

			if arg_370_1.frameCnt_ <= 1 then
				arg_370_1.dialog_:SetActive(false)
			end

			local var_373_10 = 1.63333333333333
			local var_373_11 = 0.275

			if 1.63333333333333 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				arg_370_1.dialog_:SetActive(true)

				arg_370_1.dialogCg_.alpha = 0

				local var_373_12 = LeanTween.value(arg_370_1.dialog_, 0, 1, 0.3)

				var_373_12:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_370_1.dialogCg_.alpha = arg_374_0
				end))
				var_373_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_370_1.dialog_)
					var_373_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_370_1.duration_ = arg_370_1.duration_ + 0.3

				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(417131089)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_16 = 11 <= 0 and var_373_11 or var_373_11 * (utf8.len(var_373_14) / 11)

				if (11 <= 0 and var_373_11 or var_373_11 * (utf8.len(var_373_14) / 11)) > 0 and var_373_11 < var_373_16 then
					arg_370_1.talkMaxDuration = var_373_16
					var_373_10 = var_373_10 + 0.3

					if var_373_16 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_16 + var_373_10
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131089", "story_v_out_417131.awb") ~= 0 then
					local var_373_17 = manager.audio:GetVoiceLength("story_v_out_417131", "417131089", "story_v_out_417131.awb") / 1000

					if var_373_17 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_10
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_417131", "417131089", "story_v_out_417131.awb")

						arg_370_1:RecordAudio("417131089", var_373_18)
						arg_370_1:RecordAudio("417131089", var_373_18)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417131", "417131089", "story_v_out_417131.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417131", "417131089", "story_v_out_417131.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_19 = var_373_10 + 0.3
			local var_373_20 = math.max(var_373_11, arg_370_1.talkMaxDuration)

			if var_373_10 + 0.3 <= arg_370_1.time_ and arg_370_1.time_ < var_373_19 + var_373_20 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_19) / var_373_20

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_19 + var_373_20 and arg_370_1.time_ < var_373_19 + var_373_20 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1705",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1705",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.61666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play417131090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 417131090
		arg_376_1.duration_ = 3.27

		local var_376_0 = {
			zh = 2.1,
			ja = 3.266
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
				arg_376_0:Play417131091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["10115"]) and arg_376_1.var_.actorSpriteComps10115 == nil then
				arg_376_1.var_.actorSpriteComps10115 = arg_376_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_0 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["10115"]) then
				if arg_376_1.var_.actorSpriteComps10115 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								iter_379_1.color = Color.New(Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, (arg_376_1.time_ - 0) / var_379_0), Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, (arg_376_1.time_ - 0) / var_379_0), (Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, (arg_376_1.time_ - 0) / var_379_0)))
							else
								local var_379_1 = Mathf.Lerp(iter_379_1.color.r, 1, (arg_376_1.time_ - 0) / var_379_0)

								iter_379_1.color = Color.New(var_379_1, var_379_1, var_379_1)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["10115"]) and arg_376_1.var_.actorSpriteComps10115 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_379_3 then
						iter_379_3.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_376_1.var_.actorSpriteComps10115 = nil
			end

			local var_379_2 = arg_376_1.actors_["1034"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps1034 == nil then
				arg_376_1.var_.actorSpriteComps1034 = var_379_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_3 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_3 and not isNil(var_379_2) then
				if arg_376_1.var_.actorSpriteComps1034 then
					for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_379_5 then
							if arg_376_1.isInRecall_ then
								iter_379_5.color = Color.New(Mathf.Lerp(iter_379_5.color.r, arg_376_1.hightColor2.r, (arg_376_1.time_ - 0) / var_379_3), Mathf.Lerp(iter_379_5.color.g, arg_376_1.hightColor2.g, (arg_376_1.time_ - 0) / var_379_3), (Mathf.Lerp(iter_379_5.color.b, arg_376_1.hightColor2.b, (arg_376_1.time_ - 0) / var_379_3)))
							else
								local var_379_4 = Mathf.Lerp(iter_379_5.color.r, 0.5, (arg_376_1.time_ - 0) / var_379_3)

								iter_379_5.color = Color.New(var_379_4, var_379_4, var_379_4)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_3 and arg_376_1.time_ < 0 + var_379_3 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps1034 then
				for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_379_7 then
						iter_379_7.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_376_1.var_.actorSpriteComps1034 = nil
			end

			local var_379_5 = 0
			local var_379_6 = 0.25

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_7 = arg_376_1:GetWordFromCfg(417131090)
				local var_379_8 = arg_376_1:FormatText(var_379_7.content)

				arg_376_1.text_.text = var_379_8

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_10 = 10 <= 0 and var_379_6 or var_379_6 * (utf8.len(var_379_8) / 10)

				if (10 <= 0 and var_379_6 or var_379_6 * (utf8.len(var_379_8) / 10)) > 0 and var_379_6 < var_379_10 then
					arg_376_1.talkMaxDuration = var_379_10

					if var_379_10 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_5
					end
				end

				arg_376_1.text_.text = var_379_8
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131090", "story_v_out_417131.awb") ~= 0 then
					local var_379_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131090", "story_v_out_417131.awb") / 1000

					if var_379_11 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_11 + var_379_5
					end

					if var_379_7.prefab_name ~= "" and arg_376_1.actors_[var_379_7.prefab_name] ~= nil then
						local var_379_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_7.prefab_name].transform, "story_v_out_417131", "417131090", "story_v_out_417131.awb")

						arg_376_1:RecordAudio("417131090", var_379_12)
						arg_376_1:RecordAudio("417131090", var_379_12)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_417131", "417131090", "story_v_out_417131.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_417131", "417131090", "story_v_out_417131.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_13 = math.max(var_379_6, arg_376_1.talkMaxDuration)

			if var_379_5 <= arg_376_1.time_ and arg_376_1.time_ < var_379_5 + var_379_13 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_5) / var_379_13

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_5 + var_379_13 and arg_376_1.time_ < var_379_5 + var_379_13 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play417131091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417131091
		arg_380_1.duration_ = 7.13

		local var_380_0 = {
			zh = 7.133,
			ja = 6.6
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
				arg_380_0:Play417131092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1034"]) and arg_380_1.var_.actorSpriteComps1034 == nil then
				arg_380_1.var_.actorSpriteComps1034 = arg_380_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_0 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1034"]) then
				if arg_380_1.var_.actorSpriteComps1034 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1034"]) and arg_380_1.var_.actorSpriteComps1034 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_383_3 then
						iter_383_3.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_380_1.var_.actorSpriteComps1034 = nil
			end

			local var_383_2 = arg_380_1.actors_["10115"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps10115 == nil then
				arg_380_1.var_.actorSpriteComps10115 = var_383_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_3 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_3 and not isNil(var_383_2) then
				if arg_380_1.var_.actorSpriteComps10115 then
					for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_380_1.time_ >= 0 + var_383_3 and arg_380_1.time_ < 0 + var_383_3 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps10115 then
				for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_383_7 then
						iter_383_7.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_380_1.var_.actorSpriteComps10115 = nil
			end

			local var_383_5 = 0
			local var_383_6 = 0.6

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_7 = arg_380_1:GetWordFromCfg(417131091)
				local var_383_8 = arg_380_1:FormatText(var_383_7.content)

				arg_380_1.text_.text = var_383_8

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_10 = 24 <= 0 and var_383_6 or var_383_6 * (utf8.len(var_383_8) / 24)

				if (24 <= 0 and var_383_6 or var_383_6 * (utf8.len(var_383_8) / 24)) > 0 and var_383_6 < var_383_10 then
					arg_380_1.talkMaxDuration = var_383_10

					if var_383_10 + var_383_5 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_5
					end
				end

				arg_380_1.text_.text = var_383_8
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131091", "story_v_out_417131.awb") ~= 0 then
					local var_383_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131091", "story_v_out_417131.awb") / 1000

					if var_383_11 + var_383_5 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_11 + var_383_5
					end

					if var_383_7.prefab_name ~= "" and arg_380_1.actors_[var_383_7.prefab_name] ~= nil then
						local var_383_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_7.prefab_name].transform, "story_v_out_417131", "417131091", "story_v_out_417131.awb")

						arg_380_1:RecordAudio("417131091", var_383_12)
						arg_380_1:RecordAudio("417131091", var_383_12)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_417131", "417131091", "story_v_out_417131.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_417131", "417131091", "story_v_out_417131.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_13 = math.max(var_383_6, arg_380_1.talkMaxDuration)

			if var_383_5 <= arg_380_1.time_ and arg_380_1.time_ < var_383_5 + var_383_13 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_5) / var_383_13

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_5 + var_383_13 and arg_380_1.time_ < var_383_5 + var_383_13 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play417131092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417131092
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417131093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1034"]) and arg_384_1.var_.actorSpriteComps1034 == nil then
				arg_384_1.var_.actorSpriteComps1034 = arg_384_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1034"]) then
				if arg_384_1.var_.actorSpriteComps1034 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								iter_387_1.color = Color.New(Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor2.r, (arg_384_1.time_ - 0) / var_387_0), Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor2.g, (arg_384_1.time_ - 0) / var_387_0), (Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor2.b, (arg_384_1.time_ - 0) / var_387_0)))
							else
								local var_387_1 = Mathf.Lerp(iter_387_1.color.r, 0.5, (arg_384_1.time_ - 0) / var_387_0)

								iter_387_1.color = Color.New(var_387_1, var_387_1, var_387_1)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1034"]) and arg_384_1.var_.actorSpriteComps1034 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_387_3 then
						iter_387_3.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_384_1.var_.actorSpriteComps1034 = nil
			end

			local var_387_2 = 0
			local var_387_3 = 1.1

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(417131092).content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_6 = 44 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_4) / 44)

				if (44 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_4) / 44)) > 0 and var_387_3 < var_387_6 then
					arg_384_1.talkMaxDuration = var_387_6

					if var_387_6 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_7 and arg_384_1.time_ < var_387_2 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play417131093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417131093
		arg_388_1.duration_ = 7.23

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play417131094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1034"]) and arg_388_1.var_.actorSpriteComps1034 == nil then
				arg_388_1.var_.actorSpriteComps1034 = arg_388_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1034"]) then
				if arg_388_1.var_.actorSpriteComps1034 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1034"]) and arg_388_1.var_.actorSpriteComps1034 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps1034 = nil
			end

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= 1.3 + arg_391_0 then
				local var_391_2 = arg_388_1.fswbg_.transform:Find("textbox/adapt/content") or arg_388_1.fswbg_.transform:Find("textbox/content")
				local var_391_3 = arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_391_4 = var_391_2:GetComponent("RectTransform")

				var_391_2:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_391_4.offsetMin = Vector2.New(0, 0)
				var_391_4.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= 1.3 + arg_391_0 then
				arg_388_1.fswbg_:SetActive(true)
				arg_388_1.dialog_:SetActive(false)

				arg_388_1.fswtw_.percent = 0
				arg_388_1.fswt_.text = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(417131093).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.fswt_)

				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_388_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_388_1.fswtw_:SetDirty()

				arg_388_1.typewritterCharCountI18N = 0

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_5 = 2.3

			if 2.3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.var_.oldValueTypewriter = arg_388_1.fswtw_.percent

				SetActive(arg_388_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_388_1:ShowNextGo(false)
			end

			local var_391_6 = 16
			local var_391_7 = 1.06666666666667
			local var_391_8, var_391_9 = arg_388_1:GetPercentByPara(arg_388_1:FormatText(arg_388_1:GetWordFromCfg(417131093).content), 1)

			if var_391_5 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				local var_391_10 = var_391_6 <= 0 and var_391_7 or var_391_7 * ((var_391_9 - arg_388_1.typewritterCharCountI18N) / var_391_6)

				if (var_391_6 <= 0 and var_391_7 or var_391_7 * ((var_391_9 - arg_388_1.typewritterCharCountI18N) / var_391_6)) > 0 and var_391_7 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_5
					end
				end
			end

			local var_391_11 = math.max(1.06666666666667, arg_388_1.talkMaxDuration)

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_11 then
				arg_388_1.fswtw_.percent = Mathf.Lerp(arg_388_1.var_.oldValueTypewriter, var_391_8, (arg_388_1.time_ - var_391_5) / var_391_11)
				arg_388_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.fswtw_:SetDirty()
			end

			if arg_388_1.time_ >= var_391_5 + var_391_11 and arg_388_1.time_ < var_391_5 + var_391_11 + arg_391_0 then
				arg_388_1.fswtw_.percent = var_391_8

				arg_388_1.fswtw_:SetDirty()
				arg_388_1:ShowNextGo(true)

				arg_388_1.typewritterCharCountI18N = var_391_9
			end

			local var_391_12 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_13 = 1.3

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_13 then
				local var_391_14 = Color.New(0, 0, 0)

				var_391_14.a = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_12) / var_391_13)
				arg_388_1.mask_.color = var_391_14
			end

			if arg_388_1.time_ >= var_391_12 + var_391_13 and arg_388_1.time_ < var_391_12 + var_391_13 + arg_391_0 then
				local var_391_15 = Color.New(0, 0, 0)

				var_391_15.a = 1
				arg_388_1.mask_.color = var_391_15
			end

			local var_391_16 = 1.3

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_17 = 2

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_17 then
				local var_391_18 = Color.New(0, 0, 0)

				var_391_18.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_16) / var_391_17)
				arg_388_1.mask_.color = var_391_18
			end

			if arg_388_1.time_ >= var_391_16 + var_391_17 and arg_388_1.time_ < var_391_16 + var_391_17 + arg_391_0 then
				local var_391_19 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_19.a = 0
				arg_388_1.mask_.color = var_391_19
			end

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= 1.3 + arg_391_0 then
				local var_391_20 = arg_388_1.bgs_.STblack

				arg_388_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_21 = var_391_20:GetComponent("SpriteRenderer")

				if var_391_21 and var_391_21.sprite then
					local var_391_22 = 2 * (var_391_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_20.transform.localScale = Vector3.New(var_391_22 / var_391_21.sprite.bounds.size.y < var_391_22 * manager.ui.mainCameraCom_.aspect / var_391_21.sprite.bounds.size.x and var_391_22 * manager.ui.mainCameraCom_.aspect / var_391_21.sprite.bounds.size.x or var_391_22 / var_391_21.sprite.bounds.size.y, var_391_22 / var_391_21.sprite.bounds.size.y < var_391_22 * manager.ui.mainCameraCom_.aspect / var_391_21.sprite.bounds.size.x and var_391_22 * manager.ui.mainCameraCom_.aspect / var_391_21.sprite.bounds.size.x or var_391_22 / var_391_21.sprite.bounds.size.y, 0)
				end

				for iter_391_4, iter_391_5 in pairs(arg_388_1.bgs_) do
					if iter_391_4 ~= "STblack" then
						iter_391_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= 1.3 + arg_391_0 then
				arg_388_1.cswbg_:SetActive(true)

				local var_391_23 = arg_388_1.cswt_:GetComponent("RectTransform")

				arg_388_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_391_23.offsetMin = Vector2.New(400, 105)
				var_391_23.offsetMax = Vector2.New(-400, -200)
				arg_388_1.cswt_.text = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(419106).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.cswt_)

				arg_388_1.cswt_.fontSize = 92
				arg_388_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_388_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_388_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.3 < arg_388_1.time_ and arg_388_1.time_ <= 1.3 + arg_391_0 then
				if arg_388_1.var_.effect811 then
					Object.Destroy(arg_388_1.var_.effect811)

					arg_388_1.var_.effect811 = nil
				end
			end

			if 0.466666666666667 < arg_388_1.time_ and arg_388_1.time_ <= 0.466666666666667 + arg_391_0 then
				arg_388_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_391_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_27 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_27

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_27
						arg_388_1.bgmTxt2_.text = var_391_27
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_391_28 = 2.3
			local var_391_29 = manager.audio:GetVoiceLength("story_v_out_417131", "417131093", "") / 1000

			if var_391_29 > 0 and 4.933 < var_391_29 and var_391_29 + var_391_28 > arg_388_1.duration_ then
				arg_388_1.duration_ = var_391_29 + var_391_28
			end

			if var_391_28 < arg_388_1.time_ and arg_388_1.time_ <= var_391_28 + arg_391_0 then
				arg_388_1:AudioAction("play", "voice", "story_v_out_417131", "417131093", "")
			end

			local var_391_31 = 2.53333333333333

			if 2.53333333333333 < arg_388_1.time_ and arg_388_1.time_ <= var_391_31 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			if arg_388_1.time_ >= var_391_31 + 2.63333333333333 and arg_388_1.time_ < var_391_31 + 2.63333333333333 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play417131094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 417131094
		arg_393_1.duration_ = 5.3

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play417131095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_9000

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= 1.4 + arg_396_0 then
				local var_396_0 = arg_393_1.bgs_.STblack

				arg_393_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_1 = var_396_0:GetComponent("SpriteRenderer")

				if var_396_1 and var_396_1.sprite then
					local var_396_2 = 2 * (var_396_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_0.transform.localScale = Vector3.New(var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STblack" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_3 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			if arg_393_1.time_ >= var_396_3 + 0.3 and arg_393_1.time_ < var_396_3 + 0.3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_4 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_5 = 1.4

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_5 then
				local var_396_6 = Color.New(1, 1, 1)

				var_396_6.a = Mathf.Lerp(0, 1, (arg_393_1.time_ - var_396_4) / var_396_5)
				arg_393_1.mask_.color = var_396_6
			end

			if arg_393_1.time_ >= var_396_4 + var_396_5 and arg_393_1.time_ < var_396_4 + var_396_5 + arg_396_0 then
				local var_396_7 = Color.New(1, 1, 1)

				var_396_7.a = 1
				arg_393_1.mask_.color = var_396_7
			end

			local var_396_8 = 1.4

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_9 = 2

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_9 then
				local var_396_10 = Color.New(1, 1, 1)

				var_396_10.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_8) / var_396_9)
				arg_393_1.mask_.color = var_396_10
			end

			if arg_393_1.time_ >= var_396_8 + var_396_9 and arg_393_1.time_ < var_396_8 + var_396_9 + arg_396_0 then
				local var_396_11 = Color.New(1, 1, 1)

				arg_393_1.mask_.enabled = false
				var_396_11.a = 0
				arg_393_1.mask_.color = var_396_11
			end

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= 1.4 + arg_396_0 then
				arg_393_1.fswbg_:SetActive(true)
				arg_393_1.dialog_:SetActive(false)

				arg_393_1.fswtw_.percent = 0
				arg_393_1.fswt_.text = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(417131094).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.fswt_)

				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_393_1.fswtw_:SetDirty()

				arg_393_1.typewritterCharCountI18N = 0

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_12 = 2.63333333333333

			if 2.63333333333333 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 then
				arg_393_1.var_.oldValueTypewriter = arg_393_1.fswtw_.percent

				SetActive(arg_393_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_393_1:ShowNextGo(false)
			end

			local var_396_13 = 40
			local var_396_14 = 2.66666666666667
			local var_396_15, var_396_16 = arg_393_1:GetPercentByPara(arg_393_1:FormatText(arg_393_1:GetWordFromCfg(417131094).content), 1)

			if var_396_12 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				local var_396_17 = var_396_13 <= 0 and var_396_14 or var_396_14 * ((var_396_16 - arg_393_1.typewritterCharCountI18N) / var_396_13)

				if (var_396_13 <= 0 and var_396_14 or var_396_14 * ((var_396_16 - arg_393_1.typewritterCharCountI18N) / var_396_13)) > 0 and var_396_14 < var_396_17 then
					arg_393_1.talkMaxDuration = var_396_17

					if var_396_17 + var_396_12 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_17 + var_396_12
					end
				end
			end

			local var_396_18 = math.max(2.66666666666667, arg_393_1.talkMaxDuration)

			if var_396_12 <= arg_393_1.time_ and arg_393_1.time_ < var_396_12 + var_396_18 then
				arg_393_1.fswtw_.percent = Mathf.Lerp(arg_393_1.var_.oldValueTypewriter, var_396_15, (arg_393_1.time_ - var_396_12) / var_396_18)
				arg_393_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_393_1.fswtw_:SetDirty()
			end

			if arg_393_1.time_ >= var_396_12 + var_396_18 and arg_393_1.time_ < var_396_12 + var_396_18 + arg_396_0 then
				arg_393_1.fswtw_.percent = var_396_15

				arg_393_1.fswtw_:SetDirty()
				arg_393_1:ShowNextGo(true)

				arg_393_1.typewritterCharCountI18N = var_396_16
			end

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= 1.4 + arg_396_0 then
				local var_396_19 = arg_393_1.fswbg_.transform:Find("textbox/adapt/content") or arg_393_1.fswbg_.transform:Find("textbox/content")
				local var_396_20 = arg_393_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_396_21 = var_396_19:GetComponent("RectTransform")

				var_396_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_396_21.offsetMin = Vector2.New(0, 0)
				var_396_21.offsetMax = Vector2.New(0, 0)
			end

			local var_396_22 = 1.4

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_22 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			if arg_393_1.time_ >= var_396_22 + 2.5 and arg_393_1.time_ < var_396_22 + 2.5 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= 1.4 + arg_396_0 then
				arg_393_1.cswbg_:SetActive(false)
			end

			if 1.4 < arg_393_1.time_ and arg_393_1.time_ <= 1.4 + arg_396_0 then
				local var_396_23 = arg_393_1.var_.effect820

				if not arg_393_1.var_.effect820 then
					var_396_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_396_23.name = "820"
					arg_393_1.var_.effect820 = var_396_23
				else
					var_396_23.transform:SetParent(var_396_9000)
				end

				var_396_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_396_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_396_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_396_26 = var_396_23.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_396_2, iter_396_3 in ipairs((var_396_26:ToTable())) do
					iter_396_3.transform.localScale = Vector3.New(iter_396_3.transform.localScale.x / var_396_25 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_396_26 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_396_3.transform.localScale.y / var_396_25, iter_396_3.transform.localScale.z)
				end
			end

			if 0.01 < arg_393_1.time_ and arg_393_1.time_ <= 0.01 + arg_396_0 then
				arg_393_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_flashgun", "")
			end

			if 0.01 < arg_393_1.time_ and arg_393_1.time_ <= 0.01 + arg_396_0 then
				arg_393_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play417131095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 417131095
		arg_397_1.duration_ = 8.2

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play417131096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_9000

			if 1.4 < arg_397_1.time_ and arg_397_1.time_ <= 1.4 + arg_400_0 then
				local var_400_0 = arg_397_1.bgs_.ST2105a

				arg_397_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_400_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_1 = var_400_0:GetComponent("SpriteRenderer")

				if var_400_1 and var_400_1.sprite then
					local var_400_2 = 2 * (var_400_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_400_0.transform.localScale = Vector3.New(var_400_2 / var_400_1.sprite.bounds.size.y < var_400_2 * manager.ui.mainCameraCom_.aspect / var_400_1.sprite.bounds.size.x and var_400_2 * manager.ui.mainCameraCom_.aspect / var_400_1.sprite.bounds.size.x or var_400_2 / var_400_1.sprite.bounds.size.y, var_400_2 / var_400_1.sprite.bounds.size.y < var_400_2 * manager.ui.mainCameraCom_.aspect / var_400_1.sprite.bounds.size.x and var_400_2 * manager.ui.mainCameraCom_.aspect / var_400_1.sprite.bounds.size.x or var_400_2 / var_400_1.sprite.bounds.size.y, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "ST2105a" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_3 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			if arg_397_1.time_ >= var_400_3 + 0.3 and arg_397_1.time_ < var_400_3 + 0.3 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_4 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_5 = 1.434

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_5 then
				local var_400_6 = Color.New(0, 0, 0)

				var_400_6.a = Mathf.Lerp(0, 1, (arg_397_1.time_ - var_400_4) / var_400_5)
				arg_397_1.mask_.color = var_400_6
			end

			if arg_397_1.time_ >= var_400_4 + var_400_5 and arg_397_1.time_ < var_400_4 + var_400_5 + arg_400_0 then
				local var_400_7 = Color.New(0, 0, 0)

				var_400_7.a = 1
				arg_397_1.mask_.color = var_400_7
			end

			local var_400_8 = 1.434

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_9 = 2

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_9 then
				local var_400_10 = Color.New(0, 0, 0)

				var_400_10.a = Mathf.Lerp(1, 0, (arg_397_1.time_ - var_400_8) / var_400_9)
				arg_397_1.mask_.color = var_400_10
			end

			if arg_397_1.time_ >= var_400_8 + var_400_9 and arg_397_1.time_ < var_400_8 + var_400_9 + arg_400_0 then
				local var_400_11 = Color.New(0, 0, 0)

				arg_397_1.mask_.enabled = false
				var_400_11.a = 0
				arg_397_1.mask_.color = var_400_11
			end

			if 1.4 < arg_397_1.time_ and arg_397_1.time_ <= 1.4 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(false)
				arg_397_1.dialog_:SetActive(false)
				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= 1.434 + arg_400_0 then
				arg_397_1.fswbg_:SetActive(false)
				arg_397_1.dialog_:SetActive(false)
				SetActive(arg_397_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_397_1:ShowNextGo(false)
			end

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= 1.434 + arg_400_0 then
				if arg_397_1.var_.effect811 then
					Object.Destroy(arg_397_1.var_.effect811)

					arg_397_1.var_.effect811 = nil
				end
			end

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= 1.434 + arg_400_0 then
				local var_400_13 = arg_397_1.var_.effect809

				if not arg_397_1.var_.effect809 then
					var_400_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), manager.ui.mainCamera.transform)
					var_400_13.name = "809"
					arg_397_1.var_.effect809 = var_400_13
				else
					var_400_13.transform:SetParent(var_400_9000)
				end

				var_400_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_400_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_400_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_400_16 = var_400_13.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_400_2, iter_400_3 in ipairs((var_400_16:ToTable())) do
					iter_400_3.transform.localScale = Vector3.New(iter_400_3.transform.localScale.x / var_400_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_400_16 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_400_3.transform.localScale.y / var_400_15, iter_400_3.transform.localScale.z)
				end
			end

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= 1.434 + arg_400_0 then
				if arg_397_1.var_.effect811 then
					Object.Destroy(arg_397_1.var_.effect811)

					arg_397_1.var_.effect811 = nil
				end
			end

			if 1.434 < arg_397_1.time_ and arg_397_1.time_ <= 1.434 + arg_400_0 then
				if arg_397_1.var_.effect820 then
					Object.Destroy(arg_397_1.var_.effect820)

					arg_397_1.var_.effect820 = nil
				end
			end

			if 1.4 < arg_397_1.time_ and arg_397_1.time_ <= 1.4 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if 4.06666666666667 < arg_397_1.time_ and arg_397_1.time_ <= 4.06666666666667 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			if 0.05 < arg_397_1.time_ and arg_397_1.time_ <= 0.05 + arg_400_0 then
				arg_397_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_23 = 3.2
			local var_400_24 = 0.95

			if 3.2 < arg_397_1.time_ and arg_397_1.time_ <= var_400_23 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_25 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_25:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_26 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(417131095).content)

				arg_397_1.text_.text = var_400_26

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_28 = 38 <= 0 and var_400_24 or var_400_24 * (utf8.len(var_400_26) / 38)

				if (38 <= 0 and var_400_24 or var_400_24 * (utf8.len(var_400_26) / 38)) > 0 and var_400_24 < var_400_28 then
					arg_397_1.talkMaxDuration = var_400_28
					var_400_23 = var_400_23 + 0.3

					if var_400_28 + var_400_23 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_28 + var_400_23
					end
				end

				arg_397_1.text_.text = var_400_26
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_29 = var_400_23 + 0.3
			local var_400_30 = math.max(var_400_24, arg_397_1.talkMaxDuration)

			if var_400_23 + 0.3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_29 + var_400_30 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_29) / var_400_30

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_29 + var_400_30 and arg_397_1.time_ < var_400_29 + var_400_30 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play417131096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 417131096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play417131097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.75

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(417131096).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 30 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 30)

				if (30 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 30)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play417131097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 417131097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play417131098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 1.5

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(417131097).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 60 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 60)

				if (60 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 60)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play417131098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 417131098
		arg_411_1.duration_ = 5.67

		local var_411_0 = {
			zh = 4.566,
			ja = 5.666
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
				arg_411_0:Play417131099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["10115"]) and arg_411_1.var_.actorSpriteComps10115 == nil then
				arg_411_1.var_.actorSpriteComps10115 = arg_411_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["10115"]) then
				if arg_411_1.var_.actorSpriteComps10115 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["10115"]) and arg_411_1.var_.actorSpriteComps10115 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_414_3 then
						iter_414_3.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10115 = nil
			end

			local var_414_2 = arg_411_1.actors_["10115"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10115 = var_414_2.localPosition
				var_414_2.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10115", 3)

				for iter_414_4 = 0, var_414_2.childCount - 1 do
					local var_414_3 = var_414_2:GetChild(iter_414_4)

					if var_414_3.name == "split_6" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				var_414_2.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_411_1.time_ - 0) / var_414_4)
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				var_414_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_414_5 = 0
			local var_414_6 = 0.525

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_7 = arg_411_1:GetWordFromCfg(417131098)
				local var_414_8 = arg_411_1:FormatText(var_414_7.content)

				arg_411_1.text_.text = var_414_8

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_10 = 21 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 21)

				if (21 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 21)) > 0 and var_414_6 < var_414_10 then
					arg_411_1.talkMaxDuration = var_414_10

					if var_414_10 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_8
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131098", "story_v_out_417131.awb") ~= 0 then
					local var_414_11 = manager.audio:GetVoiceLength("story_v_out_417131", "417131098", "story_v_out_417131.awb") / 1000

					if var_414_11 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_11 + var_414_5
					end

					if var_414_7.prefab_name ~= "" and arg_411_1.actors_[var_414_7.prefab_name] ~= nil then
						local var_414_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_7.prefab_name].transform, "story_v_out_417131", "417131098", "story_v_out_417131.awb")

						arg_411_1:RecordAudio("417131098", var_414_12)
						arg_411_1:RecordAudio("417131098", var_414_12)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_417131", "417131098", "story_v_out_417131.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_417131", "417131098", "story_v_out_417131.awb")
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
				actorName = "10115",
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
	Play417131099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 417131099
		arg_415_1.duration_ = 4

		local var_415_0 = {
			zh = 3.333,
			ja = 4
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
			arg_415_1.auto_ = false
		end

		function arg_415_1.playNext_(arg_417_0)
			arg_415_1.onStoryFinished_()
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0.2 < arg_415_1.time_ and arg_415_1.time_ <= 0.2 + arg_418_0 then
				arg_415_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			local var_418_1 = 0
			local var_418_2 = 0.2

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_3 = arg_415_1:GetWordFromCfg(417131099)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 8 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_4) / 8)

				if (8 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_4) / 8)) > 0 and var_418_2 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417131", "417131099", "story_v_out_417131.awb") ~= 0 then
					local var_418_7 = manager.audio:GetVoiceLength("story_v_out_417131", "417131099", "story_v_out_417131.awb") / 1000

					if var_418_7 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_1
					end

					if var_418_3.prefab_name ~= "" and arg_415_1.actors_[var_418_3.prefab_name] ~= nil then
						local var_418_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_3.prefab_name].transform, "story_v_out_417131", "417131099", "story_v_out_417131.awb")

						arg_415_1:RecordAudio("417131099", var_418_8)
						arg_415_1:RecordAudio("417131099", var_418_8)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_417131", "417131099", "story_v_out_417131.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_417131", "417131099", "story_v_out_417131.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_9 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_9 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_9

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_9 and arg_415_1.time_ < var_418_1 + var_418_9 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2105a",
		"TextureConfig/Background/B02f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS1705"
	},
	voices = {
		"story_v_out_417131.awb"
	}
}
