return {
	Play417202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417202001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.3 and arg_1_1.time_ < 2 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I05c"

			if arg_1_1.bgs_.I05c == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.I05c

				arg_1_1.bgs_.I05c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_9 = 0

			arg_1_1.isInRecall_ = true

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_4_10 = 0.0666666666666667

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_9) / var_4_10)
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
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

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_run", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 1.2

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417202001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 48 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 48)

				if (48 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 48)) > 0 and var_4_16 < var_4_20 then
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
	Play417202002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 417202002
		arg_8_1.duration_ = 3.63

		local var_8_0 = {
			zh = 3.633,
			ja = 2.3
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play417202003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["10128"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "10128"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["10128"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["10128"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10128 == nil then
				arg_8_1.var_.actorSpriteComps10128 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps10128 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								iter_11_3.color = Color.New(Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, (arg_8_1.time_ - 0) / var_11_3), Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, (arg_8_1.time_ - 0) / var_11_3), (Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, (arg_8_1.time_ - 0) / var_11_3)))
							else
								local var_11_4 = Mathf.Lerp(iter_11_3.color.r, 1, (arg_8_1.time_ - 0) / var_11_3)

								iter_11_3.color = Color.New(var_11_4, var_11_4, var_11_4)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10128 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps10128 = nil
			end

			local var_11_5 = arg_8_1.actors_["10128"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10128 = var_11_5.localPosition
				var_11_5.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10128", 3)

				for iter_11_6 = 0, var_11_5.childCount - 1 do
					local var_11_6 = var_11_5:GetChild(iter_11_6)

					if var_11_6.name == "split_6" or not string.find(var_11_6.name, "split") then
						var_11_6.gameObject:SetActive(true)
					else
						var_11_6.gameObject:SetActive(false)
					end
				end
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_8_1.time_ - 0) / var_11_7)
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -347, -300)
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_11_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_10 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_10

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_10
						arg_8_1.bgmTxt2_.text = var_11_10
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_8_1.time_ and arg_8_1.time_ <= 0.333333333333333 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_11_13 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_13 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_13

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_13
						arg_8_1.bgmTxt2_.text = var_11_13
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_14 = 0
			local var_11_15 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_16 = arg_8_1:GetWordFromCfg(417202002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 8 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 8)

				if (8 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 8)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202002", "story_v_out_417202.awb") ~= 0 then
					local var_11_20 = manager.audio:GetVoiceLength("story_v_out_417202", "417202002", "story_v_out_417202.awb") / 1000

					if var_11_20 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_14
					end

					if var_11_16.prefab_name ~= "" and arg_8_1.actors_[var_11_16.prefab_name] ~= nil then
						local var_11_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_16.prefab_name].transform, "story_v_out_417202", "417202002", "story_v_out_417202.awb")

						arg_8_1:RecordAudio("417202002", var_11_21)
						arg_8_1:RecordAudio("417202002", var_11_21)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_417202", "417202002", "story_v_out_417202.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_417202", "417202002", "story_v_out_417202.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_22 and arg_8_1.time_ < var_11_14 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play417202003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417202003
		arg_14_1.duration_ = 3.27

		local var_14_0 = {
			zh = 2.3,
			ja = 3.266
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
				arg_14_0:Play417202004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["1060"] == nil then
				local var_17_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_17_0) then
					local var_17_1 = Object.Instantiate(var_17_0, arg_14_1.canvasGo_.transform)

					var_17_1.transform:SetSiblingIndex(1)

					var_17_1.name = "1060"
					var_17_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_["1060"] = var_17_1

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs((var_17_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_2 = arg_14_1.actors_["1060"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1060 = var_17_2.localPosition
				var_17_2.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1060", 4)

				for iter_17_2 = 0, var_17_2.childCount - 1 do
					local var_17_3 = var_17_2:GetChild(iter_17_2)

					if var_17_3.name == "" or not string.find(var_17_3.name, "split") then
						var_17_3.gameObject:SetActive(true)
					else
						var_17_3.gameObject:SetActive(false)
					end
				end
			end

			local var_17_4 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				var_17_2.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_14_1.time_ - 0) / var_17_4)
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				var_17_2.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_17_5 = arg_14_1.actors_["10128"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = var_17_5.localPosition
				var_17_5.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 2)

				for iter_17_3 = 0, var_17_5.childCount - 1 do
					local var_17_6 = var_17_5:GetChild(iter_17_3)

					if var_17_6.name == "split_6" or not string.find(var_17_6.name, "split") then
						var_17_6.gameObject:SetActive(true)
					else
						var_17_6.gameObject:SetActive(false)
					end
				end
			end

			local var_17_7 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_14_1.time_ - 0) / var_17_7)
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_17_8 = arg_14_1.actors_["1060"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_8) and arg_14_1.var_.actorSpriteComps1060 == nil then
				arg_14_1.var_.actorSpriteComps1060 = var_17_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_9 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_9 and not isNil(var_17_8) then
				if arg_14_1.var_.actorSpriteComps1060 then
					for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_17_5 then
							if arg_14_1.isInRecall_ then
								iter_17_5.color = Color.New(Mathf.Lerp(iter_17_5.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_9), Mathf.Lerp(iter_17_5.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_9), (Mathf.Lerp(iter_17_5.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_9)))
							else
								local var_17_10 = Mathf.Lerp(iter_17_5.color.r, 1, (arg_14_1.time_ - 0) / var_17_9)

								iter_17_5.color = Color.New(var_17_10, var_17_10, var_17_10)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_9 and arg_14_1.time_ < 0 + var_17_9 + arg_17_0 and not isNil(var_17_8) and arg_14_1.var_.actorSpriteComps1060 then
				for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_17_7 then
						iter_17_7.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps1060 = nil
			end

			local var_17_11 = arg_14_1.actors_["10128"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_11) and arg_14_1.var_.actorSpriteComps10128 == nil then
				arg_14_1.var_.actorSpriteComps10128 = var_17_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_12 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_12 and not isNil(var_17_11) then
				if arg_14_1.var_.actorSpriteComps10128 then
					for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_17_9 then
							if arg_14_1.isInRecall_ then
								iter_17_9.color = Color.New(Mathf.Lerp(iter_17_9.color.r, arg_14_1.hightColor2.r, (arg_14_1.time_ - 0) / var_17_12), Mathf.Lerp(iter_17_9.color.g, arg_14_1.hightColor2.g, (arg_14_1.time_ - 0) / var_17_12), (Mathf.Lerp(iter_17_9.color.b, arg_14_1.hightColor2.b, (arg_14_1.time_ - 0) / var_17_12)))
							else
								local var_17_13 = Mathf.Lerp(iter_17_9.color.r, 0.5, (arg_14_1.time_ - 0) / var_17_12)

								iter_17_9.color = Color.New(var_17_13, var_17_13, var_17_13)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_12 and arg_14_1.time_ < 0 + var_17_12 + arg_17_0 and not isNil(var_17_11) and arg_14_1.var_.actorSpriteComps10128 then
				for iter_17_10, iter_17_11 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_17_11 then
						iter_17_11.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_14_1.var_.actorSpriteComps10128 = nil
			end

			local var_17_14 = 0
			local var_17_15 = 0.3

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_16 = arg_14_1:GetWordFromCfg(417202003)
				local var_17_17 = arg_14_1:FormatText(var_17_16.content)

				arg_14_1.text_.text = var_17_17

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_19 = 12 <= 0 and var_17_15 or var_17_15 * (utf8.len(var_17_17) / 12)

				if (12 <= 0 and var_17_15 or var_17_15 * (utf8.len(var_17_17) / 12)) > 0 and var_17_15 < var_17_19 then
					arg_14_1.talkMaxDuration = var_17_19

					if var_17_19 + var_17_14 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_19 + var_17_14
					end
				end

				arg_14_1.text_.text = var_17_17
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202003", "story_v_out_417202.awb") ~= 0 then
					local var_17_20 = manager.audio:GetVoiceLength("story_v_out_417202", "417202003", "story_v_out_417202.awb") / 1000

					if var_17_20 + var_17_14 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_20 + var_17_14
					end

					if var_17_16.prefab_name ~= "" and arg_14_1.actors_[var_17_16.prefab_name] ~= nil then
						local var_17_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_16.prefab_name].transform, "story_v_out_417202", "417202003", "story_v_out_417202.awb")

						arg_14_1:RecordAudio("417202003", var_17_21)
						arg_14_1:RecordAudio("417202003", var_17_21)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417202", "417202003", "story_v_out_417202.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417202", "417202003", "story_v_out_417202.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_22 = math.max(var_17_15, arg_14_1.talkMaxDuration)

			if var_17_14 <= arg_14_1.time_ and arg_14_1.time_ < var_17_14 + var_17_22 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_14) / var_17_22

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_14 + var_17_22 and arg_14_1.time_ < var_17_14 + var_17_22 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
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
	Play417202004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417202004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417202005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10128 = arg_18_1.actors_["10128"].transform.localPosition
				arg_18_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("10128", 7)

				for iter_21_0 = 0, arg_18_1.actors_["10128"].transform.childCount - 1 do
					local var_21_0 = arg_18_1.actors_["10128"].transform:GetChild(iter_21_0)

					if var_21_0.name == "" or not string.find(var_21_0.name, "split") then
						var_21_0.gameObject:SetActive(true)
					else
						var_21_0.gameObject:SetActive(false)
					end
				end
			end

			local var_21_1 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_1 then
				arg_18_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10128, Vector3.New(0, -2000, -40), (arg_18_1.time_ - 0) / var_21_1)
			end

			if arg_18_1.time_ >= 0 + var_21_1 and arg_18_1.time_ < 0 + var_21_1 + arg_21_0 then
				arg_18_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_21_2 = arg_18_1.actors_["1060"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1060 = var_21_2.localPosition
				var_21_2.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1060", 7)

				for iter_21_1 = 0, var_21_2.childCount - 1 do
					local var_21_3 = var_21_2:GetChild(iter_21_1)

					if var_21_3.name == "" or not string.find(var_21_3.name, "split") then
						var_21_3.gameObject:SetActive(true)
					else
						var_21_3.gameObject:SetActive(false)
					end
				end
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_2.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_18_1.time_ - 0) / var_21_4)
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_2.localPosition = Vector3.New(0, -2000, -40)
			end

			if 0.333333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 0.333333333333333 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_21_6 = 0
			local var_21_7 = 0.45

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_8 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417202004).content)

				arg_18_1.text_.text = var_21_8

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_10 = 18 <= 0 and var_21_7 or var_21_7 * (utf8.len(var_21_8) / 18)

				if (18 <= 0 and var_21_7 or var_21_7 * (utf8.len(var_21_8) / 18)) > 0 and var_21_7 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_6
					end
				end

				arg_18_1.text_.text = var_21_8
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_11 = math.max(var_21_7, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_11 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_6) / var_21_11

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_11 and arg_18_1.time_ < var_21_6 + var_21_11 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	Play417202005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417202005
		arg_22_1.duration_ = 8.9

		local var_22_0 = {
			zh = 3.466,
			ja = 8.9
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
				arg_22_0:Play417202006(arg_22_1)
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

			local var_25_2 = arg_22_1.actors_["1060"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1060 = var_25_2.localPosition
				var_25_2.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1060", 3)

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
				var_25_2.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_22_1.time_ - 0) / var_25_4)
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				var_25_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_25_5 = 0
			local var_25_6 = 0.4

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_7 = arg_22_1:GetWordFromCfg(417202005)
				local var_25_8 = arg_22_1:FormatText(var_25_7.content)

				arg_22_1.text_.text = var_25_8

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_10 = 16 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 16)

				if (16 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 16)) > 0 and var_25_6 < var_25_10 then
					arg_22_1.talkMaxDuration = var_25_10

					if var_25_10 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_5
					end
				end

				arg_22_1.text_.text = var_25_8
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202005", "story_v_out_417202.awb") ~= 0 then
					local var_25_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202005", "story_v_out_417202.awb") / 1000

					if var_25_11 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_5
					end

					if var_25_7.prefab_name ~= "" and arg_22_1.actors_[var_25_7.prefab_name] ~= nil then
						local var_25_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_7.prefab_name].transform, "story_v_out_417202", "417202005", "story_v_out_417202.awb")

						arg_22_1:RecordAudio("417202005", var_25_12)
						arg_22_1:RecordAudio("417202005", var_25_12)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417202", "417202005", "story_v_out_417202.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417202", "417202005", "story_v_out_417202.awb")
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
				actorName = "1060",
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
	Play417202006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417202006
		arg_26_1.duration_ = 8.13

		local var_26_0 = {
			zh = 4.333,
			ja = 8.133
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
				arg_26_0:Play417202007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(417202006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 18 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 18)

				if (18 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 18)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202006", "story_v_out_417202.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202006", "story_v_out_417202.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417202", "417202006", "story_v_out_417202.awb")

						arg_26_1:RecordAudio("417202006", var_29_6)
						arg_26_1:RecordAudio("417202006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417202", "417202006", "story_v_out_417202.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417202", "417202006", "story_v_out_417202.awb")
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
	Play417202007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417202007
		arg_30_1.duration_ = 1.33

		local var_30_0 = {
			zh = 1.333,
			ja = 0.999999999999
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
				arg_30_0:Play417202008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1060"]) and arg_30_1.var_.actorSpriteComps1060 == nil then
				arg_30_1.var_.actorSpriteComps1060 = arg_30_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1060"]) then
				if arg_30_1.var_.actorSpriteComps1060 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1060"]) and arg_30_1.var_.actorSpriteComps1060 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps1060 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.125

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
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_30_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_33_4 = arg_30_1:GetWordFromCfg(417202007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 5 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 5)

				if (5 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 5)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202007", "story_v_out_417202.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202007", "story_v_out_417202.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417202", "417202007", "story_v_out_417202.awb")

						arg_30_1:RecordAudio("417202007", var_33_9)
						arg_30_1:RecordAudio("417202007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417202", "417202007", "story_v_out_417202.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417202", "417202007", "story_v_out_417202.awb")
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
	Play417202008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417202008
		arg_34_1.duration_ = 9.83

		local var_34_0 = {
			zh = 6.133,
			ja = 9.833
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
				arg_34_0:Play417202009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1060"]) and arg_34_1.var_.actorSpriteComps1060 == nil then
				arg_34_1.var_.actorSpriteComps1060 = arg_34_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1060"]) then
				if arg_34_1.var_.actorSpriteComps1060 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 1, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1060"]) and arg_34_1.var_.actorSpriteComps1060 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps1060 = nil
			end

			local var_37_2 = 0
			local var_37_3 = 0.85

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(417202008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 34 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 34)

				if (34 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 34)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202008", "story_v_out_417202.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202008", "story_v_out_417202.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_417202", "417202008", "story_v_out_417202.awb")

						arg_34_1:RecordAudio("417202008", var_37_9)
						arg_34_1:RecordAudio("417202008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417202", "417202008", "story_v_out_417202.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417202", "417202008", "story_v_out_417202.awb")
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
	Play417202009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417202009
		arg_38_1.duration_ = 7.67

		local var_38_0 = {
			zh = 5.9,
			ja = 7.666
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
				arg_38_0:Play417202010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.625

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(417202009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 25 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 25)

				if (25 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 25)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202009", "story_v_out_417202.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202009", "story_v_out_417202.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_417202", "417202009", "story_v_out_417202.awb")

						arg_38_1:RecordAudio("417202009", var_41_6)
						arg_38_1:RecordAudio("417202009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417202", "417202009", "story_v_out_417202.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417202", "417202009", "story_v_out_417202.awb")
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
	Play417202010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417202010
		arg_42_1.duration_ = 3.9

		local var_42_0 = {
			zh = 3.9,
			ja = 3.833
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
				arg_42_0:Play417202011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.35

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:GetWordFromCfg(417202010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 14 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 14)

				if (14 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 14)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202010", "story_v_out_417202.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202010", "story_v_out_417202.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_417202", "417202010", "story_v_out_417202.awb")

						arg_42_1:RecordAudio("417202010", var_45_6)
						arg_42_1:RecordAudio("417202010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417202", "417202010", "story_v_out_417202.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417202", "417202010", "story_v_out_417202.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417202011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417202011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417202012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1060 = arg_46_1.actors_["1060"].transform.localPosition
				arg_46_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1060", 7)

				for iter_49_0 = 0, arg_46_1.actors_["1060"].transform.childCount - 1 do
					local var_49_0 = arg_46_1.actors_["1060"].transform:GetChild(iter_49_0)

					if var_49_0.name == "" or not string.find(var_49_0.name, "split") then
						var_49_0.gameObject:SetActive(true)
					else
						var_49_0.gameObject:SetActive(false)
					end
				end
			end

			local var_49_1 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_1 then
				arg_46_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_46_1.time_ - 0) / var_49_1)
			end

			if arg_46_1.time_ >= 0 + var_49_1 and arg_46_1.time_ < 0 + var_49_1 + arg_49_0 then
				arg_46_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_49_2 = 0
			local var_49_3 = 0.975

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(417202011).content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 39 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 39)

				if (39 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 39)) > 0 and var_49_3 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_7 and arg_46_1.time_ < var_49_2 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play417202012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417202012
		arg_50_1.duration_ = 6.1

		local var_50_0 = {
			zh = 3.4,
			ja = 6.1
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
				arg_50_0:Play417202013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = arg_50_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10128"]) then
				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_2 = arg_50_1.actors_["1060"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1060 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1060", 3)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "split_2" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_53_5 = 0
			local var_53_6 = 0.4

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(417202012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 16 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 16)

				if (16 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 16)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202012", "story_v_out_417202.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202012", "story_v_out_417202.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_417202", "417202012", "story_v_out_417202.awb")

						arg_50_1:RecordAudio("417202012", var_53_12)
						arg_50_1:RecordAudio("417202012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417202", "417202012", "story_v_out_417202.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417202", "417202012", "story_v_out_417202.awb")
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

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play417202013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417202013
		arg_54_1.duration_ = 7.7

		local var_54_0 = {
			zh = 4.533,
			ja = 7.7
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
				arg_54_0:Play417202014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1060 = arg_54_1.actors_["1060"].transform.localPosition
				arg_54_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1060", 3)

				for iter_57_0 = 0, arg_54_1.actors_["1060"].transform.childCount - 1 do
					local var_57_0 = arg_54_1.actors_["1060"].transform:GetChild(iter_57_0)

					if var_57_0.name == "split_1" or not string.find(var_57_0.name, "split") then
						var_57_0.gameObject:SetActive(true)
					else
						var_57_0.gameObject:SetActive(false)
					end
				end
			end

			local var_57_1 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_1 then
				arg_54_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_54_1.time_ - 0) / var_57_1)
			end

			if arg_54_1.time_ >= 0 + var_57_1 and arg_54_1.time_ < 0 + var_57_1 + arg_57_0 then
				arg_54_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_57_2 = 0
			local var_57_3 = 0.575

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(417202013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 23 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 23)

				if (23 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 23)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202013", "story_v_out_417202.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202013", "story_v_out_417202.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_417202", "417202013", "story_v_out_417202.awb")

						arg_54_1:RecordAudio("417202013", var_57_9)
						arg_54_1:RecordAudio("417202013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417202", "417202013", "story_v_out_417202.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417202", "417202013", "story_v_out_417202.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play417202014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417202014
		arg_58_1.duration_ = 8.7

		local var_58_0 = {
			zh = 8.699999999999,
			ja = 7.599999999999
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
				arg_58_0:Play417202015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 3.999999999999 < arg_58_1.time_ and arg_58_1.time_ <= 3.999999999999 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			if arg_58_1.time_ >= 3.999999999999 + 0.3 and arg_58_1.time_ < 3.999999999999 + 0.3 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_0 = "ST04b"

			if arg_58_1.bgs_.ST04b == nil then
				local var_61_1 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_0)
				var_61_1.name = var_61_0
				var_61_1.transform.parent = arg_58_1.stage_.transform
				var_61_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_0] = var_61_1
			end

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= 2 + arg_61_0 then
				local var_61_2 = arg_58_1.bgs_.ST04b

				arg_58_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_3 = var_61_2:GetComponent("SpriteRenderer")

				if var_61_3 and var_61_3.sprite then
					local var_61_4 = 2 * (var_61_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_2.transform.localScale = Vector3.New(var_61_4 / var_61_3.sprite.bounds.size.y < var_61_4 * manager.ui.mainCameraCom_.aspect / var_61_3.sprite.bounds.size.x and var_61_4 * manager.ui.mainCameraCom_.aspect / var_61_3.sprite.bounds.size.x or var_61_4 / var_61_3.sprite.bounds.size.y, var_61_4 / var_61_3.sprite.bounds.size.y < var_61_4 * manager.ui.mainCameraCom_.aspect / var_61_3.sprite.bounds.size.x and var_61_4 * manager.ui.mainCameraCom_.aspect / var_61_3.sprite.bounds.size.x or var_61_4 / var_61_3.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "ST04b" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_5 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_6 = 2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 then
				local var_61_7 = Color.New(0, 0, 0)

				var_61_7.a = Mathf.Lerp(0, 1, (arg_58_1.time_ - var_61_5) / var_61_6)
				arg_58_1.mask_.color = var_61_7
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				local var_61_8 = Color.New(0, 0, 0)

				var_61_8.a = 1
				arg_58_1.mask_.color = var_61_8
			end

			local var_61_9 = 2

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_10 = 2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 then
				local var_61_11 = Color.New(0, 0, 0)

				var_61_11.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_9) / var_61_10)
				arg_58_1.mask_.color = var_61_11
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 then
				local var_61_12 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_12.a = 0
				arg_58_1.mask_.color = var_61_12
			end

			local var_61_13 = arg_58_1.actors_["10128"]

			if 3.66666666666567 < arg_58_1.time_ and arg_58_1.time_ <= 3.66666666666567 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = var_61_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_14 = 0.2

			if 3.66666666666567 <= arg_58_1.time_ and arg_58_1.time_ < 3.66666666666567 + var_61_14 and not isNil(var_61_13) then
				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								iter_61_3.color = Color.New(Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 3.66666666666567) / var_61_14), Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 3.66666666666567) / var_61_14), (Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 3.66666666666567) / var_61_14)))
							else
								local var_61_15 = Mathf.Lerp(iter_61_3.color.r, 1, (arg_58_1.time_ - 3.66666666666567) / var_61_14)

								iter_61_3.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 3.66666666666567 + var_61_14 and arg_58_1.time_ < 3.66666666666567 + var_61_14 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_5 then
						iter_61_5.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_16 = arg_58_1.actors_["10128"].transform

			if 3.66666666666667 < arg_58_1.time_ and arg_58_1.time_ <= 3.66666666666667 + arg_61_0 then
				arg_58_1.var_.moveOldPos10128 = var_61_16.localPosition
				var_61_16.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10128", 3)

				for iter_61_6 = 0, var_61_16.childCount - 1 do
					local var_61_17 = var_61_16:GetChild(iter_61_6)

					if var_61_17.name == "split_2" or not string.find(var_61_17.name, "split") then
						var_61_17.gameObject:SetActive(true)
					else
						var_61_17.gameObject:SetActive(false)
					end
				end
			end

			local var_61_18 = 0.001

			if 3.66666666666667 <= arg_58_1.time_ and arg_58_1.time_ < 3.66666666666667 + var_61_18 then
				var_61_16.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_58_1.time_ - 3.66666666666667) / var_61_18)
			end

			if arg_58_1.time_ >= 3.66666666666667 + var_61_18 and arg_58_1.time_ < 3.66666666666667 + var_61_18 + arg_61_0 then
				var_61_16.localPosition = Vector3.New(0, -347, -300)
			end

			if 3.66666666666567 < arg_58_1.time_ and arg_58_1.time_ <= 3.66666666666567 + arg_61_0 then
				local var_61_19 = arg_58_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_61_19 then
					arg_58_1.var_.alphaOldValue10128 = var_61_19.alpha
					arg_58_1.var_.characterEffect10128 = var_61_19
				end

				arg_58_1.var_.alphaOldValue10128 = 0
			end

			local var_61_20 = 0.333333333333333

			if 3.66666666666567 <= arg_58_1.time_ and arg_58_1.time_ < 3.66666666666567 + var_61_20 then
				if arg_58_1.var_.characterEffect10128 then
					arg_58_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_58_1.var_.alphaOldValue10128, 1, (arg_58_1.time_ - 3.66666666666567) / var_61_20)
				end
			end

			if arg_58_1.time_ >= 3.66666666666567 + var_61_20 and arg_58_1.time_ < 3.66666666666567 + var_61_20 + arg_61_0 and arg_58_1.var_.characterEffect10128 then
				arg_58_1.var_.characterEffect10128.alpha = 1
			end

			local var_61_21 = arg_58_1.actors_["1060"].transform

			if 1.966 < arg_58_1.time_ and arg_58_1.time_ <= 1.966 + arg_61_0 then
				arg_58_1.var_.moveOldPos1060 = var_61_21.localPosition
				var_61_21.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1060", 7)

				for iter_61_7 = 0, var_61_21.childCount - 1 do
					local var_61_22 = var_61_21:GetChild(iter_61_7)

					if var_61_22.name == "" or not string.find(var_61_22.name, "split") then
						var_61_22.gameObject:SetActive(true)
					else
						var_61_22.gameObject:SetActive(false)
					end
				end
			end

			local var_61_23 = 0.001

			if 1.966 <= arg_58_1.time_ and arg_58_1.time_ < 1.966 + var_61_23 then
				var_61_21.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_58_1.time_ - 1.966) / var_61_23)
			end

			if arg_58_1.time_ >= 1.966 + var_61_23 and arg_58_1.time_ < 1.966 + var_61_23 + arg_61_0 then
				var_61_21.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_61_24 = 1.93333333333333

			arg_58_1.isInRecall_ = false

			if var_61_24 < arg_58_1.time_ and arg_58_1.time_ <= var_61_24 + arg_61_0 then
				arg_58_1.screenFilterGo_:SetActive(false)

				for iter_61_8, iter_61_9 in pairs(arg_58_1.actors_) do
					for iter_61_10, iter_61_11 in ipairs((iter_61_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_61_11.color = iter_61_11.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_61_25 = 0.0666666666666667

			if var_61_24 <= arg_58_1.time_ and arg_58_1.time_ < var_61_24 + var_61_25 then
				arg_58_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_24) / var_61_25)
			end

			if arg_58_1.time_ >= var_61_24 + var_61_25 and arg_58_1.time_ < var_61_24 + var_61_25 + arg_61_0 then
				arg_58_1.screenFilterEffect_.weight = 0
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_26 = 3.999999999999
			local var_61_27 = 0.3

			if 3.999999999999 < arg_58_1.time_ and arg_58_1.time_ <= var_61_26 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_28 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_28:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_29 = arg_58_1:GetWordFromCfg(417202014)
				local var_61_30 = arg_58_1:FormatText(var_61_29.content)

				arg_58_1.text_.text = var_61_30

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_32 = 12 <= 0 and var_61_27 or var_61_27 * (utf8.len(var_61_30) / 12)

				if (12 <= 0 and var_61_27 or var_61_27 * (utf8.len(var_61_30) / 12)) > 0 and var_61_27 < var_61_32 then
					arg_58_1.talkMaxDuration = var_61_32
					var_61_26 = var_61_26 + 0.3

					if var_61_32 + var_61_26 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_32 + var_61_26
					end
				end

				arg_58_1.text_.text = var_61_30
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202014", "story_v_out_417202.awb") ~= 0 then
					local var_61_33 = manager.audio:GetVoiceLength("story_v_out_417202", "417202014", "story_v_out_417202.awb") / 1000

					if var_61_33 + var_61_26 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_33 + var_61_26
					end

					if var_61_29.prefab_name ~= "" and arg_58_1.actors_[var_61_29.prefab_name] ~= nil then
						local var_61_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_29.prefab_name].transform, "story_v_out_417202", "417202014", "story_v_out_417202.awb")

						arg_58_1:RecordAudio("417202014", var_61_34)
						arg_58_1:RecordAudio("417202014", var_61_34)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417202", "417202014", "story_v_out_417202.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417202", "417202014", "story_v_out_417202.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_35 = var_61_26 + 0.3
			local var_61_36 = math.max(var_61_27, arg_58_1.talkMaxDuration)

			if var_61_26 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_35 + var_61_36 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_35) / var_61_36

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_35 + var_61_36 and arg_58_1.time_ < var_61_35 + var_61_36 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play417202015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417202015
		arg_64_1.duration_ = 10.63

		local var_64_0 = {
			zh = 5.866,
			ja = 10.633
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
				arg_64_0:Play417202016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1060"]) and arg_64_1.var_.actorSpriteComps1060 == nil then
				arg_64_1.var_.actorSpriteComps1060 = arg_64_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1060"]) then
				if arg_64_1.var_.actorSpriteComps1060 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1060"]) and arg_64_1.var_.actorSpriteComps1060 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps1060 = nil
			end

			local var_67_2 = arg_64_1.actors_["10128"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps10128 == nil then
				arg_64_1.var_.actorSpriteComps10128 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps10128 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps10128 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps10128 = nil
			end

			local var_67_5 = arg_64_1.actors_["10128"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10128 = var_67_5.localPosition
				var_67_5.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10128", 2)

				for iter_67_8 = 0, var_67_5.childCount - 1 do
					local var_67_6 = var_67_5:GetChild(iter_67_8)

					if var_67_6.name == "split_2" or not string.find(var_67_6.name, "split") then
						var_67_6.gameObject:SetActive(true)
					else
						var_67_6.gameObject:SetActive(false)
					end
				end
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_64_1.time_ - 0) / var_67_7)
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_67_8 = arg_64_1.actors_["1060"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1060 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1060", 4)

				for iter_67_9 = 0, var_67_8.childCount - 1 do
					local var_67_9 = var_67_8:GetChild(iter_67_9)

					if var_67_9.name == "" or not string.find(var_67_9.name, "split") then
						var_67_9.gameObject:SetActive(true)
					else
						var_67_9.gameObject:SetActive(false)
					end
				end
			end

			local var_67_10 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_10 then
				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_64_1.time_ - 0) / var_67_10)
			end

			if arg_64_1.time_ >= 0 + var_67_10 and arg_64_1.time_ < 0 + var_67_10 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_67_11 = 0
			local var_67_12 = 0.75

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(417202015)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 30 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_14) / 30)

				if (30 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_14) / 30)) > 0 and var_67_12 < var_67_16 then
					arg_64_1.talkMaxDuration = var_67_16

					if var_67_16 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202015", "story_v_out_417202.awb") ~= 0 then
					local var_67_17 = manager.audio:GetVoiceLength("story_v_out_417202", "417202015", "story_v_out_417202.awb") / 1000

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_417202", "417202015", "story_v_out_417202.awb")

						arg_64_1:RecordAudio("417202015", var_67_18)
						arg_64_1:RecordAudio("417202015", var_67_18)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417202", "417202015", "story_v_out_417202.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417202", "417202015", "story_v_out_417202.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_19 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_19 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_19

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_19 and arg_64_1.time_ < var_67_11 + var_67_19 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play417202016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417202016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417202017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1060"]) and arg_68_1.var_.actorSpriteComps1060 == nil then
				arg_68_1.var_.actorSpriteComps1060 = arg_68_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1060"]) then
				if arg_68_1.var_.actorSpriteComps1060 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1060"]) and arg_68_1.var_.actorSpriteComps1060 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps1060 = nil
			end

			local var_71_2 = 0
			local var_71_3 = 0.625

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(417202016).content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 25 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 25)

				if (25 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 25)) > 0 and var_71_3 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_7 and arg_68_1.time_ < var_71_2 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play417202017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417202017
		arg_72_1.duration_ = 7.8

		local var_72_0 = {
			zh = 5.466,
			ja = 7.8
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
				arg_72_0:Play417202018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1060"]) and arg_72_1.var_.actorSpriteComps1060 == nil then
				arg_72_1.var_.actorSpriteComps1060 = arg_72_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1060"]) then
				if arg_72_1.var_.actorSpriteComps1060 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1060"]) and arg_72_1.var_.actorSpriteComps1060 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1060 = nil
			end

			local var_75_2 = 0
			local var_75_3 = 0.65

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(417202017)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 26 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 26)

				if (26 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 26)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202017", "story_v_out_417202.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202017", "story_v_out_417202.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_417202", "417202017", "story_v_out_417202.awb")

						arg_72_1:RecordAudio("417202017", var_75_9)
						arg_72_1:RecordAudio("417202017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417202", "417202017", "story_v_out_417202.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417202", "417202017", "story_v_out_417202.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play417202018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417202018
		arg_76_1.duration_ = 3.93

		local var_76_0 = {
			zh = 2.066,
			ja = 3.933
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
				arg_76_0:Play417202019(arg_76_1)
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

			local var_79_2 = arg_76_1.actors_["10128"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_2.localPosition
				var_79_2.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 2)

				for iter_79_4 = 0, var_79_2.childCount - 1 do
					local var_79_3 = var_79_2:GetChild(iter_79_4)

					if var_79_3.name == "split_1" or not string.find(var_79_3.name, "split") then
						var_79_3.gameObject:SetActive(true)
					else
						var_79_3.gameObject:SetActive(false)
					end
				end
			end

			local var_79_4 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				var_79_2.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_76_1.time_ - 0) / var_79_4)
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				var_79_2.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_79_5 = arg_76_1.actors_["1060"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1060 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1060", 4)

				for iter_79_5 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_5)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_79_8 = arg_76_1.actors_["1060"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1060 == nil then
				arg_76_1.var_.actorSpriteComps1060 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_9 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_9 and not isNil(var_79_8) then
				if arg_76_1.var_.actorSpriteComps1060 then
					for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_79_7 then
							if arg_76_1.isInRecall_ then
								iter_79_7.color = Color.New(Mathf.Lerp(iter_79_7.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_9), Mathf.Lerp(iter_79_7.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_9), (Mathf.Lerp(iter_79_7.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_9)))
							else
								local var_79_10 = Mathf.Lerp(iter_79_7.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_9)

								iter_79_7.color = Color.New(var_79_10, var_79_10, var_79_10)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_9 and arg_76_1.time_ < 0 + var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps1060 then
				for iter_79_8, iter_79_9 in pairs(arg_76_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_79_9 then
						iter_79_9.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1060 = nil
			end

			local var_79_11 = 0
			local var_79_12 = 0.275

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
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

				local var_79_13 = arg_76_1:GetWordFromCfg(417202018)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 11 <= 0 and var_79_12 or var_79_12 * (utf8.len(var_79_14) / 11)

				if (11 <= 0 and var_79_12 or var_79_12 * (utf8.len(var_79_14) / 11)) > 0 and var_79_12 < var_79_16 then
					arg_76_1.talkMaxDuration = var_79_16

					if var_79_16 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202018", "story_v_out_417202.awb") ~= 0 then
					local var_79_17 = manager.audio:GetVoiceLength("story_v_out_417202", "417202018", "story_v_out_417202.awb") / 1000

					if var_79_17 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_11
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_417202", "417202018", "story_v_out_417202.awb")

						arg_76_1:RecordAudio("417202018", var_79_18)
						arg_76_1:RecordAudio("417202018", var_79_18)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417202", "417202018", "story_v_out_417202.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417202", "417202018", "story_v_out_417202.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_19 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_19 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_19

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_19 and arg_76_1.time_ < var_79_11 + var_79_19 + arg_79_0 then
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

		arg_76_1:InitPlayNodeList()
	end,
	Play417202019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417202019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play417202020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10128 = arg_80_1.actors_["10128"].transform.localPosition
				arg_80_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10128", 7)

				for iter_83_0 = 0, arg_80_1.actors_["10128"].transform.childCount - 1 do
					local var_83_0 = arg_80_1.actors_["10128"].transform:GetChild(iter_83_0)

					if var_83_0.name == "" or not string.find(var_83_0.name, "split") then
						var_83_0.gameObject:SetActive(true)
					else
						var_83_0.gameObject:SetActive(false)
					end
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10128, Vector3.New(0, -2000, -40), (arg_80_1.time_ - 0) / var_83_1)
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_83_2 = arg_80_1.actors_["1060"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1060 = var_83_2.localPosition
				var_83_2.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1060", 7)

				for iter_83_1 = 0, var_83_2.childCount - 1 do
					local var_83_3 = var_83_2:GetChild(iter_83_1)

					if var_83_3.name == "" or not string.find(var_83_3.name, "split") then
						var_83_3.gameObject:SetActive(true)
					else
						var_83_3.gameObject:SetActive(false)
					end
				end
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_2.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_80_1.time_ - 0) / var_83_4)
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_83_5 = 0
			local var_83_6 = 0.6

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(417202019).content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 24 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 24)

				if (24 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 24)) > 0 and var_83_6 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_10 and arg_80_1.time_ < var_83_5 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play417202020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417202020
		arg_84_1.duration_ = 10.8

		local var_84_0 = {
			zh = 7.466,
			ja = 10.8
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
				arg_84_0:Play417202021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10128"]) and arg_84_1.var_.actorSpriteComps10128 == nil then
				arg_84_1.var_.actorSpriteComps10128 = arg_84_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10128"]) then
				if arg_84_1.var_.actorSpriteComps10128 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 1, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10128"]) and arg_84_1.var_.actorSpriteComps10128 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps10128 = nil
			end

			local var_87_2 = arg_84_1.actors_["10128"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10128 = var_87_2.localPosition
				var_87_2.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10128", 3)

				for iter_87_4 = 0, var_87_2.childCount - 1 do
					local var_87_3 = var_87_2:GetChild(iter_87_4)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_84_1.time_ - 0) / var_87_4)
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_87_5 = 0
			local var_87_6 = 0.975

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
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

				local var_87_7 = arg_84_1:GetWordFromCfg(417202020)
				local var_87_8 = arg_84_1:FormatText(var_87_7.content)

				arg_84_1.text_.text = var_87_8

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 39 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 39)

				if (39 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 39)) > 0 and var_87_6 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_8
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202020", "story_v_out_417202.awb") ~= 0 then
					local var_87_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202020", "story_v_out_417202.awb") / 1000

					if var_87_11 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_5
					end

					if var_87_7.prefab_name ~= "" and arg_84_1.actors_[var_87_7.prefab_name] ~= nil then
						local var_87_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_7.prefab_name].transform, "story_v_out_417202", "417202020", "story_v_out_417202.awb")

						arg_84_1:RecordAudio("417202020", var_87_12)
						arg_84_1:RecordAudio("417202020", var_87_12)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417202", "417202020", "story_v_out_417202.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417202", "417202020", "story_v_out_417202.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_13 and arg_84_1.time_ < var_87_5 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play417202021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417202021
		arg_88_1.duration_ = 5.27

		local var_88_0 = {
			zh = 4,
			ja = 5.266
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
				arg_88_0:Play417202022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10128"]) and arg_88_1.var_.actorSpriteComps10128 == nil then
				arg_88_1.var_.actorSpriteComps10128 = arg_88_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10128"]) then
				if arg_88_1.var_.actorSpriteComps10128 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10128"]) and arg_88_1.var_.actorSpriteComps10128 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps10128 = nil
			end

			local var_91_2 = arg_88_1.actors_["10128"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10128 = var_91_2.localPosition
				var_91_2.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10128", 2)

				for iter_91_4 = 0, var_91_2.childCount - 1 do
					local var_91_3 = var_91_2:GetChild(iter_91_4)

					if var_91_3.name == "" or not string.find(var_91_3.name, "split") then
						var_91_3.gameObject:SetActive(true)
					else
						var_91_3.gameObject:SetActive(false)
					end
				end
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_2.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_88_1.time_ - 0) / var_91_4)
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_2.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_91_5 = arg_88_1.actors_["1060"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1060 = var_91_5.localPosition
				var_91_5.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("1060", 4)

				for iter_91_5 = 0, var_91_5.childCount - 1 do
					local var_91_6 = var_91_5:GetChild(iter_91_5)

					if var_91_6.name == "" or not string.find(var_91_6.name, "split") then
						var_91_6.gameObject:SetActive(true)
					else
						var_91_6.gameObject:SetActive(false)
					end
				end
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_88_1.time_ - 0) / var_91_7)
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_91_8 = arg_88_1.actors_["1060"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1060 == nil then
				arg_88_1.var_.actorSpriteComps1060 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_9 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_9 and not isNil(var_91_8) then
				if arg_88_1.var_.actorSpriteComps1060 then
					for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_91_7 then
							if arg_88_1.isInRecall_ then
								iter_91_7.color = Color.New(Mathf.Lerp(iter_91_7.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_9), Mathf.Lerp(iter_91_7.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_9), (Mathf.Lerp(iter_91_7.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_9)))
							else
								local var_91_10 = Mathf.Lerp(iter_91_7.color.r, 1, (arg_88_1.time_ - 0) / var_91_9)

								iter_91_7.color = Color.New(var_91_10, var_91_10, var_91_10)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_9 and arg_88_1.time_ < 0 + var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps1060 then
				for iter_91_8, iter_91_9 in pairs(arg_88_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_91_9 then
						iter_91_9.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps1060 = nil
			end

			local var_91_11 = 0
			local var_91_12 = 0.475

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_13 = arg_88_1:GetWordFromCfg(417202021)
				local var_91_14 = arg_88_1:FormatText(var_91_13.content)

				arg_88_1.text_.text = var_91_14

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_16 = 19 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_14) / 19)

				if (19 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_14) / 19)) > 0 and var_91_12 < var_91_16 then
					arg_88_1.talkMaxDuration = var_91_16

					if var_91_16 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_14
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202021", "story_v_out_417202.awb") ~= 0 then
					local var_91_17 = manager.audio:GetVoiceLength("story_v_out_417202", "417202021", "story_v_out_417202.awb") / 1000

					if var_91_17 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_17 + var_91_11
					end

					if var_91_13.prefab_name ~= "" and arg_88_1.actors_[var_91_13.prefab_name] ~= nil then
						local var_91_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_13.prefab_name].transform, "story_v_out_417202", "417202021", "story_v_out_417202.awb")

						arg_88_1:RecordAudio("417202021", var_91_18)
						arg_88_1:RecordAudio("417202021", var_91_18)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417202", "417202021", "story_v_out_417202.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417202", "417202021", "story_v_out_417202.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_19 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_19 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_11) / var_91_19

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_19 and arg_88_1.time_ < var_91_11 + var_91_19 + arg_91_0 then
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

		arg_88_1:InitPlayNodeList()
	end,
	Play417202022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417202022
		arg_92_1.duration_ = 2.33

		local var_92_0 = {
			zh = 2.333,
			ja = 2.066
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play417202023(arg_92_1)
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
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 1, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10128"]) and arg_92_1.var_.actorSpriteComps10128 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps10128 = nil
			end

			local var_95_2 = arg_92_1.actors_["1060"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1060 == nil then
				arg_92_1.var_.actorSpriteComps1060 = var_95_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_3 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.actorSpriteComps1060 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								iter_95_5.color = Color.New(Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_3), Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_3), (Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_3)))
							else
								local var_95_4 = Mathf.Lerp(iter_95_5.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_3)

								iter_95_5.color = Color.New(var_95_4, var_95_4, var_95_4)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1060 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_95_7 then
						iter_95_7.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps1060 = nil
			end

			local var_95_5 = arg_92_1.actors_["10128"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10128 = var_95_5.localPosition
				var_95_5.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10128", 2)

				for iter_95_8 = 0, var_95_5.childCount - 1 do
					local var_95_6 = var_95_5:GetChild(iter_95_8)

					if var_95_6.name == "split_2" or not string.find(var_95_6.name, "split") then
						var_95_6.gameObject:SetActive(true)
					else
						var_95_6.gameObject:SetActive(false)
					end
				end
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_92_1.time_ - 0) / var_95_7)
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_95_8 = 0
			local var_95_9 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(417202022)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 9 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 9)

				if (9 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 9)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202022", "story_v_out_417202.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_417202", "417202022", "story_v_out_417202.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_417202", "417202022", "story_v_out_417202.awb")

						arg_92_1:RecordAudio("417202022", var_95_15)
						arg_92_1:RecordAudio("417202022", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417202", "417202022", "story_v_out_417202.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417202", "417202022", "story_v_out_417202.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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
	Play417202023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417202023
		arg_96_1.duration_ = 14.07

		local var_96_0 = {
			zh = 10.233,
			ja = 14.066
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
				arg_96_0:Play417202024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10128"]) and arg_96_1.var_.actorSpriteComps10128 == nil then
				arg_96_1.var_.actorSpriteComps10128 = arg_96_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10128"]) then
				if arg_96_1.var_.actorSpriteComps10128 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10128"]) and arg_96_1.var_.actorSpriteComps10128 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps10128 = nil
			end

			local var_99_2 = arg_96_1.actors_["1060"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps1060 == nil then
				arg_96_1.var_.actorSpriteComps1060 = var_99_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_3 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.actorSpriteComps1060 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								iter_99_5.color = Color.New(Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_3), Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_3), (Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_3)))
							else
								local var_99_4 = Mathf.Lerp(iter_99_5.color.r, 1, (arg_96_1.time_ - 0) / var_99_3)

								iter_99_5.color = Color.New(var_99_4, var_99_4, var_99_4)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps1060 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_99_7 then
						iter_99_7.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps1060 = nil
			end

			local var_99_5 = 0
			local var_99_6 = 1.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:GetWordFromCfg(417202023)
				local var_99_8 = arg_96_1:FormatText(var_99_7.content)

				arg_96_1.text_.text = var_99_8

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 49 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_8) / 49)

				if (49 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_8) / 49)) > 0 and var_99_6 < var_99_10 then
					arg_96_1.talkMaxDuration = var_99_10

					if var_99_10 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_8
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202023", "story_v_out_417202.awb") ~= 0 then
					local var_99_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202023", "story_v_out_417202.awb") / 1000

					if var_99_11 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_5
					end

					if var_99_7.prefab_name ~= "" and arg_96_1.actors_[var_99_7.prefab_name] ~= nil then
						local var_99_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_7.prefab_name].transform, "story_v_out_417202", "417202023", "story_v_out_417202.awb")

						arg_96_1:RecordAudio("417202023", var_99_12)
						arg_96_1:RecordAudio("417202023", var_99_12)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417202", "417202023", "story_v_out_417202.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417202", "417202023", "story_v_out_417202.awb")
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

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play417202024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417202024
		arg_100_1.duration_ = 7

		local var_100_0 = {
			zh = 7,
			ja = 6.6
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
				arg_100_0:Play417202025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.825

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(417202024)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 33 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 33)

				if (33 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 33)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202024", "story_v_out_417202.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202024", "story_v_out_417202.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_417202", "417202024", "story_v_out_417202.awb")

						arg_100_1:RecordAudio("417202024", var_103_6)
						arg_100_1:RecordAudio("417202024", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417202", "417202024", "story_v_out_417202.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417202", "417202024", "story_v_out_417202.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play417202025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417202025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417202026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10128 = arg_104_1.actors_["10128"].transform.localPosition
				arg_104_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10128", 7)

				for iter_107_0 = 0, arg_104_1.actors_["10128"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["10128"].transform:GetChild(iter_107_0)

					if var_107_0.name == "" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10128, Vector3.New(0, -2000, 0), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_2 = arg_104_1.actors_["1060"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1060 = var_107_2.localPosition
				var_107_2.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1060", 7)

				for iter_107_1 = 0, var_107_2.childCount - 1 do
					local var_107_3 = var_107_2:GetChild(iter_107_1)

					if var_107_3.name == "" or not string.find(var_107_3.name, "split") then
						var_107_3.gameObject:SetActive(true)
					else
						var_107_3.gameObject:SetActive(false)
					end
				end
			end

			local var_107_4 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				var_107_2.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_104_1.time_ - 0) / var_107_4)
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				var_107_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_107_5 = 0
			local var_107_6 = 0.775

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(417202025).content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 31 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_7) / 31)

				if (31 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_7) / 31)) > 0 and var_107_6 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_5
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_6, arg_104_1.talkMaxDuration)

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_5) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_5 + var_107_10 and arg_104_1.time_ < var_107_5 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play417202026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417202026
		arg_108_1.duration_ = 2.53

		local var_108_0 = {
			zh = 1.333,
			ja = 2.533
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
				arg_108_0:Play417202027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1060 = arg_108_1.actors_["1060"].transform.localPosition
				arg_108_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1060", 3)

				for iter_111_0 = 0, arg_108_1.actors_["1060"].transform.childCount - 1 do
					local var_111_0 = arg_108_1.actors_["1060"].transform:GetChild(iter_111_0)

					if var_111_0.name == "split_5" or not string.find(var_111_0.name, "split") then
						var_111_0.gameObject:SetActive(true)
					else
						var_111_0.gameObject:SetActive(false)
					end
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_108_1.time_ - 0) / var_111_1)
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_111_2 = arg_108_1.actors_["1060"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps1060 == nil then
				arg_108_1.var_.actorSpriteComps1060 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps1060 then
					for iter_111_1, iter_111_2 in pairs(arg_108_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_111_2 then
							if arg_108_1.isInRecall_ then
								iter_111_2.color = Color.New(Mathf.Lerp(iter_111_2.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_2.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_2.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_2.color.r, 1, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_2.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps1060 then
				for iter_111_3, iter_111_4 in pairs(arg_108_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_111_4 then
						iter_111_4.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1060 = nil
			end

			local var_111_5 = 0
			local var_111_6 = 0.075

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(417202026)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 3 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 3)

				if (3 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 3)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202026", "story_v_out_417202.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202026", "story_v_out_417202.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_417202", "417202026", "story_v_out_417202.awb")

						arg_108_1:RecordAudio("417202026", var_111_12)
						arg_108_1:RecordAudio("417202026", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417202", "417202026", "story_v_out_417202.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417202", "417202026", "story_v_out_417202.awb")
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

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play417202027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417202027
		arg_112_1.duration_ = 6.13

		local var_112_0 = {
			zh = 5.9,
			ja = 6.133
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
				arg_112_0:Play417202028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10128"]) and arg_112_1.var_.actorSpriteComps10128 == nil then
				arg_112_1.var_.actorSpriteComps10128 = arg_112_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10128"]) then
				if arg_112_1.var_.actorSpriteComps10128 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10128"]) and arg_112_1.var_.actorSpriteComps10128 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps10128 = nil
			end

			local var_115_2 = arg_112_1.actors_["1060"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1060 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1060", 7)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_112_1.time_ - 0) / var_115_4)
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_115_5 = arg_112_1.actors_["10128"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10128 = var_115_5.localPosition
				var_115_5.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10128", 3)

				for iter_115_5 = 0, var_115_5.childCount - 1 do
					local var_115_6 = var_115_5:GetChild(iter_115_5)

					if var_115_6.name == "split_6" or not string.find(var_115_6.name, "split") then
						var_115_6.gameObject:SetActive(true)
					else
						var_115_6.gameObject:SetActive(false)
					end
				end
			end

			local var_115_7 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_112_1.time_ - 0) / var_115_7)
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_115_8 = 0
			local var_115_9 = 0.75

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
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

				local var_115_10 = arg_112_1:GetWordFromCfg(417202027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 30 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 30)

				if (30 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 30)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202027", "story_v_out_417202.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_417202", "417202027", "story_v_out_417202.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_417202", "417202027", "story_v_out_417202.awb")

						arg_112_1:RecordAudio("417202027", var_115_15)
						arg_112_1:RecordAudio("417202027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417202", "417202027", "story_v_out_417202.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417202", "417202027", "story_v_out_417202.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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
	Play417202028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417202028
		arg_116_1.duration_ = 10.33

		local var_116_0 = {
			zh = 5.933,
			ja = 10.333
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
				arg_116_0:Play417202029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.75

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
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

				local var_119_1 = arg_116_1:GetWordFromCfg(417202028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 30)

				if (30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 30)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202028", "story_v_out_417202.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202028", "story_v_out_417202.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_417202", "417202028", "story_v_out_417202.awb")

						arg_116_1:RecordAudio("417202028", var_119_6)
						arg_116_1:RecordAudio("417202028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417202", "417202028", "story_v_out_417202.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417202", "417202028", "story_v_out_417202.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417202029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417202029
		arg_120_1.duration_ = 4.07

		local var_120_0 = {
			zh = 2.733,
			ja = 4.066
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
				arg_120_0:Play417202030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.35

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(417202029)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 14 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 14)

				if (14 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 14)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202029", "story_v_out_417202.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_417202", "417202029", "story_v_out_417202.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_417202", "417202029", "story_v_out_417202.awb")

						arg_120_1:RecordAudio("417202029", var_123_6)
						arg_120_1:RecordAudio("417202029", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417202", "417202029", "story_v_out_417202.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417202", "417202029", "story_v_out_417202.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417202030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417202030
		arg_124_1.duration_ = 8.97

		local var_124_0 = {
			zh = 8.1,
			ja = 8.966
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
				arg_124_0:Play417202031(arg_124_1)
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
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10128"]) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_2 = arg_124_1.actors_["10128"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10128 = var_127_2.localPosition
				var_127_2.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10128", 2)

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
				var_127_2.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_124_1.time_ - 0) / var_127_4)
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				var_127_2.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_127_5 = arg_124_1.actors_["1060"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1060 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1060", 4)

				for iter_127_5 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_5)

					if var_127_6.name == "split_1" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_127_8 = arg_124_1.actors_["1060"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1060 == nil then
				arg_124_1.var_.actorSpriteComps1060 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_9 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_9 and not isNil(var_127_8) then
				if arg_124_1.var_.actorSpriteComps1060 then
					for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_127_7 then
							if arg_124_1.isInRecall_ then
								iter_127_7.color = Color.New(Mathf.Lerp(iter_127_7.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_9), Mathf.Lerp(iter_127_7.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_9), (Mathf.Lerp(iter_127_7.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_9)))
							else
								local var_127_10 = Mathf.Lerp(iter_127_7.color.r, 1, (arg_124_1.time_ - 0) / var_127_9)

								iter_127_7.color = Color.New(var_127_10, var_127_10, var_127_10)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_9 and arg_124_1.time_ < 0 + var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1060 then
				for iter_127_8, iter_127_9 in pairs(arg_124_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_127_9 then
						iter_127_9.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps1060 = nil
			end

			local var_127_11 = 0
			local var_127_12 = 0.95

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:GetWordFromCfg(417202030)
				local var_127_14 = arg_124_1:FormatText(var_127_13.content)

				arg_124_1.text_.text = var_127_14

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_16 = 38 <= 0 and var_127_12 or var_127_12 * (utf8.len(var_127_14) / 38)

				if (38 <= 0 and var_127_12 or var_127_12 * (utf8.len(var_127_14) / 38)) > 0 and var_127_12 < var_127_16 then
					arg_124_1.talkMaxDuration = var_127_16

					if var_127_16 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_16 + var_127_11
					end
				end

				arg_124_1.text_.text = var_127_14
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202030", "story_v_out_417202.awb") ~= 0 then
					local var_127_17 = manager.audio:GetVoiceLength("story_v_out_417202", "417202030", "story_v_out_417202.awb") / 1000

					if var_127_17 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_17 + var_127_11
					end

					if var_127_13.prefab_name ~= "" and arg_124_1.actors_[var_127_13.prefab_name] ~= nil then
						local var_127_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_13.prefab_name].transform, "story_v_out_417202", "417202030", "story_v_out_417202.awb")

						arg_124_1:RecordAudio("417202030", var_127_18)
						arg_124_1:RecordAudio("417202030", var_127_18)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417202", "417202030", "story_v_out_417202.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417202", "417202030", "story_v_out_417202.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_19 = math.max(var_127_12, arg_124_1.talkMaxDuration)

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_19 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_11) / var_127_19

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_11 + var_127_19 and arg_124_1.time_ < var_127_11 + var_127_19 + arg_127_0 then
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417202031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417202031
		arg_128_1.duration_ = 3.33

		local var_128_0 = {
			zh = 2.2,
			ja = 3.333
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
				arg_128_0:Play417202032(arg_128_1)
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

			local var_131_2 = arg_128_1.actors_["1060"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps1060 == nil then
				arg_128_1.var_.actorSpriteComps1060 = var_131_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_3 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.actorSpriteComps1060 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								iter_131_5.color = Color.New(Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_3), Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_3), (Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_3)))
							else
								local var_131_4 = Mathf.Lerp(iter_131_5.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_3)

								iter_131_5.color = Color.New(var_131_4, var_131_4, var_131_4)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps1060 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_131_7 then
						iter_131_7.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps1060 = nil
			end

			local var_131_5 = 0
			local var_131_6 = 0.25

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

				local var_131_7 = arg_128_1:GetWordFromCfg(417202031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 10 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 10)

				if (10 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 10)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202031", "story_v_out_417202.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202031", "story_v_out_417202.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_417202", "417202031", "story_v_out_417202.awb")

						arg_128_1:RecordAudio("417202031", var_131_12)
						arg_128_1:RecordAudio("417202031", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417202", "417202031", "story_v_out_417202.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417202", "417202031", "story_v_out_417202.awb")
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

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417202032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417202032
		arg_132_1.duration_ = 10.17

		local var_132_0 = {
			zh = 9.2,
			ja = 10.166
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
				arg_132_0:Play417202033(arg_132_1)
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
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10128"]) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_2 = arg_132_1.actors_["1060"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1060 == nil then
				arg_132_1.var_.actorSpriteComps1060 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps1060 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 1, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps1060 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps1060 = nil
			end

			local var_135_5 = 0
			local var_135_6 = 1.1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(417202032)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 44 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 44)

				if (44 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 44)) > 0 and var_135_6 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202032", "story_v_out_417202.awb") ~= 0 then
					local var_135_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202032", "story_v_out_417202.awb") / 1000

					if var_135_11 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_5
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_417202", "417202032", "story_v_out_417202.awb")

						arg_132_1:RecordAudio("417202032", var_135_12)
						arg_132_1:RecordAudio("417202032", var_135_12)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417202", "417202032", "story_v_out_417202.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417202", "417202032", "story_v_out_417202.awb")
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

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417202033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417202033
		arg_136_1.duration_ = 2.13

		local var_136_0 = {
			zh = 2.133,
			ja = 2.066
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
				arg_136_0:Play417202034(arg_136_1)
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

			local var_139_2 = arg_136_1.actors_["1060"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1060 == nil then
				arg_136_1.var_.actorSpriteComps1060 = var_139_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_3 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.actorSpriteComps1060 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.actorSpriteComps1060 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_139_7 then
						iter_139_7.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps1060 = nil
			end

			local var_139_5 = 0
			local var_139_6 = 0.25

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

				local var_139_7 = arg_136_1:GetWordFromCfg(417202033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 10 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 10)

				if (10 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 10)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417202", "417202033", "story_v_out_417202.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_417202", "417202033", "story_v_out_417202.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_417202", "417202033", "story_v_out_417202.awb")

						arg_136_1:RecordAudio("417202033", var_139_12)
						arg_136_1:RecordAudio("417202033", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417202", "417202033", "story_v_out_417202.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417202", "417202033", "story_v_out_417202.awb")
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
	Play417202034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417202034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417202035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10128 = arg_140_1.actors_["10128"].transform.localPosition
				arg_140_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10128", 7)

				for iter_143_0 = 0, arg_140_1.actors_["10128"].transform.childCount - 1 do
					local var_143_0 = arg_140_1.actors_["10128"].transform:GetChild(iter_143_0)

					if var_143_0.name == "split_6" or not string.find(var_143_0.name, "split") then
						var_143_0.gameObject:SetActive(true)
					else
						var_143_0.gameObject:SetActive(false)
					end
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10128, Vector3.New(0, -2000, 0), (arg_140_1.time_ - 0) / var_143_1)
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_2 = arg_140_1.actors_["1060"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1060 = var_143_2.localPosition
				var_143_2.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1060", 7)

				for iter_143_1 = 0, var_143_2.childCount - 1 do
					local var_143_3 = var_143_2:GetChild(iter_143_1)

					if var_143_3.name == "" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_140_1.time_ - 0) / var_143_4)
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_143_5 = 0
			local var_143_6 = 0.8

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(417202034).content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 32 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 32)

				if (32 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 32)) > 0 and var_143_6 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_10 and arg_140_1.time_ < var_143_5 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	Play417202035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417202035
		arg_144_1.duration_ = 5.73

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417202036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_0 = 1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				local var_147_1 = Color.New(0, 0, 0)

				var_147_1.a = Mathf.Lerp(0, 1, (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.mask_.color = var_147_1
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				local var_147_2 = Color.New(0, 0, 0)

				var_147_2.a = 1
				arg_144_1.mask_.color = var_147_2
			end

			local var_147_3 = 1

			if 1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_3 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_4 = 1

			if var_147_3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_3 + var_147_4 then
				local var_147_5 = Color.New(0, 0, 0)

				var_147_5.a = Mathf.Lerp(1, 0, (arg_144_1.time_ - var_147_3) / var_147_4)
				arg_144_1.mask_.color = var_147_5
			end

			if arg_144_1.time_ >= var_147_3 + var_147_4 and arg_144_1.time_ < var_147_3 + var_147_4 + arg_147_0 then
				local var_147_6 = Color.New(0, 0, 0)

				arg_144_1.mask_.enabled = false
				var_147_6.a = 0
				arg_144_1.mask_.color = var_147_6
			end

			local var_147_7 = "STblack"

			if arg_144_1.bgs_.STblack == nil then
				local var_147_8 = Object.Instantiate(arg_144_1.paintGo_)

				var_147_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_147_7)
				var_147_8.name = var_147_7
				var_147_8.transform.parent = arg_144_1.stage_.transform
				var_147_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.bgs_[var_147_7] = var_147_8
			end

			if 1 < arg_144_1.time_ and arg_144_1.time_ <= 1 + arg_147_0 then
				local var_147_9 = arg_144_1.bgs_.STblack

				arg_144_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_147_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_10 = var_147_9:GetComponent("SpriteRenderer")

				if var_147_10 and var_147_10.sprite then
					local var_147_11 = 2 * (var_147_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_147_9.transform.localScale = Vector3.New(var_147_11 / var_147_10.sprite.bounds.size.y < var_147_11 * manager.ui.mainCameraCom_.aspect / var_147_10.sprite.bounds.size.x and var_147_11 * manager.ui.mainCameraCom_.aspect / var_147_10.sprite.bounds.size.x or var_147_11 / var_147_10.sprite.bounds.size.y, var_147_11 / var_147_10.sprite.bounds.size.y < var_147_11 * manager.ui.mainCameraCom_.aspect / var_147_10.sprite.bounds.size.x and var_147_11 * manager.ui.mainCameraCom_.aspect / var_147_10.sprite.bounds.size.x or var_147_11 / var_147_10.sprite.bounds.size.y, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "STblack" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_144_1.time_ and arg_144_1.time_ <= 1 + arg_147_0 then
				arg_144_1.fswbg_:SetActive(true)
				arg_144_1.dialog_:SetActive(false)

				arg_144_1.fswtw_.percent = 0
				arg_144_1.fswt_.text = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(417202035).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.fswt_)

				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_144_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_144_1.fswtw_:SetDirty()

				arg_144_1.typewritterCharCountI18N = 0

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_12 = 1.43333333333333

			if 1.43333333333333 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.var_.oldValueTypewriter = arg_144_1.fswtw_.percent

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_13 = 21
			local var_147_14 = 1.2
			local var_147_15, var_147_16 = arg_144_1:GetPercentByPara(arg_144_1:FormatText(arg_144_1:GetWordFromCfg(417202035).content), 1)

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				local var_147_17 = var_147_13 <= 0 and var_147_14 or var_147_14 * ((var_147_16 - arg_144_1.typewritterCharCountI18N) / var_147_13)

				if (var_147_13 <= 0 and var_147_14 or var_147_14 * ((var_147_16 - arg_144_1.typewritterCharCountI18N) / var_147_13)) > 0 and var_147_14 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_12
					end
				end
			end

			local var_147_18 = math.max(1.2, arg_144_1.talkMaxDuration)

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_18 then
				arg_144_1.fswtw_.percent = Mathf.Lerp(arg_144_1.var_.oldValueTypewriter, var_147_15, (arg_144_1.time_ - var_147_12) / var_147_18)
				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.fswtw_:SetDirty()
			end

			if arg_144_1.time_ >= var_147_12 + var_147_18 and arg_144_1.time_ < var_147_12 + var_147_18 + arg_147_0 then
				arg_144_1.fswtw_.percent = var_147_15

				arg_144_1.fswtw_:SetDirty()
				arg_144_1:ShowNextGo(true)

				arg_144_1.typewritterCharCountI18N = var_147_16
			end

			if 1.01666666666667 < arg_144_1.time_ and arg_144_1.time_ <= 1.01666666666667 + arg_147_0 then
				local var_147_19 = arg_144_1.fswbg_.transform:Find("textbox/adapt/content") or arg_144_1.fswbg_.transform:Find("textbox/content")
				local var_147_20 = arg_144_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_147_21 = var_147_19:GetComponent("RectTransform")

				var_147_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_147_21.offsetMin = Vector2.New(0, 0)
				var_147_21.offsetMax = Vector2.New(0, 0)
			end

			if 1 < arg_144_1.time_ and arg_144_1.time_ <= 1 + arg_147_0 then
				arg_144_1.cswbg_:SetActive(true)

				local var_147_22 = arg_144_1.cswt_:GetComponent("RectTransform")

				arg_144_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_147_22.offsetMin = Vector2.New(0, 0)
				var_147_22.offsetMax = Vector2.New(0, 0)
				arg_144_1.cswt_.text = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(419110).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.cswt_)

				arg_144_1.cswt_.fontSize = 120
				arg_144_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_144_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_147_23 = 1.43333333333333
			local var_147_24 = manager.audio:GetVoiceLength("story_v_out_417202", "417202035", "") / 1000

			if var_147_24 > 0 and 4.3 < var_147_24 and var_147_24 + var_147_23 > arg_144_1.duration_ then
				arg_144_1.duration_ = var_147_24 + var_147_23
			end

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1:AudioAction("play", "voice", "story_v_out_417202", "417202035", "")
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417202036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417202036
		arg_148_1.duration_ = 2.49

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417202037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.fswbg_:SetActive(true)
				arg_148_1.dialog_:SetActive(false)

				arg_148_1.fswtw_.percent = 0
				arg_148_1.fswt_.text = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(417202036).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.fswt_)

				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_148_1.fswtw_:SetDirty()

				arg_148_1.typewritterCharCountI18N = 0

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_1 = 12
			local var_151_2 = 0.6
			local var_151_3, var_151_4 = arg_148_1:GetPercentByPara(arg_148_1:FormatText(arg_148_1:GetWordFromCfg(417202036).content), 1)

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_5 = var_151_1 <= 0 and var_151_2 or var_151_2 * ((var_151_4 - arg_148_1.typewritterCharCountI18N) / var_151_1)

				if (var_151_1 <= 0 and var_151_2 or var_151_2 * ((var_151_4 - arg_148_1.typewritterCharCountI18N) / var_151_1)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end
			end

			local var_151_6 = math.max(0.6, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_6 then
				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_3, (arg_148_1.time_ - var_151_0) / var_151_6)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_6 and arg_148_1.time_ < var_151_0 + var_151_6 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_3

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_4
			end

			local var_151_7 = 0.0872775018215179
			local var_151_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202036", "") / 1000

			if var_151_8 > 0 and 2.4 < var_151_8 and var_151_8 + var_151_7 > arg_148_1.duration_ then
				arg_148_1.duration_ = var_151_8 + var_151_7
			end

			if var_151_7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1:AudioAction("play", "voice", "story_v_out_417202", "417202036", "")
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play417202037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417202037
		arg_152_1.duration_ = 8.23

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417202038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.fswbg_:SetActive(true)
				arg_152_1.dialog_:SetActive(false)

				arg_152_1.fswtw_.percent = 0
				arg_152_1.fswt_.text = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(417202037).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.fswt_)

				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_152_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_152_1.fswtw_:SetDirty()

				arg_152_1.typewritterCharCountI18N = 0

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.var_.oldValueTypewriter = arg_152_1.fswtw_.percent

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_1 = 43
			local var_155_2 = 2.66666666666667
			local var_155_3, var_155_4 = arg_152_1:GetPercentByPara(arg_152_1:FormatText(arg_152_1:GetWordFromCfg(417202037).content), 1)

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				local var_155_5 = var_155_1 <= 0 and var_155_2 or var_155_2 * ((var_155_4 - arg_152_1.typewritterCharCountI18N) / var_155_1)

				if (var_155_1 <= 0 and var_155_2 or var_155_2 * ((var_155_4 - arg_152_1.typewritterCharCountI18N) / var_155_1)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end
			end

			local var_155_6 = math.max(2.66666666666667, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_6 then
				arg_152_1.fswtw_.percent = Mathf.Lerp(arg_152_1.var_.oldValueTypewriter, var_155_3, (arg_152_1.time_ - var_155_0) / var_155_6)
				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_152_1.fswtw_:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_6 and arg_152_1.time_ < var_155_0 + var_155_6 + arg_155_0 then
				arg_152_1.fswtw_.percent = var_155_3

				arg_152_1.fswtw_:SetDirty()
				arg_152_1:ShowNextGo(true)

				arg_152_1.typewritterCharCountI18N = var_155_4
			end

			local var_155_7 = 0.0999999999999999
			local var_155_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202037", "") / 1000

			if var_155_8 > 0 and 8.133 < var_155_8 and var_155_8 + var_155_7 > arg_152_1.duration_ then
				arg_152_1.duration_ = var_155_8 + var_155_7
			end

			if var_155_7 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 then
				arg_152_1:AudioAction("play", "voice", "story_v_out_417202", "417202037", "")
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417202038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417202038
		arg_156_1.duration_ = 8.09

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417202039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.fswbg_:SetActive(true)
				arg_156_1.dialog_:SetActive(false)

				arg_156_1.fswtw_.percent = 0
				arg_156_1.fswt_.text = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(417202038).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.fswt_)

				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_156_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_156_1.fswtw_:SetDirty()

				arg_156_1.typewritterCharCountI18N = 0

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_1 = 40
			local var_159_2 = 2.66666666666667
			local var_159_3, var_159_4 = arg_156_1:GetPercentByPara(arg_156_1:FormatText(arg_156_1:GetWordFromCfg(417202038).content), 1)

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_5 = var_159_1 <= 0 and var_159_2 or var_159_2 * ((var_159_4 - arg_156_1.typewritterCharCountI18N) / var_159_1)

				if (var_159_1 <= 0 and var_159_2 or var_159_2 * ((var_159_4 - arg_156_1.typewritterCharCountI18N) / var_159_1)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end
			end

			local var_159_6 = math.max(2.66666666666667, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_6 then
				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_3, (arg_156_1.time_ - var_159_0) / var_159_6)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_6 and arg_156_1.time_ < var_159_0 + var_159_6 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_3

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_4
			end

			local var_159_7 = 0.0853788033127785
			local var_159_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202038", "") / 1000

			if var_159_8 > 0 and 8 < var_159_8 and var_159_8 + var_159_7 > arg_156_1.duration_ then
				arg_156_1.duration_ = var_159_8 + var_159_7
			end

			if var_159_7 < arg_156_1.time_ and arg_156_1.time_ <= var_159_7 + arg_159_0 then
				arg_156_1:AudioAction("play", "voice", "story_v_out_417202", "417202038", "")
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417202039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417202039
		arg_160_1.duration_ = 2.59

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0
				arg_160_1.fswt_.text = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417202039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_1 = 17
			local var_163_2 = 0.933333333333333
			local var_163_3, var_163_4 = arg_160_1:GetPercentByPara(arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417202039).content), 1)

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_5 = var_163_1 <= 0 and var_163_2 or var_163_2 * ((var_163_4 - arg_160_1.typewritterCharCountI18N) / var_163_1)

				if (var_163_1 <= 0 and var_163_2 or var_163_2 * ((var_163_4 - arg_160_1.typewritterCharCountI18N) / var_163_1)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_0
					end
				end
			end

			local var_163_6 = math.max(0.933333333333333, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_6 then
				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_3, (arg_160_1.time_ - var_163_0) / var_163_6)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_6 and arg_160_1.time_ < var_163_0 + var_163_6 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_3

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_4
			end

			local var_163_7 = 0.0889083966612816
			local var_163_8 = manager.audio:GetVoiceLength("story_v_out_417202", "417202039", "") / 1000

			if var_163_8 > 0 and 2.5 < var_163_8 and var_163_8 + var_163_7 > arg_160_1.duration_ then
				arg_160_1.duration_ = var_163_8 + var_163_7
			end

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1:AudioAction("play", "voice", "story_v_out_417202", "417202039", "")
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05c",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417202.awb"
	}
}
